<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.form" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.default" type="any" default="">
<cfparam name="attributes.validation" type="string" default="">
<cfparam name="attributes.options_flag" type="numeric" default="-1">
<cfparam name="attributes.suppress" type="string" default="">
<cfparam name="attributes.override" type="string" default="">
<cfparam name="attributes.display_heading_once" type="string" default="">
<cfparam name="attributes.type" type="string" default="">
<cfparam name="attributes.useHardcodedOrder" type="boolean" default="false">
<cfset debug = false>
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>

<cfset getQuestion = application.QuestionPool.getQuestion(attributes.code)>
<!--- If multiselect question, check to see if there are any
      answerfields for the current subset and answerfield --->
<cfset hasAnswerfields = true>
<cfif getQuestion.type eq 'multiselect'>
	<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="thisStateID">
	<cfif Not IsDefined('thisStateID') or thisStateID eq ''>
		<cfset thisStateID = session.state_id>
	</cfif>
	<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#thisStateID#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="#attributes.code#" var="questionAnswerfields" >
    	<cfset phash = ''>
	<!---cfset partnerDiff = false>
	<cfif session.partner_id neq ''>
		<cf_cacheAnswerfieldSubsetPartnerPool action="isDifferent" subset_id="#session.subset_id#" partner_id=		 "#session.partner_id#" var="partnerDiff">
		<cfif partnerDiff>
			<cfset phash = "p#session.partner_id#">
		</cfif>
	</cfif>
	<cfset sqahash = thisStateID & session.subset_id & phash & '_' & attributes.code>
    <cfset QuestionAnswerfieldSort = Evaluate("application.bcuSubsetQuestionAnswerfieldPool.sqa.#sqahash#")--->
	<cfif StructCount(questionAnswerfields.sort) eq 0>
		<cfset hasAnswerfields = false>
	</cfif>
