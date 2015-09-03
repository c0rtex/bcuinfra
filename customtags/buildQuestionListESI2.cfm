<cfparam name="attributes.page" type="numeric">
<cfparam name="attributes.edit" type="numeric" default="0">
<cfparam name="attributes.continue" type="numeric" default="0">
<cfparam name="attributes.errorlist" type="string" default="">
<cfparam name="attributes.all" type="boolean" default="false">
<cfparam name="attributes.listvar" type="string" default="accumAFList">

<cfif attributes.edit eq 2 and attributes.errorlist eq ''>
	<cfset attributes.page = -1>
</cfif>
<cfset redirectURL = ''>
<!--- First, loop through session.screenings.questions structure, testing rules for the questions in limbo. --->
<cfif attributes.errorlist neq ''>
	<cfset error = true>
	<cfset repeat = false>
	<cfset findQuestion = 0>
	<cfset startQuestion = 0>
	<cfset startPage = attributes.page>
	<cfloop condition="startQuestion eq 0 and findQuestion lt StructCount(session.screening.qsort)">
		<cfset findQuestion = findQuestion + 1>
		
		<cfset qcode = StructFind(session.screening.qsort, findQuestion)>
		<cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="qspg">
		<cfif qspg eq startPage>
			<cfset startQuestion = findQuestion>
		</cfif>
	</cfloop>
<cfelseif attributes.continue eq 2>
	<cfif session.subset_id IS 61>
    	<cfset redirectURL="fit_actionplan.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif session.subset_id eq 63>
    	<cfset redirectURL="esi_actionplan.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
    	<cfelse>
	<cfset redirectURL="procShadow.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&fromesi=yes">
    	</cfif>
<cfelseif attributes.edit eq 1 or ListFind(session.screening.pglist, attributes.page) lt ListLen(session.screening.pglist)>
	<cfset error = false>
	<cfset repeat = true>
	<cfset findQuestion = 0>
	<cfset startQuestion = 0>
	<cfif attributes.edit eq 1>
		<cfset startPage = attributes.page>
	<cfelse>
		<cfset startPage = ListGetAt(session.screening.pglist, ListFind(session.screening.pglist, attributes.page) + 1)>
	</cfif>
	<cfloop condition="startQuestion eq 0 and findQuestion lt StructCount(session.screening.qsort)">
		<cfset findQuestion = findQuestion + 1>
		<cfset qcode = StructFind(session.screening.qsort, findQuestion)>
		<cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="qspg">
		<cfif qspg eq startPage>
			<cfset startQuestion = findQuestion>
		</cfif>
	</cfloop>
<cfelseif attributes.continue eq 1>
	<cfset error = false>
	<cfset repeat = false>
	<cfset findQuestion = 0>
	<cfset startQuestion = 0>
	<cfset startPage = attributes.page>
	<cfloop condition="startQuestion eq 0 and findQuestion lt StructCount(session.screening.qsort)">
		<cfset findQuestion = findQuestion + 1>
		<cfset qcode = StructFind(session.screening.qsort, findQuestion)>
		<cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="qspg">
		<cfif qspg eq startPage>
			<cfset startQuestion = findQuestion>
		</cfif>
	</cfloop>
	<cfset session.screening.cont = 1>
<cfelse>
	<cfset error = false>
	<cfset repeat = false>
	<cf_loopPoolStruct scope="session" struct="screening" sortBy="qsort" index="x">
		<cf_handleScreeningQuestion action="get" code="#x#" element="status" var="status">
        		<cfset qobj = application.QuestionPool.getQuestion(x)>
		<cfif qobj.rule eq ''>
			<cfset rule = ''>
		<cfelse>
			<cf_cacheRulePool action="get" code="#qobj.rule#" var="ruleobj">
			<cfset rule = ruleobj.text>
		</cfif>
		<cfif status eq 0>
			<cfif rule eq ''>
				<cf_handleScreeningQuestion action="set" code="#x#" status="2">
			<cfelse>
				<cf_testCondition condition="#rule#">
				<cf_handleScreeningQuestion action="set" code="#x#" status="#value#">
			</cfif>
		</cfif>
	</cf_loopPoolStruct>
	<cfset findQuestion = 0>
	<cfset startQuestion = 0>
	<cfset startPage = 0>
	<cfloop condition="startQuestion eq 0 and findQuestion lt StructCount(session.screening.qsort)">
		<cfset findQuestion = findQuestion + 1>
		<cfset qcode = StructFind(session.screening.qsort, findQuestion)>
		<cf_handleScreeningQuestion action="get" code="#qcode#" element="status" var="qstatus">
		<cfif qstatus eq 2>
			<cfset startQuestion = findQuestion>
			<cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="startPage">
		</cfif>
	</cfloop>
	<cfset session.screening.pglist = ListAppend(session.screening.pglist, startPage)>
