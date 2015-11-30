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

<cf_cacheStatePool action="get">

</cfsilent><cfif attributes.mode neq 'print'><select name="#attributes.code#">
	<option value="">-- Select one --</option>
	<cf_loopPoolStruct struct="application.bcuStatePool" index="stateID">
		<cf_cacheStatePool action="get" state_id="#stateID#" var="stateStruct">
		<cfif stateStruct.type eq 'state'>
			<cfoutput><option value="#stateID#"<cfif matchVal eq stateID> selected</cfif>>#stateStruct.name#</option></cfoutput>
		</cfif>
	</cf_loopPoolStruct>
</select><cfelse>________________</cfif><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "s-#attributes.code#")>
</cfif>

</cfsilent>