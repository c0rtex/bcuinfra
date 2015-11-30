<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.name" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.width" type="numeric" default="720">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfparam name="attributes.zip" type="string" default="">
<cfparam name="attributes.useHardcodedOrder" type="boolean" default="false">
<cfparam name="attributes.debug" type="boolean" default="false">
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
    
    <!--- ###### TESTING THE NEW CFC FOR handleScreening ###### 
    <cfset attributes.mode = createObject("component","com.bcu.screening.handleScreening").init(element='mode').getScreening()>--->
</cfif>

<cfset subwidth = attributes.width - 270>
<cfif attributes.mode neq 'print'>
	<cfset aflist = ''>
</cfif>

<cfset preHardcodedQuestionsList = 'client,gender,st,pri_resident,city,zip'>
<cfset postHardcodedQuestionsList = 'incomegrid,assetgrid,drugs,learn,race,hispanic'>

<cfset postHardcodedDisplayList = ''>
</cfsilent>
<cfif attributes.mode neq "remote">
<cf_buildQuestionnaireStyle>
</cfif>
<!--- if SPQ, include a hidden field to facilitate a zipcode-based state change --->
<cfif attributes.mode eq 'full'>
	<input type="hidden" name="zyxzip_state_change" value="" />
</cfif>

<cfoutput>
<cfif attributes.mode neq "remote">
<table width="#attributes.width#" align="center" border="0" cellpadding="0" cellspacing="0">
<tr class="pagebreak">
<td width="40"><img src="img/spacer.gif" width="40" height="1" hspace="0" vspace="0"></td>
<td width="10"><img src="img/spacer.gif" width="10" height="1" hspace="0" vspace="0"></td>
<td width="10"><img src="img/spacer.gif" width="10" height="1" hspace="0" vspace="0"></td>
<td width="10"><img src="img/spacer.gif" width="10" height="1" hspace="0" vspace="0"></td>
<td width="#subwidth#"><img src="img/spacer.gif" width="#subwidth#" height="1" hspace="0" vspace="0"></td>
<td width="10"><img src="img/spacer.gif" width="10" height="1" hspace="0" vspace="0"></td>
<td width="50"><img src="img/spacer.gif" width="50" height="1" hspace="0" vspace="0"></td>
<td width="10"><img src="img/spacer.gif" width="10" height="1" hspace="0" vspace="0"></td>
<td width="130"><img src="img/spacer.gif" width="130" height="1" hspace="0" vspace="0"></td>
</tr>
<cfelse>
<h1>Mode #attributes.mode#</h1>
</cfif>
<cfif attributes.useHardcodedOrder>
	<!--- If using hardcoded question order (old-style order), then loop through prescreen questions first --->
	<cfloop list="#preHardcodedQuestionsList#" index="code">
		<cfif IsDefined("session.screening.q.#code#")>
        	<cf_displayQuestion mode="#attributes.mode#" code="#code#" form="#attributes.name#">
        </cfif>
	</cfloop>
	<!--- Next, loop through main question set, ignoring pre- and postscreen questions --->
	<cf_loopPoolStruct struct="session.screening" sortBy="qsort" index="code">
		<cfif ListFind(postHardcodedQuestionsList, code)>
        	<cfset postHardcodedDisplayList = ListAppend(postHardcodedDisplayList, code)>
        <cfelseif not ListFind(preHardcodedQuestionsList, code)>
        	<cf_displayQuestion mode="#attributes.mode#" code="#code#" form="#attributes.name#">
        </cfif>
	</cf_loopPoolStruct>
	<!--- Finally, loop through postscreen questions --->
	<cfloop list="#postHardcodedDisplayList#" index="code">
		<cfif IsDefined("session.screening.q.#code#") and not (code eq 'learn' and not session.partnerLearnFlag) and not (code eq 'learn' and session.partner_id eq 22 and session.org_id gt 0) and not (code eq 'race' and not session.partnerRaceFlag) and not (code eq 'hispanic' and not session.partnerHispanicFlag)>
        	<cf_displayQuestion mode="#attributes.mode#" code="#code#" form="#attributes.name#" useHardcodedOrder="#attributes.useHardcodedOrder#">
        </cfif>
	</cfloop>
<cfelse>
	<cfset questionnaireXML = "">
	<cf_loopPoolStruct struct="session.screening" sortBy="qsort" index="code">
		<cfif not (code eq "food_security" AND session.partner_id NEQ 0) and not (code eq "fit_last_name_2" AND session.partner_id NEQ 76) and not (code eq "fit_agency_id_2" AND session.partner_id nEQ 76) and not (code eq "fit_counseling_session_type" AND session.partner_id nEQ 76) and not (code eq 'learn' and not session.partnerLearnFlag) and not (code eq 'race' and not session.partnerRaceFlag) and not (code eq 'hispanic' and not session.partnerHispanicFlag) and not (session.partner_id eq 27 and session.subset_id eq 51 and code eq 'fit_counseling_session_type_2' )>
			<cfif (code NEQ "fit_last_name_2" OR code NEQ "fit_agency_id_2" or code NEQ "fit_counseling_session_type")  and  (code neq 'chicago_agency_screening' or session.partner_id eq 81) and  (code neq 'pl_agency_screening' or session.partner_id eq 81 or session.partner_id eq 61 or session.partner_id eq 63 or session.partner_id eq 102)  AND (code neq 'hr_healthplan_screening' or session.partner_id eq 47) and (code neq 'int_chase_direct_deposit' or (session.partner_id eq 0 and session.org_id lt 1)) and (code neq 'reverse_mortgage' or (session.partner_id eq 0 and session.org_id lt 1))>
				<cfif attributes.mode eq "remote">
			 		<cf_displayQuestionXML mode="remote" code="#code#" form="#attributes.name#" debug="#attributes.debug#">
					<cfset questionnaireXML = questionnaireXML & outputXML >
                		<cfelse>
                			<cfif code neq 'chronic_condition' or ((session.partner_id eq 0 or session.partner_id eq 58) and session.subset_id eq 0)>
                				<cf_displayQuestion mode="#attributes.mode#" code="#code#" form="#attributes.name#" debug="#attributes.debug#">
					</cfif>
                    		</cfif>
			</cfif>
		</cfif>
	</cf_loopPoolStruct>
    
	<cfif attributes.mode eq "remote">
    <cfsilent>
		<cfset caller.questionnaireXML = "
<Questionnaire><Questions>" 
& questionnaireXML & "
</Questions>
</Questionnaire>">
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"</strong>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<strong>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<b>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<li>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"</li>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<i>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"</i>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"</b>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<u>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"</u>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"&","&amp;","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"'","&apos;","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<br>","","ALL")#>
<cfset caller.questionnaireXML = #replacenocase(caller.questionnaireXML,"<strong>Please Note:</strong>","Please Note:","ALL")#>
</cfsilent>
	</cfif>
</cfif>
<cfif attributes.mode neq "remote"></table></cfif>
</cfoutput>
<cfsilent>
<cfif attributes.mode neq 'print'>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), aflist)>
</cfif>
</cfsilent>