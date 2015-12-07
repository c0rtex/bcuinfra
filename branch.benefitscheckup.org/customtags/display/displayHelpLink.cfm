<cfsilent>
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.textonly" type="string" default="FALSE">

<cfif Left(attributes.code, 5) eq 'help_'>
	<cfset attributes.code = Right(attributes.code, Len(attributes.code) - 5)>
</cfif>

<cf_cacheHelpPool action="get" code="#attributes.code#" var="hobj">

</cfsilent>

<cfif hobj.exists>
<cfif partner_id eq 0> <!--- main bcu site, fixing the scsep_inc help link appearing as a text and not as a button; making it a button; all help links are buttons on the main site --->
<cfset attributes.textonly = TRUE>
<!---
<cfoutput>#attributes.code#</cfoutput>
<cfoutput>#attributes.textonly#</cfoutput>
--->
</cfif>
	<cf_buildPopupLink code="#attributes.code#" text="HELP" textonly="#attributes.textonly#">
</cfif>
