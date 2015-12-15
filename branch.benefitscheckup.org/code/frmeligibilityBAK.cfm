<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">
<cfset tag = partnerQuery.wrapper_tag3>
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
<cf_tagHeader show_title="yes" guts="frmeligibility.cfm" popupwarning="1">

<cfoutput><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td rowspan="2" bgcolor="##FFFFFF"><img src="images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td>
	<td bgcolor="##FFFFFF" VALIGN="top"><IMG SRC="images/pixel.gif" width="1" height="#session.cellpadding#" border="0" alt=""></td>
	<td bgcolor="##FFFFFF" VALIGN="top"><!cf_headerILTabs partner_id="#session.partner_id#" align="right"></td>
	<td rowspan="2" bgcolor="##FFFFFF"><img src="images/pixel.gif" width="#session.cellpadding#" border="0" height="1" alt=""></td></cfoutput>
	</tr>
	<tr>
	<td colspan="2" bgcolor="#FFFFFF">
<!--Dynamic Area--><font face="arial" size="4" color="#000000">
<!--- 09/01/2002 REM  There's a slight possibility that there won't be any programs
returned in the new RX Only version, so we have to trap for that here: --->
<!--- 12/04/2002 BS  An error cropped up in cases where the user qualified for no regular programs
but did qualify for buffer programs.  Now we check here ONLY to make sure the regular prg_list is empty. --->
<!--- 08/03/2005 BShunn  Moved query up here so if we're filtering out 333 and 334 programs and that makes
           prg_list empty the page still displays a no-results message --->
<cfset programCodeList = ''>
<cfset programGroupList = ''>
<cfif ListLen(trim(session.prg_list))>
	<!--- Pull in eligible programs from session.prg_list--->
	<cfquery name="prgConvert" datasource="#application.dbSrc#">
		select p.program_code
		from tbl_prg_all pa inner join program p
				on pa.RecID=p.program_id
			left outer join programgroup pg
				on p.programgroup_id=pg.programgroup_id
		where pa.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
		order by pg.sort, p.sort
	</cfquery>
	<cfloop query="prgConvert">
		<cfset programCodeList = ListAppend(programCodeList, program_code)>
		<cf_cacheProgramPool action="get" code="#program_code#" var="pobj">
		<cfif pobj.group neq '' and not ListFind(programGroupList, pobj.group)>
			<cfset programGroupList = ListAppend(programGroupList, pobj.group)>
		</cfif>
	</cfloop>
	<cfquery name="prgs" datasource="#application.dbSrc#">
		select pp.program_code, ifnull(pp.supersort, 999999999) bigsort
		from tbl_prg_all p, program pp, programcategory pc
		where p.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
			and p.RecID=pp.program_id
			and pp.programgroup_id is null
			and pp.programcategory_id=pc.programcategory_id
		<cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''>
			and (pc.legacy_code is null or pc.legacy_code not in (333, 334))
		</cfif>
		order by bigsort, pc.sort, pp.sort
	</CFQUERY>
<cfelse>
	<!--- 08/03/2005 BShunn  If list is empty, create an empty query object in case we still try to access query --->
	<cfset prgs = QueryNew('program_code,bigsort')>
</cfif>

<cfif false><cf_surveyLink src="e" aft="#aft#"></cfif>

