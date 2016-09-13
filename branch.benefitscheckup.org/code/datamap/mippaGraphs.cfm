<cfsetting showdebugoutput="no">
<cfparam name="data_id" default="">

<cfquery name="nationalData" datasource="#application.dbSrc#">
    SELECT ifNull(de.#data_id#, 0) as natVal, de.year, mp_codebook2.type_of_variable as type
    FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#data_id#'
    WHERE  de.state = 'United States' AND (de.county = 'Nationwide') AND  de.#data_id# != 0
    ORDER BY year
</cfquery>

<cfquery name="stateData" datasource="#application.dbSrc#">
    SELECT ifNull(de.#data_id#,0) AS stateVal, de.year, mp_codebook2.type_of_variable AS type, de.state
    FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#data_id#'
    WHERE  de.state_abbv = '#session.mstate#' AND de.county = 'Statewide' AND  de.#data_id# != 0
    ORDER BY year
</cfquery>
<cfoutput>
<!--- <cfdump var="#nationalData#" expand="no"> --->
	<cfif SESSION.mstate NEQ "" AND stateData.recordCount GT 0>
		<cfif stateData.type is 'percent'>
            <cfset stateType = 'percent'>
            <cfset stateTitle = "Percent">
            <cfset sscaleF = 0>
        	<cfset sscaleT = 1>
        <cfelse>
            <cfset stateType = 'number'>
            <cfset stateTitle = 'Amount'>
            <!--- Bug 5697 - Mapping Tool - Show two decimal places for rate fields in Trends Tab
			 	::
			 --->
            <cfset stateValList = listSort(valueList(stateData.stateVal),"Numeric","DESC")>
            <cfset adjustedList = round(listFirst(stateValList) + 200000)>
            <cfset sscaleF = 0>
        	<cfset sscaleT = adjustedList>
        </cfif>
		<!---<cfloop query="stateData">
			<cfif stateData.stateVal LT 1>
				#NumberFormat(stateData.stateVal,"999.9999")#<br>
			</cfif>
        </cfloop>--->
        <h3 style="margin-bottom:0;">#stateData.state#</h3>
    	<cfchart scalefrom="#sscaleF#" scaleto="#sscaleT#" format="png" showxgridlines="yes" showygridlines="yes" chartwidth="480" chartheight="250" xAxisTitle="Year" yAxisTitle="#stateTitle#" labelformat="#stateType#" fontsize="13" fontbold="yes">
         	<cfchartseries type="line" seriescolor="##ff6600" paintstyle="shade">
            	<cfloop query="stateData">
						<!--- Bug 5697 - Mapping Tool - Show two decimal places for rate fields in Trends Tab  --->
						<cfchartdata item="#year#" value="#stateData.stateVal#">
                </cfloop>
            </cfchartseries>        
        </cfchart>
         <br />
    </cfif>
    <cfif nationalData.type is 'percent'>
		<cfset nationalType = 'percent'>
        <cfset nationalTitle = "Percent">
        <cfset nscaleF = 0>
        <cfset nscaleT = 1>
    <cfelse>
        <cfset nationalType = 'number'>
        <cfset nationalTitle = "Amount">
        <cfset natValList = listSort(valueList(nationalData.natVal),"Numeric","DESC")>
        <cfset adjustedNum = round(listFirst(natValList) + 10000000)>
        <cfset nscaleF = 1>
        <cfset nscaleT = adjustedNum>
    </cfif>

    <h3 style="margin-bottom:0;">United States</h3>
		<!--- Bug 5696 - Mapping Tool - Rightmost data point box in Trends tab sometimes is underneath zip code box
		Set table that displays tip with a high z-index so that data point will overlay all page elements.
	 --->
		<style>
			TABLE {
			z-index:500;
			}
			TABLE TR TD {
			opacity:100;
			}
		</style>
	    <cfchart scalefrom="#nscaleF#" scaleto="#nscaleT#" format="png" showxgridlines="yes" showygridlines="yes" chartwidth="480" chartheight="250" xAxisTitle="Year" yAxisTitle="#nationalTitle#" labelformat="#nationalType#" fontsize="13" fontbold="yes">
	        <cfchartseries type="line" seriescolor="##B0CFC8" paintstyle="shade">
	        <cfloop query="nationalData">
	        	<cfchartdata item="#year#" value="#natVal#">
	        </cfloop>
	        </cfchartseries>
	    </cfchart>
</cfoutput>