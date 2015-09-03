<cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0>

	<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">
	<cfset tag = partnerQuery.wrapper_tag2>
	<!----=======================================
	DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
		qualifies
	CALLED BY: procEligibility.cfm
	GOES TO: frmDetails.cfm
	REQUIRED: session.prg_list
	============================================---->
	<cf_sessioncheck>
	<cfparam name="src" type="string" default="">
	<cfparam name="adj" type="numeric" default="0">
	<cfparam name="aft" type="numeric" default="0">
	<cfparam name="url.reportType" type="string" default="All">
	
	<cfif src eq '' AND IsDefined('session.subsetRecFlag') and session.subsetRecFlag eq 0>
		<cflocation url="frmeligibility.cfm" addtoken="yes">
	<cfelse>
			<cfif session.partner_id neq 0>
            		<cfif cgi.SCRIPT_NAME NEQ '/cf/frmRecommend.cfm' AND cgi.SCRIPT_NAME NEQ '/cf/frmeligibility.cfm' AND SESSION.partner_id NEQ 22>
					<link rel="stylesheet" href="include/repotstyle.css" type="text/css" media="all">
					</cfif>
						<cfif IsDefined('application.serverPathOE')>
						<script language="JavaScript1.1">
						<!--
						function openMain() {
							setTimeout('window.close()', 1000);
							window.open('<cfoutput>#application.transferType#://#application.serverPathOE#</cfoutput>/menu.do', 'main');
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
			</cfif>
	</cfif>
	
	<cf_tagHeader show_title="yes" popupwarning="1" guts="frmRecommend.cfm">
	
		<cfif SESSION.partner_id EQ 0>
			
			
					<cfif IsDefined('application.serverPathOE')>
					<script language="JavaScript1.1">
					<!--
					function openMain() {
						setTimeout('window.close()', 1000);
						window.open('<cfoutput>#application.transferType#://#application.serverPathOE#</cfoutput>/menu.do', 'main');
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
		</cfif>
			
	<div id="frmRecommend" class="row survey">
		<cfif IsDefined('URL.ReportType') AND URL.ReportType EQ 'PAP' AND SESSION.subset_id EQ 39>	
			<div class="frmrecommend_buttons">
				<div style="float:left; cursor:pointer;">
					<a href="frmRecommend.cfm?adj=1&rpt=presdrug&<cfoutput>cfid=#session.cfid#&cftoken=#session.cftoken#</cfoutput>">
						<img src="/cf/img/backtoPrimaryRecommendations.gif" title="Back to Primary Recommendations" alt="Back to Primary Recommendations">
					</a>
				</div>
				<div style="float:right; cursor:pointer;">
					<a href="##" onClick="window.print();return false;">
						<img src="/cf/img/print_this_page.gif">
					</a>
				</div>
			</div>	
		</cfif>
	
	
		<h1>Our Recommendations</h1>
	
	<!--- check to make sure household members is between 1 and 8 --->
	<cfif Not IsDefined('session.no_hh_members') or session.no_hh_members eq 0>
	   		<cfset session.no_hh_members = 1>
		<cfelseif session.no_hh_members GT 8>
	   		<cfset session.no_hh_members = 8>
	</cfif>
	
	<cfset householdcount =  session.no_hh_members >
	<cfif IsDefined('session.hh_depend') > 
		<cfset session.hh_depend = val(session.hh_depend)>
		<cfif  session.hh_depend eq "" or session.hh_depend lt 1 >  
	   		<cfset session.hh_depend = 1>
		<cfelseif session.hh_depend GT 8>
	   		<cfset session.hh_depend = 8>
		</cfif>
		<cfset householdcount = session.hh_depend >
	</cfif>
	
	<cfif IsDefined('session.hh_depend') and IsDefined('session.no_hh_members') and session.hh_depend gt 1 or session.no_hh_members gt 1>
		<cfif session.no_hh_members gt session.hh_depend >
			<cfset householdcount =  session.no_hh_members >
		<cfelse>
			<cfset householdcount = session.hh_depend >
		</cfif>
	</cfif>
	
	<cfif false>
		
	  			<p><cf_surveyLink src="r" aft="#aft#"></p>
	  		
	</cfif>
	
	<cfif session.prg_list neq "">
	
		
	  			<p><cfinclude template="rx/dspRX.cfm"></p>
	  		
		
		<cfif adj eq 1>
			<cfloop list="#ReplaceList(RxPrgList, '(,)', ',')#" index="prgRec">
				<cfquery name="markseen" datasource="#application.dbSrc#">
				UPDATE tbl_user_prgid
				SET unseen=NULL
				WHERE clientnum=<cfqueryparam 
	                    value="#session.clientnum#" 
	                    cfsqltype="cf_sql_integer"
	                    maxlength="10">
					AND prg_id = <cfqueryparam 
	                    value="#prgRec#" 
	                    cfsqltype="CF_SQL_VARCHAR" 
	                    maxlength="25">
				</cfquery>
			</cfloop>
		</cfif>
		
	<cfelseif session.prg_list eq "" and (session.subset_id eq 19)>
	
		<p>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</p>
		
			
	  				<p>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</p>
		  				
	
			
	  				<p>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money</p>
		  				
	
			
	  				<p>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</p>
		  				
		
	<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>
		<p><strong>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</strong></p>
		
		<p>
			<strong>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</strong>
		</p>
	
		<p>
			<strong>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</strong>
		</p>
	
		<p>
			<strong>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</strong>
		</p>
		
	<cfelseif session.prg_list eq "" and (session.subset_id eq 28)>
	
		<p>
			<strong>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</strong>
		</p>
	
	<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>
	
		<p>
			<strong>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</strong>
		</p>
	
		<p>
			<strong>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</strong>
		</p>
		
		<p>
			<strong>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</strong>
		</p>
		
		<p>
			<strong>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</strong>
		</p>
	
	<cfelseif session.prg_list eq "" and (session.subset_id eq 40 or session.subset_id eq 41 or session.subset_id eq 55)>
		<p>Thank you for taking the time to complete the online application for the Medicare Part D Low-Income Subsidy (Extra Help) through the National Council on Aging's BenefitsCheckUp.  After you completed the application, we compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer.  We update our program list on a regular basis, so please try again by visiting <a href="http://www.benefitscheckup.org/"> www.BenefitsCheckUp.org</a>.
		</p>
		
		<p>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.
		</p>
	
	<cfelse>
	
		<p>
			<strong>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</strong>
		</p>
		
		<p>
			<strong>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</strong>
		</p>
		
		<p>
			<strong>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</strong>
		</p>
		
		<p>
			<strong>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</strong>
		</p>
		
		<cfif isdefined('session.client_id') and session.client_id neq 'null'>
			<cfoutput>
			<div id="return_to_client">
				<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
					<input type="submit" value="Return to Client Detail">
				</form>
			</div>
			</cfoutput>
		</cfif>
		
	</cfif><!--- END <cfif session.prg_list neq ""> FROM line 156 --->
	</div><!--- END <div id="prg_list">--->
	
	<cfif session.subset_id neq 40  >
		<div id="links">
			<cfinclude template="links.cfm">
		</div>
	</cfif>
	
		<cfif IsDefined('URL.ReportType') AND URL.ReportType EQ 'PAP' AND SESSION.subset_id EQ 39>	
			<div class="frmrecommend_buttons">
				<div style="float:left; cursor:pointer;">
					<a href="frmRecommend.cfm?adj=1&rpt=presdrug&<cfoutput>cfid=#session.cfid#&cftoken=#session.cftoken#</cfoutput>">
						<img src="/cf/img/backtoPrimaryRecommendations.gif" title="Back to Primary Recommendations" alt="Back to Primary Recommendations">
					</a>
				</div>
				<div style="float:right; cursor:pointer;">
					<a href="##" onClick="window.print();return false;">
						<img src="/cf/img/print_this_page.gif">
					</a>
				</div>
			</div>	
		</cfif>
	
	</div><!--- END <div id="frmRecommend"> --->
	
		<cfif isdefined('session.subset_id') and session.subset_id eq 39>
		
			<!-- Google Code for Prescription Drug Assistance Conversion Page -->
			<script language="JavaScript" type="text/javascript">
			<!--
			var google_conversion_id = 1057730453;
			var google_conversion_language = "en_US";
			var google_conversion_format = "1";
			var google_conversion_color = "ffffff";
			var google_conversion_label = "liRMCPecpgEQld-u-AM";
			//-->
			</script>
			<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
			</script>
			<noscript>
			<img height="1" width="1" border="0" src="https://www.googleadservices.com/pagead/conversion/1057730453/?label=liRMCPecpgEQld-u-AM&amp;guid=ON&amp;script=0"/>
			</noscript>
		
		<cfelseif isdefined('session.subset_id') and session.subset_id eq 27>
		
			<!-- Google Code for Medicare Rx Extra Help Conversion Page -->
			<script language="JavaScript" type="text/javascript">
			<!--
			var google_conversion_id = 1057730453;
			var google_conversion_language = "en_US";
			var google_conversion_format = "1";
			var google_conversion_color = "ffffff";
			var google_conversion_label = "I0RKCNGdpgEQld-u-AM";
			//-->
			</script>
			<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
			</script>
			<noscript>
			<img height="1" width="1" border="0" src="https://www.googleadservices.com/pagead/conversion/1057730453/?label=I0RKCNGdpgEQld-u-AM&amp;guid=ON&amp;script=0"/>
			</noscript>
		<cfelse>
		
		</cfif>
		<!--- call footer tag --->
	
	<cf_tagFooter tag="#tag#">
	<!--- End subset rec flag ID --->
<cfelse>
<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">
<cfset tag = partnerQuery.wrapper_tag2>
<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
	qualifies
CALLED BY: procEligibility.cfm
GOES TO: frmDetails.cfm
REQUIRED: session.prg_list
============================================---->
<cf_sessioncheck>
<cfparam name="src" type="string" default="">
<cfparam name="adj" type="numeric" default="0">
<cfparam name="aft" type="numeric" default="0">
<cfparam name="url.reportType" type="string" default="All">

<cfif src eq '' AND IsDefined('session.subsetRecFlag') and session.subsetRecFlag eq 0>
	<cflocation url="frmeligibility.cfm" addtoken="yes">
<cfelse>
		<cfif SESSION.partner_id NEQ 86>
        		<cfif cgi.SCRIPT_NAME NEQ '/cf/frmRecommend.cfm' AND cgi.SCRIPT_NAME NEQ '/cf/frmeligibility.cfm' AND SESSION.partner_id NEQ 22>
				<link rel="stylesheet" href="include/repotstyle.css" type="text/css" media="all">
				</cfif>
					<cfif IsDefined('application.serverPathOE')>
					<script language="JavaScript1.1">
					<!--
					function openMain() {
						setTimeout('window.close()', 1000);
						window.open('<cfoutput>#application.transferType#://#application.serverPathOE#</cfoutput>/menu.do', 'main');
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
		</cfif>
</cfif>

<cf_tagHeader show_title="yes" popupwarning="1" guts="frmRecommend.cfm">

	<cfif SESSION.partner_id EQ 86>
    	<cfif cgi.SCRIPT_NAME NEQ '/cf/frmRecommend.cfm' AND cgi.SCRIPT_NAME NEQ '/cf/frmeligibility.cfm' AND SESSION.partner_id NEQ 22>
		<link rel="stylesheet" href="include/repotstyle.css" type="text/css" media="all">
		</cfif>
				<cfif IsDefined('application.serverPathOE')>
				<script language="JavaScript1.1">
				<!--
				function openMain() {
					setTimeout('window.close()', 1000);
					window.open('<cfoutput>#application.transferType#://#application.serverPathOE#</cfoutput>/menu.do', 'main');
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
	</cfif>
	
<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td bgcolor="##FFFFFF" VALIGN="top" class="printtable"><cf_headerILTabs partner_id="#session.partner_id#" align="right"></td>
</cfoutput>
	</tr>

	<tr>
	<td bgcolor="#FFFFFF" class="printtd"><FONT face="Arial" size=3><cfif session.subset_id eq 14><img src="images/recommendationheading.gif" alt="Our Recommendations"><cfelseif session.subset_id eq 40><cfelse><h1>Our Recommendations</h1>
	<hr></cfif>

<cfif url.ReportType neq "All">
	<div class="noprint" <cfif (SESSION.partner_id EQ 86)>id="print_buttons"</cfif>>
	<cf_buttons goText="Back to Primary Recommendations" goURL="frmRecommend.cfm?ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	</div>
<cfelseif src eq 'elig' >
	<div class="noprint">
	<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	</div>
<cfelse>
		<div class="noprint">
		<cf_buttons  go="false" printText="Print This Page Now For Your Records">
		</div>
		<cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
			<cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
			<cfparam name="attributes.fontSize" type="numeric" default="8">
			<cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
			<cf_displayButton return_oe="true" name="print" style="#fontStyle#">
		</cfif>

</cfif>

<!--- check to make sure household members is between 1 and 8 --->
<cfif Not IsDefined('session.no_hh_members') or session.no_hh_members eq 0>
   		<cfset session.no_hh_members = 1>
	<cfelseif session.no_hh_members GT 8>
   		<cfset session.no_hh_members = 8>
</cfif>

<cfset householdcount =  session.no_hh_members >
<cfif IsDefined('session.hh_depend') > 
	<cfset session.hh_depend = val(session.hh_depend)>
	<cfif  session.hh_depend eq "" or session.hh_depend lt 1 >  
   		<cfset session.hh_depend = 1>
	<cfelseif session.hh_depend GT 8>
   		<cfset session.hh_depend = 8>
	</cfif>
	<cfset householdcount = session.hh_depend >
</cfif>

<cfif IsDefined('session.hh_depend') and IsDefined('session.no_hh_members') and session.hh_depend gt 1 or session.no_hh_members gt 1>
	<cfif session.no_hh_members gt session.hh_depend >
		<cfset householdcount =  session.no_hh_members >
	<cfelse>
		<cfset householdcount = session.hh_depend >
	</cfif>
</cfif>

	<cfif false><cf_surveyLink src="r" aft="#aft#"></cfif>

<cfif session.prg_list neq "">

		<cfinclude template="rx/dspRX.cfm">
		<cfif adj eq 1>
			<cfloop list="#ReplaceList(RxPrgList, '(,)', ',')#" index="prgRec">
				<cfquery name="markseen" datasource="#application.dbSrc#">
				UPDATE tbl_user_prgid
				SET unseen=NULL
				WHERE clientnum=<cfqueryparam 
                        value="#session.clientnum#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="10">
					AND prg_id = <cfqueryparam 
                        value="#prgRec#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
				</cfquery>
			</cfloop>
		</cfif>
	
<cfelseif session.prg_list eq "" and (session.subset_id eq 19)>
	<p><font face="Arial" size="3"><b>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</b></font></p>
	
<p><font face="Arial" size="3"><b>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>
<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>
	<p><font face="Arial" size="3"><b>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</b></font></p>
	
<p><font face="Arial" size="3"><b>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

	
<cfelseif session.prg_list eq "" and (session.subset_id eq 28)>

<p><font face="Arial" size="3"><b>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</b></font></p><br>

<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>

<p><font face="Arial" size="3"><b>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</b></font></p>

<p><font face="Arial" size="3"><b>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

<cfelseif session.prg_list eq "" and (session.subset_id eq 40 or session.subset_id eq 41 or session.subset_id eq 55)>
	<p>Thank you for taking the time to complete the online application for the Medicare Part D Low-Income Subsidy (Extra Help) through the National Council on Aging's BenefitsCheckUp.  After you completed the application, we compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer.  We update our program list on a regular basis, so please try again by visiting <a href="http://www.benefitscheckup.org/"> www.BenefitsCheckUp.org</a>.
	</p>
		
    <p>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.
    </p>

<cfelse>

	<p><font face="Arial" size="3"><b>Thank you for taking the time to answer these questions.  We have compared your answers with the program rules for many benefits.  However, based on the answers you provided, you do not meet the guidelines for the programs we offer. We update our program list on a regular basis, so please try again soon.</b></font></p>
	
	<p><font face="Arial" size="3"><b>For additional information and assistance, please contact the Eldercare Locator.  The Eldercare Locator can help you find state and local area agencies on aging and community-based organizations that provides assistance to older adults and their families.  You can also get more information by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a> or you can speak to an Eldercare Locator Information Specialist at: (800) 677-1116.</b></font></p>
	
	<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>
	
	<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

	<cfif not isdefined('session.org_id') or session.org_id eq 0>
	<!---	<b>Start Over</b>
	<p><font face="Arial" size="3"><b>
		If you would like to repeat the questionnaire, click <cf_sessionPassVars href="startover.cfm" prev_id="0">here</cf_sessionPassVars>. 
	</b></font></p> --->
	</cfif>
	
	<cfif isdefined('session.client_id') and session.client_id neq 'null'>
		<cfoutput>
		<br>
		<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
			<input type="submit" value="Return to Client Detail">
		</form>
		</cfoutput>
	</cfif>
	
</cfif><!--- END <cfif session.prg_list neq ""> FROM line 148 --->

 <cfif session.subset_id neq 40  >
	<cfinclude template="links.cfm">
 </cfif>


	<cfif url.ReportType neq "All">
		<div class="noprint" <cfif (SESSION.partner_id EQ 86)>id="print_button"</cfif>>
		<cf_buttons goText="Back to Primary Recommendations" goURL="frmRecommend.cfm?ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
		</div>
	<cfelseif src eq 'elig' >
		<div class="noprint">
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
		</div>
	</cfif></FONT></TD></TR></TABLE>

	<cfif isdefined('session.subset_id') and session.subset_id eq 39>
	
		<!-- Google Code for Prescription Drug Assistance Conversion Page -->
		<script language="JavaScript" type="text/javascript">
		<!--
		var google_conversion_id = 1057730453;
		var google_conversion_language = "en_US";
		var google_conversion_format = "1";
		var google_conversion_color = "ffffff";
		var google_conversion_label = "liRMCPecpgEQld-u-AM";
		//-->
		</script>
		<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
		</script>
		<noscript>
		<img height="1" width="1" border="0" src="https://www.googleadservices.com/pagead/conversion/1057730453/?label=liRMCPecpgEQld-u-AM&amp;guid=ON&amp;script=0"/>
		</noscript>
	
	<cfelseif isdefined('session.subset_id') and session.subset_id eq 27>
	
		<!-- Google Code for Medicare Rx Extra Help Conversion Page -->
		<script language="JavaScript" type="text/javascript">
		<!--
		var google_conversion_id = 1057730453;
		var google_conversion_language = "en_US";
		var google_conversion_format = "1";
		var google_conversion_color = "ffffff";
		var google_conversion_label = "I0RKCNGdpgEQld-u-AM";
		//-->
		</script>
		<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
		</script>
		<noscript>
		<img height="1" width="1" border="0" src="https://www.googleadservices.com/pagead/conversion/1057730453/?label=I0RKCNGdpgEQld-u-AM&amp;guid=ON&amp;script=0"/>
		</noscript>
	<cfelse>
	
	</cfif>
	<!--- call footer tag --->
	<cf_tagFooter tag="#tag#">
<!--- End subset rec flag ID --->
</cfif>