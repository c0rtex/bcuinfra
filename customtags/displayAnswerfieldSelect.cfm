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
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="-1" var="matchVal">
</cfif>
<cfset options = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>
</cfsilent><cfif attributes.mode neq 'print'><cfoutput><select name="#attributes.code#">
	<option value="">-- Select one --</option>
	<cf_loopPoolStruct struct="options" index="optionName">
		<!--- <cf_cacheOptionPool action="get" code="#optionName#" var="optionStruct"> --->
        <cfset optionStruct = application.OptionPool.getOption(optionName)>
		<cf_ifOptionIncluded struct="optionStruct">
			<option value="#optionStruct.id#-#optionName#"<cfif matchVal eq optionStruct.id> selected</cfif>><cf_displayText group="option" code="option_#optionName#" stripTags="true"></option>
		</cf_ifOptionIncluded>
	</cf_loopPoolStruct>
</select></cfoutput><cfelse><cfsilent>
	<cfset optionCount = 0>
	<cf_loopPoolStruct struct="options" index="optionName">
		<!--- <cf_cacheOptionPool action="get" code="#optionName#" var="optionStruct"> --->
        <cfset optionStruct = application.OptionPool.getOption(optionName)>
		<cf_ifOptionIncluded struct="optionStruct">
			<cfset optionCount = optionCount + 1>
		</cf_ifOptionIncluded>
	</cf_loopPoolStruct>
	<cfset breakpoint = Max(2, optionCount / 2 + .5)>
	<cfset pointer = 1>
	<cfset placeholder = 1>
	<cfset maxholder = 0>
	<cfset leftCol = ArrayNew(1)>
	<cfset rightCol = ArrayNew(1)>
	<cf_loopPoolStruct struct="options" index="optionName">
		<!--- <cf_cacheOptionPool action="get" code="#optionName#" var="optionStruct"> --->
        <cfset optionStruct = application.OptionPool.getOption(optionName)>
		<cf_ifOptionIncluded struct="optionStruct">
			<cfif pointer gt breakpoint>
				<cfset breakpoint = 9999>
				<cfset placeholder = 1>
			</cfif>
			<cf_displayText group="option" code="option_#optionName#" stripTags="true" var="optionText">
			<cfif breakpoint eq 9999>
				<cfset rightCol[placeholder] = Trim(optionText)>
			<cfelse>
				<cfset leftCol[placeholder] = Trim(optionText)>
			</cfif>
			<cfif placeholder gt maxholder>
				<cfset maxholder = placeholder>
			</cfif>
			<cfset pointer = pointer + 1>
			<cfset placeholder = placeholder + 1>
		</cf_ifOptionIncluded>
	</cf_loopPoolStruct>
	</cfsilent>
	</tr>
	<tr>
		<td colspan="9" class="question-space"></td>
	</tr>
	<tr class="question-print">
		<td colspan="3"></td>
		<td colspan="6" class="q-text">[Check only one]</td>
	</tr>
	<tr>
		<td colspan="9" class="question-space"></td>
	</tr>
	<tr>
		<td colspan="4"></td>
		<td colspan="5"><table align="left" border="0" cellspacing="0" cellpadding="0"><tr class="question-print"><td width="50%" class="q-text"><table align="left" border="0" cellspacing="3" cellpadding="0">
		<cfoutput>
		<cfloop from="1" to="#ArrayLen(leftCol)#" index="x">
		<tr class="question-print">
			<td class="q-text">____&nbsp;</td>
			<td class="q-text">#leftCol[x]#</td>
		</tr>
		</cfloop>
		<cfif ArrayLen(rightCol) gt 0>
		</table></td><td>&nbsp;&nbsp;&nbsp;</td><td width="50%" class="q-text"><table align="left" border="0" cellspacing="3" cellpadding="0">
		<cfloop from="1" to="#ArrayLen(rightCol)#" index="x">
		<tr class="question-print">
			<td class="q-text">____&nbsp;</td>
			<td class="q-text">#rightCol[x]#</td>
		</tr>
		</cfloop>
		</cfif>
		</cfoutput>
		</table></td>
	</tr></table></td>
</cfif><cfsilent>
<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "o-#attributes.code#")>
</cfif>
</cfsilent>