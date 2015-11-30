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

<cfparam name="url.reportType" type="string" default="All">

<cfif src eq '' and IsDefined('session.subsetRecFlag') and session.subsetRecFlag eq 0>
	<cflocation url="frmeligibility.cfm" addtoken="yes">
<cfelse>

<link rel="stylesheet" href="include/repotstyle.css" type="text/css" media="all">

<style type="text/css">

    @media print {

        BODY {

            size: 8.5in 11in portrait;

          margin: 0in;

        }

        TABLE {

            page-break-before: auto;

            page-break-inside: avoid;

        }

        .pagebreak { page-break-before: always;    }

        .noprint { display: none; }

    }

</style>

<cfif IsDefined('session.oeservername')>

<script language="JavaScript1.1">

<!--

function openMain() {

		setTimeout('window.close()', 1000);

		window.open('<cfoutput>#session.transfertype#://#session.oeservername#</cfoutput>/menu.do', 'main');

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

<cf_tagHeader>



<cfoutput><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

	<tr>

	<td rowspan="2" bgcolor="##FFFFFF"><img src="images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td>

	<td bgcolor="##FFFFFF" VALIGN="top"><IMG SRC="images/pixel.gif" width="1" height="#session.cellpadding#" border="0" alt=""></td>

	<td bgcolor="##FFFFFF" VALIGN="top"><cf_headerILTabs partner_id="#session.partner_id#" align="right"></td>

	<td rowspan="2" bgcolor="##FFFFFF"><img src="images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td></cfoutput>

	</tr>

	<tr>

	<td colspan="2" bgcolor="#FFFFFF">

<!--Dynamic Area--><font face="arial" size="4" color="#000000">



<FONT face="Arial" size=3><cfif session.subset_id eq 14><img src="images/recommendationheading.gif" alt="Our Recommendations"><cfelseif session.subset_id eq 40><cfelse><h1>Our Recommendations</h1><hr></cfif>

<cfif src eq 'eforms'>

	<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">

<cfelseif url.ReportType neq "All">

	<cf_buttons goText="Back to Primary Recommendations" goURL="frmRecommend.cfm?ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">

<cfelseif src eq 'elig' >

	<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">


<cfelse>

		<cf_buttons  go="false" printText="Print This Page Now For Your Records">
		<cfif session.org_id gt 0>
			<cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
			<cfparam name="attributes.fontSize" type="numeric" default="8">
			<cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
			<cfoutput>
				<form action="#session.transfertype#://#session.oeservername#/menu.do" method="post" target="_top">
				<input type="submit" name="print" value="Return to OE Home" style="#fontStyle#">			
				</form>
			</cfoutput>
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



<cfif session.prg_list neq "">

	

		<cfinclude template="rx/dspRX.cfm">

		<cfif adj eq 1>

			<cfloop list="#ReplaceList(RxPrgList, '(,)', ',')#" index="prgRec">

				<cfquery name="markseen" datasource="#session.datasrc#">

				UPDATE tbl_user_prgid

				SET unseen=NULL

				WHERE clientnum=#session.clientnum#

					AND prg_id='#prgRec#'

				</cfquery>

			</cfloop>

		</cfif>
		
<cfelseif session.prg_list eq "" and (session.subset_id eq 19)>
<cfif session.partner_id eq 17>
<p><font face="Arial" size="3"><b>Thank you for taking the time to complete the Kaiser Permanente
CheckUp questionnaire. We've compared your answers with the eligibility criteria for more than 1,350 public and private assistance programs. Based on
the answers you provided, we currently have no programs to recommend to you. We continually update our database with new programs and medications, so please
try again soon.</b></font></p>
<cfelse>
<p><font face="Arial" size="3"><b>Thank you for taking the time to complete the BenefitsCheckUp questionnaire. We've compared your answers with the eligibility criteria for more than 1,350 public and private assistance programs. Based on
the answers you provided, we currently have no programs to recommend to you. We continually update our database with new programs and medications, so please
try again soon.</b></font></p>
</cfif>
<p><font face="Arial" size="3"><b>For additional information, please contact the Eldercare Locator. This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers. You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/"  target="_blank">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>

<cfif session.partner_id eq 17>
<p><font face="Arial" size="3"><b>Thank you for taking the time to complete the Kaiser Permanente
CheckUp questionnaire. We've compared your answers with the eligibility
criteria of many government programs that provide substantial savings on the
costs of health care and prescription drugs. Based on the answers you provided,
we currently have no programs to recommend to you. We continually update our
database with new programs, so please try again soon.</b></font></p>
<cfelse>
<p><font face="Arial" size="3"><b>Thank you for taking the time to complete BenefitsCheckUpRx. We've compared
your answers with the eligibility criteria of many government programs that
provide substantial savings on the costs of health care and prescription drugs.
Based on the answers you provided, we currently have no programs to recommend
to you. We continually update our database with new programs,
so please try again soon.</b></font></p>
</cfif>
<p><font face="Arial" size="3"><b>For additional information, please contact the Eldercare Locator. This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers. You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/"  target="_blank">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

	
<cfelseif session.prg_list eq "" and (session.subset_id eq 28)>

<p><font face="Arial" size="3"><b>Thank you for taking the time to complete a BenefitsCheckUp screening for Medicaid and Supplemental Security Income (SSI).  We've compared your answers with the eligibility criteria for the Medicaid and Supplemental Security Income (SSI) programs in your state.  Based on the answers you provided, we currently have no programs to recommend to you.</b></font></p><br>

<cfelseif session.prg_list eq "" and (session.subset_id eq 27  )>

<p><font face="Arial" size="3"><b>Thank you for taking the time to complete BenefitsCheckUpRx. We've compared your answers with the eligibility criteria of many government programs that provide substantial savings on the costs of health care and prescription drugs. Based on the answers you provided, we currently have no programs to recommend to you. We continually update our database with new programs, so please try again soon.</b></font></p>

<p><font face="Arial" size="3"><b>For additional information, please contact the Eldercare Locator. This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers. You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/"  target="_blank">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>



<cfelseif session.prg_list eq "" and (session.subset_id eq 12 )>

<p><font face="Arial" size="3"><b>Thank you for taking the time to complete the Medicare Card Finder through BenefitsCheckUpRx. We've compared your answers with the eligibility criteria of the Medicare-approved drug discount card programs. Based on the answers you provided, we did not screen you eligible for a Medicare-approved drug discount card.</b></font></p>

<p><font face="Arial" size="3"><b>For additional information, please contact the Eldercare Locator. This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers. You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/"  target="_blank">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>

<cfelseif session.prg_list eq "" and (session.subset_id eq 40 or session.subset_id eq 41 )>
<p>Thank you for taking the time to complete the online application for the Medicare Prescription Drug Coverage&rsquo;s Extra Help / Low Income Subsidy through the National Council on Aging&rsquo;s BenefitsCheckUp. We've compared the information that you entered into the application with the eligibility criteria of many public programs. Based on that information, we currently have no programs to recommend to you. We continually update our database with new information, so please visit <a href="http://www.benefitscheckup.org/"> www.BenefitsCheckUp.org</a> to complete a BenefitsCheckUp eligibility screening.</p>
</br>
<p>For additional information and assistance, please contact the Eldercare Locator. This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers. You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</p>
<cfelse>

<p><font face="Arial" size="3"><b>Thank you for taking the time to complete BenefitsCheckUpRx. We've compared your answers with the eligibility criteria of many public and private programs that provide substantial savings on the costs of prescription drugs.  Based on the answers you provided, we currently have no programs to recommend to you. We continually update our database with new programs and medications, so please try again soon.</b></font></p>

<p><font face="Arial" size="3"><b>For additional information, please contact the Eldercare Locator.  This valuable resource can provide you with assistance in finding state and local area agencies on aging and community-based organizations that serve older adults and their caregivers.  You may find the information resources you need by visiting the Eldercare Locator Web site at <a href="http://www.eldercare.gov/" target="_blank">http://www.eldercare.gov/</a>, or you may speak to an Eldercare Locator information specialist by calling 1-800-677-1116.</b></font></p>

<p><font face="Arial" size="3"><b>There are other ways you can save money on prescription drugs. Click <a href="genericdruginfo.cfm">here</a> for additional information on saving money.</b></font></p>

<p><font face="Arial" size="3"><b>Click <a href="javascript:help2('imp_rx_info.cfm')">here</a> for important information you should know about prescription medications.</b></font></p>



<cfif not isdefined('session.cobrand_cso_id') or session.cobrand_cso_id eq 0 or session.cobrand_cso_id eq ''>



<!---	<b>Start Over</b>

<p><font face="Arial" size="3"><b>

	If you would like to repeat the questionnaire, click <cf_sessionPassVars href="startover.cfm" prev_id="0">here</cf_sessionPassVars>. 

</b></font></p> --->

	</cfif>

	<cfif isdefined('session.client_id') and session.client_id neq 'null'>

		<cfoutput>

		<br>

		<form action="#session.transfertype#://#session.oeservername#/clientDetail.do?id=#session.client_id#" method="post" target="_top">

			<input type="submit" value="Return to Client Detail">

		</form>

		</cfoutput>

	</cfif>

 </cfif>

 <cfif session.subset_id neq 40  >

	<cfinclude template="links.cfm">

 </cfif>

<cfif src eq 'eforms'>

	<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">

<cfelseif url.ReportType neq "All">

	<cf_buttons goText="Back to Primary Recommendations" goURL="frmRecommend.cfm?ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">

<cfelseif src eq 'elig' >

	<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">




</cfif>

	
</FONT></TD></TR></TABLE>

<!--- call footer tag --->

<cf_tagFooter hidehf="yes">

</cfif> <!--- End subset rec flag ID --->