</cfif>

<!--- Get answerfield values needed in later ELSEIF condition of IF block --->
<cf_handleScreeningAnswerfield action="get" code="be_sav_lmt_xnd" element="val" var="valBeSavLmtXnd">
<cf_handleScreeningAnswerfield action="get" code="med_receive" element="val" var="valMedReceive">
<cf_handleScreeningAnswerfield action="get" code="receive_msp" element="val" var="valReceiveMsp">
<cf_handleScreeningAnswerfield action="get" code="ssi_receive" element="val" var="valSsiReceive">
<cf_handleScreeningAnswerfield action="get" code="ct_receive_medicare_xnd" element="val" var="valCtReceiveMedicareXnd">
<cf_handleScreeningAnswerfield action="get" code="ct_ss_disblty_xnd" element="val" var="valCtSsDisbltyXnd">
<cf_handleScreeningAnswerfield action="get" code="ct_older_xnd" element="val" var="valCtOlderXnd">
<cfif redirectURL neq ''>
	<cflocation url="#redirectURL#">
<cfelseif (startQuestion eq 0 or attributes.page eq -1 or (IsDefined("application.pgrecap.pg#startPage#") And Evaluate("application.pgrecap.pg#startPage#") eq 1 and attributes.continue eq 0) )and session.subset_id neq 63>

<!--- START RECAP PAGE --->
	<cfif IsDefined("application.pgrecap.pg#startPage#") And Evaluate("application.pgrecap.pg#startPage#") eq 1>
		<cfset session.screening.postrecap = startPage>
	</cfif>
	<cfoutput>
	<cf_displayText code="site_turboapp_qaire_recap" group="site"><br><br>
	<cfset prevPage = 0>
	<cfset prevTitlePage = 0>
	<table border="0" cellspacing="2" cellpadding="2" width="600">
	<cfloop from="1" to="#StructCount(session.screening.qsort)#" index="x">
		<cfset recapCode = StructFind(session.screening.qsort, x)>
		<cf_handleScreeningQuestion action="get" code="#recapCode#" element="status" var="recapStatus">
		<cf_handleScreeningQuestion action="get" code="#recapCode#" element="spg" var="recapSubsetPage">
		<cf_handleScreeningQuestion action="get" code="#recapCode#" element="qno" var="recapQNum">
		
		<cfif recapStatus eq 3>
            <cfset qobj = application.QuestionPool.getQuestion(recapCode)>
			<cf_loopPoolStruct struct="qobj" index="y">
                <cfset afobj = application.AnswerfieldPool.getAnswerfield("#y#")>
				<cf_handleScreeningAnswerfield action="get" code="#y#" element="val" var="valVal">
 				<cf_handleScreeningAnswerfield action="get" code="#y#" element="type" var="valType">
				<cfif valType eq 3 and valVal neq ''>
                	<cfset myPool = application.OptionPool.getOptions()>
					<cfset valOpt = StructFind(mypool.sort, valVal)>
				</cfif>
				<cf_handleScreeningAnswerfield action="get" code="#y#" element="recap" var="valRecap">
				<cfif valRecap neq ''>

					<cfif prevPage And prevPage neq recapSubsetPage>
						</table><br>
						<cfform action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
							<input type="submit" value="Edit Responses">
							<input type="hidden" name="page" value="#prevPage#">
							<input type="hidden" name="edit" value="1">
						</cfform>
						<hr>
						<table border="0" cellspacing="2" cellpadding="2" width="600">
					</cfif>
					<cfif prevTitlePage neq recapSubsetPage>
						<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 13pt; color: black; font-weight: bold;">
							<td colspan="3"><cf_displayText code="pgtitle_#Evaluate("application.pgvars.pg#recapSubsetPage#")#" group="pgtitle" alt=" "><br>&nbsp;</td>
						</tr>
					</cfif>

					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td valign="top" style="font-weight: bold;" width="400"><cf_displayText code="afshort_#y#" group="afshort" alt="#y#"></td>
						<td>&nbsp;&nbsp;&nbsp;</td>
						<td valign="top" width="500">
							<cfif afobj.type eq 'no'>
								<cfif valVal eq 1>No<cfelse>Yes</cfif>
							<cfelseif valType eq 3>
                            	<!--- Adding in conditional to reverse the yes/no order for one question. --->
                            	<cfif afobj.id eq 6259>
                                	<cfif valVal IS "">
                                    	<b>Interested in MSP</b> - Since you did not respond to this question, our assumption is that you are interested in MSP. If this is not correct, select "Edit Responses" to go back and change your answer.
                                    <cfelse>
                                        <b>Not interested in MSP</b> - You are <b><u>not</u></b> interested in MSP. If this is not correct, select "Edit Responses" to go back and change your answer.                                    
                                    </cfif>
                                <cfelse>
									<cfif valVal neq ''>
                                        <cf_displayText group="option" code="option_#valOpt#">
                                    </cfif>
                                </cfif>
                                <!--- end conditional for reversing order --->
							<cfelseif afobj.type eq 'month' and IsNumeric(valVal)>
                            	<cf_displayText code="calendar_month_#valVal#" group="calendar" alt="#valVal#">
                            <cfelse>
                            	#valVal#
                            </cfif>
                        </td>
					</tr>

					<cfset prevPage = recapSubsetPage>
					<cfset prevTitlePage = recapSubsetPage>

				</cfif>
			</cf_loopPoolStruct>

		</cfif>
		
	</cfloop></table><br>
	<cfform action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
		<input type="submit" value="Edit Responses">
		<input type="hidden" name="page" value="#prevPage#">
		<input type="hidden" name="edit" value="1">
	</cfform><br>

	<cfif session.screening.postrecap gt 1>
		<form action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
			<input type="submit" value="Continue">
			<input type="hidden" name="page" value="#session.screening.postrecap#">
			<input type="hidden" name="continue" value="1">
		</form>		
	<cfelse>
		<cf_displayText code="site_turboapp_qaire_submit" group="site"><br><br>
		<form action="procShadow.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
			<!---<cf_displayText code="site_turboapp_not_for_test_submissions" group="site"><br><br>--->
			<input type="submit" value="Submit Your Application">
		</form>
	</cfif>

	</cfoutput>
