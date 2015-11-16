<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Entry Point Group Order" section="program" js="order"><cfoutput>

<cf_buildOrder title="Entry Point Group Order" name="#name#" width="640" table="program_entrypointgroup" code="entrypointgroup" condition="program_id=#id#" crosstable="entrypointgroup" crosstag="egx" crosskey="entrypointgroup_id" crosscolumn="name" crosscondition="x.entrypointgroup_id=egx.entrypointgroup_id" saving="#saving#" redirect="programview.cfm?id=#id#">

</cfoutput></cf_buildPage>