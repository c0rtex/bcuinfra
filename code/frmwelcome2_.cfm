<!----=======================================
DESCRIPTION: first page of questions...these are static and are used to set up the personilization
CALLED BY: First.cfm
GOES TO: frmQuestions.cfm
REQUIRED:N/A
============================================---->

<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<cf_handleScreening action="start" basics="true">

<!--- focus: bring window to front on open, if already open --->
<script language="JavaScript1.1">
<!--
window.focus();
// -->
</script>
<!--- end focus --->

<cfset session.strongpath=cgi.SERVER_NAME>

<!--- Call header tag --->

<cfif session.subsetStateFlag eq 1>
	<cfset extraAF = ''>
<cfelse>
	<cfset extraAF = 's-st,y-pri_resident,'>
</cfif>
<cf_buildHTML onLoad="var objrow = document.getElementById('client_other_question'); if (document.formwelcome.client1.options[document.formwelcome.client1.selectedIndex].text == 'Other') {objrow.style.display = ''; documment.formwelcome.aflist.value = 'o-client1-client,s-client_other,g-gender,#extraAF#s-zip';}" show_title="yes" guts="frmwelcome2.cfm">

<cfoutput>
<table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#">
	<tr>
	<td bgcolor="##FFFFFF" colspan="2">
<!--Dynamic Area--><font face="arial" size="4" color="##000000">

<form action="#application.transferType#://#application.serverPath#/frmquestions.cfm" method="post" name="formwelcome" id="formwelcome" onSubmit="return validateWelcome()">
	<input type="hidden" name="cfid" value="#session.cfid#" />
	<input type="hidden" name="cftoken" value="#session.cftoken#" />

<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
			<FONT FACE="arial" size="4"><B>Introduction to Public Programs</B></FONT><BR>

<p class="introSmall">The public program section of the Long-Term Care Counselor (LTCC) will help you to learn about your eligibility for public programs that will help pay for long-term care services based on your financial resources and the programs available in your state. <A HREF="javascript:help2('ltccinfo.cfm','')"><img width="85" height="18" src="http://#session.ltccservername#/Graphics/button_moreinfo.gif" border=0 alt="More Information" align="texttop"></A></p>

<p class="introRed">All responses are totally confidential. Your information is not saved and you are not identified in any way. The questions are based on information experts in this area would need to know in order to advise you.</p>
<cfelseif session.subset_id eq 14>
			<FONT FACE="arial" size="4"><B>INSTRUCTIONS</B><BR>
			The following questions are designed to help you assess your current situation, and to figure out what benefits, rights and options you have, related to the new Medicare Prescription Drug Coverage.  You will receive the most complete analysis and report if you answer all questions.  Click the <font size="2"><u>HELP</u></font> link if you need help answering a question.  Please do not click your browser's "Back" button while completing a screening, as your answers may not be saved.
			</FONT><BR><BR>
<cfelse>
			<FONT FACE="arial" size="4"><B>INSTRUCTIONS</B><BR>
			The following questions are designed to determine your potential eligibility for benefits programs.  You will receive the most complete benefits report if you answer all questions.  Click the <font size="2"><u>HELP</u></font> link if you need help answering a question. Please do not click your browser's "Back" button while completing a screening, as your answers may not be saved.
			<cfif IsDefined('session.partner_id') And session.partner_id eq 6>
				<br><br><a href="javascript:help2('neededinfo-rx.cfm')">Click here</a> to see if you need to gather any information before you begin.<BR>
			</cfif>
			</FONT><BR><BR>
</cfif>

