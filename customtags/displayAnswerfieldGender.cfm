<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode neq 'print' and session.screening.prepopulate and StructKeyExists(session.screening.a, attributes.code)>
	<cfset matchVal = Evaluate("session.screening.a.#attributes.code#.pre")>
	<cfif matchVal eq ''>
		<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="3" var="matchVal">
	</cfif>
<cfelse>
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="3" var="matchVal">
</cfif>
<cf_displayText group="option" code="option_male" var="maleText">
<cf_displayText group="option" code="option_female" var="femaleText">

</cfsilent><cfoutput><cfif attributes.mode neq 'print'><table align="right" border="0" cellspacing="0" cellpadding="0"><tr><td class="q-field"><input type="radio" name="#attributes.code#" value="M"<cfif matchVal Eq 2> checked</cfif>></td><td class="q-field">#maleText#</td><td class="q-field">&nbsp;&nbsp;&nbsp;</td><td class="q-field"><input type="radio" name="#attributes.code#" value="F"<cfif matchVal Eq 3> checked</cfif>></td><td class="q-field">#femaleText#</td></tr></table><cfelse>____&nbsp;#maleText#&nbsp;&nbsp;&nbsp;&nbsp;____&nbsp;#femaleText#</cfif></cfoutput><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "g-#attributes.code#")>
</cfif>

</cfsilent>