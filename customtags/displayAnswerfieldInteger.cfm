<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode neq 'print' and session.screening.prepopulate>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="error" var="hasError">
	<cfif hasError eq ''>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="pre" var="matchVal">
	<cfelse>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="val" var="matchVal">
	</cfif>
<cfelse>
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="" var="matchVal">
</cfif>
<cfset bcuAnswerfield = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>
<cfif bcuAnswerfield.length eq ''>
	<cfset maxlength = "8">
	<cfset size = "3">
	<cfset underscore = "6">
<cfelse>
	<cfset maxlength = bcuAnswerfield.length>
	<cfset size = maxlength + 1>
	<cfif size gt 15>
		<cfset size = 15>
	</cfif>
	<cfset underscore = maxlength * 2>
	<cfif underscore gt 12>
		<cfset underscore = 12>
	</cfif>
</cfif>

</cfsilent>
<cfif attributes.mode neq 'print'>
	<cfoutput><input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="#size#" maxlength="#maxlength#"></cfoutput>
<cfelse>
	<cfoutput>#RepeatString('_', underscore)#</cfoutput>
</cfif><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "n-#attributes.code#")>
</cfif>

</cfsilent>