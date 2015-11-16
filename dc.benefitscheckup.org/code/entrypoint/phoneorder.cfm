<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="4">

<cf_buildPage title="Entry Point Phone Order" section="entrypoint" js="order"><cfoutput>

<cf_buildOrder title="Entry Point Phone Order" name="#name#" table="phone" code="phone" condition="entrypoint_id=#id#" saving="#saving#" selflink="true" redirect="entrypointview.cfm?id=#id#">

</cfoutput></cf_buildPage>