<cfif isdefined('session.clientnum')>
<cfset clientnum = session.clientnum>
<cfelse>
<cfset clientnum = "">
</cfif>
<cfif isdefined('session.zip')>
<cfset zip = session.zip>
<cfelse>
<cfset zip = "">
</cfif>
<cfif isdefined('session.marital_stat')>
<cfset maritalstatus = session.marital_stat>
<cfelse>
<cfset maritalstatus = "">
</cfif>
<cf_tagHeader>

<cfquery datasource="#application.dbSrc#" name="getMedicare"> 
<cfif isdefined('url.prg_id')>
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id = '#url.prg_id#'

<cfelse>
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN
                      tbl_user_prgid ON tbl_prg_all.prg_id = tbl_user_prgid.prg_id INNER JOIN
                      tbl_RX_PrgDetail ON tbl_user_prgid.prg_id = tbl_RX_PrgDetail.PRG_ID
WHERE  
(tbl_user_prgid.unseen IS NULL) and (tbl_user_prgid.clientnum = '#clientnum#') AND (tbl_prg_all.Cat_ID = 333)
</cfif> 
</cfquery>

<form name="MedEnroll" method="post" action="dspMedicareConfirm.cfm">

<table  align="center"  border="0"  width="100%" cellpadding=12 cellspacing=2      >
	<tr>
	<td bgcolor=#FFFFFF colspan=2 >
<table align=center  bgColor=#f0f0f0><tr><td  >
<table valign=top align=center cellpadding=8   bgColor=#fFFFFF > 
  <tr>
    <th colspan=3  scope="col">Medicare-Approved Drug Discount Card Enrollment </th>
  </tr>
   <tr>
    <td colspan=3  scope="col"><em>&nbsp;&nbsp;&nbsp;<strong>Step 1: Preliminary Quetions</strong></em></td>
  
  </tr>
   <tr>
    <td width="47">&nbsp;</td>
    <td colspan=2><p  align="left">In order to complete enrollment, we will be sending some of your responses to Medicare.gov. Please verify the information you have provided.</p></td>
  </tr>
  <tr>
    <td width="47">&nbsp;</td>
    <td colspan=2><p  align="left">Medicare-Approved Drug Discount Card Program you have selected for enrollment:</p></td>
  </tr>
 <tr>
    <td width="5">&nbsp;</td>
    <td colspan=2>
	<cfif isdefined('url.prg_id')>
	<cfoutput query="getMedicare"><input type="hidden" value="#DNumber#"  name="SponsorID" >#prg_nm#</cfoutput>
	<cfelse>
	<select type="select" name="SponsorID">
	<cfoutput query="getMedicare">
	<option value="#DNumber#" >#prg_nm#</option>
	</cfoutput>
	</select>
	</cfif>
	</td>
   
  </tr>
  
  
  
  
  <tr>
    <td width="47">&nbsp;</td>
    <td width="338"><p  align="left">Zip Code:</p></td>
    <td width="100" align=right><cfoutput><input type="text" value="#zip#"  name="zip" size="8" maxlength="5"></cfoutput></td>

  </tr>
  <tr>
    <td >&nbsp;</td>
    <td width="338"> <p  align="left">Are you married? </p ></td>
    <td width="100" valign=top align=right>
	<select  type="select" name="maritalstatus">
	<cfif maritalstatus eq 'Married'>
	<option value="">-----------</option>
	<option  selected value="Y">Yes</option>
	<option value="No">No</option>
	<cfelseif maritalstatus neq ''>
	<option value="">-----------</option>
	<option  value="Yes">Yes</option>
	<option selected value="No">No</option>
	<cfelse>
	<option value="">-----------</option>
	<option value="Yes">Yes</option>
	<option  value="No">No</option>
	</cfif>
	</select>
		
	</td>

  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left">Have you recently been one of the following: widowed, divorced, or separated? </p></td>
    <td width="100" valign=top align=right><select type="select" name="recently"><option value="">-----------</option><option value="Yes">Yes</option><option value="No">No</option></select></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left">Does your State help you pay your Medicare Part A or Part B premiums? </p ></td>
    <td width="100" valign=top align=right><select type="select" name="statepay"><option value="">-----------</option><option value="Yes">Yes</option><option value="No">No</option></select></td>

  </tr>
    <tr>
    <td>&nbsp;</td>
    <td width="338" align=right><INPUT TYPE="button"  NAME="Submit" onclick="history.back(1)"  VALUE="Back to Recommendations" ></td>
    <td width="100" valign=top align=right><INPUT TYPE="submit"  NAME="Submit" VALUE="Continue" ></td>

  </tr>
  
</table>
</td></tr></table>
</TD></TR></TABLE>


</form>

<cf_tagFooter>