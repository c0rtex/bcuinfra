<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode neq 'print' and session.screening.prepopulate and StructKeyExists(session.screening.a, attributes.code)>
	<cfset matchVal = Evaluate("session.screening.a.#attributes.code#.pre")>
<cfelse>
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="" var="matchVal">
</cfif>

</cfsilent>

<cfoutput><cfif attributes.code eq "fit_agency_id" and session.partner_id eq 76>8</cfif><cfif attributes.mode neq 'print'><cfif attributes.code eq "fit_agency_id" and session.partner_id eq 76><input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="5" maxlength="4"><cfelse><input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="15" maxlength="64"></cfif><cfelse><cfif attributes.code eq "fit_agency_id" and session.partner_id eq 76>________<cfelse>____________</cfif></cfif></cfoutput>

<cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "s-#attributes.code#")>
</cfif>

</cfsilent>