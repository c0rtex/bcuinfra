<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="state_id" type="string">
<cfparam name="county_id" type="string" default="">
<cfparam name="entrypointgroup_id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="reps" type="numeric" default="0">

<cf_checkAccess level="4">

<cf_buildPage title="Zip Codes Served" section="entrypoint" js="order"><cfoutput>

<cf_buildServedSelector title="Zip Codes Served" item="Zip Codes" name="#name#" table="zip" code="zip" entrypoint_id="#id#" state_id="#state_id#" county_id="#county_id#" entrypointgroup_id="#entrypointgroup_id#" crosstable="entrypoint_zip" crosscolumn="zipcode" saving="#saving#" reps="#reps#">

</cfoutput></cf_buildPage>