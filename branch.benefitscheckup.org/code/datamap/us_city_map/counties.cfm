<cfparam name="url.state" default="">
<cfif len(url.state) GT 2>
	<cfset state = trim(listGetAt(url.state, 1,"-"))>
</cfif>
<cfsilent><cfset qCounties = createObject("component","com.bcu.mippaHandler").getCounties(state)>
<cfsetting showdebugoutput="no" />
</cfsilent><map>  
<cfoutput query="qCounties">
	<cfif session.mData NEQ "">
        <cfquery name="countydata" datasource="#application.dbSrc#">
            SELECT de.#session.mData#, de.year, de.county, mp_codebook2.type_of_variable AS type
            FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#session.mData#'
            WHERE  (de.year =
              (SELECT MAX(year) AS Expr1
               FROM  mp_dataelement2 AS mp_dataelement_1 
               WHERE mp_dataelement_1.#session.mData# <> 0 AND county = '#qCounties.county_name#' AND state_abbv = '#state#'))
            AND de.county = '#qCounties.county_name#' AND de.state_abbv = '#state#'
        </cfquery>
         <cfscript>
			num = listLen(qCounties.county_name, " ");
			for(i = 1 ; i LTE num;i++){
				word[#i#] = listGetAt(qCounties.county_name,i," ");
				fLetter = left(word[#i#],1);
				fLetter = uCase(fLetter);
				word[#i#] = fLetter & LCase(right(word[#i#], (len(word[#i#]) - 1)));
				if( i EQ 1){	
					cname = word[#i#];
				}else{
					cname = cname & " " & word[#i#];
				};
			};
		</cfscript>
        <cfif countydata.recordCount gt 0>
        	<cfset testNum = evaluate('countydata.#session.mData#')>
            <cfset amtCText = "Number">
            <cfif testNum IS "" OR testNum is "NULL">
            	<cfset testNum = 'N/A'>
        	<cfelseif  countydata.type IS 'percent' AND testNum LT 1>
				<cfset testNum = NumberFormat(testNum * 100,"99.99") & "%">
                <cfset amtCText = "Percent">
            <cfelseif countydata.type IS 'percent' AND testNum EQ 1>
                <cfset testNum = "100%">
                <cfset amtCText = "Percent">
            <cfelse>
            	<cfset testNum = NumberFormat(testNum)>
            </cfif>
        <cfelse>
        	<cfset testNum = 'N/A'>
            <cfset amtCText = "No Data">
        </cfif>
    </cfif>
    
 
    <county>
    <id>#map_id#</id>
    <name>#county_name#</name>
    <URL></URL>
    <popup>&lt;b&gt;#cname#<cfif session.mData NEQ "" and countydata.recordcount IS 1>&lt;br&gt;Year:&nbsp;#countydata.year#&lt;br&gt;#amtCText#:&nbsp;#testNum#<cfelse>&lt;br&gt;No Data Available</cfif>&lt;&frasl;b&gt;</popup>
    <color1>799e8c</color1>
    <color2>8eb9a4</color2>
    </county>
</cfoutput>
</map>