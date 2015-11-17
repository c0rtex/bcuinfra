<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Program Group Order" section="program" js="order"><cfoutput>

<cf_buildOrder table="programgroup" code="programgroup" saving="#saving#" title="Program Group Order">

</cfoutput></cf_buildPage>