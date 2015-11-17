<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Grid Row" section="question" js="order"><cfoutput>

<cf_buildOrder table="gridrow" code="gridrow" saving="#saving#" title="Grid Row Order">

</cfoutput></cf_buildPage>