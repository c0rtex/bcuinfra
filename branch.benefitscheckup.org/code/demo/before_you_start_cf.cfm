
<cfparam name="preserve" type="boolean" default="false">
<cfset hasRadio = false>
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<!--- Call header tag --->
<cf_tagHeader>
<cfif session.subset_id eq 1>
	<cfset neededURL = "neededinfo-rx.cfm">
<cfelseif session.subset_id eq 12>
	<cfset neededURL = "neededinfo-card.cfm">
<cfelseif session.subset_id eq 14>
	<cfset neededURL = "neededinfo-lis.cfm">
<cfelseif session.subset_id eq 18 or session.subset_id eq 22 Or (Not Preserve And session.subset_id eq 19)>
	<cfset neededURL = "neededinfo-aoa.cfm">
<cfelseif session.subset_id eq 21>
	<cfset neededURL = "neededinfo-il.cfm">
<cfelseif session.subset_id eq 27>
	<cfset neededURL = "neededinfo-aarp.cfm">
<cfelseif session.subset_id eq 34>
	<cfset neededURL = "neededinfo-wom.cfm">
<cfelseif session.subset_id eq 35>
	<cfset neededURL = "neededinfo-35.cfm">
<cfelseif session.subset_id eq 36>
	<cfset neededURL = "neededinfo-36.cfm">
<cfelseif session.subset_id eq 37>
	<cfset neededURL = "neededinfo-37.cfm">
<cfelseif session.subset_id eq 38>
	<cfset neededURL = "neededinfo-38.cfm">
<cfelseif session.subset_id eq 39>
	<cfset neededURL = "neededinfo-39.cfm">
<cfelseif session.subset_id eq 44>
	<cfset neededURL = "neededinfo-44.cfm">
<cfelseif session.subset_id eq 49>
	<cfset neededURL = "neededinfo-49.cfm">
<cfelse>
	<cfset neededURL = "neededinfo.cfm">
</cfif>
<cfif session.partner_id eq 14 or session.partner_id eq 15>
	<cfset imgExt = '-mmm'>
<cfelse>
	<cfset imgExt = ''>
</cfif>

<!--- Open Main Table --->
<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
        <TR>
          <TD bgColor="#ffffff" colSpan="2" align="center"><TABLE width=700 cellpadding="0" cellspacing="0" border="0">

	<tr>
		<td rowspan="2"><IMG SRC="images/pixel.gif" width="8" height="1" border="0" alt=""></td>
		<td valign="top">

<cfoutput></cfoutput>
</TD>
<td><IMG SRC="images/pixel.gif" width="8" height="0" border="0" alt=""></td>
<TD VALIGN="top"><cf_headerILTabs partner_id="#session.partner_id#"><IMG SRC="images/pixel.gif" width="1" height="8" border="0" alt=""><br><FONT FACE="arial"><b>
<cfif session.subsetText neq ''>
	<cfif Not Preserve And session.subset_id eq 19>
		BenefitsCheckUpRx helps people with Medicare and other older adults to learn about and enroll in government benefits, including the new Medicare Prescription Drug Coverage and other valuable federal, state and private programs that can save you money on health care and prescription drugs.
	<cfelse>
		<cf_CountProgramsRounded var="varCountProgramsRounded">
		<cf_CountProgramsRounded var="varCountProgramsRoundedPAP" subset="pap">
		<cf_CountDrugsRounded var="varCountDrugsRounded">
		<cfset session.subsetText = Replace(session.subsetText, '##varCountProgramsRounded##', varCountProgramsRounded, 'ALL')>
		<cfset session.subsetText = Replace(session.subsetText, '##varCountProgramsRoundedPAP##', varCountProgramsRoundedPAP, 'ALL')>
		<cfset session.subsetText = Replace(session.subsetText, '##varCountDrugsRounded##', varCountDrugsRounded, 'ALL')>
		<cfoutput>#session.subsetText#</cfoutput>
	</cfif>
