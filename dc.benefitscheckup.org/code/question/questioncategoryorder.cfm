<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Question Category" section="question" js="order"><cfoutput>

<cf_buildOrder table="questioncategory" code="questioncategory" saving="#saving#" title="Question Category Order">

</cfoutput></cf_buildPage>