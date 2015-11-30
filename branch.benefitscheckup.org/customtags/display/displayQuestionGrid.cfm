<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode eq 'print' or attributes.mode eq 'XML'>
	<cfset stripTags = true>
<cfelse>
	<cfset stripTags = false>
</cfif>

<cfset qobj = application.QuestionPool.getQuestion(attributes.code)>
<cf_cacheSubsetQuestionGridrowPool action="get" subset_id="#session.subset_id#" question="#attributes.code#" var="sqgobj">

</cfsilent><cfif attributes.mode neq "XML"><cfoutput>
	<tr>
		<td colspan="9" class="question-space"></td>
	</tr>
	<tr class="question-print">
		<td colspan="3"></td>
		<td colspan="6"><table width="580" align="left" border="0" cellspacing="5" cellpadding="0">
			<tr class="question-print">
				<td width="250" class="q-text">&nbsp;</td>
				<cf_loopPoolStruct struct="qobj" sortBy="gsort" index="gccode">
					<cf_displayText group="gridcol" code="gridcol_#gccode#" var="gctext">
					<cf_cacheGridcolumnPool action="get" code="#gccode#" var="gcobj">
					<cfif attributes.mode eq 'print' or gcobj.help eq ''>
						<cfset colhead = gctext>
					<cfelse>
                    	<cf_buildPopupLink code="#gcobj.help#" text="#gctext#" var="colhead">
					</cfif>
					<td width="75" class="q-text-center"><strong>#colhead#</strong></td>
				</cf_loopPoolStruct>
			</tr>
		<cf_loopPoolStruct struct="sqgobj" index="grcode">
			<cf_displayText group="gridrow" code="gridrow_#grcode#" var="grtext">
			<cf_cacheGridrowPool action="get" code="#grcode#" var="grobj">
			<cfif attributes.mode eq 'print' or grobj.help eq ''>
				<cfset rowhead = grtext>
			<cfelse>
				<cf_buildPopupLink code="#grobj.help#" text="#grtext#" var="rowhead">
			</cfif>
			<tr class="question-print">
				<td width="250" class="q-text">#rowhead#</td>
				<cf_loopPoolStruct struct="qobj" sortBy="gsort" index="gccode">
					<cf_cacheGridrowGridcolumnPool action="get" code="#grcode#_#gccode#" var="ggobj">			
                    <cfset ansObj = application.answerfieldPool.getAnswerfield(ggobj.af)>
					<cfset type = ansObj.type> 
					<td width="75" class="q-text-center"><cf_displayAnswerfield code="#ggobj.af#" type="#type#" showText="false" aflistvarname="caller.#attributes.aflistvarname#"></td>
				</cf_loopPoolStruct>
			</tr>
		</cf_loopPoolStruct>
		</table><cfif session.subset_id eq 63><p>&nbsp;</p></cfif></td>
</cfoutput>
<cfelse>
	<cf_loopPoolStruct struct="sqgobj" index="grcode">
	<cf_displayText group="gridrow" code="gridrow_#grcode#" var="grtext">
	<cf_cacheGridrowPool action="get" code="#grcode#" var="grobj">
	<cf_loopPoolStruct struct="qobj" sortBy="gsort" index="gccode">
	<cf_cacheGridrowGridcolumnPool action="get" code="#grcode#_#gccode#" var="ggobj">
    <cfset ansObj = application.answerfieldPool.getAnswerfield(ggobj.af)>
	<cfset type = ansObj.type> 
    <cfset id = ansObj.id>
<cfset caller.outputXML = caller.outputXML & '
<Answerfield type="#type#" id="#id#"'>
<cfset caller.outputXML = caller.outputXML & ' name="#ggobj.af#"  label="#gccode#:#grtext#"'>
<cfset caller.outputXML = caller.outputXML & '></Answerfield>
							'>
 </cf_loopPoolStruct>
</cf_loopPoolStruct>
</cfif>