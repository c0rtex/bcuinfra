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
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="0" var="matchVal">
</cfif>

</cfsilent><cfif attributes.mode neq 'print'><cfoutput><select name="#attributes.code#"><option value="">--year--</option><option value="1899">before 1900</option><cfloop from="1900" to="#DateFormat(Now(), "yyyy")#" index="y"><option value="#y#"<cfif matchVal eq y> selected</cfif>>#y#</option></cfloop></select></cfoutput><cfelse>______</cfif><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "n-#attributes.code#")>
</cfif>

</cfsilent>