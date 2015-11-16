<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cfif IsDefined('dcsrch_zipcode')>
	<cfset validityCondition = ''>
<cfelse>
	<cfset validityCondition = 'z.valid=1'>
</cfif>

<cf_checkAccess level="5">
<cf_buildPage title="Zip Codes" section="zip">

<cf_buildList title="Zip Codes" table="zip" code="zip" by="#by#" dir="#dir#" page="#page#" rows="#rows#" edit="false" condition="#validityCondition#">
	<cf_buildListProperty column="state_id" references="state">
	<cf_buildListProperty column="county_id" references="county">
	<cf_buildListProperty column="valid" display="yesno">
</cf_buildlist>

</cf_buildpage>