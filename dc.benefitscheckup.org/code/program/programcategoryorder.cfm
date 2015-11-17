<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Program Category Order" section="program" js="order"><cfoutput>

<cf_buildOrder table="programcategory" code="programcategory" saving="#saving#" title="Program Category Order">

</cfoutput></cf_buildPage>