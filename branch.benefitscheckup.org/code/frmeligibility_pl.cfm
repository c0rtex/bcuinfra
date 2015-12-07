	<!--- PL Begins HERE --->
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
    <style type="text/css">
		INPUT#view_results
{
	display: block;
	float: left;
	background: #FEE5AA url(/wp-content/themes/bcuwptheme/images/buttons/helpTip-bg.png) repeat-x scroll 0 0;
	border: 2px solid #999;
	/*behavior: url(border-radius.htc);*/
	border-radius: 14px 14px 14px 14px;
	color: #1F419B !important;
	font-weight: 700;
	margin-right: 12px;
	text-decoration: none;
	width:auto;
	/* IE */ 
	/*width:1;*/
   	overflow:visible;
	text-align: center;
	text-transform: uppercase;
	padding:6px;
	font-size: 12px;
	cursor: pointer;
	margin-top: 5px;
}
	</style>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" <cfif SESSION.partner_id EQ 80>id="report_table"</cfif>>
		<cfif SESSION.partner_id NEQ 80 AND SESSION.partner_id NEQ 89 AND SESSION.partner_id NEQ 90>	
		<tr>
		<cfoutput>
			<td rowspan="2" bgcolor="##FFFFFF"><img src="/images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td>
			<td bgcolor="##FFFFFF" valign="top"><img src="images/pixel.gif" width="1" height="#session.cellpadding#" border="0" alt=""></td>
			<td bgcolor="##FFFFFF" valign="top"><!cf_headerILTabs partner_id="#session.partner_id#" align="right"></td>
			<td rowspan="2" bgcolor="##FFFFFF"><img src="/images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td>
		</cfoutput>
		</tr>
		</cfif>
		<tr>
	    	<cfif session.partner_id neq 86>
			<td colspan="2" bgcolor="#FFFFFF">
	        <cfelse>
	        <td colspan="2" bgcolor="#FFFFFF" class="text1">
	        </cfif>
				<!---Dynamic Area--->
	            
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
						<p><strong>
						<cfoutput>
                        	<cfif session.subset_id eq 55>
                                <p>Thank you for taking the time to complete the online application for the Medicare Part D Low-Income Subsidy (Extra Help) through the National Council on Aging's BenefitsCheckUp.  After you completed the application, we compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer.  We update our program list on a regular basis, so please try again by visiting <a href="http://www.benefitscheckup.org/"> www.BenefitsCheckUp.org</a>.
                                </p>
                                
                                <p>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.
                                </p>
                    		<cfelse>
								Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.
							</cfif>
							</cfoutput>
	                    </strong></p>
						
						<cfset prgnum=0>
					<cfelse>
						<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
							<cfset boxColor = "##feedb9">
						<cfelse>
							<cfset boxColor = "##d4dfdb">
						</cfif>
						<cfif (IsDefined('session.subset_id') And session.subset_id eq 22) or (url.ReportType eq 'All')>
							<strong>Report Options</strong>
							<hr>
							test<br><br>
						<cfelse>
							<cfif SESSION.partner_id EQ 80>
								<div id="results_overview">
									<strong class="strong_class_header">Results Overview</strong>
								</div>
							<cfelseif SESSION.partner_id EQ 86>
								<div id="results_overview">
									<h1>Results Overview</h1>
								</div>
							<cfelseif SESSION.partner_id EQ 77 and session.subset_id neq 0 and session.subset_id neq 62>
								<div>
								<cfoutput><h1 style="float:left;">Results Overview</h1>
								<div style="clear:both;"></cfoutput>
								</div>
                          					<cfelse>
                            				<h1 id="marginChangedToRemoveWhiteSpace">Results Overview</h1>
							</cfif>
							
							<hr>
							<!--- output the lead paragraph for the page --->
							<cfif prgs.RecordCount gt 0>
	                        	<!--- MH: Bug 5476 --->
								<cfif session.subset_id neq 3 and session.subset_id neq 62>
									<cfoutput><cfif SESSION.partner_id EQ 80><div class="report_text"></cfif><cf_displaytext group="site" code="site_results_eligible" param1="#prgs.RecordCount#"><cfif SESSION.partner_id EQ 80></div></cfif></cfoutput>
	                            <cfelseif session.subset_id eq 62>
	                            	<cfoutput><cf_displaytext group="site" code="site_results_eligible_subset_62"></cfoutput>
								<cfelse>
	                                Based on your answers, you may be eligible for the following nutrition 
	                                assistance program. Click on the program below to get a fact sheet that 
	                                contains the following information: short description of the program, 
	                                internet resources, local contact information, list of the paperwork/documents 
	                                you may need to apply for the program, and application forms (if available). 
								</cfif>
								<br><br>
	                            <cfset orgList = "2362,2370,1235,2379,1867,2372,2373,2374,2375,2377,2376,2378,2371,1660,2369">
								<cfif isDefined("session.st") AND session.st IS "GA" AND session.subset_id EQ 0 AND listFind(orgList, session.org_id) AND session.partner_id IS 0>
	                            <!--- <cfdump var="#prgs#" expand="no"> --->
	                            	<cfset aPrograms = createObject("component","com.bcu.gaVob").init(#prgs#)>
									<style type="text/css">
	                                    #gaBtn,#gaClose{ 
											cursor:pointer;
										}
										#gaClose{
											border:1px solid #000;
											padding:4px;
											background-color:#ccc;
											font-weight:bold;
											font-size:12px;
						d					margin-top:4px;
											z-index:999;
											height:25px;
										}
										#gaText{ 
											margin-bottom:10px;
											border-top:1px dotted #999;
											border-bottom:1px dotted #999;
										}
										#gaText p{padding-bottom:6px;}
	                                </style>
	                                <div>
	                                    <img id="gaBtn" src="images/ga_potential_savings.gif" border="0" alt="GA Potential Savings Button" />
	                                </div>
	                                <div id="gaText" style="display:none;">
	                                    <div style="font-weight:bold; text-align:center;padding:4px;position:relative;height:25px;">
	                                        <div style="position:absolute;top:2px;right:4px;">
	                                        	<a id="gaClose">CLOSE</a>
											<!--- <img id="gaClose" src="images/close.gif" border="0" alt="close savings" /> --->
	                                        </div>
	                                        Your Potential Savings
	                                    </div>
	                                    <p style="padding-left:6px; font-family:arial;">
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
	                                   <!---<cfdump var="#aPrograms#" expand="no" label="calculator struct"><br /><br />
	                                   <cfdump var="#prgs#" expand="no" label="program list"><br /><br />
	                                   <cfquery name="testVob" datasource="#application.dbSrc#">
	                                   	SELECT TOP 20 *
	                                    FROM gavob
	                                   </cfquery>
	                                   <cfdump var="#testVob#" expand="no" label="Top 20 new DB entries">
	                                   <cfoutput>session.org_id: #session.org_id#<br />#listFind(orgList, session.org_id)#</cfoutput>
	                                     <cfoutput>#aPrograms.dumpRecords()#</cfoutput> --->
	                                </div>
	                                <script type="text/javascript">
	                                    jQuery(document).ready(function(){
	                                        jQuery('#gaBtn').click(function(){
	                                            jQuery("#gaText").show('slow');			   
	                                        });
	                                        jQuery('#gaClose').click(function(){
	                                            jQuery("#gaText").hide('slow');							  
	                                        });
	                                    });
	                                </script>
	                            </cfif>
								<cfif session.subset_id neq 3 AND session.partner_id neq 14>
									<strong class="strong_class">Your Program List</strong>.  Click on the program names below to learn more.
									<br><br>
									<font face="Arial"><font size="+1"> <font face="Arial" size="+1"> </font>
								</cfif>
	                            <cfif isDefined("session.st") AND session.st IS "GA">
	                                
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
								<table border="0">
									<cfset HaveChips = "No">
									<cfset ER=(#sr# + 9)>
									<cfset prgnum = #SR#>
									<cfset monkeycounterA="1">
									<cfset session.category =  ArrayNew(1)>
									<cfloop query="prgs" startrow="#SR#" endrow="#ER#">
										<!--- if the prg_id is for CHIPS save chips for output later else print out --->
										<cf_cacheprogrampool action="get" code="#program_code#" var="pobj">
										<cf_displaytext group="program" code="program_#program_code#" var="programName">
										<cf_displaytext group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
										<cfoutput>
											<tr>
												<cfif session.subset_id neq 3>
	                                                <td align="right" valign="top"><strong>#prgnum#.</strong></td>
	                                            </cfif>
												<td align="left" valign="top">
													<cfif pobj.legacy eq '103-311-2593-FD-FD'>
	                                                	<cf_displaylispopup hspace="3" vspace="0" align="right">
	                                                </cfif> 
	                                               <strong>
													
	                                                	<cf_sessionpassvars href="frmDetails.cfm" state_id="#session.st#" extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#">#programName#</cf_sessionpassvars>
													
	                                                (#programCategoryName#)
													</strong>
	                                            </td>
											</tr>
										</cfoutput>
										<cfset prgnum = prgnum + 1>
									</cfloop>
								</table>
								<br>
								<cf_tagnextrecords 
									records="#prgs.RecordCount#"
									thispagename="frmeligibility.cfm"
									recordstodisplay="10"
									displaytext="Program"
									displayfont="Arial"
									usebold="Yes"
									extraurl="&CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#">
								
								<!--- format spacing depending on the number of records --->
								<cfif prgs.RecordCount gt 10>
									<br>
								</cfif>
							</cfif>
	                        <!--- MH: Bug 5702 9-3-2010 BCBH Ad | Updated per 7052--->
	                        <cfif (SESSION.partner_id EQ 86) OR (session.partner_id eq 0 and session.org_id eq 0)>
	                        	<cfset showBreaks = "false">
	                        	<BR />
	                            <center>
	                        	<table <cfif (SESSION.partner_id EQ 86)>id="dealing_health"</cfif> border="4" cellpadding="5" cellspacing="0" bgcolor="#EEEEEE" bordercolordark="#333333" bordercolorlight="#666666">
	                               	<tr>
	                                   	<td>
	                        				<table border='0' cellpadding="0" cellspacing="0">
	                            				<tr>
	                                				<td align="center"><strong>Dealing with an ongoing health condition?</strong></td>
	                                			</tr>
	                                   			<tr>
	                                				<td align="center"><strong>Visit Restart Living to sign up for a workshop that can help you feel better.</strong></td>
	                                			</tr>
	                                   			<tr>
	                                				<td align="center"><strong><cf_buildRedirectURL code="bcbh" >Sign up today!</cf_buildRedirectURL></strong></td>
	                                            </tr>
			                            	</table>
	        		                      </td>
	 								</tr>
	                            </table>
	                            </center>
	                        </cfif>
							<!--- program groups --->
							<cfif ListLen(programGroupList)>
                            	<BR />
								<cfloop list="#programGroupList#" index="x">
									
									<cf_displaytext group="prggrpblurb" code="prggrpblurb_#x#">
									<table border="0">
										<cfset prgnum = 1>
										<cfloop list="#programCodeList#" index="y">
											<cf_cacheprogrampool action="get" code="#y#" var="pobj">
											<cfif pobj.group eq x>
												<cf_displaytext group="program" code="program_#y#" var="programName">
												<cf_displaytext group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
												<cfoutput>
													<tr>
														<td align="right" valign="top"><font face="arial" ><strong>#prgnum#.</strong></font></td>
														<td align="left" valign="top">
															<cfif pobj.legacy eq '103-311-2593-FD-FD'>
	                                                        	<cf_displaylispopup hspace="3" vspace="0" align="right">
	                                                        </cfif> 
	                                                        <strong>
															<cf_sessionpassvars 
	                                                        	href="frmDetails.cfm" 
	                                                            state_id="#session.st#" 
	                                                            extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#">
	                                                            #programName#
	                                                        </cf_sessionpassvars> 
	                                                        (#programCategoryName#)
															</strong>
	                                                    </td>
													</tr>
												</cfoutput>
												<cfset prgnum = prgnum + 1>
											</cfif>
										</cfloop>
									</table>
								</cfloop>
								
							</cfif>
						</cfif>
    <cfoutput>                    
    <cfset partnerList = "36,37,38,39,40">
    <cfif listFind(partnerList, session.partner_id)>                 
	<cfset List1 = "CA">
    <cfset List2 = "CO,NV,IN,KY,OH,MO,WI,VA,CT,ME,NH">
    <cfset List3 = "GA">
    <cfset List4 = "NY">
	<cfif session.st EQ "CA">
    	<BR /><BR />
        <font size=+2><strong>Medicare Options</strong></font><br>
		<hr size="1" color="ababab" noshade="noshade" />
    	<cf_buildRedirectURL code="anthem_bluecross"><img src="img/partners/Anthem Blue Cross Logo.jpg" style="margin-right:20px;" alt="Anthem Blue Cross" title="Anthem Blue Cross" align="left" /></cf_buildRedirectURL>
      	Enjoy benefits not covered by Original Medicare.  Carefully evaluate your options.  Call 1-855-572-4538.
    <cfelseif listFind(List2, session.st)>
    	<BR /><BR />
        <font size=+2><strong>Medicare Options</strong></font><br>
		<hr size="1" color="ababab" noshade="noshade" />
    	<cf_buildRedirectURL code="anthem_bcbs"><img src="img/partners/Anthem Blue Cross and Blue Shield Logo.jpg" style="margin-right:20px;" alt="Anthem Blue Cross and Blue Shield" title="Anthem Blue Cross and Blue Shield" align="left" /></cf_buildRedirectURL>
      	Enjoy benefits not covered by Original Medicare.  Carefully evaluate your options.  Call 1-855-572-4540.
    <cfelseif session.st EQ "GA">
    	<BR /><BR />
        <font size=+2><strong>Medicare Options</strong></font><br>
		<hr size="1" color="ababab" noshade="noshade" />
    	<cf_buildRedirectURL code="georgia_bcbs"><img src="img/partners/Blue Cross and Blue Shield of Georgia Logo.jpg" style="margin-right:20px;" alt="Blue Cross and Blue Shield of Georgia" title="Blue Cross and Blue Shield of Georgia" align="left"/></cf_buildRedirectURL>
      	Enjoy benefits not covered by Original Medicare.  Carefully evaluate your options.  Call 1-855-572-4539.
    <cfelseif session.st EQ "NY">
		<BR /><BR />
        <font size=+2><strong>Medicare Options</strong></font><br>
		<hr size="1" color="ababab" noshade="noshade" />
    	<cf_buildRedirectURL code="empire_bcbs"><img src="img/partners/Empire Blue Cross Blue Shield Logo.jpg" style="margin-right:20px;" alt="Empire Blue Cross Blue Shield" title="Empire Blue Cross Blue Shield" align="left" /></cf_buildRedirectURL>
      	Enjoy benefits not covered by Original Medicare.  Carefully evaluate your options.  Call 1-855-572-4536.
    <cfelse>
    	<BR /><BR />
        <font size=+2><strong>Medicare Options</strong></font><br>
		<hr size="1" color="ababab" noshade="noshade" />
    	<cf_buildRedirectURL code="unicare_shop"><img src="img/partners/Unicare Logo.jpg" width="242px" style="margin-right:20px;" alt="Unicare" title="Unicare" align="left" /></cf_buildRedirectURL>
    </cfif>
    <br>
    </cfif>
    </cfoutput>					
	<!--- 04.08.2004 BS  Display AssistGuide text if any programs returned --->
	<!--- 04.27.2004 BS  Display AssistGuide text if partner not 5 or 6 --->
	<cfif session.subsetEFormFlag neq 1><cfoutput>
	<br><strong>Guide to Application Forms</strong><br>
	There are <strong>fact sheets</strong> and <strong>application forms</strong> available for many of the programs appearing in your results list.  If you would like help printing and filling out application forms for these programs, <a href="frmAccess.cfm?src=comp&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.<br>
	</cfoutput></cfif>
	
	<cfif session.subsetDrugFlag eq 0 and session.subsetRecFlag neq 0>
	<cfoutput>
	<br>
	<strong>Prescription Benefits Recommendations</strong><br>
	We have compiled recommendations for you as to how to save money on your prescription medications.   To get your recommendations, <a href="frmRecommend.cfm?adj=1&src=elig&ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.<br>

	</cfoutput>
	</cfif>
	
	<!--- 09/01/2002 REM  closing cfif from no programs trap --->
	</cfif>
	
	<cfif session.evaluation>
	<table><tr><td bgcolor="f0f0f0">
	<center>
	<strong>Evaluators Please Take Note:</strong></center>
	Kindly take a moment to give us your overall feedback on this new service.  Follow this link: <a href="javascript:feedback('https://bcudev.benefitscheckup.org/overallfeedback_f.cfm')"><strong>Your Overall Feedback Form</strong></a> to rate the new service, provide comments and suggestions.
	<br>
	</td></tr></table><br>
	</cfif>
	<cfif url.ReportType neq 'all' and session.subset_id neq 22>
	<cfif session.partner_id neq 5>
	
	<!--- output generic drug details if client qualifies --->
	<cfif session.subset_id neq 63 and session.subset_id neq 67 and session.subset_id neq 40 AND session.subset_id neq 51 AND session.subset_id neq 54 and session.genericdrugs is "y" and not (NOT ListLen(trim(session.prg_list)) and IsDefined('session.subset_id') AND session.subset_id eq 1)>
	<cfif session.partner_id IS NOT 24 and showBreaks eq "true">
	<br /><br />
	</cfif>
    <hr size="1" color="ababab" noshade="noshade" /><br>
	<table>
	<cfoutput>
	<tr><td><strong>There are many ways you can save money on prescription drugs. <br> <a href="genericdruginfo.cfm?src=elig&sr=#SR#&cfid=#session.cfid#&cftoken=#session.cftoken#">Click here</a> for additional information on saving money.</strong></td><td>
	<!--- <a href="frmDetails.cfm?prg_id=XXX-311-2387-FD-FD&src=elig&CFID=#session.cfid#&CFTOKEN=#session.cftoken#"> --->
	</td></tr>
	<cfset prgnum = prgnum + 1>
	</cfoutput>
	</table>	
	</cfif>
	<!--- MH: Bug 5476 Removed 'Click here…' from subset 62 --->
	<cfif session.subset_id neq 35 and session.subset_id neq 40 and session.subset_id neq 44 and session.subset_id neq 49 and session.subset_id neq 51 and session.subset_id neq 55 and session.subset_id neq 54 and session.subset_id neq 56 and session.subset_id neq 57 and session.subset_id neq 3 and session.subset_id neq 62 and session.subset_id neq 70 and session.subset_id neq 76 and session.subset_id neq 77>
	<br>
	<cfif  session.subset_id neq 59 and session.subset_id neq 64 and session.subset_id neq 63 and session.subset_id neq 67 and session.subset_id neq 78>
	<table>
	<tr><td><strong><a href="javascript:help2('imp_rx_info.cfm')">Click here</a> for important information you should know about prescription medications.</strong></td><td>
	</td></tr>
	</table>
	</cfif>
	</cfif>
	
	<!--- output chips details if client answered chips question --->
	<!--- 09/01/2002 REM  Removed 'havechips is "yes" or ' from below cfif --->
	<cfif IsDefined('session.wantchips') and session.wantchips is "y">
	<br>
	<table>
	<cfoutput>
	<tr><td><strong>Since you indicated that you know of children without health insurance, you may want to click on the following link to get more information about the State Children's Health Insurance Program. Each state has a program that makes health insurance coverage available, either free or at low cost, to children in working families. <a href="frmDetails.cfm?prg_id=103-309-2191-FD-FD&src=elig&CFID=#session.cfid#&CFTOKEN=#session.cftoken#">State Children's Health Insurance Program</a></strong></td><td>
	</td></tr>
	<cfset prgnum = prgnum + 1>
	</cfoutput>
	</table>	
	</cfif>
	<br>
	</cfif>
	
	
	
	<!--- output the bottom paragragh and the links to recap, eval form, and restart --->
	<cfif session.buff_list NEQ "" and session.subset_id neq 49>
	<cf_tagshowbufferprogs><br>
	</cfif>
	
	
	<!--cfif session.st eq 'OH' and session.county eq 'CUYAHOGA' >
	<strong>Other Cuyahoga County Programs</strong><br>
	<hr>
	For a chart of other Cuyahoga County programs, click <a href="CCSSPM.html">here</a>.  (If you have Adobe Acrobat Reader, download this chart as a <a href="images/CCSSPM.pdf">PDF file</a>.)<br><br>
	cfif-->
	
	<cf_displayresultscomments>
	
	<cfoutput>
	<cfif SESSION.partner_id EQ 80>
		<h4>Answer Recap</h4>
		<hr>
		If you would like to see a short recap of your answers, click <a href="javascript:help3 ('frmrecap.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#')">here</a>.<br>
	<cfelseif session.subset_id neq 55 and session.subset_id neq 54>
<cfif session.partner_id neq 14>
	<font size=+2><strong>Answer Recap</strong></font><br>
	<hr>
	If you would like to see a short recap of your answers, click <a href="javascript:help3 ('frmrecap.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#')">here</a>.<br>
<cfelse>
<br>
	<h2>Answer Recap</h2>

					If you would like to see a short recap of your answers, click <a data-toggle="modal" role="button" href="##answerrecap">here</a>.

<div id="answerrecap" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Answer Recap" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Answer Recap</h2></div>
  </div>
  <div class="modal-body">

<cfinclude template="frmrecap.cfm">

<!-- Lynna Cekova: missing one closing div because of specifics in frmrecap.cfm -->

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
	



</cfif>
	</cfif>
	<br>
	<!---   Added in a cfif to check for a program list--otherwise, this link is pointless: --->
	<cfif (ListLen(session.prg_list) OR ListLen(session.buff_list)) AND session.partner_id neq 5 AND session.subset_id neq 3>
	<cfif SESSION.partner_id EQ 80>
		<h4>View and Print Report</h4>
		<hr>
	<cfelse>
 
<cfif session.partner_id neq 14>
		<font size=+2><strong>View and Print Report</strong></font><br>
		<hr>
<cfelse>
		<h2>View and Print Report</h2>
</cfif>
	</cfif>
	
	
	Print the listing and details of the programs to which you may be potentially eligible to receive. Details include program descriptions, local offices, and required materials.
	
	<br><br>
	
<cfif session.partner_id eq 14><div style="float:left; display: inline-block;" id="printReportElig"><cfelse><div style="display: inline-block"></cfif>
		<form action="frmreportview.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&RequestTimeout=300" method="post" name="ReportForm">
		<input class="view_results" type="submit" value="View and Print Report"></form>
	</div>
    <cfif ListContains('45,61,63,64,81,82,83,84,85,87,88', session.partner_id) gt 0>
	<div style="display: inline-block;">
		<form action="frmreportoptions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="ReportCustomizeForm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Customize and Print Report"></form>
	</div>
	</cfif>
	<br>
	<cfif session.org_id gt 0>
	<!---<form action="frmreportoptions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="ReportCustomizeForm">
	<input type="submit" value="Customize and Print Report"></form>
	<br>--->
	<cfif session.client_id neq 'null'>
	<form action="#urlType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
	<input type="submit" value="Return to Client Detail">
	</form>
	<br>
	</cfif>
	</cfif>
	</cfif>
	</cfoutput>
	</cfif>
	<cfif session.org_id eq 0 and session.subset_id neq 55 and session.subset_id neq 63 and session.subset_id neq 67 >
	<cfinclude template="links.cfm">
	</cfif>
	<cfif session.source_id eq 2 or session.source_id eq 3>
	<cf_displaybutton return_oe="true">
	<cfinclude template="links.cfm">
	</cfif>
	<!--- MH: Bug 5476 Remove 'Try a Comp…' for subset 62 --->
	<cfif session.subset_id neq 0 And session.subset_id neq 21 And session.subset_id neq 22 And session.subset_id neq 35 And session.subset_id neq 37 And session.subset_id neq 38 And session.subset_id neq 40 And session.subset_id neq 44 And session.subset_id neq 49 And session.subset_id neq 51 And session.source_id neq 3 And session.partner_id neq 5 And session.partner_id neq 17 And session.subset_id neq 55 And session.subset_id neq 54 And session.subset_id neq 56 and session.subset_id neq 57 and session.subset_id neq 3 and session.subset_id neq 59 and session.subset_id neq 62 and session.subset_id neq 63  and session.subset_id neq 64 and session.subset_id neq 67 and session.subset_id neq 68 and session.subset_id neq 70 and session.subset_id neq 77 and session.subset_id neq 78 and session.subset_id neq 76 and session.partner_id neq 77
	and session.subset_id neq 19 
		and session.subset_id neq 27
		and session.subset_id neq 39 >
	<strong>Try a Comprehensive Screening</strong><br>
	<hr>
	The <cf_tagbcu subset_id="#session.subset_id#"> service is only a small portion of what <cf_tagbcu> offers.  Please take a few more minutes to complete a comprehensive benefits screening and learn what other programs you may be eligible to receive.  Click <cfif not isdefined('session.partner_id') or session.partner_id neq 6><cf_sessionpassvars href="startover.cfm" subset_id="0" partner_id="0">here</cf_sessionpassvars><cfelse><a href="<cfoutput>https://#application.consumerurl#</cfoutput>">here</a></cfif>.<br><br>
	</cfif>
	
	<cfif session.partner_id eq 5>
	
	<cfoutput>
	<table border=0 cellpadding=0 cellspacing=0>
	<tr>
	<td colspan="8">&nbsp;</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	<td><a href="https://#session.ltccservername#/index.cfm#qltccQS#"><img border=0 src="https://#session.ltccservername#/Graphics/nav_01_welcome.gif" width="81" height="27" alt="Welcome" border="0"></a></td>
	<td><a href="https://#session.ltccservername#/index.cfm?method=ltcc.doCalculateCosts#altccQS#"><img  border=0 src="https://#session.ltccservername#/Graphics/nav_02_risks.gif" width="125" height="27" alt="Risks and Costs" border="0"></a></td>
	<td><a href="https://#session.ltccservername#/index.cfm?method=ltcc.doServiceOptions#altccQS#"><img border=0 src="https://#session.ltccservername#/Graphics/nav_03_services.gif" width="92" height="27" alt="Services" border="0"></a></td>
	<td><a href="https://#session.ltccservername#/index.cfm?method=ltcc.doFinanceOptions#altccQS#"><img border=0 src="https://#session.ltccservername#/Graphics/nav_04_financing.gif" width="98" height="27" alt="Financing" border="0"></a></td>
	<td><a href="ltcc.cfm"><img border=0 src="https://#session.ltccservername#/Graphics/nav_active_07_programs.gif" width="132" height="27" alt="Public Programs" border="0"></a></td>
	<td><a href="https://#session.ltccservername#/index.cfm?method=ltcc.doLibrary#altccQS#"><img border=0 src="https://#session.ltccservername#/Graphics/nav_05_library.gif" width="83" height="27" alt="Library" border="0"></a></td>
	<td><a href="https://#session.ltccservername#/index.cfm?method=ltcc.doReport#altccQS#"><img border=0 src="https://#session.ltccservername#/Graphics/nav_06_report.gif" width="77" height="27" alt="Your Personal Report" border="0"></a></td>
	</tr>
	</table>
	</cfoutput>
	<!--- MH: Bug 5476 Remove for session 62 --->
	<cfelseif session.subset_id neq 55 and session.subset_id neq 54 and session.subset_id neq 62>
	<!--- tag that outputs the disclaimer for if you're not a citizen --->
	<cf_tagyedisclaimer>
	</cfif>
	</font></td></tr></table>
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
	<!--- call footer tag --->
	<cf_tagfooter tag="#tag#">