<cfelse>
<FONT FACE="arial" SIZE="3"><cf_tagBCU></font> <FONT FACE="arial">quickly gives you a personal report of public programs and benefits that you may qualify for.  Click below to give us some basic information and we will check over <cf_countProgramsRounded> programs for you, including those covering more than <cf_countDrugsRounded> prescription medications.
</cfif>
	</b></font></td>
	<td rowspan="2"><IMG SRC="images/pixel.gif" width="8" height="1" border="0" alt=""></td>
</tr>
<tr>
	<td colspan="3">
<cfset blocklist=''>
<cfif (session.partner_id eq 7 Or session.partner_id eq 8 Or session.partner_id eq 12 Or (session.partner_id eq 13 and session.subset_id gt 0) Or session.partner_id eq 14 Or session.partner_id eq 15 Or session.partner_id eq 22) And Not preserve>
	<cfset blocklist='subset_id'>
</cfif>
<cf_sessionPassVars action="#session.transfertype#://#session.servername#/frmwelcome2.cfm" method="post" name="formwelcome" blocklist="#blocklist#">

<FONT FACE="arial" SIZE="3">
<cfif Not (IsDefined('session.subset_id') And (session.subset_id eq 1 or session.subset_id eq 12))>
<IMG SRC="images/pixel.gif" width="1" height="15" border="0" alt=""><br>
Here's how it works:
</cfif>
<OL>
<cfif IsDefined('session.subset_id') And (session.subset_id eq 1 or session.subset_id eq 12)>
<li><a href="javascript:help2('whomithelps.cfm')">Click here</a> to learn who is likely to receive the most help from this service.<BR>
<IMG SRC="images/pixel.gif" width="1" height="10" border="0" alt=""><BR>
</cfif>
<cfif blocklist eq 'subset_id'>
<li>Choose one of the following:<br>
<IMG SRC="images/pixel.gif" width="1" height="5" border="0" alt=""><br>
<cfif session.partner_id eq 7 and session.subset_id neq 19 and false>
	<cfset hasRadio = true>
<input type="radio" name="subset_id" value="18"<cfif session.subset_id Neq 12> checked</cfif>> <b>All Rx Assistance Programs</b>
&nbsp;
<input type="radio" name="subset_id" value="12"<cfif session.subset_id Eq 12> checked</cfif>> <b>Medicare Card Finder</b><br>
<cfelse>
	<cfset hasRadio = true>
	<table>
			<tr>
				<td><IMG SRC="images/pixel.gif" width="1" height="3" border="0" alt=""></td>
			</tr>
			<cfif session.subset_id eq 21>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="21" checked></td>
				<td>&nbsp;</td>
				<td valign="top">Find out which Federal, State, Local and Private Programs you may be eligible for</td>
			</tr>
				<cfif session.partner_id eq 13>
				<tr>
					<td><IMG SRC="images/pixel.gif" width="1" height="3" border="0" alt=""></td>
				</tr>
				<tr>
					<td valign="top"><input type="radio" name="subset_id" value="39"></td>
					<td>&nbsp;</td>
					<td valign="top">Find out which Prescription Drug and Health Care Programs (including
Medicare Rx) you may be eligible for</td>
				</tr>
				<tr>
					<td><IMG SRC="images/pixel.gif" width="1" height="3" border="0" alt=""></td>
				</tr>
				<tr>
					<td valign="top"><input type="radio" name="subset_id" value="27"></td>
					<td>&nbsp;</td>
					<td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
				</tr>
				</cfif>
			<cfelseif session.subset_id eq 27>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="27" checked></td>
				<td>&nbsp;</td>
				<td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
			</tr>
			<cfelseif session.subset_id eq 49>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="49" checked></td>
				<td>&nbsp;</td>
				<td valign="top">Find key federal and state public benefits</td>
			</tr>
			<tr>
				<td><IMG SRC="images/pixel.gif" width="1" height="3" border="0" alt=""></td>
			</tr>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="19"></td>
				<td>&nbsp;</td>
				<td valign="top">Find free prescription drugs from private company programs</td>
			</tr>
			<cfelse>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="39"<cfif session.subset_id neq 41> checked</cfif>></td>
				<td>&nbsp;</td>
				<td valign="top">Find out which Prescription Drug and Health Care Programs (including
Medicare Rx) you may be eligible for</td>
			</tr>
				<cfif session.subset_id eq 39 and (session.partner_id eq 7 or (session.partner_id eq 12 and session.source_id eq 5))>
				<tr>
					<td><IMG SRC="images/pixel.gif" width="1" height="3" border="0" alt=""></td>
				</tr>
				<tr>
					<td valign="top"><input type="radio" name="subset_id" value="27"></td>
					<td>&nbsp;</td>
					<td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
				</tr>
				</cfif>
			</cfif>
			<tr>
				<td><IMG SRC="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td valign="top"><input type="radio" name="subset_id" value="41"<cfif session.subset_id eq 41> checked</cfif>></td>
				<td>&nbsp;</td>
				<td valign="top"><cfif session.subset_id neq 49><font size="-1" color="red"><sup><b>NEW!</b></sup></font> </cfif><b>Apply Now</b> for Medicare Rx Extra Help</td>
			</tr>
	</table>
