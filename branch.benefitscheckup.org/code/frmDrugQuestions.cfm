<!----=======================================
DESCRIPTION: these are the two questions that are used for drugs and drug companies.
CALLED BY: procAsset.cfm
GOES TO: procDrugQuestions.cfm
REQUIRED:N/A
============================================---->
<cfsilent>
<cfset defaultSearchString = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz">
<cfparam name="ltr" type="string" default="#defaultSearchString#">
<cfparam name="drg" type="string" default="">
<cfparam name="udrg" type="string" default="">
<cfparam name="clr" type="numeric" default="0">
<cfparam name="sym" type="numeric" default="0">
<!---<cfparam name="session.selectedDrugs" default="">--->

<cfif ltr eq defaultSearchString or sym eq 1>
	<cfset ltr = 'a'>
	<cfset includeSymbols = true>
	<cfset sym = '&sym=1'>
<cfelse>
	<cfset includeSymbols = false>
	<cfset sym = ''>
</cfif>

<cfif session.screening.prepopulate and not session.screening.dview>
	<cfset session.screening.dview = 1>
	<!---<cfset session.selectedDrugs = ''>--->
	<cf_loopRxStruct grouplist="rx,generic" object="rxobj">
		<cfif StructKeyExists(session.screening.a, rxobj.code)>
			<cf_handleScreeningAnswerfield action="get" code="#rxobj.code#" element="pre" var="matchVal">
			<cfif matchVal neq ''>
				<cfset session.selectedDrugs = ListAppend(session.selectedDrugs, rxobj.code)>
			</cfif>
		</cfif>
	</cf_loopRxStruct>
</cfif>

<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
	<cfset boxColor = "##cccc99">
<cfelseif IsDefined('session.partner_id') And session.partner_id eq 89>
	<cfset boxColor = "##b2d8e5">
<cfelseif IsDefined('session.partner_id') And session.partner_id eq 90>
	<cfset boxColor = "##b2d8e5">
<cfelse>
	<cfset boxColor = "##d4dfdb">
</cfif>

<cfif drg neq '' and ListFindNoCase(session.selectedDrugs, drg) eq 0>
	<cfset session.selectedDrugs = ListAppend(session.selectedDrugs, drg)>
<cfelseif udrg neq '' and ListFindNoCase(session.selectedDrugs, udrg)>
	<cfset session.selectedDrugs = ListDeleteAt(session.selectedDrugs, ListFindNoCase(session.selectedDrugs, udrg))>
</cfif>

</cfsilent>
<cf_buildHTML expires="true" jsInclude="true">

<table width="100%" border="0" align="center" cellpadding="6" cellspacing="2">
	<tr>
	<td bgcolor=#FFFFFF>
<!--- Dynamic Area --->

<cfoutput>
<br>
<table border="0" align="center" width="95%"><!--- outer --->
<tr>
<td>
<font face="Arial" size="3"><b>Your Medications</b></font><br><br>

<table align="center" width="100%" border="0">
<tr>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B>
<cf_showQuestionNumber increment="false">.</b></td><TD VALIGN="top">
	 <FONT face="Arial" size="3">
Find each medication you take by searching below.  Click a letter to get a list of all supported medications beginning with that letter, or enter the first few letters of a medication name in the search box and click "Find."  When you have found each medication, click its name to add it to the shaded "Selected Medications" box below right.  When all your medications appear in the shaded box, click "Next."<cfif session.access_id neq 1>&nbsp;

<i>(If you would prefer to select your medications from one complete list, <a href="frmDrugList.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.)</i></cfif></font><br><br>


<font face="Arial" size="3">

<b><cfloop list="##,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z" index="letter">
<a href="frmDrugQuestions.cfm?ltr=#URLEncodedFormat(letter)#">#UCase(letter)#</a>&nbsp;
</cfloop></b><br><br>

<form action="procDrugQuestions.cfm" method="post" name="formDrug">
	<input type="hidden" name="cfid" value="#session.cfid#" />
	<input type="hidden" name="cftoken" value="#session.cftoken#" />
	
<table cellpadding="5" align="right" bgcolor="#boxColor#" width="250" border="0">
<tr><td style="font-size: 8pt;"><b>Selected Medications</b><cfif session.selectedDrugs neq ''><br>
<i>Click medication name to remove from list</i>
<ul id="medication_list" style="clear:both;">
<cf_loopRxStruct grouplist="rx,generic" object="rx">
	<cfif ListFindNoCase(session.selectedDrugs, rx.code)>
		<li><cfif rx.code eq drg><b></cfif><a href="frmDrugQuestions.cfm?ltr=#URLEncodedFormat(ltr)#&udrg=#rx.code##sym#">#rx.text#</a><cfif rx.code eq drg></b></cfif>
	</cfif>
</cf_loopRxStruct>
</ul>
<cfelse><br><br>
<i>Click a drug name to add it to this list.<br><br>
</cfif>
<input type="hidden" name="selectedDrugNm" value="#session.selectedDrugs#">
<cf_passScreeningInput aflist="d-selecteddrugnm" pagecode="drugs">
<div align="right"><input type="submit" value="  Next  "></div></td></tr>
</table></form>

<form method="post" action="frmDrugQuestions.cfm">
	<input type="hidden" name="cfid" value="#session.cfid#" />
	<input type="hidden" name="cftoken" value="#session.cftoken#" />
	<input type="text" name="ltr" value="<cfif Len(ltr) gt 1 or (Len(ltr) eq 1 and ltr neq '##' and (ltr lt 'a' or ltr gt 'z'))>#ltr#</cfif>" size="20">
	<input type="submit" value="Find">
</form>

<ul id="unselected_medication_list">
<cfset rxCount = 0>
<cfif ltr neq ''>
	<cfif includeSymbols>
		<cf_loopRxStruct grouplist="rx,generic" letter="##" object="rx">
			<cfset rxCount = rxCount + 1>
			<li><a href="frmDrugQuestions.cfm?ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#">#rx.text#</a></li>
		</cf_loopRxStruct>
	</cfif>
	<cf_loopRxStruct grouplist="rx,generic" letter="#ltr#" object="rx">
		<cfset rxCount = rxCount + 1>
		<li><a href="frmDrugQuestions.cfm?ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#">#rx.text#</a></li>
	</cf_loopRxStruct>
</cfif>
<cfif not rxCount><li style="font-size: 10pt; font-style: italic;">no result</li></cfif>
</ul>

<cfif rxCount gt 15>
<form action="procDrugQuestions.cfm" METHOD="post" NAME="formDrugNext">
	<input type="hidden" name="cfid" value="#session.cfid#" />
	<input type="hidden" name="cftoken" value="#session.cftoken#" />
	<input type="button" name="popup" value="Medication not in list?" onClick="javascript:help2('RxNotListed.cfm')"><br><br>
	<input type="hidden" name="selectedDrugNm" value="#session.selectedDrugs#">
	<div align="right"><input type="submit" value="  Next  "></div></td></tr>
	<cf_passScreeningInput aflist="d-selecteddrugnm" pagecode="drugs">
</form>
<cfelse>
<form NAME="formDrugNext">
	<input type="button" name="popup" value="Medication not in list?" onClick="javascript:help2('RxNotListed.cfm')"><br><br>
	</td></tr>
</form>
</cfif>

</td></tr></table>

</cfoutput>

</font></td></tr>	
</table>
</form>

</TD></TR>
</TABLE>


</cf_buildHTML>