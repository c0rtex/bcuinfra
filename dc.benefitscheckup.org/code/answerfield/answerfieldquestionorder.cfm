<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Question Order" section="answerfield" js="order"><cfoutput>

<cf_buildOrder name="#name#" table="question_answerfield" code="question" condition="answerfield_id=#id#" crosstable="question" crosstag="q" crosskey="question_id" crosscolumn="question_code" crosscondition="x.question_id=q.question_id" saving="#saving#" title="Question Order" redirect="answerfieldview.cfm?id=#id#">

</cfoutput></cf_buildPage>