<TABLE ALIGN="center" border="0" cellpadding="2" cellspacing="2" width="100%"></cfoutput>
	<TR>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B><cf_showQuestionNumber>.</B></FONT>
		</TD>
		<TD VALIGN="top">
			<FONT FACE="arial"><cf_displayText code="question_client" group="question"> <cf_displayHelpLink code="client"></FONT>
		</TD>
	</TR>
	<CF_TagYeSetAnswerField answerfield="client" answerTYPE="opt" textlength="" validation="">
	<TR VALIGN="top" id="client_other_question" style="display: none;">
		<TD></TD>
		<TD>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="client_other" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = ''>
			</cfif>
			<FONT FACE="arial">Please specify:&nbsp;&nbsp;
			<cfoutput><INPUT TYPE="text" NAME="client_other" SIZE="15" maxlength="64" value="#HTMLEditFormat(matchVal)#" onBlur="validatetext(this);"></cfoutput></FONT>
		</TD>
	</TR>
	<tr><td>&nbsp;</td></tr>
	<TR>
		<TD></TD>
		<TD VALIGN="top">
			<FONT FACE="arial"><b>Please note:</b>&nbsp; If you're filling out this questionnaire for someone else, please answer all subsequent questions as if they're being asked of that person.</FONT>
		</TD>
	</TR>
	<tr><td></td></tr>
	<TR>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B><cf_showQuestionNumber>.</B></FONT>
		</TD>
		<TD valign="top">
			<FONT FACE="arial"><cf_displayText code="question_gender" group="question"></FONT>
		</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD>
			<FONT FACE="arial">
			<CF_TagYeWhiteSpace>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="gender" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = 0>
			</cfif>
			<INPUT bgcolor="white" TYPE="radio" NAME="gender" VALUE="m"<cfif matchVal eq 2> CHECKED</cfif>>Male
			&nbsp;
			<INPUT TYPE="radio" NAME="gender" VALUE="f"<cfif matchVal eq 3> CHECKED</cfif>>Female</FONT>
		</TD>
	</TR>
	<tr><td></td></tr>
<cfif session.subsetStateFlag neq 1>
	<TR>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B><cf_showQuestionNumber>.</B></FONT>
		</TD>
		<TD valign="top">
			<FONT FACE="arial"><cf_displayText code="question_st" group="question"> <cf_displayHelpLink code="st"></FONT>
		</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD>
			<FONT FACE="arial">
			<CF_TagYeWhiteSpace>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="st" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = session.state_id>
			</cfif>
			<cf_buildStateSelect name="st" required="true" showName="false" default="#matchVal#" style="">
			</FONT>
		</TD>
	</TR>
	<tr><td></td></tr>
	<TR>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B><cf_showQuestionNumber>.</B></FONT>
		</TD>
		<TD valign="top">
			<FONT FACE="arial"><cf_displayText code="question_pri_resident" group="question"> <cf_displayHelpLink code="pri_resident"></FONT>
		</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD>
			<FONT FACE="arial">
			<CF_TagYeWhiteSpace>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="pri_resident" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = -1>
			</cfif>
			<INPUT TYPE="radio" NAME="pri_resident" VALUE="Y"<cfif matchVal Neq 0> CHECKED</cfif>>Yes &nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="pri_resident" VALUE="N"<cfif matchVal Eq 0> CHECKED</cfif>>No
			</FONT>
		</TD>
	</TR>
	<tr><td></td></tr>
</cfif>
	<TR>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B><cf_showQuestionNumber>.</B></FONT>
		</TD>
		<TD valign="top">
			<!--- changed wording of zip code question  01/27/00-JL --->
			<FONT FACE="arial"><cf_displayText code="question_zip" group="question"></b>
		</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD>
			<FONT FACE="arial">
			<CF_TagYeWhiteSpace>
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="zip" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = ''>
			</cfif>
			<script language="javascript">
			<!--
			<cfoutput>var saveThisZip = '#matchVal#';</cfoutput>
			// -->
			</script>
			<cfoutput><INPUT TYPE="text" NAME="zip" SIZE="5" MAXLENGTH="5" value="#matchVal#" onBlur="
			
	<!---alert('Blur ' + saveThisZip + ' : ' + this.value);--->
	if (saveThisZip != this.value) {
		<!---alert('values have changed');--->
		if (!validatezip(this)) {
			<!---alert('zip was found invalid');--->
			saveThisZip = this.value;
			this.focus();
			this.select();
		}
	}
	
"></cfoutput>
			</FONT>
		</TD>
	</TR>
</TABLE>

<br>
<div align="right"><font size="+2"><INPUT TYPE="submit" VALUE="  Next  " NAME="welcome"></font></div>
<br>

<cf_passScreeningInput aflist="o-client1-client,g-gender,#extraAF#s-zip">

</FONT></FORM></TD></TR></TBODY></TABLE>

<!--- Call footer tag --->
</cf_buildHTML>