<cfelseif Not IsDefined('continue') And session.screening.pgno eq 2 And session.screening.cont eq 0 And (valBeSavLmtXnd eq 1 or valMedReceive eq 1 or valReceiveMsp eq 1 or valSsiReceive eq 1 or (valCtReceiveMedicareXnd eq 0 and valCtSsDisbltyXnd eq 0 and valCtOlderXnd eq 0))>

	<cfset showContinueButton = false>
    <cfset showPrev = true>
	<cf_handleScreeningAnswerfield action="get" code="ct_live" element="val" var="valCtLive">
	<cfif valCtReceiveMedicareXnd eq 0 and valCtSsDisbltyXnd eq 0 and valCtOlderXnd eq 0>
		<cf_displayText code="site_turboapp_submission_status_10" group="site">
	<cfelseif valMedReceive eq 1 or valReceiveMsp eq 1 or valSsiReceive eq 1>
		<cf_displayText code="site_turboapp_deemed" group="site">
	<cfelseif valBeSavLmtXnd eq 1 and ListFindNoCase('AL,AZ,CT,DC,DE,ME,MN,MS,NY,VT', valCtLive) and (valCtReceiveMedicareXnd eq 1 or valCtSsDisbltyXnd eq 1 or valCtOlderXnd eq 1)>
		<cfset showprev = false>
        <cf_displayText code="site_turboapp_special_msp_asset" group="site">
        <br />
        <br />
        <div style="float:left;padding:4px;">
        <FORM style="float:left"><INPUT TYPE="BUTTON" VALUE="Previous" ONCLICK="history.go(-1)"></FORM>
        </div>
        <div style="float:left;padding:4px;">
        <cfoutput>
        <form style="float:left" action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
        	<input type="submit" value="Continue">
        	<input type="hidden" name="page" value="#startPage#">
        	<input type="hidden" name="continue" value="1">
        </form>
        </cfoutput>
        </div>
        <div style="clear:both;"></div>
	<cfelseif valBeSavLmtXnd eq 1>
    	<cfset showprev = false>
        <div style="float:left;padding:4px;">
        <FORM><INPUT TYPE="BUTTON" VALUE="Previous" ONCLICK="history.go(-1)"></FORM>
        </div>
