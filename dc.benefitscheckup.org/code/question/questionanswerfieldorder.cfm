<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Answerfield Order" section="question" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="question_answerfield" code="answerfield" condition="question_id=#id#" crosstable="answerfield" crosstag="a" crosskey="answerfield_id" crosscolumn="answerfield" crosscondition="x.answerfield_id=a.answerfield_id" saving="#saving#" title="Answerfield Order" redirect="questionview.cfm?id=#id#">

</cfoutput></cf_buildPage>