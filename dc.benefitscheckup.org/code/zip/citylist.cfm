<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cfif IsDefined('dcsrch_city_id')>
	<cfset validityCondition = ''>
<cfelse>
	<cfset validityCondition = 'c.valid=1'>
</cfif>

<cf_checkAccess level="5">
<cf_buildPage title="Cities" section="zip">

<cf_buildList title="Cities" table="city" code="city" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="2" condition="#validityCondition#">
	<cf_buildListProperty column="state_id" references="state">
	<cf_buildListProperty column="pref_city_id" references="city">
	<cf_buildListProperty column="exclude_flag" display="yesno">
	<cf_buildListProperty column="valid" display="yesno">
</cf_buildlist>

</cf_buildpage>