</cfif>
<IMG SRC="images/pixel.gif" width="1" height="10" border="0" alt=""><br>
</cfif>
<LI><b><INPUT TYPE="submit" VALUE="Click Here" NAME="welcome" class="b1"></b> &nbsp;<FONT SIZE=+1>to start<cfif session.partner_id eq 7 and session.subset_id neq 14>, get your results, and get help enrolling<cfelseif session.subset_id eq 14>, learn about your current coverage, and get our recommendations for what you should do next</cfif>.</font><BR>
<IMG SRC="images/pixel.gif" width="1" height="10" border="0" alt=""><BR>

<cfif session.subset_id eq 22 or session.subset_id eq 18 Or (Not Preserve And session.subset_id eq 19)>

<li>Print out your personalized report that lists programs you may qualify for, telephone numbers, and directions on how to sign up for these programs.<br>

<cfelseif session.subset_id eq 19>

<li>Print out your personalized report that includes a list of the Patient Assistance Programs  you may qualify for as well as application forms and instructions about how to sign up for them.<br>

<cfelseif session.partner_id neq 7 or session.subset_id neq 39>

<cfif session.partner_id neq 7 and session.partner_id neq 22>
<IMG SRC="images/pixel.gif" width="1" height="10" border="0" alt=""><BR>
<LI>Print out your personalized report that lists programs you may qualify for, telephone numbers, and directions on how to sign up for these programs.
</cfif>

</cfif>
</B>
</ol>

<cfif session.subset_id neq 19 Or (Not Preserve And session.subset_id eq 19)><p><cfif session.subset_id eq 14 or session.subset_id eq 18 or session.subset_id eq 19 or session.subset_id eq 22 or session.subset_id eq 27 or session.subset_id eq 34 or session.subset_id eq 35 or session.subset_id eq 39 or session.subset_id eq 49>
<a href="javascript:help2('<cfoutput>#session.transfertype#://#session.servername#/whatithelps.cfm?id=#session.subset_id#</cfoutput>')">Click here</a> to learn which benefits are included in this screening and enrollment service.<br>
</cfif>
<cfif session.subset_id eq 36>
See if you need to gather information <a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">before you begin</a>.
<cfelse>
<a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">Click here</a> to see if you need to gather any information before you begin.
</cfif></p></cfif>

<cfif false>
<cfif session.subset_id eq 14 Or (Not Preserve And session.subset_id eq 19)>
	<cfif hasRadio>
<p><b>Note:</b>&nbsp; <input type="button" name="qjump" value="Click Here" onClick="this.form.subset_id[0].value = '34'; this.form.subset_id[0].checked = true; this.form.submit();" class="b1"> &nbsp;if you're looking for prescription drug assistance for a person who does NOT have Medicare.</p>
	<cfelse>
<p><b>Note:</b>&nbsp; <input type="button" name="qjump" value="Click Here" onClick="this.form.subset_id.value = '34'; this.form.submit();" class="b1"> &nbsp;if you're looking for prescription drug assistance for a person who does NOT have Medicare.</p>
	</cfif>
</cfif>
</cfif>


<cfif session.partner_id neq 7>
	<!---
