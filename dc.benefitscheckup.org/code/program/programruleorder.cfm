<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Eligibility Rule Order" section="program" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="program_rule" code="rule" condition="program_id=#id#" crosstable="rule" crosstag="pr" crosskey="rule_id" crosscolumn="code" crosscondition="x.rule_id=pr.rule_id" saving="#saving#" title="Eligibility Rule Order" redirect="programview.cfm?id=#id#">

</cfoutput></cf_buildPage>