<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="state_id" type="string">
<cfparam name="county_id" type="string" default="">
<cfparam name="entrypointgroup_id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="reps" type="numeric" default="0">

<cf_checkAccess level="4">

<cf_buildPage title="Cities Served" section="entrypoint" js="order"><cfoutput>

<cf_buildServedSelector title="Cities Served" item="Cities" name="#name#" table="city" code="city" entrypoint_id="#id#" state_id="#state_id#" county_id="#county_id#" entrypointgroup_id="#entrypointgroup_id#" crosstable="entrypoint_city" crosscolumn="city_id" saving="#saving#" reps="#reps#">

</cfoutput></cf_buildPage>