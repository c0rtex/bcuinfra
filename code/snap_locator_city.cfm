<cfsilent>

<cfscript>
	//log page views in to database
	application.udf.logPageViews();
</cfscript>

<cfquery name="findCity" datasource="#application.dbSrc#">
	SELECT *
	FROM city c
	LEFT JOIN city_zip cz ON cz.city_id = c.city_id
	WHERE c.state_id = <cfqueryparam value="#state#">
	AND c.city_name = <cfqueryparam value="#city#">
	AND c.valid = 1
</cfquery>

<cfquery name="getPrgID" datasource="#application.dbSrc#">
	Select program_id as pid
    from program
    where state_id = '#state#' and programcategory_id = 23
</cfquery>
<cfif getPrgID.RecordCount eq 1>
	<cfoutput query="getPrgID">
		<cfset program_id = #pid#>
	</cfoutput>
</cfif>

</cfsilent><div id="offices">
<cf_displayProgramDetailEntrypoints program_id="#program_id#" mode="screen" source="" zipcode="#findCity.zipCode#" limit="10" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" google="true"><cfoutput>
<h2>SNAP Office(s):</h2>
<p>
#outstr#
</p>
</cfoutput>
</di>