<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Program Supersort Order" section="program" js="order"><cfoutput>

<cf_buildOrder title="Program Supersort Order" table="program" code="program" selflink="true" ordercolumn="supersort" condition="supersort is not null" redirect="programlist.cfm?by=supersort&dir=desc" saving="#saving#">

</cfoutput></cf_buildPage>