<cfcomponent>
	<!--- Gets a list of all states --->
	<cffunction name="getStates" access="remote" returntype="query">
    	<cfargument name="state" required="no" default="" type="string">
    	<cfset qStates = "">
		<cfquery name="qStates" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
        	SELECT state_map_code2, state_id, state_name
            FROM state
            WHERE statetype_id = 1
            <cfif arguments.state NEQ "">
            	AND state_id = '#arguments.state#'
            </cfif>
            ORDER BY state_map_code2
        </cfquery>
		<cfreturn qStates>
	</cffunction>
    
    <cffunction name="getStateTotals" access="remote" returnformat="json">
    	<cfargument name="data" required="yes" type="string">
        <cfsetting showdebugoutput="no">
        <cfset statedata = "">
    	<cfif arguments.data NEQ "">
            <cfquery name="statedata" datasource="#application.dbSrc#">
                SELECT de.#arguments.data# as natVal, de.year, mp_codebook2.type_of_variable as type
                FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#arguments.data#'
                WHERE  (de.year =
                  (SELECT MAX(year) AS Expr1
                   FROM  mp_dataelement2 AS mp_dataelement_1
                   WHERE mp_dataelement_1.#arguments.data# <> 0))
                AND de.state = 'United States' AND (de.county = 'Nationwide')
            </cfquery>
        </cfif>
        <cfreturn statedata />
    </cffunction>
    
    <cffunction name="getCountyTotals" access="remote" returnformat="json">
    	<cfargument name="data" required="yes" type="string">
        <cfargument name="state" required="yes" type="string">
        <cfsetting showdebugoutput="no">
        <cfset countydata = "">
        <cfif arguments.data NEQ "" AND arguments.state NEQ "">
        	<cfquery name="countydata" datasource="#application.dbSrc#">
                SELECT de.#arguments.data# as natVal, de.year, mp_codebook2.type_of_variable as type, de.state
                FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#arguments.data#'
                WHERE  (de.year =
                  (SELECT MAX(year) AS Expr1
                   FROM  mp_dataelement2 AS mp_dataelement_1
                   WHERE mp_dataelement_1.#arguments.data# <> 0))
                AND de.state_abbv = '#arguments.state#' AND (de.county = 'Statewide')
            </cfquery>
        </cfif>
    	<cfreturn countydata />
    </cffunction>
    
    <cffunction name="getStateMapcode" access="remote" returnformat="json">
    	<cfargument name="state" required="yes" default="" type="string">
        <cfsetting showdebugoutput="no">
        <cfquery name="qStatesCode" datasource="#application.dbSrc#">
        	SELECT state_map_code2
            FROM state
            WHERE state_id = '#arguments.state#' and statetype_id = 1
        </cfquery>
        
        <cfreturn qStatesCode />
    </cffunction>
    
    <cffunction name="getCountiesAsJSON" access="remote" returnformat="json">
    	<cfargument name="state" required="yes" type="string">
        <cfsetting showdebugoutput="no">
        <cfquery name="qCounties" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
        	SELECT county_name
            FROM county
            WHERE state_id = '#arguments.state#'
            AND map_id > 0
            ORDER BY map_id
        </cfquery>
        <cfreturn qCounties />
    </cffunction>
    
    <!--- gets a list of all counties for a state --->
    <cffunction name="getCounties" access="public" returntype="query">
    	<cfargument name="state" required="yes" type="string">
        <cfquery name="qCounties" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
        	SELECT *
            FROM county
            WHERE state_id = '#arguments.state#'
            AND map_id > 0
            ORDER BY map_id
        </cfquery>
        <cfreturn qCounties />
    </cffunction>
    
    <cffunction name="processZip" access="remote" returnformat="json">
    	<cfargument name="zipcode" required="yes" type="string">
        <cfset var showmap = 0>
        <cfset var findZip = "">
        <cfsetting showdebugoutput="no">
        <cfset vZip = validateZip(arguments.zipCode)>
        <cfset session.mZip = arguments.zipcode>
        <cfif vZip>
            <cfquery name="findZip" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
                SELECT state_map_code2, z.state_id, s.state_name
                FROM zip z
                LEFT JOIN state s ON s.state_id = z.state_id
                WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#left(zipCode, 5)#">
            </cfquery>
        <cfelse>
        	<cfset findZip = false>
        </cfif>
        
        <cfreturn findZip />
    </cffunction>
    <cffunction name="validateZip" access="public" returntype="boolean">
    	<cfargument name="zipcode" required="yes" type="string">
        <cfargument name="state_id" required="no" type="string" default="">
		<cfset validzip = "">
    	<cfquery name="validzip" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
            SELECT zipcode, state_id, valid
            FROM zip
            WHERE zipcode=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#arguments.zipcode#">
            AND valid=1
            <cfif arguments.state_id neq ''>
                AND state_id=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#arguments.state_id#">									    
            </cfif>
		</cfquery>
        <cfif validzip.recordCount is 1 AND validzip.valid>
        	<cfset session.mZip = arguments.zipcode>
        	<cfreturn true />
        <cfelse>
        	<cfset session.mZip = "">
        	<cfreturn false />
        </cfif>
    </cffunction>
    <!--- GET JSON OF RANKING INFO TO POPULATE RANKINGS TABLE --->
    <cffunction name="getRankingInfo" access="remote" returnformat="json">
    	<cfargument name="data_id" required="yes" type="string">
        <cfargument name="rankOrder" required="no" default="DESC">
        <cfargument name="sortCol" required="no" default="Row">
        <cfargument name="mstate" required="no" default="">
        <cfset qCounties = "">

        <cfif arguments.sortCol NEQ "">
        	<cfset myOrderBy = arguments.sortCol>
        <cfelse>
        	<cfset myOrderBy = arguments.data_id>
        </cfif>
        
        <cfset session.mData = arguments.data_id>
        <cfsetting showdebugoutput="no">
        
        <cfif arguments.mstate is "">
        	<cfquery name="statedata" datasource="#application.dbSrc#">
<!---           SELECT  
                		state.state_name, mp_dataelement2.year, mp_dataelement2.#arguments.data_id#, state.state_id,
                        ROW_NUMBER() OVER (ORDER BY mp_dataelement2.#arguments.data_id# DESC) AS Row
                FROM state
                	INNER JOIN mp_dataelement2 ON state.state_name = mp_dataelement2.state
                WHERE (mp_dataelement2.year =
					(SELECT MAX(year) AS Expr1
					FROM mp_dataelement2 AS mp_dataelement_1
                    WHERE mp_dataelement_1.#arguments.data_id# <> 0))
                AND (mp_dataelement2.county = 'Statewide' OR mp_dataelement2.county = 'District of Columbia')
                	ORDER BY #myOrderBy# #rankOrder#, state.state_id ASC --->


                select de.state_name, de.year, de.#arguments.data_id#, de.state_id, @num:=@num+1 as `Row` 
                from
		(SELECT  
                		state.state_name, mp_dataelement2.year, mp_dataelement2.#arguments.data_id#, state.state_id
                        
                FROM state
                	INNER JOIN mp_dataelement2 ON state.state_name = mp_dataelement2.state
                WHERE (mp_dataelement2.year =
					(SELECT MAX(year) AS Expr1
					FROM mp_dataelement2 AS mp_dataelement_1
                    WHERE mp_dataelement_1.#arguments.data_id# <> 0))
                AND (mp_dataelement2.county = 'Statewide' OR mp_dataelement2.county = 'District of Columbia')
                	ORDER BY '#myOrderBy#' #rankOrder#, state.state_name #rankOrder# 
                ) as de, (SELECT @num := 0) as t 
                <cfif arguments.sortCol EQ 'Row'>
               	 	order by de.#arguments.data_id# #rankOrder# 
				</cfif>
            </cfquery>
            
            <cfreturn statedata />
        <cfelse>
        	<cfquery name="countydata" datasource="#application.dbSrc#">
<!---           SELECT 
                	de.county,de.year,de.#arguments.data_id#,
                    ROW_NUMBER() OVER (ORDER BY de.#arguments.data_id# DESC) AS Row
                FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#arguments.data_id#'
                WHERE  (de.year =
                  (SELECT MAX(year) AS Expr1
                   FROM  mp_dataelement2 AS mp_dataelement_1 
                   WHERE mp_dataelement_1.#arguments.data_id# <> 0 AND county = de.county AND state_abbv = '#arguments.mstate#'))
                AND de.state_abbv = '#arguments.mstate#' AND de.county <> 'Statewide'
                ORDER BY <cfif arguments.mstate IS ''>de.county ASC<cfelse>#myOrderBy# #rankOrder#</cfif> --->


		<!---select dde.county, dde.`year`, dde.dataelement_id, dde.state_abbv, @num:=@num+1 as `Row`
		from  
		(
		 Select   de.county, de.year, de.#arguments.data_id#, de.state_abbv
                 from 
		 mp_dataelement2 as de		
		 inner join mp_codebook2 on mp_codebook2.variable_label = '#arguments.data_id#'
                 where  (de.year = (select max(year) as expr1
		                    from  mp_dataelement2 as mp_dataelement_1 
                 		   where mp_dataelement_1.dataelement_id <> 0 AND county = de.county AND state_abbv = '#arguments.mstate#'))
                 AND de.state_abbv = '#arguments.mstate#' AND de.county <> 'Statewide'
                 ORDER BY <cfif arguments.mstate IS ''>de.county ASC<cfelse>#myOrderBy# #rankOrder#</cfif>
                ) as dde, (SELECT @num := 0) as t--->

				SELECT 
				dde.county, dde.year, dde.#arguments.data_id#, dde.state_abbv, @num:=@num+1 AS 'Row'
				FROM 
				  (SELECT de.county, de.year, de.#arguments.data_id#, de.state_abbv
				    FROM mp_dataelement2 AS de		
				    INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = 'partdelg'
				    WHERE (
				            de.year = (
				                        SELECT max(year) AS expr1
						                    FROM  mp_dataelement2 AS mp_dataelement_1 
				                        WHERE mp_dataelement_1.dataelement_id <> 0 
				                        AND county = de.county 
				                        AND state_abbv = '#arguments.mstate#'
				                        AND #arguments.data_id# IS NOT NULL
				                        )
				           )
				    AND de.state_abbv = '#arguments.mstate#' AND de.county <> 'Statewide'
				    ORDER BY <cfif myOrderBy EQ 'county'>de.county #rankOrder#<cfelse>de.partdelg #rankOrder#</cfif>
				  ) AS dde, 
				  (SELECT @num := 0) AS t

            </cfquery>
            <cfreturn countydata />
        </cfif>
    </cffunction>
    
    <cffunction name="getDataInfo" access="remote" returnformat="json">
    	<cfargument name="data_id" required="yes" type="string">
        <cfset var qDataInfo = "">
        <cfsetting showdebugoutput="no">
    	<cfquery name="qDataInfo" datasource="#application.dbSrc#">
            SELECT mp_codebook2.long_title,mp_codebook2.notes_and_sources, mp_codebook2.acronyms, mp_codebook2.uses_of_the_data
            FROM mp_codebook2
            WHERE mp_codebook2.variable_label = '#arguments.data_id#'
        </cfquery>
        
        <cfreturn qDataInfo />
    </cffunction>
    <!---MH: Bug 5309 Uses of the Data information (Merge with getDataInfo after transitioning to using mp_codebook2) --->
    <cffunction name="getDataUsesInfo" access="remote" returnformat="json">
    	<cfargument name="data_id" required="yes" type="string">
        <cfset var qDataUsesInfo = "">
        <cfsetting showdebugoutput="no">
    	<cfquery name="qDataUsesInfo" datasource="#application.dbSrc#">
            SELECT mp_codebook2.uses_of_the_data
            FROM mp_codebook2
            WHERE mp_codebook2.variable_label = '#arguments.data_id#'
        </cfquery>
        
        <cfreturn qDataUsesInfo />
    </cffunction>
    <!--- Get JSON of programs for the programSel dropdown --->
    <cffunction name="getPrograms" access="remote" returnformat="json">
    	<cfargument name="program_id_list" required="yes" type="string">
        <cfset var qPrograms = "">
        <cfsetting showdebugoutput="no">
        	<cfquery name="qPrograms" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
                SELECT p.program_id,dl.display_text
                FROM program p
                	INNER JOIN display_language dl ON dl.display_id = p.name_display_id
                WHERE p.program_id IN (#arguments.program_id_list#) AND dl.language_id = 'EN'
            </cfquery>
        <cfreturn qPrograms />
    </cffunction>
    <!--- Get JSON of data sets for the dataSel fropdown --->
    <cffunction name="getDataSets" access="remote" returnformat="json">
    	<cfargument name="data_id_list" required="yes" type="string">
        <cfset var qdataSets = "">
        <cfsetting showdebugoutput="no">
            <cfquery name="qDataSets" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
            	SELECT variable_label,short_title
                FROM mp_codebook2
                WHERE codebook_id IN (#arguments.data_id_list#)
            </cfquery>
        <cfreturn qDataSets />
    </cffunction>
    <!--- Get JSON of program info to populate the about title and text and get entrypoints --->
    <cffunction name="getProgramInfo" access="remote" returnformat="json">
    	<cfargument name="program_id" required="yes" type="numeric">
        <cfset var qProgramInfo = "">
        <cfsetting showdebugoutput="no">
            <cfquery name="qProgramInfo" datasource="#application.dbSrc#">
            	SELECT dll.display_text as name, dl.display_text as description
                FROM program p
                	INNER JOIN display_language dl ON dl.display_id = p.desc_display_id
                    INNER JOIN display_language dll ON dll.display_id = p.name_display_id
                WHERE p.program_id IN (#arguments.program_id#) AND dl.language_id = 'EN' AND dll.language_id = 'EN'
            </cfquery>
        <cfreturn qProgramInfo />
    </cffunction>
    <!--- set session vars on program change --->
    <cffunction name="setvars" access="remote" returntype="any">
    	<cfargument name="program_id" required="no" type="any" default="">
        <cfargument name="zipcode" required="no" type="any" default="">
        <cfargument name="state" required="no" type="any" default="">
        <cfsetting showdebugoutput="no">
        	<cfset session.mProgram = arguments.program_id>
        	<cfset session.mZip = arguments.zipcode>
            <cfset session.mstate = arguments.state>
            <cfset rtnVar = true>
    </cffunction>
</cfcomponent>