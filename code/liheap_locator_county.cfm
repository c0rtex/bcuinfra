<cfsilent>

<cfscript>
	//log page views in to database
	application.udf.logPageViews();
</cfscript>

<cfquery name="findCounty" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE county_id = <cfqueryparam value="#county_id#" cfsqltype="cf_sql_char">
</cfquery>

<cfset countyName = "">

<cfloop list="#lcase(findCounty.county_name)#" delimiters=" " index="i">
	<cfset countyName = listAppend(countyName, "#ucase(left(i, 1))##mid(i, 2, len(i))#", " ")>
</cfloop>

</cfsilent><div id="offices">

<cf_displayProgramDetailEntrypoints program_id="#program_id#" mode="screen" source="" county_id="#county_id#" limit="10" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" proximityOverride="county" google="true"><cfoutput>
<h4>LIHEAP Office(s):</h4>
<p>
#outstr#
</p>
</cfoutput>
</div>