<cfif not ListLen(programCodeList)>
<p><b><cfoutput>
<cfif session.partner_id eq 5>
Thank you for taking the time to complete the Public Programs Section of the Long-Term Care Counselor.  We've compared your answers with the eligibility criteria for long-term care programs in our database.  Based on the answers you provided, we currently have no programs to recommend to you.  We continually update our database with new programs and medications, so please try again soon.
<cfelseif session.subset_id eq 19>
Thank you for taking the time to complete <cf_tagBCU subset_id="19">.  We've
compared your answers with the eligibility criteria of many public and private
programs that provide substantial savings on the costs of prescription drugs.
Based on the answers you provided, we currently have no programs to recommend
to you. We continually update our database with new programs and medications,
so please try again soon.
<cfelseif session.subset_id eq 27>
Thank you for taking the time to complete <cf_tagBCU subset_id="27">.  We've compared
your answers with the eligibility criteria of many government programs that
provide substantial savings on the costs of health care and prescription drugs.
Based on the answers you provided, we currently have no programs to recommend
to you. We continually update our database with new programs,
so please try again soon.
<cfelseif session.subset_id eq 35>
Thank you for taking the time to complete the <cf_tagBCU> questionnaire.  We've compared your answers with the eligibility criteria for Food Stamp, Housing and Energy Assistance programs. Based on the answers you provided, we currently have no programs to recommend to you.  We continually update our database with new programs, so please try again soon.
<cfelseif session.subset_id eq 37>
Thank you for taking the time to complete the BenefitsCheckUp questionnaire.
We've compared your answers with the eligibility criteria for a variety of
benefits assistance programs. Based on the answers you provided, we currently
have no programs to recommend to you. We continually update our database with
new programs, so please try again soon.
<cfelseif session.subset_id eq 38>
Thank you for taking the time to complete the BenefitsCheckUp Disaster
Recovery questionnaire. We've compared your answers with the eligibility
criteria for a variety of programs that help with Disaster Recovery.  Based on
the answers you provided, we currently have no programs to recommend to you. We
continually update our database with new programs and medications, so please
try again soon.
<cfelseif session.subset_id eq 44>
Thank you for taking the time to complete the <cf_tagBCU> questionnaire.  We've compared
your answers with the eligibility criteria for a
variety of benefits assistance programs.
Based on the answers you provided, we currently have no programs to recommend
to you. We continually update our database with new programs,
so please try again soon.
<cfelseif session.subset_id eq 49>
Thank you for taking the time to complete the <cf_tagBCU> questionnaire.
We've compared your answers with the eligibility criteria for a variety of
public assistance programs. Based on the answers you provided, we currently
have no programs to recommend to you. We continually update our database with
new programs, so please try again soon.
<cfelseif session.subset_id eq 51>
Thank you for taking the time to complete the Aging in Place HECM
questionnaire. We've compared your answers with the eligibility criteria for a
variety of public and private programs that offer resources or alternative
options to a reverse mortgage. Based on the answers you provided, we currently
have no programs to recommend to you. We continually update our database with
new programs, so please try again soon.
<cfelseif session.subset_id eq 54 or session.subset_id eq 55 or session.subset_id eq 56>
Thank you for taking the time to complete the <cf_tagBCU subset_id="#session.subset_id#"> questionnaire.  We've compared your answers with the eligibility criteria for more than <cf_expandTextCodes text="[[count|program|active|50|#session.subset_id#]]"> benefit assistance programs.  Based on the answers you provided, we currently have no programs to recommend to you. We continually update our
database with new programs, so please try again soon.
<cfelseif session.subset_id eq 3 >
Thank you for taking the time to complete the <cf_tagBCU subset_id="#session.subset_id#"> questionnaire.
We've compared your answers with the eligibility criteria for your state's Supplemental Nutrition Assistance Program (SNAP) (the new name for the federal Food Stamp Program). Based on the answers you provided, you may not qualify for
this program. We continually update our database, so please try again soon.
<cfelse>
Thank you for taking the time to complete the <cf_tagBCU subset_id="#session.subset_id#"> questionnaire.  We've compared your answers with the eligibility criteria for more than <cf_expandTextCodes text="[[count|program|active|50|#session.subset_id#]]"> public and private assistance programs.  Based on the answers you provided, we currently have no programs to recommend to you.  We continually update our database with new programs and medications, so please try again soon.
</cfif>

<cfif prgs.RecordCount eq 0 And IsDefined('session.subset_id') AND session.subset_id eq 1>
<br><br><FONT FACE="arial" size="4"><b>There are other ways you can save money on prescription drugs.  <A HREF="genericdruginfo.cfm?src=elig&sr=#SR#&cfid=#session.cfid#&cftoken=#session.cftoken#">Click here</a> for additional information on saving money.</b></FONT>
</cfif>

</cfoutput></b></p>
<FONT FACE="Arial" SIZE="+1">
<cfset prgnum=0>
<cfelse>


<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
	<cfset boxColor = "##feedb9">
<cfelse>
	<cfset boxColor = "##d4dfdb">
</cfif>
<cfif (IsDefined('session.subset_id') And session.subset_id eq 22) or (url.ReportType eq 'All')>
<FONT face="Arial"><FONT SIZE=+2><B>Report Options</B></FONT>
<hr>
test<br><br>
<cfelse>
<FONT face="Arial"><FONT SIZE=+2><B>Results Overview</B></FONT>
<hr>

<!--- output the lead paragraph for the page --->
<cfif prgs.RecordCount gt 0>
<cfoutput><cf_displayText group="site" code="site_results_eligible" param1="#prgs.RecordCount#">
<br><br></CFOUTPUT>
<FONT FACE="Arial"><FONT SIZE="+1">

<b>Your Program List</b>.  Click on the program names below to learn more.
<br><br>

