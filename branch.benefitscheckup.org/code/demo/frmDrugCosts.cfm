<!----=======================================
DESCRIPTION: these are the two questions that are used for drugs and drug companies.
CALLED BY: procAsset.cfm
GOES TO: procDrugQuestions.cfm
REQUIRED:N/A
============================================---->
<cfparam name="shownumber" type="numeric" default="1">
<cfset session.shownumber = #shownumber#>
<cfsilent>

<CFQUERY NAME="qryDrugnm" DATASOURCE="#session.datasrc#">
select substring(dl.display_text, 1, 255) as option_nm, a.answerfield as fieldtext,
        0 sort_id, lower(substring(dl.display_text, 1, 255)) as low
from answerfield a, display_language dl
where a.answerfieldtype_id=14
        and a.display_id=dl.display_id
        and dl.language_id='EN'
union
select substring(dl.display_text, 1, 255) as option_nm, q.answerfield as fieldtext,
        0 sort_id, lower(substring(dl.display_text, 1, 255)) as low
from (
        select a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
        from program_answerfield pa, answerfield a
        where pa.answerfield_id=a.answerfield_id
                and a.answerfieldtype_id=13
        group by a.answerfield_id, a.answerfieldtype_id, a.answerfield, a.display_id
     ) q, display_language dl
where q.answerfieldtype_id=13
        and q.display_id=dl.display_id
        and dl.language_id='EN'
order by option_nm
</CFQUERY>	

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

<font face="Arial" size="3"><b>Your <cfif session.strClient neq 'Self'>#session.strClient#'s </cfif>Medication Costs</b><br><br>

<table align="center" width="100%" border="0">
<tr>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B>
#session.ShowNumber#.</b></td><TD VALIGN="top">
	 <FONT face="Arial" size="3">
	 
Please enter the <b>monthly</b> cost for each of the medications you<cfif session.strClient eq 'Self'> take<cfelse>r #session.strClient# takes</cfif>.

<FORM ACTION="procDrugCosts.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formDrug">

<table>

	<tr>
	<td valign="top"><b>Medication</b></td>
	<td>&nbsp;&nbsp;</td>
	<td align="right" valign="top" colspan="2"><b>Monthly Cost&nbsp;</b></td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>

<cfloop query="qryDrugnm">
	<cfset blech=ListFindNoCase(session.selectedDrugs, fieldtext)>
	<cfif blech>
		<tr>
		<td align="top">#option_nm#</td>
		<td>&nbsp;&nbsp;</td>
		<td align="top">$&nbsp;</td>
		<td align="top"><input type="text" name="rxcost_#fieldtext#" value="" size="8"></td>
		</tr>
	</cfif>
</cfloop>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
</table>

<input type="hidden" name="shownumber" value="#Evaluate("session.shownumber + 1")#">
<input type="submit" value="Next"></form>

</td></tr></table>

</cfoutput>

</font></td></tr>	
</table>
</form>

</TD></TR>
</TABLE>


<cf_tagFooter>
