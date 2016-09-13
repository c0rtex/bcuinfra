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


</cfsilent><div id="offices">
<cf_displayProgramDetailEntrypoints program_id="#program_id#" mode="screen" source="" zipcode="#findCity.zipCode#" limit="10" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" google="true"><cfoutput>
<h4>Medicaid Office(s):</h4>
<p>
#outstr#
</p>
</cfoutput>
</di>