<!--[if IE]>
	<style>
		.continue_button
		{
			margin-top: 0px !important;
		}
	</style>
<![endif]-->
        <div class="continue_button" style="float:left;padding:4px;margin-top:-16px;">
        <cfoutput>
        <form action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
        	<input type="submit" value="Continue">
        	<input type="hidden" name="page" value="#startPage#">
        	<input type="hidden" name="continue" value="1">
        </form>
        </cfoutput>
        </div>
        <div style="clear:both;"></div>
		<cf_displayText code="site_turboapp_not_eligible" group="site">
        <br />
        <div style="float:left;padding:4px;">
        <FORM><INPUT TYPE="BUTTON" VALUE="Previous" ONCLICK="history.go(-1)"></FORM>
        </div>
        <div style="float:left;padding:4px;">
        <cfoutput>
        <form action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
        	<input type="submit" value="Continue">
        	<input type="hidden" name="page" value="#startPage#">
        	<input type="hidden" name="continue" value="1">
        </form>
        </cfoutput>
        </div>
        <div style="clear:both;"></div>
	<cfelse>
		<cf_displayText code="site_turboapp_submission_status_10" group="site">
	</cfif>
	
	<br></form>
    <cfif showPrev>
		<cfoutput>
			<div style="float:left;padding:4px;">
            <FORM><INPUT TYPE="BUTTON" VALUE="Previous" ONCLICK="history.go(-1)"></FORM>
            </div>
        </cfoutput>
   </cfif>
	<cfoutput>
	<cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
		</form>
		<cfif IsDefined('session.oe_server_id') and session.oe_server_id neq ''>
		<form action="https://#session.oe_server_id#.benefitscheckup.org/oe/menu.do" method="post" target="_top">
		<cfelse>
		<form action="https://#application.serverPathOE#/menu.do" method="post" target="_top">
		</cfif>
			<input type="submit" value="Return to OE Home">
	</cfif>
	<cfif showContinueButton>
		</form>
		<form action="questions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
			<input type="submit" value="Continue">
			<input type="hidden" name="page" value="#startPage#">
			<input type="hidden" name="continue" value="1">
	</cfif>
	</cfoutput>
	
<cfelse>
	<cfoutput>
