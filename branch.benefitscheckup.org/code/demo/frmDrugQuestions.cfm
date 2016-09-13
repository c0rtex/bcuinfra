<!----=======================================
DESCRIPTION: these are the two questions that are used for drugs and drug companies.
CALLED BY: procAsset.cfm
GOES TO: procDrugQuestions.cfm
REQUIRED:N/A
============================================---->
<cfsilent>
<cfparam name="ltr" type="string" default="A">
<cfparam name="drg" type="string" default="">
<cfparam name="udrg" type="string" default="">
<cfparam name="clr" type="numeric" default="0">

<cfif not IsDefined('session.selectedDrugs')>
	<cfset session.selectedDrugs=''>
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

<CFQUERY NAME="qryDrugnm" DATASOURCE="#session.datasrc#">
select substring(dl.display_text, 1, 255) as option_nm, a.answerfield as fieldtext
from answerfield a, display_language dl
where a.answerfieldtype_id=14
        and a.display_id=dl.display_id
        and dl.language_id='#session.language_id#'
union
select substring(dl.display_text, 1, 255) as option_nm, q.answerfield as fieldtext
from (
        select a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
        from program_answerfield pa, answerfield a
        where pa.answerfield_id=a.answerfield_id
                and a.answerfieldtype_id=13
        group by a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
     ) q, display_language dl
where q.answerfieldtype_id=13
        and q.display_id=dl.display_id
        and dl.language_id='#session.language_id#'
order by option_nm
</CFQUERY>

<!--- 12/18/2002 BShunn: Code to handle client language, i.e. you, your mother, etc. --->

<cfset notmsg = "Medication not in list">

</cfsilent>
<cfheader name="EXPIRES" value="#now()#">
<cfhtmlhead text="<META HTTP-EQUIV=""Pragma"" CONTENT=""no-cache"">">
<cfhtmlhead text="<META HTTP-EQUIV=""expires"" CONTENT=""Tue, 01 Jan 1980 1:00:00 GMT"">">
<cfhtmlhead text="<meta http-equiv=""cache-control"" content=""no-cache"">">

<script language="JavaScript" src="include/select.js"></script>

<cf_tagHeader> 

<table width="100%" border="0" align="center" cellpadding=6 cellspacing=2>
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
Find each medication you take by searching below.  Click a letter to get a list of all supported medications beginning with that letter, or enter the first few letters of a medication name in the search box and click "Find."  When you have found each medication, click its name to add it to the green "Selected Medications" box below right.  When all your medications appear in the green box, click "Next."<cfif session.access_id neq 1>&nbsp;

<i>(If you would prefer to select your medications from one complete list, <a href="frmDrugList.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a>.)</i></cfif></font><br><br>


<font face="Arial" size="3">

<b><cfloop list="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z" index="letter">
<a href="frmDrugQuestions.cfm?ltr=#letter#&cfid=#session.cfid#&cftoken=#session.cftoken#">#letter#</a>&nbsp;
</cfloop></b><br><br>

<FORM ACTION="procDrugQuestions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formDrug">
<table cellpadding="5" align="right" bgcolor="#boxColor#" width="250">
<tr><td style="font-size: 8pt;"><b>Selected Medications</b><cfif session.selectedDrugs neq ''><br>
 <i>Click medication name to remove from list</i>
<ul>
<cfloop query="qryDrugnm">
	<cfset blech=ListFindNoCase(session.selectedDrugs, fieldtext)>
	<cfif blech>
		<cfif fieldtext eq drg>
		<li><b><a href="frmDrugQuestions.cfm?ltr=#ltr#&udrg=#fieldtext#&cfid=#session.cfid#&cftoken=#session.cftoken#">#option_nm#</a></b>
		<cfelse>
		<li><a href="frmDrugQuestions.cfm?ltr=#ltr#&udrg=#fieldtext#&cfid=#session.cfid#&cftoken=#session.cftoken#">#option_nm#</a>
		</cfif>
	</cfif>
</cfloop>
</ul>
<cfelse><br><br>
<i>Click a drug name to add it to this list.<br><br>
</cfif>
<input type="hidden" name="selectedDrugNm" value="#session.selectedDrugs#">
<div align="right"><input type="submit" value="  Next  "></div></td></tr>
</table></form>

<form method="post" action="frmDrugQuestions.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<input type="text" name="ltr" value="<cfif Len(ltr) gt 1>#ltr#</cfif>" size="20">
	<input type="submit" value="Find">
</form>

<ul><cfloop query="qryDrugnm">
	<cfif FindNoCase(ltr, option_nm) eq 1>
		<li><a href="frmDrugQuestions.cfm?ltr=#ltr#&drg=#fieldtext#&cfid=#session.cfid#&cftoken=#session.cftoken#">#option_nm#</a>
	</cfif>
</cfloop></ul>

<FORM ACTION="procDrugQuestions.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formDrugNext">
<input type="button" name="popup" value="#notmsg#" onClick="javascript:help2('RxNotListed.cfm')"><br><br>
<input type="hidden" name="selectedDrugNm" value="#session.selectedDrugs#">
<div align="right"><input type="submit" value="  Next  "></div></td></tr>
<cf_passScreeningInput aflist="d-selecteddrugnm" pagecode="drugs">
</form>

</td></tr></table>

</cfoutput>

</font></td></tr>	
</table>
</form>

</TD></TR>
</TABLE>


<cf_tagFooter>
