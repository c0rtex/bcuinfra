	<cf_cachepartnerquery query="partnerQuery" partner_id="#session.partner_id#">
	<cfset tag = partnerQuery.wrapper_tag3>
	
	<cfif parameterExists(session.transferTypeCanonicalOverride)>
		<cfset urlType = session.transferTypeCanonicalOverride>
	<cfelse>
		<cfset urlType = application.transferType>			
	</cfif>	
	
	<!---
	=======================================
	DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user qualifies
	CALLED BY: procEligibility.cfm
	GOES TO: frmDetails.cfm
	REQUIRED: session.prg_list
	============================================
	--->
	
	
	<cf_sessioncheck>
	<cfparam name="sr" type="numeric" default="1">
	<cfparam name="prgnum" type="numeric" default="0">
	<cfparam name="aft" type="numeric" default="0">
	<cfparam name="url.reportType" type="string" default="">
	
	<cfset session.RxPrgList = ''>
	<cfset showBreaks = "true">
	
	<cf_tagheader show_title="yes" guts="frmeligibility.cfm" popupwarning="1">
	<cfif isdefined('url.debug') >
		<cfoutput>session.hh_income_total_complete : #session.hh_income_total_complete#<BR />
	    	session.ch_income_total_unearned: #session.ch_income_total_unearned#<BR />
	        session.ch_income_earned: #session.ch_income_earned#<BR />
	        session.ch_asset_total_complete: #session.ch_asset_total_complete#<BR />
	        session.ch_income_child_support: #session.ch_income_child_support#<BR />
			session.ch_dep_care_costs: #session.ch_dep_care_costs#<BR />
		</cfoutput>
	</cfif>
	
	<cfif IsDefined('application.serverPathOE')>
		<script language="JavaScript1.1">
		<!--
			function openMain() {
				setTimeout('window.close()', 1000);
				window.open('<cfoutput>#urlType#://#application.serverPathOE#</cfoutput>/menu.do', 'main');
				main.focus();
			}
	
			function exitQuestionnaire() {
				if (document.layers) {
					if (window.opener.closed) {
						openMain();
					} else {
						window.opener.focus();
					window.close();
					}
				} else {
					window.onerror = openMain;
					if (!(window.opener.closed)) {
						window.opener.focus();
						window.close();
					}
				}
			}
		// -->
		</script>
	</cfif>
	
	<div id="frmeligibility" class="row survey">
	
		<style>
			#pageTip{ top:30px !important; display: none;}
		</style>
		
		<div class="row survey">
			<div class="question">
				<div class="questionHolder questionBar">
					<div id="pageTip" class="helpTip">
						<h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                      	<p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                        <cfif IsDefined('session.partner_id') And session.partner_id eq 6>
                            <br /><br />
                            <a href="javascript:help2('neededinfo-rx.cfm')">Click here</a> 
                            to see if you need to gather any information before you begin.<br />
                        </cfif>
					</div><!-- pageTip -->
				</div><!-- questionHolder -->
			</div><!-- question -->	
	
	            
		<!--- 
			09/01/2002 REM  There's a slight possibility that there won't be any programs
	    	returned in the new RX Only version, so we have to trap for that here: 
	
			12/04/2002 BS  An error cropped up in cases where the user qualified for no regular programs
	    	but did qualify for buffer programs.  Now we check here ONLY to make sure the regular prg_list is empty.
	    	
	        08/03/2005 BShunn  Moved query up here so if we're filtering out 333 and 334 programs and that makes
	    	prg_list empty the page still displays a no-results message 
	    --->
		<cfset programCodeList = ''>
		<cfset programGroupList = ''>
		
		<cfif ListLen(trim(session.prg_list))>
			<!--- Pull in eligible programs from session.prg_list--->
			<cfquery name="prgConvert" datasource="#application.dbSrc#">
				SELECT p.program_code
				FROM tbl_prg_all pa INNER JOIN program p
					ON pa.RecID = p.program_id
					LEFT OUTER JOIN programgroup pg
					ON p.programgroup_id = pg.programgroup_id
				WHERE pa.prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
				ORDER BY pg.sort, p.sort
			</cfquery>
			<cfloop query="prgConvert">
				<cfset programCodeList = ListAppend(programCodeList, program_code)>
				<cf_cacheprogrampool action="get" code="#program_code#" var="pobj">
				<cfif pobj.group neq '' and not ListFind(programGroupList, pobj.group)>
					<cfset programGroupList = ListAppend(programGroupList, pobj.group)>
				</cfif>
			</cfloop>
			<cfquery name="prgs" datasource="#application.dbSrc#">
				SELECT pp.program_code,pp.program_id, IFNULL(pp.supersort, 999999999) bigsort, pc.code AS cat_code
				FROM tbl_prg_all p, program pp, programcategory pc
				WHERE p.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
				AND p.RecID = pp.program_id
				AND pp.programgroup_id is null
				AND pp.programcategory_id = pc.programcategory_id
				<cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''>
					AND (pc.legacy_code IS null OR pc.legacy_code not in (333, 334))
				</cfif>
				ORDER BY bigsort, pc.sort, pp.sort
			</cfquery>
		<cfelse>
			<!--- 08/03/2005 BShunn  If list is empty, create an empty query object in case we still try to access query --->
			<cfset prgs = QueryNew('program_code,bigsort')>
		</cfif>
					
		<cfif false>
	    	<cf_surveylink src="e" aft="#aft#">
	    </cfif>
	    
		<cfif not ListLen(programCodeList)>
			<div class="question">
					<div class="questionHolder questionBar">		
						<h1>Results Overview</h1>
					</div><!-- questionHolder -->
				</div><!-- question -->
			<div class="question">
					<div class="questionHolder questionBar">	
					<p>
				<cfoutput>
                	<cfif session.subset_id eq 55>
                    	<p>Thank you for taking the time to complete the online application for the Medicare Part D Low-Income Subsidy (Extra Help) through the National Council on Aging's BenefitsCheckUp.  After you completed the application, we compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer.  We update our program list on a regular basis, so please try again by visiting <a href="http://www.benefitscheckup.org/"> www.BenefitsCheckUp.org</a>.
                        </p>
                        
                        <p>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.
                        </p>
					<cfelse>
                        Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.
                	</cfif>
				</p>	
				</div><!-- questionHolder -->
			</div><!-- question -->
			
			</cfoutput>
			<div class="question">
			<div class="questionHolder questionBar">			
								
			</div>
			</div><!-- questionHolder -->
			</div><!-- question -->			
	
			<cfset prgnum=0>
		<cfelse>
	
			<cfif (IsDefined('session.subset_id') 
				And session.subset_id eq 22) 
				or (url.ReportType eq 'All')>
				
				<div class="question">
					<div class="questionHolder questionBar">
						<h1>Report Options</h1>
					</div><!-- questionHolder -->
				</div><!-- question -->
			<cfelse>
				<div class="question">
					<div class="questionHolder questionBar">		
						<h1>Results Overview</h1>
					</div><!-- questionHolder -->
				</div><!-- question -->	
					
				<!--- output the lead paragraph for the page --->
				<cfif prgs.RecordCount gt 0>	
						
					<div class="question">
						<div class="questionHolder questionBar">
							<p>
		                    	<!--- MH: Bug 5476 --->
								<cfif session.subset_id neq 3 and session.subset_id neq 62>
									<cfoutput>
										<cf_displaytext group="site" code="site_results_eligible" param1="#prgs.RecordCount#">
									</cfoutput>
		                        <cfelseif session.subset_id eq 62>
		                        	<cfoutput>
		                        		<cf_displaytext group="site" code="site_results_eligible_subset_62">	
		                        	</cfoutput>
								<cfelse>
		                            Based on your answers, you may be eligible for the following nutrition 
		                            assistance program. Click on the program below to get a fact sheet that 
		                            contains the following information: short description of the program, 
		                            internet resources, local contact information, list of the paperwork/documents 
		                            you may need to apply for the program, and application forms (if available). 
								</cfif>
							</p>
						</div><!-- questionHolder -->
					</div><!-- question -->
									
					<cfset orgList = "2362,2370,1235,2379,1867,2372,2373,2374,2375,2377,2376,2378,2371,1660,2369">
					
					<cfif isDefined("session.st") 
							AND session.st IS "GA" 
							AND session.subset_id EQ 0 
							AND listFind(orgList, session.org_id) 
							AND session.partner_id IS 0>
							
						<cfset aPrograms = createObject("component","com.bcu.gaVob").init(#prgs#)>
							<div class="question">
								<div class="questionHolder questionBar">
		                            <img id="gaBtn" src="/cf/images/ga_potential_savings.gif" border="0" 
		                            		alt="GA Potential Savings Button" />
		                            		
		                                <div id="gaText" style="display:none;">
		                                    <div style="font-weight:bold; text-align:center;padding:4px;position:relative;height:25px;">
		                                        <div style="position:absolute;top:2px;right:4px;">
		                                        	<a id="gaClose">CLOSE</a>
		                                        </div>
		                                        Your Potential Savings
		                                    </div>
		                                    <p>
		                                        By applying for the benefits programs in your program list, it is likely you 
		                                        will save money. For example, if you are eligible for a Medicare Savings 
		                                        Program, you could save as much as $2,360 a year. If you are eligible for 
		                                        Medicare Prescription Drug Coverage for People with Limited Incomes and
		                                        Resources, you could save on average $4,000 each year. 
		                                        <br /><br />
		                                        <cfif aPrograms.total NEQ 0>
		                                        	If you apply for some of the key benefits below, and are found eligible, you 
		                                            could potentially save <cfoutput>#dollarFormat(aPrograms.total)#</cfoutput> each year.
		                                        </cfif>
		                                    </p>
		                                </div>
		                                
		                                <script type="text/javascript">
		                                    jQuery(document).ready(function(){

tempPrintButton = $("#printReportElig");

tempPrintButton.remove();
		                                        jQuery('#gaBtn').click(function(){
		                                            jQuery("#gaText").show('slow');			   
		                                        });
		                                        jQuery('#gaClose').click(function(){
		                                            jQuery("#gaText").hide('slow');							  
		                                        });
		                                    });
		                                </script>
							</div><!-- questionHolder -->
						</div><!-- question -->
					</cfif><!--- END <cfif isDefined("session.st")  --->
					
					<cfif session.subset_id neq 3>
						<div class="question">
								<div class="questionHolder questionBar">
									<h2>Your Program List</h2> 
                                    <hr /> 
									<p>
										Click on the program names below to learn more.
									</p>
							</div><!-- questionHolder -->
							
						</div><!-- question -->	
					</cfif>
								
		                           
					<cf_tagnextrecordsinvisible 
						records="#prgs.RecordCount#"
						thispagename="frmeligibility.cfm"
						recordstodisplay="10"
						displaytext="Program"
						displayfont="Arial"
						usebold="Yes"
						extraurl="&CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#">
									
					<!--- The actual output for the visible screen this is the list of programs numbered --->
					
						<cfset HaveChips = "No">
						<cfset ER=(#sr# + 9)>
						<cfset prgnum = #SR#>
						<cfset monkeycounterA="1">
						<cfset session.category =  ArrayNew(1)>
						<!--- Temporarily dumping table html to show ad in right column --->
						<table width=900><tr><td width=800> 
						<!--- --->
						<ul class="striping">
							<cfloop query="prgs" startrow="#SR#" endrow="#ER#">
								<!--- if the prg_id is for CHIPS save chips for output later else print out --->
								<cf_cacheprogrampool action="get" code="#program_code#" var="pobj">
								<cf_displaytext group="program" code="program_#program_code#" var="programName">
								<cf_displaytext group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
								<cfoutput>
									<li class="questionBar">
										<cfif session.subset_id neq 3>
			                                <span class="program_number">#prgnum#.</span>
			                            </cfif>
										
											<cfif pobj.legacy eq '103-311-2593-FD-FD'>
			                                	<cf_displaylispopup hspace="3" vspace="0" align="right">
			                                </cfif> 
											
			                            	<cf_sessionpassvars href="frmDetails.cfm" state_id="#session.st#" extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#">#programName#</cf_sessionpassvars>
											
			                                (#programCategoryName#)
									</li>
								</cfoutput>
								<cfset prgnum = prgnum + 1>
							</cfloop>
						</ul>
						<!--- Temporarily dumping table html to show ad in right column --->
						</td><cfif session.subset_id eq 27 or session.subset_id eq 39 or session.subset_id eq 0 ><td valign=top><a href="/cf/redirect.cfm?id=73&tgt=1&partner_id=14&visible=false" target="_new"><img title="My Medicare Matters" alt="My Medicare Matters" src="/wp-content/uploads/2014/10/Generic2_180x280_MMM_BCU.jpg"></a></td></cfif></tr></table>
						<!--- Temporarily dumping table html to show ad in right column --->
						<div class="question">
							<div class="questionHolder questionBar">			
								<cf_tagnextrecords 
									records="#prgs.RecordCount#"
									thispagename="frmeligibility.cfm"
									recordstodisplay="10"
									displaytext="Program"
									displayfont="sans-serif"
									fontsize="14px"
									usebold="no"
									extraurl="&CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#">
									</div>
							</div><!-- questionHolder -->
						</div><!-- question -->	
				</cfif><!--- END <cfif prgs.RecordCount gt 0> on line 278--->
							
	                        
				<!--- program groups --->
				<cfif ListLen(programGroupList)>
					<ul class="striping">
					<cfloop list="#programGroupList#" index="x">
						<li class="questionBar">
						<cf_displaytext group="prggrpblurb" code="prggrpblurb_#x#"><br /><br />
							<cfset prgnum = 1>
							<cfloop list="#programCodeList#" index="y">
								<cf_cacheprogrampool action="get" code="#y#" var="pobj">
								<cfif pobj.group eq x>
									<cf_displaytext group="program" code="program_#y#" var="programName">
									<cf_displaytext group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
									<cfoutput>
										<span class="program_number">#prgnum#.</span>
											<cfif pobj.legacy eq '103-311-2593-FD-FD'>
	                                        	<cf_displaylispopup hspace="3" vspace="0" align="right">
	                                        </cfif> 
											<cf_sessionpassvars 
												href="frmDetails.cfm" 
												state_id="#session.st#" extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#">
													#programName#
											</cf_sessionpassvars> 
	                                            (#programCategoryName#)
	
									</cfoutput>
									<cfset prgnum = prgnum + 1>
								</cfif><!--- END <cfif pobj.group eq x> --->
							</cfloop>
						</li>
					</cfloop>
					</ul>
				</cfif><!--- END <cfif ListLen(programGroupList)> --->
							
		</cfif><!--- END <cfif (IsDefined('session.subset_id') on line 264??? --->
						
						
		<!--- 04.08.2004 BS  Display AssistGuide text if any programs returned --->
		<!--- 04.27.2004 BS  Display AssistGuide text if partner not 5 or 6 --->
		<cfif session.subsetEFormFlag neq 1>
			<div class="question">
				<div class="questionHolder questionBar">
					<h2>Guide to Application Forms</h2>
                    <hr />
					<p>
						There are fact sheets and application forms available 
						for many of the programs appearing in your results 
						list.  If you would like help printing and filling 
						out application forms for these programs, 
						<a href="frmAccess.cfm?src=comp&<cfoutput>cfid=#session.cfid#&cftoken=#session.cftoken#</cfoutput>">click here</a>.
					</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
	
		<cfif session.subsetDrugFlag eq 0 and session.subsetRecFlag neq 0>
			<div class="question">
				<div class="questionHolder questionBar">
					<h2>Prescription Benefits Recommendations</h2>
					<hr />
					<p>	
						We have compiled recommendations for you as to how to 
						save money on your prescription medications.   To get 
						your recommendations, 
						<a href="frmRecommend.cfm?adj=1&src=elig&ReportType=All&<cfoutput>cfid=#session.cfid#&cftoken=#session.cftoken#</cfoutput>">click here</a>.
					</p>
				</div><!-- questionHolder -->
			</div><!-- question -->		
		</cfif>
	
	</cfif><!--- 09/01/2002 REM  closing cfif from no programs trap --->
	
		<cfif session.evaluation>
			<div class="question">
				<div class="questionHolder questionBar">
					<h2>Evaluators Please Take Note:</h2>
                    <hr />
					<p>
						Kindly take a moment to give us your overall feedback 
						on this new service.  Follow this link: 
						<a href="javascript:feedback('overallfeedback_f.cfm')">Your Overall Feedback Form</a> 
						to rate the new service, provide comments and suggestions.
					</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
	
		<cfif url.ReportType neq 'all' and session.subset_id neq 22>
		
			<cfif session.partner_id neq 5>
				<!--- output generic drug details if client qualifies --->
				<cfif session.subset_id neq 40 
						AND session.subset_id neq 51 
						AND session.subset_id neq 54 
						and session.genericdrugs is "y" 
						and not (NOT ListLen(trim(session.prg_list)) 
						and IsDefined('session.subset_id') 
						AND session.subset_id eq 1)>
					<div class="question">
						<div class="questionHolder questionBar">
							<h2>Save money on prescription drugs</h2>
                            <hr />
							<p>
								<a href="genericdruginfo.cfm?src=elig&<cfoutput>sr=#SR#&cfid=#session.cfid#&cftoken=#session.cftoken#</cfoutput>">Click here</a> for additional information on saving money.
							</p>
							</div><!-- questionHolder -->
					</div><!-- question -->	
					<cfset prgnum = prgnum + 1>	
				</cfif><!--- END <cfif session.subset_id neq 40 --->
			</cfif><!--- END <cfif session.partner_id neq 5> --->
			
			<!--- MH: Bug 5476 Removed 'Click here...' from subset 62 --->
			<cfif session.subset_id neq 35 
					and session.subset_id neq 40 
					and session.subset_id neq 44 
					and session.subset_id neq 49 
					and session.subset_id neq 51 
					and session.subset_id neq 55 
					and session.subset_id neq 54 
					and session.subset_id neq 56 
					and session.subset_id neq 57 
					and session.subset_id neq 3 
					and session.subset_id neq 62
					and session.subset_id neq 59
					and session.subset_id neq 64>
					
					<div class="question">
						<div class="questionHolder questionBar">
							<p>
								<a href="javascript:help2('imp_rx_info.cfm')">Click here</a> for important information you should know about prescription medications.
							</p>
						</div><!-- questionHolder -->
					</div><!-- question -->	
					
			</cfif>
	
			<!--- output chips details if client answered chips question --->
			<!--- 09/01/2002 REM  Removed 'havechips is "yes" or ' from below cfif --->
			<cfif IsDefined('session.wantchips') and session.wantchips is "y">
				<div class="question">
						<div class="questionHolder questionBar">
							<p>
								Since you indicated that you know of children without 
								health insurance, you may want to click on the following 
								link to get more information about the State Children&rsquo;s 
								Health Insurance Program. Each state has a program that makes 
								health insurance coverage available, either free or at low cost, 
								to children in working families. 
								<a href="frmDetails.cfm?prg_id=103-309-2191-FD-FD&src=elig&<cfoutput>CFID=#session.cfid#&CFTOKEN=#session.cftoken#</cfoutput>">State Children&rsquo;s Health Insurance Program</a>
							</p>
						</div><!-- questionHolder -->
					</div><!-- question -->	
				<cfset prgnum = prgnum + 1>	
			</cfif>
	
		</cfif><!--- END <cfif url.ReportType neq 'all' and session.subset_id neq 22> on line 524--->
	
		<!--- output the bottom paragragh and the links to recap, eval form, and restart --->
		<cfif session.buff_list NEQ "" and session.subset_id neq 49>
			<div class="question">
				<div class="questionHolder questionBar">
					<p>
						<cf_tagshowbufferprogs>
					</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
		
		
	
		<div class="question">
			<div class="questionHolder questionBar">
				<h2>Answer Recap</h2>
                <hr />
				<p>

					If you would like to see a short recap of your answers, click <a href="javascript:help3 ('frmrecap.cfm?CFID=<cfoutput>#session.cfid#&CFTOKEN=#session.cftoken#</cfoutput>')">here</a>.




				</p>
		</div><!-- questionHolder -->
		</div><!-- question -->	
	
		<!--- 09/01/2002 REM  Added in a cfif to check for a program list--otherwise, this link is pointless: --->
		<cfif (ListLen(session.prg_list) 
			OR ListLen(session.buff_list)) 
			AND session.partner_id neq 5 
			AND session.subset_id neq 3>
				<div class="question">
					<div class="questionHolder questionBar">
						<h2>View and Print Report</h2>
                        <hr />
							<p>
								Print the listing and details of the programs 
								to which you may be potentially eligible to receive. 
								Details include program descriptions, local offices, 
								and required materials.
							</p>
	<div style="float:left; display: inline-block;" id="printReportElig">
							<form action="frmreportview.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&RequestTimeout=300" method="post" name="ReportForm">
								
									<p>
										<input class="view_results" type="submit" value="  View and Print Report " name="welcome" />	
									</p> 
								

							</form>				
</div>
					</div><!-- questionHolder -->
				</div><!-- question -->	
	
	
	
			<cfif session.org_id gt 0>
	<div style="float:left; display: inline-block;" id="printReportElig">
				<form action="frmreportoptions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="ReportCustomizeForm">
					<div id="surveyNav">
						<p><div class="left"><input class="view_results" type="submit" value=" Customize and Print Report " name="welcome" /></div></p> 
					</div>
				</form>
</div>
			
				<cfif session.client_id neq 'null'>
	<div style="float:left" id="printReportElig">
					<form action="#urlType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
						<div id="surveyNav">
							<p><div class="left"><input class="view_results" type="submit" value=" Return to Client Detail " name="welcome" /></div></p> 
						</div>
					</form>
</div>
				</cfif>
			</cfif>
		</cfif><!--- END <cfif (ListLen(session.prg_list) on line 624 --->
	
	
		<cfif session.org_id eq 0 and session.subset_id neq 55 >
			<div class="question">
				<div class="questionHolder questionBar">
					<cfinclude template="links.cfm">
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
	
		<cfif session.source_id eq 2 or session.source_id eq 3>
			<div class="question">
				<div class="questionHolder questionBar">
					<cf_displaybutton return_oe="true">
					<cfinclude template="links.cfm">
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
		
		<!--- MH: Bug 5476 Remove 'Try a Comp...' for subset 62 --->
		<cfif session.subset_id neq 0 And session.subset_id neq 21 And session.subset_id neq 22 And session.subset_id neq 35 And session.subset_id neq 37 And session.subset_id neq 38 And session.subset_id neq 40 And session.subset_id neq 44 And session.subset_id neq 49 And session.subset_id neq 51 And session.source_id neq 3 And session.partner_id neq 5 And session.partner_id neq 17 And session.subset_id neq 55 And session.subset_id neq 54 And session.subset_id neq 56 and session.subset_id neq 57 and session.subset_id neq 3 and session.subset_id neq 59 and session.subset_id neq 62  and session.subset_id neq 64 and session.subset_id neq 67 and session.partner_id neq 77 and session.subset_id neq 19 
		and session.subset_id neq 27
		and session.subset_id neq 39 >
			<div class="question">
				<div class="questionHolder questionBar">
					<h2>Try a Comprehensive Screening</h2>
                    <hr />
						<p>
							The <cf_tagbcu subset_id="#session.subset_id#"> service 
							is only a small portion of what <cf_tagbcu> offers.  
							Please take a few more minutes to complete a comprehensive 
							benefits screening and learn what other programs you may 
							be eligible to receive.  Click 
							<cfif not isdefined('session.partner_id') or session.partner_id neq 6><cf_sessionpassvars href="startover.cfm" subset_id="0" partner_id="0">here</cf_sessionpassvars><cfelse><a href="<cfoutput>https://#application.consumerurl#</cfoutput>">here</a></cfif>.
						</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
	
		<cfif session.partner_id eq 5>
			<cfoutput>
			<div class="question">
				<div class="questionHolder questionBar">
					<p>
						<a href="https://#session.ltccservername#/index.cfm#qltccQS#"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_01_welcome.gif" width="81" height="27" alt="Welcome" border="0"></a>
					</p>
					<p>
						<a href="https://#session.ltccservername#/index.cfm?method=ltcc.doCalculateCosts#altccQS#"><img  border=0 src="https://#session.ltccservername#/cf/Graphics/nav_02_risks.gif" width="125" height="27" alt="Risks and Costs" border="0"></a>
					</p>
					<p>
						<a href="https://#session.ltccservername#/index.cfm?method=ltcc.doServiceOptions#altccQS#"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_03_services.gif" width="92" height="27" alt="Services" border="0"></a>
					</p>
					<p>
						<a href="https://#session.ltccservername#/index.cfm?method=ltcc.doFinanceOptions#altccQS#"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_04_financing.gif" width="98" height="27" alt="Financing" border="0"></a>
					</p>
					<p>
						<a href="ltcc.cfm"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_active_07_programs.gif" width="132" height="27" alt="Public Programs" border="0"></a>
					</p>
					<p>
						<a href="https://#session.ltccservername#/index.cfm?method=ltcc.doLibrary#altccQS#"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_05_library.gif" width="83" height="27" alt="Library" border="0"></a>
					</p>
					<p>
						<a href="https://#session.ltccservername#/index.cfm?method=ltcc.doReport#altccQS#"><img border=0 src="https://#session.ltccservername#/cf/Graphics/nav_06_report.gif" width="77" height="27" alt="Your Personal Report" border="0"></a>
					</p>
				</div><!-- questionHolder -->
			</div><!-- question -->	
			</cfoutput>
		<!--- MH: Bug 5476 Remove for session 62 --->
		<cfelseif session.subset_id neq 55 and session.subset_id neq 54 and session.subset_id neq 62>
			<div id="tag_disclaimer" class="question">
				<div class="questionHolder questionBar">
					<cf_tagyedisclaimer>
				</div><!-- questionHolder -->
			</div><!-- question -->	
		</cfif>
		
		<cfif session.subset_id eq 0>
			<!-- Google Code for Comprehensive Conversion Page -->
			<script language="JavaScript" type="text/javascript">
			<!--
			var google_conversion_id = 1057730453;
			var google_conversion_language = "en_US";
			var google_conversion_format = "1";
			var google_conversion_color = "ffffff";
			var google_conversion_label = "gkiNCJ2cpgEQld-u-AM";
			//-->
			</script>
			<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
			</script>
			<noscript>
			<img height="1" width="1" border="0" src="https://www.googleadservices.com/pagead/conversion/1057730453/?label=gkiNCJ2cpgEQld-u-AM&amp;guid=ON&amp;script=0"/>
			</noscript>
		</cfif>
	
	</div>
	<!--- call footer tag --->
	<cf_tagfooter tag="#tag#">