<cfif session.subset_id eq 18 or session.subset_id eq 22 Or session.subset_id eq 39 Or (Not Preserve And session.subset_id eq 19)><font face="arial" size="3"><cf_tagBCU>Rx</font><cfelseif session.subset_id eq 19>This service<cfelseif session.subset_id eq 14><font face="arial" size="3"><cf_tagBCU> for People with Medicare</font><cfelse><font face="arial" size="3"><cf_tagBCU></font></cfif> <FONT FACE="arial">is completely confidential.  It does not require your name, address, phone number, or Social Security number.  For more information<cfif session.subset_id eq 27 or session.subset_id eq 36>, see our <a href="javascript:help2('privacy.cfm?keyword=residence&type=Definition')">privacy policy</A><cfelse> on our privacy policy, <a href="javascript:help2('privacy.cfm?keyword=residence&type=Definition')">click here</A></cfif>.</B></FONT>
	--->

<cfif session.subset_id neq 14 and session.subset_id neq 18 and session.subset_id neq 19 and session.subset_id neq 21 and session.subset_id neq 22 and session.subset_id neq 27 and session.subset_id neq 34 and session.subset_id neq 35 and session.subset_id neq 39 and session.subset_id neq 49 and session.partner_id neq 17>
<p><font face="arial" size="3"><cf_tagBCU></font> <FONT FACE="arial">is designed to help <i>you</i>.  <cfif session.subset_id eq 27 or session.subset_id eq 36>Find out how you can help <a href="http://www.ncoa.org/content.cfm?sectionID=57" target="_blank">NCOA</a><cfelse>For information about how you can help NCOA, <a href="http://www.ncoa.org/content.cfm?sectionID=57" target="_blank">click here</a></cfif>.</FONT></p>
</cfif>
</cfif>

<cfif session.subset_id neq 14 and session.subset_id neq 27 and session.subset_id neq 34 and session.subset_id neq 35 and session.subset_id neq 36 and session.subset_id neq 37 and session.subset_id neq 38 and session.subset_id neq 49 and session.partner_id neq 17 and (session.subset_id neq 39 or session.partner_id neq 12)><cfif IsDefined('session.partner_id') And session.partner_id eq 7>Note: If you represent an organization that is using this service to help your clients, <a href="javascript:var oe=open('http://www.accesstobenefits.org/Helpful%20Resources/OrganizationalEdition/default.aspx', 'OE', 'width=575,height=450,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no')">click here</a> to learn about the special ABC Organizational Edition.<cfelse><a href="javascript:var oe=open('http://www.ncoa.org/content.cfm?sectionID=23', 'OE', 'width=575,height=450,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no')">Click here</a> if you represent an organization with an interest in serving your community with BenefitsCheckUp.  The BenefitsCheckUp Organizational Edition has been tailored to fit your needs.</cfif><br>
<cfelseif session.partner_id eq 7 and session.subset_id eq 39>
<p>Note: If you represent an organization that is using this service to help your clients, <a href="javascript:var oe=open('http://www.accesstobenefits.org/Helpful%20Resources/OrganizationalEdition/default.aspx', 'OE', 'width=575,height=450,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no')">click here</a> to learn about the special ABC Organizational Edition.</p>
</cfif>

<cfif session.partner_id eq 17><cfoutput>
<p align="center">Organizational Edition users, <a href="#session.transfertype#://#session.servername#/kaiseroe/">click here</a>.</p>
</cfoutput></cfif>

<cfif session.partner_id eq 12>
<p><font face="arial">This website is sponsored by the United States Department of Health and Human Services and The Administration on Aging and maintained by the National Council on Aging.  If you have questions about this website, please send e-mail to <a href="mailto:contact@benefitscheckup.org">contact@benefitscheckup.org</a>.  The people in the photos on this website are models and used for illustrative purposes only.</font></p>
</cfif>

</FONT>
</cf_sessionPassVars>

</td></tr></table>
		  
</TD></TR></TABLE>
<!--- close Main Table --->
<cfif partnerQuery.wrapper_template IS 'bcu.cfm'>
<cfelse>
<cf_tagFooter>
</cfif>