</cfif>
<cfif hasAnswerfields>
	<cfif attributes.display_heading_once eq '' and getQuestion.head neq ''>
		<cfset attributes.display_heading_once = getQuestion.head>
	</cfif>
	<cfif IsStruct(getQuestion)>
		<cf_handleScreeningQuestion action="get" code="#attributes.code#" element="qno" var="qno">
		<cfif qno eq 0>
			<cfif attributes.suppress neq 'number' and getQuestion.sup eq 0>
				<cfset session.screening.qno = session.screening.qno + 1>
				<cfset qno = session.screening.qno>
			<cfelse>
				<cfset qno = ''>
			</cfif>
			<cf_handleScreeningQuestion code="#attributes.code#" qno="#qno#">
		</cfif>
		<cfoutput>
			<cfif session.screening.cat neq getQuestion.cat>
				<tr>
					<td colspan="9" class="question-category"><cfif attributes.useHardcodedOrder and (attributes.code eq 'incomegrid' or attributes.code eq 'assetgrid')>Income &amp; Assets<cfelse><cf_displayText code="quescat_#getQuestion.cat#" group="quescat"></cfif></td>
				</tr>
				<tr>
					<td colspan="9" class="question-space"></td>
				</tr>
			</cfif>
			<!--- SIMPLE VERSION OF CATEGORY DISPLAY
			<cfif session.screening.cat neq getQuestion.cat>
				<div class="question-category"><cf_displayText code="quescat_#getQuestion.cat#" group="quescat"></div>
			</cfif>
			--->
			<cfset session.screening.cat = getQuestion.cat>
			<cfif attributes.display_heading_once neq '' and not StructKeyExists(session.screening.head, attributes.display_heading_once)>
				<tr class="question-print">
					<td colspan="2"></td>
					<td colspan="7" class="q-text"><strong><cf_displayText code="queshead_#attributes.display_heading_once#" group="queshead"></strong></div>
				</tr>
				<tr>
					<td colspan="9" class="question-space"></td>
				</tr>
				<cfset StructInsert(session.screening.head, attributes.display_heading_once, 1)>
			</cfif>
			<cfset errorText = ''>
			<cf_loopPoolStruct struct="getQuestion" index="af">
				<cfif IsDefined('af')>
				<cf_handleScreeningAnswerfield action="get" code="#af#" element="error" var="afErrList">
				<cfif attributes.mode neq 'print' and afErrList neq ''>
					<cfloop list="#afErrList#" index="afErr">
						<cf_handleScreeningAnswerfield action="get" code="#af#" element="group" var="afGrp">
						<cf_displayText group="#afGrp#" code="#afGrp#_#afErr#" var="afText">
						<cfset errorText = ListAppend(errorText, afText, '<br>')>
					</cfloop>
				</cfif>
				</cfif>
			</cf_loopPoolStruct>
			<cfif errorText neq ''>
				<tr>
					<td colspan="2"></td>
					<td colspan="7" class="question-error"><strong>#errorText#</strong></div>
				</tr>
				<tr>
					<td colspan="9" class="question-space"></td>
				</tr>
			</cfif>
			<cfif attributes.type eq ''>
				<cfset testType = getQuestion.type>
			<cfelse>
				<cfset testType = attributes.type>
			</cfif>
			<cfif StructKeyExists(getQuestion.sort, 1)>
				<cfset firstAF = StructFind(getQuestion.sort, 1)>
                <cfset firstAFObj = application.answerfieldPool.getAnswerfield(firstAF)>
				<cfif attributes.mode eq 'print' and testType eq 'general' and firstAFObj.type eq 'select'>
					<cfset testType = 'radio'>
				</cfif>
				<cfset firstReq = firstAFObj.req>
			<cfelse>
				<cfset firstReq = 0>
			</cfif>
			<tr class="question-print">
				<td class="q-no">
					<cfif qno eq ''>&nbsp;<cfelseif firstReq><span style="color: red;">*#qno#.</span><cfelse>#qno#.</cfif>
				</td>
				<td></td>
				<cfif attributes.mode eq 'print'>
					<cfset stripTags = true>
				<cfelse>
					<cfset stripTags = false>
				</cfif>
				<cfif testType eq 'either_or_marital'>
					<cf_handleScreeningAnswerfield action="get" code="marital_stat" var="maritalOptionID">
					<cfif attributes.mode eq 'full' or attributes.mode eq 'print'>
						<cfset eitherOrElementText = 1>
						<cfset eitherOrElementAnswerfield = 2>
					<cfelseif maritalOptionID neq '' and maritalOptionID neq 4>
						<cfset eitherOrElementText = 2>
						<cfset eitherOrElementAnswerfield = 2>
					<cfelse>
						<cfset eitherOrElementText = 1>
						<cfset eitherOrElementAnswerfield = 1>
					</cfif>
					<cf_displayTextQuestion code="#attributes.code#" element="#eitherOrElementText#" stripTags="#stripTags#" var="questionText">
				<cfelse>
					<cf_displayTextQuestion code="#attributes.code#" stripTags="#stripTags#" var="questionText">
				</cfif>

                <cfswitch expression="#testType#">
                	<cfcase value="date">
                		<td colspan="7">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                				<tr>
                					<td class="q-text">
                						<cfif debug>
                                        	<span style="font-weight: bold; color: red;">
												<cfif attributes.type eq ''>
                                                	#getQuestion.type#
                                                <cfelse>
                                                	#attributes.type#
                                                </cfif> 
                                                [#attributes.code#]:
                                            </span>
                                            &nbsp; 
                                        </cfif>
										<cfif attributes.override eq ''>
                                        	#questionText#
                                        <cfelse>
											<cfoutput>#attributes.override#</cfoutput>
											<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                                            	<cf_displayHelpLink code="#getQuestion.help#">
                                            </cfif>
                                        </cfif>
                					</td>
                					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                					<td class="q-field" align="right">
                						<cfset loopcount = 0>
										<cfoutput>
											<cfif attributes.mode neq 'print'>
                                            	<table border="0" cellspacing="0" cellpadding="0" align="right">
                                                	<tr>
                                                    	<td class="q-field">
                                            </cfif>
                                            <cf_loopPoolStruct struct="getQuestion" index="answerfield">
                                            	<cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
												<cfset type = ansObj.type> 
                                                <cfif loopcount>
                                                    <cfif attributes.mode eq 'print'>
                                                        /
                                                    <cfelse>
                                                        </td>
                                                        <td class="q-field">&nbsp;</td>
                                                        <td class="q-field">
                                                    </cfif>
                                                </cfif>
                                                <cf_displayAnswerfield code="#answerfield#" type="#type#" aflistvarname="caller.aflist">
                                                <cfset loopcount++>
                                            </cf_loopPoolStruct>
                                            <cfif attributes.mode neq 'print'>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </cfif>
										</cfoutput>
                					</td>
               					 </tr>
                			</table>
                        </td>
                	</cfcase>
                
                	<cfcase value="drug">
                		<td colspan="7" class="q-text">
                			<cfif debug>
                            	<span style="font-weight: bold; color: red;">
									<cfif attributes.type eq ''>
                                    	#getQuestion.type#
                                    <cfelse>
                                    	#attributes.type#
                                    </cfif> 
                                    [#attributes.code#]:
                                </span>&nbsp; 
                            </cfif>
							<cfif attributes.override eq ''>
                            	#questionText#
                            <cfelse>
                            	#attributes.override#
                            </cfif>
							<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                            	<cf_displayHelpLink code="#getQuestion.help#">
                            </cfif>
                		</td>
                	</tr>
                	<cf_displayQuestionDrug code="#attributes.code#" form="#attributes.form#" aflistvarname="caller.aflist">
                	</cfcase>
                
                	<cfcase value="either_or_marital">
                		<td colspan="7">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="q-text">
                                        <cfif debug>
                                            <span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                                        </cfif>
                                        <cfif attributes.override eq ''>
                                            #questionText#
                                        <cfelse>
                                            <cfoutput>#attributes.override#</cfoutput>
                                        </cfif>
                                        <cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                                            <cf_displayHelpLink code="#getQuestion.help#">
                                        </cfif>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td class="q-field" align="right">
                                        <cfset loopcount = 0>
                                        <cfset loopelement = 0>
                                        <cfoutput>
                                            <cf_loopPoolStruct struct="getQuestion" index="answerfield">
                                                <cfset loopelement = loopelement + 1>
                                                <cfif loopelement eq eitherOrElementAnswerfield>
                                                    <cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
													<cfset type = ansObj.type> 
                                                    <cfif loopcount><br /></cfif>
                                                    <cf_displayAnswerfield code="#answerfield#" type="#type#" stripTags="#stripTags#" aflistvarname="caller.aflist">
                                                    <cfset loopcount = loopcount + 1>
                                                </cfif>
                                            </cf_loopPoolStruct>
                                        </cfoutput>
                                    </td>
                                </tr>
                            </table>
                    	</td>
                	</cfcase>
                    
                    <cfcase value="hh_expenses_layout">
                    	<td colspan="7">
                        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                            	<tr>
                                	<td class="q-text" colspan="3">
                                    	<cfif debug>
                                            <span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                                        </cfif>
                                        <cfif attributes.override eq ''>
                                            #questionText#
                                        <cfelse>
                                            <cfoutput>#attributes.override#</cfoutput>			
                                        </cfif>
                                    </td>
                                </tr>
								<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#session.state_id#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="hh_expenses" var="hh_expensefieldlist">
                                <cf_loopPoolStruct struct="hh_expensefieldlist" index="answerfield">
                                	<cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
									<cfset type = ansObj.type> 
                                	<tr>
                                    	<td class="q-field" align="right" colspan="3" style="padding:2px 0 2px;">
                                        	 <cf_displayAnswerfield tables="false" showtext="true" form="#attributes.form#" code="#answerfield#" type="#type#" stripTags="#stripTags#" aflistvarname="caller.aflist">
                                        </td>
                                    </tr>
                                </cf_loopPoolStruct>
                            </table>
                        </td>
                    </cfcase>
                
                	<cfcase value="general">
                		<td colspan="7" id="#attributes.code#">
                			<cfif attributes.code EQ 'pl_agency_screening'>
                				<div id="agency_error" style="display:none; color:red; padding-bottom:10px; font-weight:bold;">
                					Please select an agency from the list below.
                				</div>
                			</cfif>
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                				<!--- MH 03/03/10: Custom Layout for question code 'no_hh_members' for the PQ and SPQ only--->
                				<cfif attributes.code eq 'no_hh_members'>
                					<tr>
                						<td class="q-text" colspan="3">
                							<cfif debug>
                                            	<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                                            </cfif>
											<cfif attributes.override eq ''>
                                                #questionText#
                                            <cfelse>
                                                <cfoutput>#attributes.override#</cfoutput>			
                                            </cfif>
                						</td>	
                					</tr>
                					<tr>
                						<td class="q-field" align="right" colspan="3">
                							<cfset loopcount = 0>
                							<cfoutput>
                								<cf_loopPoolStruct struct="getQuestion" index="answerfield">
													<cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
													<cfset type = ansObj.type> 
                                                    <cfif loopcount><br /></cfif>
                                                    <cfif getQuestion.format IS "text_hide">
                                                        <cfset showText = false>
                                                    <cfelse>
                                                        <cfset showText = true>
                                                    </cfif>
                                                    <cf_displayAnswerfield showtext="#showText#" form="#attributes.form#" code="#answerfield#" type="#type#" stripTags="#stripTags#" aflistvarname="caller.aflist">
                                                    <cfset loopcount = loopcount + 1>
                								</cf_loopPoolStruct>
                							</cfoutput>
                						</td>
                					</tr>
                				<cfelse>
                					<tr>
                						<td class="q-text">
                							<cfif debug>
                                            	<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                                            </cfif>
                							<cfif attributes.override eq ''>
                								<cfif attributes.mode eq 'print' and attributes.code eq 'frail'>
                									Are you either frail and elderly or over 18 and functionally impaired? 	
                								<cfelseif attributes.mode eq 'print' and attributes.code eq 'blind'>
                									Are you legally blind?	     	
                								<cfelseif attributes.mode eq 'print' and attributes.code eq 'dep_care'>
                									Are you dependent on family members or others for care?
                								<cfelseif attributes.mode eq 'print' and attributes.code eq 'fam_mem'>
                									Do you have a family member who is either frail and elderly or over 18 and functionally impaired?
                								<cfelse>
                									#questionText#
                								</cfif>		
                							<cfelse>
                								<cfoutput>#attributes.override#</cfoutput>			
                							</cfif>
                							<cfif attributes.mode neq 'print' and getQuestion.help neq ''><cf_displayHelpLink code="#getQuestion.help#"></cfif>
                						</td>	
                						<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>				
                						<td class="q-field" align="right">
                							<cfset loopcount = 0>
                							<cfoutput>
                								<cf_loopPoolStruct struct="getQuestion" index="answerfield">
                									<cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
													<cfset type = ansObj.type> 
                									<cfif loopcount><br /></cfif>
                									<cfif getQuestion.format IS "text_hide">
                										<cfset showText = false>
                									<cfelse>
                										<cfset showText = true>
                									</cfif>
                									<cf_displayAnswerfield showtext="#showText#" form="#attributes.form#" code="#answerfield#" type="#type#" stripTags="#stripTags#" aflistvarname="caller.aflist">
                									<cfset loopcount = loopcount + 1>
                								</cf_loopPoolStruct>
                							</cfoutput>
                						</td>
                					</tr>
                				</cfif>
                			</table>
                        </td>
                	</cfcase>
                    
                	<cfcase value="grid">
                		<td colspan="7" class="q-text">
                			<cfif debug>
                            	<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                            </cfif>
							<cfif attributes.override eq ''>
                            	#questionText#
                            <cfelse>
                            	#attributes.override#
                            </cfif>
							<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                            	<cf_displayHelpLink code="#getQuestion.help#">
                            </cfif>
                		</td>
                	</tr>
                	<cf_displayQuestionGrid code="#attributes.code#" aflistvarname="caller.aflist">
                	</cfcase>
                    
                	<cfcase value="multiselect">
                		<td colspan="7" class="q-text">
                			<cfif debug>
                            	<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                            </cfif>
							<cfif attributes.override eq ''>
                            	#questionText#
                            <cfelse>
								<cfoutput>#attributes.override#</cfoutput>
                            </cfif>
							<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                            	<cf_displayHelpLink code="#getQuestion.help#">
                            </cfif>
                		</td>
                		</tr>
                		<cf_displayQuestionMultiselect code="#attributes.code#" aflistvarname="caller.aflist">
                	</cfcase>
                	
                    <cfcase value="radio">
                		<td colspan="7" class="q-text">
                			<cfif debug>
                            	<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                            </cfif>
							<cfif attributes.override eq ''>
                            	#questionText#
                            <cfelse>
                            	#attributes.override#
                            </cfif>
							<cfif attributes.mode neq 'print' and getQuestion.help neq ''><cf_displayHelpLink code="#getQuestion.help#"></cfif>
                		</td>
                	</tr>
                	<tr>
                		<td colspan="4"></td>
                		<td colspan="5">
							<cfset loopcount = 0>
							<cfoutput>
                            	<cf_loopPoolStruct struct="getQuestion" index="answerfield">
									<cfset ansObj = application.answerfieldPool.getAnswerfield(answerfield)>
									<cfset type = ansObj.type> 
									<cfif loopcount>
                                    		</td>
                						</tr>
                						<tr>
                							<td colspan="9" class="question-space"></td>
                						</tr>
                        				<tr>
                    						<td colspan="4"></td>
                							<td colspan="5">
                                   </cfif>
                                   <cf_displayAnswerfield code="#answerfield#" type="#type#" aflistvarname="caller.aflist">
								   <cfset loopcount = loopcount + 1>
                               	</cf_loopPoolStruct>
							</cfoutput>
                        </td>
                	</cfcase>
                    <cfcase value="select_other_specify">
                    	<cfset loopcount = 0>
                    	<cf_loopPoolStruct struct="getQuestion" index="answerfield">
                    		<cfset loopcount = loopcount + 1>
                    		<cfset "af#loopcount#" = answerfield>
                    	</cf_loopPoolStruct>
                    	<cfset ansObj = application.answerfieldPool.getAnswerfield(af1)>
						<cfset type = ansObj.type> 
                    	<cfif attributes.mode eq 'print'>
                    		<td colspan="7" class="q-text">
                    			<cfif debug>
                    				<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                    			</cfif>
                    			<cfif attributes.override eq ''>
                    				#questionText#
                    			<cfelse>
                    				<cfoutput>#attributes.override#</cfoutput>
                    			</cfif>
                    			<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                    				<cf_displayHelpLink code="#getQuestion.help#">
                    			</cfif>
                    			<cf_displayAnswerfieldSelect code="#af1#" aflistvarname="caller.aflist">
                   		 <cfelse>
                    		<td colspan="7">
                    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    				<tr>
                    					<td class="q-text">
                    						<cfif debug>
                    							<span style="font-weight: bold; color: red;"><cfif attributes.type eq ''>#getQuestion.type#<cfelse>#attributes.type#</cfif> [#attributes.code#]:</span>&nbsp; 
                    						</cfif>
                    						<cfif attributes.override eq ''>
                    							#questionText#
                    						<cfelse>
                    							<cfoutput>#attributes.override#</cfoutput>
                    						</cfif>
                    						<cfif attributes.mode neq 'print' and getQuestion.help neq ''>
                    							<cf_displayHelpLink code="#getQuestion.help#">
                    						</cfif>
                    					</td>							
                    					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    					<td class="q-field" align="right">
                    						<cfif attributes.mode neq 'print'>
                    							<table border="0" cellspacing="0" cellpadding="0" align="right">
                    								<tr>
                    									<td class="q-field">
                    						</cfif>
                    						<cf_displayAnswerfield code="#af1#" type="#type#" aflistvarname="caller.aflist">
                    						<cfif attributes.mode neq 'print'>
                    									</td>
                    								</tr>
                    							</table>
                    						</cfif>
                    					</td>
                    				</tr>
                    			</table>
                    		</cfif>
                    	</td>
                    </tr>
                    <cf_buildQuestionnaireRow>
                    <tr>
                    	<td colspan="2"></td>
                    	<td colspan="7">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    			<tr>
                    				<td class="q-text"><cf_displayTextAnswerfield code="#af2#"></td>
                    				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    				<td class="q-field" align="right">
										<cfif attributes.mode neq 'print'>
                                        	<table border="0" cellspacing="0" cellpadding="0" align="right">
                                            	<tr>
                                                	<td class="q-field">
                                        </cfif>
                                        <cf_displayAnswerfieldText code="#af2#" aflistvarname="caller.aflist">
										<cfif attributes.mode neq 'print'>
                                        			</td>
                                                </tr>
                                            </table>
                                        </cfif>
                    				</td>
                    			</tr>
                    		</table>
                        </td>
                    </cfcase>
                	<cfdefaultcase>
                		<td class="q-text" colspan="7"><strong>#getQuestion.type#</strong></td>
                	</cfdefaultcase>
                </cfswitch>
			</tr>
			<cf_buildQuestionnaireRow>
		</cfoutput>
	</cfif>
</cfif>
</cfprocessingdirective>