<!--- START PROCESSING AND DISPLAYING QUESTIONS --->
	<cfif session.subset_id NEQ 61 and session.subset_id NEQ 63>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr style="font-weight: bold; font-size: 14pt;">
                <td align="left" valign="top">
                    <cf_displayText code="pgtitle_#Evaluate("application.pgvars.pg#startPage#")#" group="pgtitle" alt=" ">
                    <cfif application.debug><br><span style="font-size: 11pt;">(id = <span style="color: ##880000;">#session.screening.id#</span>; startPage = <span style="color: ##00656C;">#startPage#</span>; startQuestion = <span style="color: ##888800;">#startQuestion#</span>; postRecap = <span style="color: ##000088;">#Evaluate("application.pgrecap.pg#startPage#")#</span>)</span></cfif></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <cfif session.subset_id NEQ 61>
                    <td style="font-size: 11pt;" align="right" valign="top"><a href="onlineapphelp.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">Need&nbsp;Help?</a></td>
                </cfif>
            </tr>
        </table>
        <p style="font-weight: bold; font-size: 11pt;"><cf_displayText code="page_#Evaluate("application.pgvars.pg#startPage#")#" group="page" alt=" "></p>
	<cfelse>
    	<cfif session.subset_id EQ 63>
        	<cfif application.debug><p>(id = <span style="color: ##880000;">#session.screening.id#</span>; startPage = <span style="color: ##00656C;">#startPage#</span>; startQuestion = <span style="color: ##888800;">#startQuestion#</span>; postRecap = <span style="color: ##000088;">#Evaluate("application.pgrecap.pg#startPage#")#</span>)</p>
			</cfif>
        <cfelse>
   			<cfif application.debug><br><span style="font-size: 11pt;">(id = <span style="color: ##880000;">#session.screening.id#</span>; startPage = <span style="color: ##00656C;">#startPage#</span>; startQuestion = <span style="color: ##888800;">#startQuestion#</span>; postRecap = <span style="color: ##000088;">#Evaluate("application.pgrecap.pg#startPage#")#</span>)</span></cfif>
       	</cfif>
    </cfif>
	<cfif error>
    	<cfif session.subset_id neq 63 and partner_id neq 77>
    		<p style="font-weight: bold; color: red;"><cf_displayText code="error_completed_incorrectly" group="error"></p>
       	<cfelse>
        	<cfset session.screening.qnum = 1>
        	<p style="font-weight: bold; color: red;">We're sorry, but some responses are missing or were completed incorrectly. Please<BR />correct the problems where indicated below.</p>
        </cfif>
    </cfif>
    <!--- Start showing ESI Questions --->
	<cfif session.subset_id EQ 63>
		<cfset templist = ''>
		<cfset prevPage = startPage>
        <cfset qcode = StructFind(session.screening.qsort, startQuestion)>
        <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="thisPage">
        <cfset fitCount = 1>
        <cfset supCount = 0>
        <cfset qNotShown = 0>
        <cfset qToShow = #StructCount(session.screening.qsort)# - #startQuestion# + 1>
 
        <cfloop condition="startQuestion lte StructCount(session.screening.qsort) and prevPage eq thisPage">
			<!--- START QUESTION LOOP --->
            <cf_handleScreeningQuestion action="get" code="#qcode#" element="status" var="qstatus">
            <cfif qstatus eq 2 or ((error or repeat) and qstatus eq 3)>
                <cfif not error and not repeat>
                    <cfif #FindNoCase("esi_header",Qcode)# eq 0><cfset session.screening.qno = session.screening.qno + 1></cfif>
                    <cf_handleScreeningQuestion action="set" code="#qcode#" qno="#session.screening.qno#">
				<cfelseif  session.screening.qno gte 9 and  session.screening.qno lt 33 and repeat >
                    <cfif #FindNoCase("esi_header",Qcode)# eq 0><cfset session.screening.qno = session.screening.qno + 1></cfif>
                    <cf_handleScreeningQuestion action="set" code="#qcode#" qno="#session.screening.qno#">
                </cfif>
                <cfset qGroup = ''>
                <cfset qError = ''>
                <cfset qErrorAccum = ''>
                <cfset qNameFirst = ''>
                <cfset qCount = 0>
                <cfset qobj = application.QuestionPool.getQuestion(qcode)>
                <cf_loopPoolStruct struct="qobj" index="element">
                    <cfif ListFindNoCase(attributes.errorlist, element)>
                        <cf_handleScreeningAnswerfield action="get" code="#element#" element="group" var="qGroup">
                        <cf_handleScreeningAnswerfield action="get" code="#element#" element="error" var="qError">
                        <cf_displayText code="afshort_#element#" group="afshort" alt="#element#" var="qName">
                        <cf_displayText group="#qGroup#" code="#qGroup#_#qError#" var="qText">
                        <cfif qErrorAccum eq ''>
                            <cfset qNameFirst = qName>
                        <cfelse>
                            <cfset qErrorAccum = qErrorAccum & "<br>#qName#: ">
                        </cfif>
                        <cfset qErrorAccum = qErrorAccum & "#qText#">
                    </cfif>
                    <cfset qCount = qCount + 1>
                </cf_loopPoolStruct>
				<cfif qCount gt 1 and qErrorAccum neq ''>
                    <cfset qErrorAccum = "#qNameFirst#: " & qErrorAccum>
                </cfif>
                <cf_handleScreeningQuestion action="get" code="#qcode#" element="qno" var="qno">
              	<!--- send the question for formatting --->
                <!--- Category Divider handling --->
                <cfif FindNoCase("esi_header",Qcode) GT 0><p><h2 style="background-color:##C6E5FD; font-weight:700; line-height:26px; margin-bottom:5px; margin-top:25px; padding:5px; color:##1f419b;"><cf_displayText code="question_#qcode#" group="question"></h2></p>
                <!--- Question handling --->
                <cfelseif FindNoCase("esi_header", Qcode) EQ 0>
                    <div class="question">
                        <div class="questionHolder questionBar">
                            <span class="question_number"><cfif application.debug><a href="##" onClick="if (document.getElementById('#qcode#').style.display == 'none') document.getElementById('#qcode#').style.display = ''; else document.getElementById('#qcode#').style.display = 'none'; return false;"></cfif><cf_showQuestionNumber>.<cfif application.debug></a></cfif></span><cf_displayText code="question_#qcode#" group="question"><cf_displayHelpLink code="#qobj.help#" textonly="TRUE">
                        	<p id="#qcode#" style="display: none; font-family: arial, helvetica, sans-serif; font-size: 9pt; color: black;"><cf_buildAnswerfieldList2 debug="#qcode#"></p>
                        	<p><cf_buildAnswerfieldList2 code="#qcode#" type="#qobj.type#" format="#qobj.format#" errortext="#qErrorAccum#"></p>
                        </div><!--- questionHolder --->
					</div><!--- question --->
                    <cfif isdefined('saflist') and saflist neq ''>
                    	<cfset templist = ListAppend(templist, saflist)>
                	</cfif>
            		<cf_handleScreeningQuestion action="set" code="#qcode#" status="3">
                </cfif>
           	</cfif>
            <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="prevPage">
            <cfset startQuestion = startQuestion + 1>
            <cfif startQuestion gt StructCount(session.screening.qsort)>
                <cfset thisPage = prevPage>
            <cfelse>
                <cfset qcode = StructFind(session.screening.qsort, startQuestion)>
                <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="thisPage">
            </cfif>
            <!--- END QUESTION LOOP --->
        </cfloop>
   	<cfelse>
        <TABLE valign="top" border="0" <cfif CGI.SCRIPT_NAME EQ '/cf/esi_questions.cfm'>id="esi_questions_table"</cfif>>
            <cfset templist = ''>
            <cfset prevPage = startPage>
            <cfset qcode = StructFind(session.screening.qsort, startQuestion)>
            <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="thisPage">
            <cfset fitCount = 1>
            <cfset supCount = 0>
            <cfset qNotShown = 0>
            <cfset qToShow = #StructCount(session.screening.qsort)# - #startQuestion# + 1>
     
            <cfloop condition="startQuestion lte StructCount(session.screening.qsort) and prevPage eq thisPage">
                <!--- START QUESTION LOOP --->
                <cf_handleScreeningQuestion action="get" code="#qcode#" element="status" var="qstatus">
                <cfif qstatus eq 2 or ((error or repeat) and qstatus eq 3)>
                    <cfif not error and not repeat>
                        <cfif #FindNoCase("esi_header",Qcode)# eq 0><cfset session.screening.qno = session.screening.qno + 1></cfif>
                        <cf_handleScreeningQuestion action="set" code="#qcode#" qno="#session.screening.qno#">
    
                    <cfelseif  session.screening.qno gte 9 and  session.screening.qno lt 33 and repeat >
                        <cfif #FindNoCase("esi_header",Qcode)# eq 0><cfset session.screening.qno = session.screening.qno + 1></cfif>
                        <cf_handleScreeningQuestion action="set" code="#qcode#" qno="#session.screening.qno#">
                    </cfif>
                    <cfset qGroup = ''>
                    <cfset qError = ''>
                    <cfset qErrorAccum = ''>
                    <cfset qNameFirst = ''>
                    <cfset qCount = 0>
                                <cfset qobj = application.QuestionPool.getQuestion(qcode)>
                    <cf_loopPoolStruct struct="qobj" index="element">
                        <cfif ListFindNoCase(attributes.errorlist, element)>
                            
                            <cf_handleScreeningAnswerfield action="get" code="#element#" element="group" var="qGroup">
                            <cf_handleScreeningAnswerfield action="get" code="#element#" element="error" var="qError">
                            
                            
                            <cf_displayText code="afshort_#element#" group="afshort" alt="#element#" var="qName">
                            <cf_displayText group="#qGroup#" code="#qGroup#_#qError#" var="qText">
                            <cfif qErrorAccum eq ''>
                                <!--- 2/8/10 MH: Hardcoded exception to prefix error with recap for the FIT app only --->
                                <cfif session.subset_id eq 61 AND (qcode eq "fit_how_long_in_home" OR qcode eq "fit_cln_stay_home" OR qcode eq "fit_emergency_help" OR qcode eq "stay_hosp_nurse" OR qcode eq "fit_homeowner_fall" OR qcode eq "fit_annual_income" OR qcode eq "fit_ss" OR qcode eq "fit_get_other_inc" OR qcode eq "fit_house_age" OR qcode eq "fit_stairs_barriers" OR qcode eq "fit_loan_fut_exp") OR qcode eq "fit_bcu_assessment">
                                  <cfset qErrorAccum = qErrorAccum & "#qName#: ">
                                <cfelseif session.subset_id is 61 AND (element is "fit_health_homeowner1")>
                                    <cfif qError is "fit_homeowner2_age">
                                        <cfset qNameFirst = "Homeowner ##2 Health ">
                                    <cfelseif qError is "fit_homeowner3_age" OR qError is "fit_function_homeowner3_no2">
                                        <cfset qNameFirst = "Homeowner ##3 Health ">
                                    <cfelseif qError is "fit_homeowner_age">
                                        <cfset qNameFirst = "Homeowners ##2 and ##3 Health ">
                                    <cfelse>
                                        <cfset qNameFirst = qName>
                                    </cfif>
                                <cfelseif session.subset_id is 61 AND (element is "fit_homeowner_1")>
                                    <cfif qError is "fit_function_homeowner3_no2">
                                        <cfset qNameFirst = "Homeowner ##3">
                                    <cfelse>
                                        <cfset qNameFirst = qName>
                                    </cfif>
                                <cfelse>
                                  <cfset qNameFirst = qName>
                                </cfif>
                                
                            <cfelse>
                                <cfif session.subset_id is 61 AND (element is "fit_homeowner_1")>
                                    <cfif qError is "fit_function_homeowner3_no2">
                                        <cfset qErrorAccum = qErrorAccum & "<br>Homeowner ##3:&nbsp; ">
                                    <cfelse>
                                        <cfset qErrorAccum = qErrorAccum & "<br>#qName#: ">
                                    </cfif>
                                <cfelse>
                                    <cfset qErrorAccum = qErrorAccum & "<br>#qName#: ">
                                </cfif>
                            </cfif>
                            <cfset qErrorAccum = qErrorAccum & "#qText#">
                        </cfif>
                        <cfset qCount = qCount + 1>
                    </cf_loopPoolStruct>
                    <cfif qCount gt 1 and qErrorAccum neq ''>
                        <cfset qErrorAccum = "#qNameFirst#: " & qErrorAccum>
                    </cfif>
                    <cf_handleScreeningQuestion action="get" code="#qcode#" element="qno" var="qno">
                    <!--- send the question for formatting --->
                    <cfif session.subset_id IS 61>
                        <tr valign="top" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;<cfif qobj.sup>background-color:##BDCFC8;</cfif>">
                            <cfif NOT qobj.sup>
                                <td valign="top" align="right" width="35">
                                    <b><cfif application.debug>
                                        <a href="##" onClick="if (document.getElementById('#qcode#').style.display == 'none') document.getElementById('#qcode#').style.display = ''; else document.getElementById('#qcode#').style.display = 'none'; return false;">
                                    </cfif>#fitCount#.
                                    <cfif application.debug></a></cfif>
                                    </b>
                                </td>
                                <td>&nbsp;&nbsp;</td>
                                <cfset fitCount++>
                            <cfelse>
                                <cfset supCount++>
                            </cfif>
                            <td valign="top" colspan="<cfif qobj.sup>4<cfelse>2</cfif>" <cfif qobj.sup>style="padding:4px;margin-bottom:4px;"</cfif>>
                                <cf_displayText code="question_#qcode#" group="question"> 
                                <cfif qobj.help neq ''>
                                    <cfset trueHelpCode = listRest(qobj.help, "_")>
                                <cf_buildPopupLink code="#trueHelpCode#" text="HELP" image="img_partners_fit_risk_icon_gif">
                                </cfif>
                            </td>
                        </tr>
                        <!---
                            <span style="position:relative;">
                                &nbsp;<img style="cursor:pointer;" onclick="getElementById('#qobj.help#').style.display = '';" src="img/partners/fit/risk_icon.gif" alt="flag icon" />
                                <div id="#qobj.help#" style="z-index:900;border:1px dashed ##999;padding:18px 6px 6px 6px;background:##CCC;position:absolute;top:20px;left:-300px;width:350px;display:none;">
                                    <div style="position:absolute;top:0;right:0;padding:2px;cursor:pointer;" onclick="getElementById('#qobj.help#').style.display = 'none';">CLOSE</div>
                                    <cf_displayText code="#qobj.help#" group="help">
                                </div>
                            </span>
                        --->
                        <!--- <tr id="#qobj.help#" style="display: none;">
                            <td colspan="2"></td>
                            <td colspan="2" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black; background: ##CC0; padding:4px;border:1px dashed ##000;">
                                <div style="font-weight:bold; font-size:14px;">Yellow Flag Risk Factors</div>
                                <cf_displayText code="#qobj.help#" group="help">
                            </td>
                        </tr> --->
                    <cfelse>
          
          <cfif CGI.SCRIPT_NAME NEQ '/cf/questions.cfm' AND CGI.SCRIPT_NAME NEQ '/cf/esi_questions.cfm'>
                <tr valign="top" align="left" ><td colspan=5>&nbsp;</td></tr>
          </cfif>
          
           <cfif FindNoCase("esi_header",Qcode) gt 0><tr valign="middle" align="left" ><td colspan=5><img src="img/#qcode#.jpg" alt="<cf_displayText code="question_#qcode#" group="question">"  height="66" ><br></td></tr>
          <tr valign="top" align="left" ><td colspan=5>&nbsp;</td></tr>
           <cfelse>
                        <tr  valign="top" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;"><cfif session.subset_id eq 63><td width=30>&nbsp;</td></cfif>
                            <td valign="top" align="right" width="35">
                                <b><cfif application.debug>
                                    <a href="##" onClick="if (document.getElementById('#qcode#').style.display == 'none') document.getElementById('#qcode#').style.display = ''; else document.getElementById('#qcode#').style.display = 'none'; return false;">
                                </cfif>#qno#. 
                                <cfif application.debug></a></cfif>
                                </b>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <td valign="top" colspan="2">
                                    <cf_displayText code="question_#qcode#" group="question">
                                    <cfif qobj.help neq ''>&nbsp;<a href="##" onClick="if (document.getElementById('#qobj.help#').style.display == 'none') document.getElementById('#qobj.help#').style.display = ''; else document.getElementById('#qobj.help#').style.display = 'none'; return false;" style="font-size: 8pt; color: ##00656C;">HELP</a></span></cfif>
                           
               </td>
                        </tr>
                        <tr id="#qobj.help#" style="display: none;">
                            <td colspan="2"></td><cfif session.subset_id eq 63><td width=25>&nbsp;</td></cfif>
                            <td colspan="2" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black; background: ##ccFFcc;"><cf_displayText code="#qobj.help#" group="help"></td>
                        </tr>
          </cfif>
                    </cfif>
                    
                    <cfif (#FindNoCase("esi_header",Qcode)# eq 0) ><tr id="#qcode#" style="display: none; font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
                        <td colspan="2"></td>
                        <td colspan="2"><cf_buildAnswerfieldList debug="#qcode#"></td>
                    </tr></cfif>
                    <!--- show answer field --->
                    <cfif session.subset_id IS 61 AND supCount GT 1 AND qobj.sup>
                    <cfelse>
                        
                       <cfif  (#FindNoCase("esi_header",Qcode)# eq 0)><cf_buildAnswerfieldList code="#qcode#" type="#qobj.type#" format="#qobj.format#" errortext="#qErrorAccum#"></cfif>
                        <cfif isdefined('saflist') and saflist neq ''>
                            <cfset templist = ListAppend(templist, saflist)>
                        </cfif>
                    </cfif>
                    
                    <cf_handleScreeningQuestion action="set" code="#qcode#" status="3">
                </cfif>
                <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="prevPage">
                <cfset startQuestion = startQuestion + 1>
                <cfif startQuestion gt StructCount(session.screening.qsort)>
                    <cfset thisPage = prevPage>
                <cfelse>
                    <cfset qcode = StructFind(session.screening.qsort, startQuestion)>
                    <cf_handleScreeningQuestion action="get" code="#qcode#" element="spg" var="thisPage">
                </cfif>
                <!--- END QUESTION LOOP --->
            
            </cfloop>
        </TABLE>
    </cfif>
	</cfoutput>
	<cfset "caller.#attributes.listvar#" = templist>
	<cfset caller.page = startPage>
<!--- END PROCESSING AND DISPLAYING QUESTIONS --->
</cfif>
