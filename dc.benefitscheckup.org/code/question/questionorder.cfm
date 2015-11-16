<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Question" section="question" js="order"><cfoutput>

<!--<cf_buildOrder table="question" code="question" ordercolumn="sort" order="sort" saving="#saving#" title="Question Order"> -->

<cf_buildOrder table="question" code="question" ordercolumn="sort" order="sort" crosstable="question" crosstag="question" crosskey="question_id" crosscolumn="question_code" crosscondition="x.question_id=question.question_id" saving="#saving#" title="Question Order">

</cfoutput></cf_buildPage>
