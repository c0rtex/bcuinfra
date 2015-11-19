<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode eq 'print' or attributes.mode eq 'xml'>
	<cfset stripTags = true>
<cfelse>
	<cfset stripTags = false>
</cfif>

<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#session.state_id#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="#attributes.code#" var="checkboxes">

<cfset cbCount = 0>
<cf_loopPoolStruct struct="checkboxes" index="checkboxName">
	<cfset ansObj = application.answerfieldPool.getAnswerfield(checkboxName)>
	<cfset state_id = ansObj.state_id>
	<cfif  state_id eq '' or state_id eq '#session.state_id#'>
		<cfset cbCount = cbCount + 1>
	</cfif>
</cf_loopPoolStruct>
<cfset breakpoint = Max(2, cbCount / 2 + .5)>
<cfset pointer = 1>
<cfset placeholder = 1>
<cfset maxholder = 0>
<cfset leftCol = ArrayNew(1)>
<cfset leftAF = ArrayNew(1)>
<cfset leftType = ArrayNew(1)>
<cfset rightCol = ArrayNew(1)>
<cfset rightAF = ArrayNew(1)>
<cfset rightType = ArrayNew(1)>
<cf_loopPoolStruct struct="checkboxes" index="checkboxName">
        <cfset ansObj = application.answerfieldPool.getAnswerfield(checkboxName)>
		<cfset type = ansObj.type> 
    	<cfset state_id = ansObj.state_id>
	<cfif state_id eq '' or state_id eq '#session.state_id#'>
		<cfif pointer gt breakpoint>
			<cfset breakpoint = 9999>
			<cfset placeholder = 1>
		</cfif>
		<cf_displayText group="answerfield" code="answerfield_#checkboxName#" stripTags="#stripTags#" var="checkboxText">
		<cfif breakpoint eq 9999>
			<cfset rightCol[placeholder] = Trim(checkboxText)>
			<cfset rightAF[placeholder] = checkboxName>
			<cfset rightType[placeholder] = type>
		<cfelse>
			<cfset leftCol[placeholder] = Trim(checkboxText)>
			<cfset leftAF[placeholder] = checkboxName>
			<cfset leftType[placeholder] = type>
		</cfif>
		<cfif placeholder gt maxholder>
			<cfset maxholder = placeholder>
		</cfif>
		<cfset pointer = pointer + 1>
		<cfset placeholder = placeholder + 1>
	</cfif>
</cf_loopPoolStruct>
</cfsilent><cfif attributes.mode neq 'xml'><tr>
	<td colspan="9" class="question-space"></td>
</tr>
<tr class="question-print">
	<td colspan="3"></td>
	<td colspan="6" class="q-text">[Check all that apply]</td>
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
		<td class="q-text"><cfif attributes.mode eq 'print'>____<cfelse><cf_displayAnswerfield code="#leftAF[x]#" type="#leftType[x]#" showText="false" aflistvarname="caller.#attributes.aflistvarname#"></cfif>&nbsp;</td>
		<td class="q-text">#leftCol[x]#</td>
	</tr>
	</cfloop>
	<cfif ArrayLen(rightCol) gt 0>
	</table></td><td>&nbsp;&nbsp;&nbsp;</td><td width="50%" class="q-text"><table align="left" border="0" cellspacing="3" cellpadding="0">
	<cfloop from="1" to="#ArrayLen(rightCol)#" index="x">
	<tr class="question-print">
		<td class="q-text"><cfif attributes.mode eq 'print'>____<cfelse><cf_displayAnswerfield code="#rightAF[x]#" type="#rightType[x]#" showText="false" aflistvarname="caller.#attributes.aflistvarname#"></cfif>&nbsp;</td>
		<td class="q-text">#rightCol[x]#</td>
	</tr>
	</cfloop>
	</cfif>
	</cfoutput>
	</table></td>
</tr></table></td>
<cfelse><cfloop from="1" to="#ArrayLen(leftCol)#" index="x">
		<cfset caller.outputXML = caller.outputXML &  '
		<Answerfield type="checkbox" id="#caller.ans.id#"'>
					<cfset caller.outputXML = caller.outputXML & ' name="#leftAF[x]#" label="#leftCol[x]#">'>
					<cfset caller.outputXML = caller.outputXML & '</Answerfield>
						'>
	</cfloop>
	<cfloop from="1" to="#ArrayLen(rightCol)#" index="x">
		<cfset caller.outputXML = caller.outputXML &  '
		<Answerfield type="checkbox" id="#caller.ans.id#"'>
					<cfset caller.outputXML = caller.outputXML & ' name="#rightAF[x]#" label="#rightCol[x]#">'>
					<cfset caller.outputXML = caller.outputXML & '</Answerfield>
						'>
	</cfloop>
</cfif>