<FONT FACE="Arial" SIZE="+1">
<cf_tagNextRecordsInvisible 
			 Records="#prgs.RecordCount#"
			 ThisPageName="frmeligibility.cfm"
			 RecordsToDisplay="10"
			 DisplayText="Program"
			 DisplayFont="Arial"
			 UseBold="Yes"
             ExtraURL="&CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#">
</FONT>

<!--- The actual output for the visible screen this is the list of programs numbered --->
<table border="0">
	<cfset HaveChips = "No">
	<cfset ER=(#sr# + 9)>
	<cfset prgnum = #SR#>
	<cfset monkeycounterA="1">
	<cfset session.category =  ArrayNew(1)>
	<cfloop query="prgs" startrow="#SR#" endrow="#ER#">
		<!--- if the prg_id is for CHIPS save chips for output later else print out --->
		<cf_cacheProgramPool action="get" code="#program_code#" var="pobj">
		<cf_displayText group="program" code="program_#program_code#" var="programName">
		<cf_displayText group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
		<cfoutput>
		<tr>
			<td align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b></FONT></td>
			<td align="left" valign="top"><cfif pobj.legacy eq '103-311-2593-FD-FD'><cf_displayLISPopup hspace="3" vspace="0" align="right"></cfif> <FONT FACE="arial"><b>
			<cfif session.partner_id neq 55>
			<cf_sessionPassVars HREF="frmDetails.cfm" addtoken="true" state_id="#session.st#" extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#,state_id=#session.st#,cfid=#session.cfid#,cftoken=#session.cftoken#">#programName#</cf_sessionPassVars> (#programCategoryName#)
			<cfelse>
			<a href="#application.transfertype#://#application.serverPath#/frmDetails.cfm?CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#&prg_id=#pobj.legacy#&src=elig&sr=#sr#&county=#session.county#&city=#session.city#&zip=#session.zip#">#programName#</a> (#programCategoryName#)
			</cfif>			

		</b></FONT></td>
		</tr>
		</cfoutput>
		<cfset prgnum = prgnum + 1>
	</cfloop>
</table>
<FONT FACE="Arial" SIZE="+1">
<cf_tagNextRecords 
			 Records="#prgs.RecordCount#"
			 ThisPageName="frmeligibility.cfm"
			 RecordsToDisplay="10"
			 DisplayText="Program"
			 DisplayFont="Arial"
			 UseBold="Yes"
             ExtraURL="&CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#">
</FONT>
<!--- format spacing depending on the number of records --->
<cfif prgs.RecordCount gt 10>
<br>
</cfif>
</cfif>

<!--- program groups --->
<cfif ListLen(programGroupList)>
	<cfloop list="#programGroupList#" index="x">
		<br />
		<cf_displayText group="prggrpblurb" code="prggrpblurb_#x#"><br /><br />
		<table border="0">
			<cfset prgnum = 1>
			<cfloop list="#programCodeList#" index="y">
				<cf_cacheProgramPool action="get" code="#y#" var="pobj">
				<cfif pobj.group eq x>
					<cf_displayText group="program" code="program_#y#" var="programName">
					<cf_displayText group="prgcat" code="prgcat_#pobj.cat#" var="programCategoryName">
					<CFOUTPUT>
					<tr>
					<td align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b></FONT></td>
					<td align="left" valign="top"><cfif pobj.legacy eq '103-311-2593-FD-FD'><cf_displayLISPopup hspace="3" vspace="0" align="right"></cfif> <FONT FACE="arial"><b>
					<cfif session.partner_id neq 55>
					<cf_sessionPassVars HREF="frmDetails.cfm" addtoken="true" state_id="#session.st#" extralist="prg_id=#pobj.legacy#,src=elig,sr=#sr#,county=#session.county#,city=#session.city#,zip=#session.zip#">#programName#</cf_sessionPassVars> (#programCategoryName#)
					<cfelse>
					<a href="#application.transfertype#://#application.serverPath#/frmDetails.cfm?CFID=#Session.CFID#&CFTOKEN=#Session.CFTOKEN#&prg_id=#pobj.legacy#&src=elig&sr=#sr#&county=#session.county#&city=#session.city#&zip=#session.zip#">#programName#</a> (#programCategoryName#)
					</cfif>
					</b></FONT></td>
					</tr>
					</CFOUTPUT>
					<cfset prgnum = prgnum + 1>
				</cfif>
			</cfloop>
		</table>
	</cfloop>
</cfif>

</cfif>
<!--- 04.08.2004 BS  Display AssistGuide text if any programs returned --->
<!--- 04.27.2004 BS  Display AssistGuide text if partner not 5 or 6 --->
<cfif session.subsetEFormFlag neq 1><cfoutput>
<br><b>Guide to Application Forms</b><br>
There are <b>fact sheets</b> and <b>application forms</b> available for many of the programs appearing in your results list.  If you would like help printing and filling out application forms for these programs, <a href="frmAccess.cfm?src=comp&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.<br>
</cfoutput></cfif>

<cfif session.subsetDrugFlag eq 0 and session.subsetRecFlag neq 0>
<cfoutput>
<br>
<b>Prescription Benefits Recommendations</b><br>
We have compiled recommendations for you as to how to save money on your prescription medications.   To get your recommendations, <a href="frmRecommend.cfm?adj=1&src=elig&ReportType=All&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.<br>
</cfoutput>
</cfif>

<!--- 09/01/2002 REM  closing cfif from no programs trap --->
</cfif>

<cfif session.evaluation>
<TABLE><TR><TD BGCOLOR="f0f0f0">
<CENTER>
<FONT FACE="arial"><b>Evaluators Please Take Note:</b></center>
Kindly take a moment to give us your overall feedback on this new service.  Follow this link: <A HREF="javascript:feedback('http://bcudev.benefitscheckup.org/overallfeedback_f.cfm')"><b>Your Overall Feedback Form</b></a> to rate the new service, provide comments and suggestions.
</font><BR>
</td></tr></table><BR>
</cfif>
<cfif url.ReportType neq 'all' and session.subset_id neq 22>
<cfif session.partner_id neq 5>

<!--- output generic drug details if client qualifies --->
	<cfif session.subset_id neq 40 AND session.subset_id neq 51 AND session.subset_id neq 54 and session.genericdrugs is "y" and not (NOT ListLen(trim(session.prg_list)) and IsDefined('session.subset_id') AND session.subset_id eq 1)>
	<br /><br />
	<table>
	<CFOUTPUT>
	<TR><TD><FONT FACE="arial" size="3"><b>There are many ways you can save money on prescription drugs.  <A HREF="genericdruginfo.cfm?src=elig&sr=#SR#&cfid=#session.cfid#&cftoken=#session.cftoken#">Click here</a> for additional information on saving money.</b></FONT></TD><TD>
<!--- <A HREF="frmDetails.cfm?prg_id=XXX-311-2387-FD-FD&src=elig&CFID=#session.cfid#&CFTOKEN=#session.cftoken#"> --->
	</TD></TR>
	<CFSET prgnum = prgnum + 1>
	</CFOUTPUT>
	</table>	
	</cfif>
	<cfif session.subset_id neq 35 and session.subset_id neq 40 and session.subset_id neq 44 and session.subset_id neq 49 and session.subset_id neq 51 and session.subset_id neq 55 and session.subset_id neq 54 and session.subset_id neq 56>
	<br>
<cfif session.subset_id neq 3>
	<table>
	<TR><TD><FONT FACE="arial" size="3"><b><a href="javascript:help2('imp_rx_info.cfm')">Click here</A> for important information you should know about prescription medications.</b></FONT></TD><TD>
	</TD></TR>
	</table>
	</cfif>
</cfif>
<!--- output chips details if client answered chips question --->
<!--- 09/01/2002 REM  Removed 'havechips is "yes" or ' from below cfif --->
	<cfif IsDefined('session.wantchips') and session.wantchips is "y">
	<br>
	<table>
	<CFOUTPUT>
	<TR><TD><FONT FACE="arial" size="3"><b>Since you indicated that you know of children without health insurance, you may want to click on the following link to get more information about the State Children's Health Insurance Program. Each state has a program that makes health insurance coverage available, either free or at low cost, to children in working families. <A HREF="frmDetails.cfm?prg_id=103-309-2191-FD-FD&src=elig&CFID=#session.cfid#&CFTOKEN=#session.cftoken#">State Children's Health Insurance Program</A></b></FONT></TD><TD>
	</TD></TR>
	<CFSET prgnum = prgnum + 1>
	</CFOUTPUT>
	</table>	
	</cfif>
</font><br>
</cfif>



<!--- output the bottom paragragh and the links to recap, eval form, and restart --->
<cfif session.buff_list NEQ "" and session.subset_id neq 49>
	<CF_tagShowBufferProgs><br>
</cfif>


<!--cfif session.st eq 'OH' and session.county eq 'CUYAHOGA' >
<b>Other Cuyahoga County Programs</b><br>
<hr>
For a chart of other Cuyahoga County programs, click <a href="CCSSPM.html">here</a>.  (If you have Adobe Acrobat Reader, download this chart as a <a href="images/CCSSPM.pdf">PDF file</a>.)<br><br>
cfif-->

<cf_displayResultsComments>

<cfoutput>
<cfif session.subset_id neq 55 and session.subset_id neq 54 >
<FONT SIZE=+2><b>Answer Recap</b></FONT><br>
<hr>
If you would like to see a short recap of your answers, click <A HREF="javascript:help3 ('frmrecap.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#')">here</A>.<BR>
</cfif>
<br>
<!--- 09/01/2002 REM  Added in a cfif to check for a program list--otherwise, this link is pointless: --->
<cfif (ListLen(session.prg_list) OR ListLen(session.buff_list)) AND session.partner_id neq 5>

<FONT SIZE=+2><b>View and Print Report</b></FONT><br>
<hr>

Print the listing and details of the programs to which you may be potentially eligible to receive. Details include program descriptions, local offices, and required materials.

<br><br>

<form action="frmreportview.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&RequestTimeout=300" method="post" name="ReportForm">
	<input type="submit" value="View and Print Report"></form>
<br>
<cfif session.org_id gt 0>
<form action="frmreportoptions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" name="ReportCustomizeForm">
	<input type="submit" value="Customize and Print Report"></form>
<br>
<cfif session.client_id neq 'null'>
	<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
		<input type="submit" value="Return to Client Detail">
	</form>
<br>
</cfif>
</cfif>
</cfif>
</cfoutput>
</cfif>
<cfif session.org_id eq 0 and session.subset_id neq 55 >
	<cfinclude template="links.cfm">
</cfif>
<cfif session.source_id eq 2 or session.source_id eq 3>
	<cf_displayButton return_oe="true">
	<cfinclude template="links.cfm">
</cfif>

<cfif session.subset_id neq 0 And session.subset_id neq 21 And session.subset_id neq 22 And session.subset_id neq 35 And session.subset_id neq 37 And session.subset_id neq 38 And session.subset_id neq 40 And session.subset_id neq 49 And session.subset_id neq 51 And session.source_id neq 3 And session.partner_id neq 5 And session.partner_id neq 17 And session.subset_id neq 55 And session.subset_id neq 54 And session.subset_id neq 56 And session.subset_id neq 3>
<b>Try a Comprehensive Screening</b><br>
<hr>
The <cf_tagBCU subset_id="#session.subset_id#"> service is only a small portion of what <cf_tagBCU> offers.  Please take a few more minutes to complete a comprehensive benefits screening and learn what other programs you may be eligible to receive.  Click <cfif not isdefined('session.partner_id') or session.partner_id neq 6><cf_sessionPassVars href="startover.cfm" subset_id="0" partner_id="0">here</cf_sessionPassVars><cfelse><a href="<cfoutput>http://#application.consumerurl#</cfoutput>">here</a></cfif>.<BR><BR>
</CFIF>

<cfif session.partner_id eq 5>

<cfoutput>
<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
	<tr>
		<TD colspan="8">&nbsp;</td>
	</tr>
	<TR>
		<TD>&nbsp;</td>
		<TD><A HREF="http://#session.ltccservername#/index.cfm#qltccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_01_welcome.gif" WIDTH="81" HEIGHT="27" ALT="Welcome" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doCalculateCosts#altccQS#"><IMG  border=0 SRC="http://#session.ltccservername#/Graphics/nav_02_risks.gif" WIDTH="125" HEIGHT="27" ALT="Risks and Costs" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doServiceOptions#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_03_services.gif" WIDTH="92" HEIGHT="27" ALT="Services" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doFinanceOptions#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_04_financing.gif" WIDTH="98" HEIGHT="27" ALT="Financing" BORDER="0"></A></TD>
		<TD><A HREF="ltcc.cfm"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_active_07_programs.gif" WIDTH="132" HEIGHT="27" ALT="Public Programs" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doLibrary#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_05_library.gif" WIDTH="83" HEIGHT="27" ALT="Library" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doReport#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_06_report.gif" WIDTH="77" HEIGHT="27" ALT="Your Personal Report" BORDER="0"></A></TD>
	</TR>
</table>
</cfoutput>
<cfelseif session.subset_id neq 55 and session.subset_id neq 54>
<!--- 2005-06-25 BShunn: Removed exit link, per bug #666 --->
<!---
<b>Exit</b><br>
<hr>
If you would like to exit <b><cf_tagBCU></b>, click <A href="<cfoutput>#exitURL#</cfoutput>">here</a>.<BR>
--->
<!--- tag that outputs the disclaimer for if you're not a citizen --->
<CF_TagYeDisclaimer>
</cfif>
</FONT></TD></TR></TABLE>
<!--- call footer tag --->
<cf_tagFooter tag="#tag#">