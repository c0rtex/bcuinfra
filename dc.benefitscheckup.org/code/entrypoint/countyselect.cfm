<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="state_id" type="string">
<cfparam name="entrypointgroup_id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="reps" type="numeric" default="0">

<cf_checkAccess level="4">

<cf_buildPage title="Counties Served" section="entrypoint" js="order"><cfoutput>

<cf_buildServedSelector title="Counties Served" item="Counties" name="#name#" table="county" code="county" entrypoint_id="#id#" state_id="#state_id#" entrypointgroup_id="#entrypointgroup_id#" crosstable="entrypoint_county" crosscolumn="county_id" saving="#saving#" reps="#reps#">

</cfoutput></cf_buildPage>