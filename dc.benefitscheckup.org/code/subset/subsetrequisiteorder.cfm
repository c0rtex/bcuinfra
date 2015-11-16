<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Requisite Item (Needed Info) Order" section="subset" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="subset_requisite" code="requisite" condition="subset_id=#id#" crosstable="requisite" crosstag="rq" crosskey="requisite_id" crosscolumn="code" crosscondition="x.requisite_id=rq.requisite_id" saving="#saving#" title="Requisite Item (Needed Info) Order" redirect="subsetview.cfm?id=#id#">

</cfoutput></cf_buildPage>