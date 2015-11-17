<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Proximity Method Order" section="program" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="program_proximity" code="proximity" condition="program_id=#id#" crosstable="proximity" crosstag="px" crosskey="proximity_id" crosscolumn="code" crosscondition="x.proximity_id=px.proximity_id" saving="#saving#" title="Proximity Method Order" redirect="programview.cfm?id=#id#">

</cfoutput></cf_buildPage>