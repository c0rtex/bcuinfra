<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Requisite Item Order" section="program" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="program_requisite" code="requisite" condition="program_id=#id#" crosstable="requisite" crosstag="rq" crosskey="requisite_id" crosscolumn="code" crosscondition="x.requisite_id=rq.requisite_id" saving="#saving#" title="Requisite Item Order" redirect="programview.cfm?id=#id#">

</cfoutput></cf_buildPage>