<cfset form_id=url.form_id>
<cfset type_id=url.type_id>

<cfinclude template="typedissociate.cfm">

<cflocation url="formview.cfm?id=#form_id#">