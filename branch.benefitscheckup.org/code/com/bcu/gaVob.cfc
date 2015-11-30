<cfcomponent displayname="gaVOBCalculator" hint="Calculates the VOB for any comnp screening for GA">
	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" returntype="any">
        <cfargument name="programs" type="query" required="yes">
        <!--- medicaid arguments --->
        <cfargument name="medicaid_ga_nursing_home" required="no" default="0" type="numeric">
        <cfargument name="medicaid_ga_medicaid_spend_down" required="no" default="0" type="numeric">
        <cfargument name="medicaid_ga_medicaid" required="no" default="0" type="numeric">
        <cfargument name="medicaid_ga_community_care" required="no" default="0" type="numeric">
        <!--- snap arg --->
        <cfargument name="nutrition_ga_snap_program" required="no" default="0" type="numeric">
        <!---   Low Income Home Energy Assistance Program (LIHEAP)  --->
        <cfargument name="utility_fd_liheap" required="no" default="0" type="numeric">
        <!--- Weatherization Assistance Program --->
        <cfargument name="utility_fd_weatherization_assist" required="no" default="0" type="numeric">
        <!--- Elderly Nutrition Program --->
        <cfargument name="foodsupp_fd_congregate_group" required="no" default="0" type="numeric">
        <cfargument name="foodsupp_fd_home_delivered_meal" required="no" default="0" type="numeric">
        <!--- Medicare Savings Program - Qualified Medicare Beneficiary (QMB) --->
        <cfargument name="health_fd_msp_qmb" required="no" default="0" type="numeric">
        <cfargument name="health_fd_msp_slmb" required="no" default="0" type="numeric">
        <cfargument name="health_fd_msp_qi" required="no" default="0" type="numeric">
        <!--- VA's Health Care System --->
        <cfargument name="health_fd_va_health_care_system" required="no" default="0" type="numeric">
        <!--- Supplemental Security Income --->
        <cfargument name="income_fd_ssi" required="no" default="0" type="numeric">
        <!--- Medicare Prescription Drug Coverage for People with Limited Incomes and Resources --->
        <cfargument name="rxgov_fd_medicare_lis" required="no" default="0" type="numeric">
        <!--- Medicare Prescription Drug Coverage --->
        <cfargument name="rxgov_fd_medicare_part_d" required="no" default="0" type="numeric">
        
        <cfscript>
			var myProgs = "";
			var mycounter = 1;
			var medicaidList = arrayNew(1);
			var mspList = arrayNew(1);
			variables.instance.medicaid_ga_nursing_home = arguments.medicaid_ga_nursing_home;
			variables.instance.medicaid_ga_medicaid_spend_down = arguments.medicaid_ga_medicaid_spend_down;
			variables.instance.medicaid_ga_community_care = arguments.medicaid_ga_community_care;
			variables.instance.medicaid_ga_medicaid = arguments.medicaid_ga_medicaid;
			
			variables.instance.nutrition_ga_snap_program = arguments.nutrition_ga_snap_program;
			variables.instance.utility_fd_liheap = arguments.utility_fd_liheap;
			variables.instance.utility_fd_weatherization_assist = arguments.utility_fd_weatherization_assist;
			
			variables.instance.foodsupp_fd_congregate_group = arguments.foodsupp_fd_congregate_group;
			variables.instance.foodsupp_fd_home_delivered_meal = arguments.foodsupp_fd_home_delivered_meal;
			
			variables.instance.health_fd_msp_qmb = arguments.health_fd_msp_qmb;
			variables.instance.health_fd_msp_slmb = arguments.health_fd_msp_slmb;
			variables.instance.health_fd_msp_qi = arguments.health_fd_msp_qi;
			
			variables.instance.health_fd_va_health_care_system = arguments.health_fd_va_health_care_system;
			variables.instance.income_fd_ssi = arguments.income_fd_ssi;
			variables.instance.rxgov_fd_medicare_lis = arguments.rxgov_fd_medicare_lis;
			variables.instance.rxgov_fd_medicare_part_d = arguments.rxgov_fd_medicare_part_d;
			variables.instance.total = 0;
			variables.instance.rxCounter = 0;
			variables.instance.rxTotal = 0;
			variables.instance.rxPrograms = structNew();
			variables.instance.check = false;
			variables.instance.temoFoodSuppAvg = 0;
		</cfscript>
        
        <cfoutput query="arguments.programs">
        	<cfset myProgs = program_code>
            <cfset myCatCode = cat_code>
            <cfif myCatCode EQ "rxco" OR myCatCode EQ "rxcard">
            	<cfset variables.instance.total =  variables.instance.total + getProgVal(program_id)>
                <cfset variables.instance.rxCounter++>
                <cfset variables.instance.rxPrograms[#variables.instance.rxCounter#] = myProgs> 
                <cfset variables.instance.rxTotal = variables.instance.rxTotal  + getProgVal(program_id)>
            <cfelse>
            	<cfswitch expression="#myProgs#">
                    <cfcase value="medicaid_ga_nursing_home">
                        <cfset variables.instance.medicaid_ga_nursing_home = getProgVal(program_id)>
                        <cfset arrayAppend(medicaidList,variables.instance.medicaid_ga_nursing_home)>
                    </cfcase>
                    <cfcase value="medicaid_ga_medicaid_spend_down">
                        <cfset variables.instance.medicaid_ga_medicaid_spend_down = getProgVal(program_id)>
                        <cfset arrayAppend(medicaidList,variables.instance.medicaid_ga_medicaid_spend_down)>
                    </cfcase>
                    <cfcase value="medicaid_ga_medicaid">
                        <cfset variables.instance.medicaid_ga_medicaid = getProgVal(program_id)>
                        <cfset arrayAppend(medicaidList,variables.instance.medicaid_ga_medicaid)>
                    </cfcase>
                    <cfcase value="medicaid_ga_community_care">
                        <cfset variables.instance.medicaid_ga_community_care = getProgVal(program_id)>
                        <cfset arrayAppend(medicaidList,variables.instance.medicaid_ga_community_care)>
                    </cfcase>
                    
                    <cfcase value="nutrition_ga_snap_program">
                        <cfset variables.instance.nutrition_ga_snap_program = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.nutrition_ga_snap_program />
                    </cfcase>
                    <cfcase value="utility_fd_liheap">
                        <cfset variables.instance.utility_fd_liheap = getLiheapProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.utility_fd_liheap />
                    </cfcase>
                    <cfcase value="utility_fd_weatherization_assist">
                        <cfset variables.instance.utility_fd_weatherization_assist = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.utility_fd_weatherization_assist />
                    </cfcase>
                    <cfcase value="foodsupp_fd_congregate_group">
                        <cfset variables.instance.foodsupp_fd_congregate_group = getProgVal(program_id)>
                    </cfcase>
                    <cfcase value="foodsupp_fd_home_delivered_meal">
                        <cfset variables.instance.foodsupp_fd_home_delivered_meal = getProgVal(program_id)>
                    </cfcase>
                    <cfcase value="health_fd_msp_qmb">
                        <cfset variables.instance.health_fd_msp_qmb = getProgVal(program_id)>
                        <cfset arrayAppend(mspList,variables.instance.health_fd_msp_qmb)>
                    </cfcase>
                    <cfcase value="health_fd_msp_slmb">
                        <cfset variables.instance.health_fd_msp_slmb = getProgVal(program_id)>
                        <cfset arrayAppend(mspList,variables.instance.health_fd_msp_slmb)>
                    </cfcase>
                    <cfcase value="health_fd_msp_qi">
                        <cfset variables.instance.health_fd_msp_qi = getProgVal(program_id)>
                        <cfset arrayAppend(mspList,variables.instance.health_fd_msp_qi)>
                    </cfcase>
                    <cfcase value="health_fd_va_health_care_system">
                        <cfset variables.instance.health_fd_va_health_care_system = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.health_fd_va_health_care_system />
                    </cfcase>
                    <cfcase value="income_fd_ssi">
                        <cfset variables.instance.income_fd_ssi = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.income_fd_ssi />
                    </cfcase>
                    <cfcase value="rxgov_fd_medicare_lis">
                        <cfset variables.instance.rxgov_fd_medicare_lis = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.rxgov_fd_medicare_lis />
                    </cfcase>
                    <cfcase value="rxgov_fd_medicare_part_d">
                        <cfset variables.instance.rxgov_fd_medicare_part_d = getProgVal(program_id)>
                        <cfset variables.instance.total =  variables.instance.total + variables.instance.rxgov_fd_medicare_part_d />
                    </cfcase>
                </cfswitch>
            </cfif>
			<cfset mycounter++>
        </cfoutput>
        
        
        <!--- Medicaid calculations --->
        <cfif isDefined("session.housing") AND session.housing EQ 'Nursing Facility'>
            <cfset largestProgram = arrayMax(medicaidList)>
        	<cfset variables.instance.total =  variables.instance.total + largestProgram />
        <cfelse>
        	<cfset smallestProgram = arrayMin(medicaidList)>
            <cfset variables.instance.total =  variables.instance.total + smallestProgram />
        </cfif>
        <!--- foodsupp calculations --->
        <cfif variables.instance.foodsupp_fd_home_delivered_meal NEQ 0 AND variables.instance.foodsupp_fd_congregate_group NEQ 0>
        	<cfset tempAverage = (variables.instance.foodsupp_fd_home_delivered_meal + variables.instance.foodsupp_fd_congregate_group) / 2>
            <cfset variables.instance.temoFoodSuppAvg = tempAverage />
            <cfset variables.instance.total =  variables.instance.total + tempAverage />
        <cfelseif variables.instance.foodsupp_fd_home_delivered_meal NEQ 0 AND variables.instance.foodsupp_fd_congregate_group EQ 0>
        	<cfset variables.instance.total =  variables.instance.total + variables.instance.foodsupp_fd_home_delivered_meal />
        <cfelseif variables.instance.foodsupp_fd_home_delivered_meal EQ 0 AND variables.instance.foodsupp_fd_congregate_group NEQ 0>
        	<cfset variables.instance.total =  variables.instance.total + variables.instance.foodsupp_fd_congregate_group />
        </cfif>
        <!--- MSP calculations --->
        <cfif arrayLen(mspList)>
        	<cfset variables.instance.check = true>
        	<cfset tempMspTotal = arrayMax(mspList)>
            <cfset variables.instance.total =  variables.instance.total + 2360 />
        <!--- <cfelse>
        	<cfset tempMspTotal = arrayMax(mspList)>
        	<cfset variables.instance.total =  variables.instance.total + 2360 /> --->
        </cfif>
        <cfscript>
			insertRecord();
		</cfscript>
		<cfreturn variables.instance />
	</cffunction>
    
    
    <cffunction name="insertRecord" returntype="void" output="no" access="public">
    	<cfset var insertVob = "">
        <cfset var checkrecord = "">
    	<cfoutput>
        	<cfquery name="checkrecord" datasource="#application.dbSrc#">
            	SELECT *
                FROM gavob
                WHERE screening_id = #session.screening_id#
            </cfquery> 
            <cfif checkrecord.recordCount IS 0>
            	 <cfquery name="insertVob" datasource="#application.dbSrc#">
                    INSERT INTO gavob (screening_id,total,date_created,org_id)
                    VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#session.screening_id#">,
                        <cfqueryparam cfsqltype="cf_sql_float" value="#variables.instance.total#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#session.org_id#">
                        )
                </cfquery>
            </cfif>
           
        </cfoutput>
    </cffunction>
    
    <cffunction name="dumpRecords" returntype="any" access="public">
    	<cfset var dumpVob = "">
        <cfset var rtn = "">
        <cfquery name="dumpVob" datasource="#application.dbSrc#">
        	SELECT *
            FROM gavob limit 0, 20
        </cfquery>
        
        <cfif dumpVob.recordCount GT 0>
        	<cfsavecontent variable="rtn">
            	<cfdump var="#dumpVob#" expand="no" / >
            </cfsavecontent>
            <cfreturn rtn />
        </cfif>
    </cffunction>
    
    
    <cffunction name="getProgVal" returntype="numeric" output="no">
    	<cfargument name="program_id" required="yes" default="0">
        <cfset rtnVal = 0>
        <cfif program_id NEQ 0>
        	<cfquery name="qProgVal" datasource="#application.dbSrc#">
            	SELECT dollarvalue
				FROM programvalue pv
				WHERE (program_id = #arguments.program_id#)
				AND (start_date = (
                					SELECT MAX(start_date) AS Expr1
                            		FROM programvalue
                            		WHERE program_id = pv.program_id
                                   )
                    )
            </cfquery>
            <cfif qProgVal.recordcount gt 0>
            	<cfset rtnVal = qProgVal.dollarvalue>
            </cfif>
        </cfif>
        <cfreturn rtnVal />
    </cffunction>
    
    <cffunction name="getLiheapProgVal" returntype="numeric" output="no">
    	<cfargument name="program_id" required="yes" default="0">
        <cfset rtnVal = 0>
        <cfif program_id NEQ 0>
        	<cfquery name="qProgVal" datasource="#application.dbSrc#">
            	SELECT dollarvalue
				FROM programvalue pv
				WHERE (program_id = #arguments.program_id#) 
                AND pv.state_id = 'GA'
				AND (start_date = (
                					SELECT MAX(start_date) AS Expr1
                            		FROM programvalue
                            		WHERE program_id = pv.program_id
                                   )
                    )
            </cfquery>
            <cfif qProgVal.recordcount gt 0>
            	<cfset rtnVal = qProgVal.dollarvalue>
            </cfif>
        </cfif>
        <cfreturn rtnVal />
    </cffunction>
</cfcomponent>