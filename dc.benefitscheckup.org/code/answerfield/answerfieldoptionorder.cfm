<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Option Order" section="answerfield" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="answerfield_option" code="option" condition="answerfield_id=#id#" crosstable="option" crosstag="o" crosskey="option_id" crosscolumn="option_code" crosscondition="x.option_id=o.option_id" saving="#saving#" title="Option Order" redirect="answerfieldview.cfm?id=#id#">

</cfoutput></cf_buildPage>