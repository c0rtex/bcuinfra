<cfparam name="src" type="string" default="">
<cfparam name="url.prg_id" type="string" default="">
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
<cfset application.TAScreeningEnable = "Y">
<cf_tagHeader>

<cfif application.TAScreeningEnable eq 'Y' >
<cfquery datasource="#application.dbSrc#" name="getMedicare"> 
<cfif isdefined('url.prg_id')>
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.prg_id#" maxlength="30">

<cfelse>
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN
                      tbl_user_prgid ON tbl_prg_all.prg_id = tbl_user_prgid.prg_id INNER JOIN
                      tbl_RX_PrgDetail ON tbl_user_prgid.prg_id = tbl_RX_PrgDetail.PRG_ID
WHERE  
(tbl_user_prgid.unseen IS NULL) and (tbl_user_prgid.clientnum = '#clientnum#') AND (tbl_prg_all.Cat_ID = 333)
</cfif> 
</cfquery>
<cfif GetMedicare.recordcount eq 0>
<cfquery datasource="#application.dbSrc#" name="getMedicare"> 
SELECT tbl_prg_all.prg_id, tbl_prg_all.prg_nm, tbl_RX_PrgDetail.DNumber
FROM         tbl_prg_all INNER JOIN tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
where
tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id and
tbl_prg_all.prg_id in ('#session.prg[1]#','#session.prg[2]#','#session.prg[3]#')
</cfquery>
</cfif>
<cfoutput>
<form name="MedEnroll" method="post" action="dspMedicareConfirm.cfm?#session.URLToken#">
</cfoutput>
<table  align="center"  border="0"  width="100%" cellpadding=12 cellspacing=2      >
	<tr>
	<td bgcolor=#FFFFFF colspan=2 >
<table align=center  bgColor=#f0f0f0><tr><td  >
<table valign=top align=center cellpadding=8   bgColor=#fFFFFF > 
  <tr>
    <th colspan=3  scope="col"><font size="+1" face="Geneva, Arial, Helvetica, sans-serif">Medicare-Approved Drug Discount Card Enrollment </font></th>
  </tr>
   <tr>
    <td colspan=3  scope="col"><font  face="Geneva, Arial, Helvetica, sans-serif"><em>&nbsp;&nbsp;&nbsp;<strong>Step 1: Preliminary Questions</strong></em></font></td>
  
  </tr>
   <tr>
    <td width="47">&nbsp;</td>
    <td colspan=2><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">In order to complete enrollment, we will be sending some of your responses to Medicare.gov. Please verify the information you have provided.</font></p></td>
  </tr>
  <tr>
    <td width="47">&nbsp;</td>
    <td colspan=2><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Medicare-Approved Drug Discount Card Program you have selected for enrollment:</font></p></td>
  </tr>
 <tr>
    <td width="5">&nbsp;</td>
    <td colspan=2>
	<cfif isdefined('url.prg_id')>
	<cfoutput query="getMedicare"><input type="hidden" value="#DNumber#"  name="SponsorID" ><font  face="Geneva, Arial, Helvetica, sans-serif">#prg_nm#</font></cfoutput>
	<cfelse>
	<select  name="SponsorID">
	<cfoutput query="getMedicare">
	<option value="#DNumber#" >#prg_nm#</option>
	</cfoutput>
	</select>
	</cfif>
	</td>
   
  </tr>
  
  
  
  
  <tr>
    <td width="47">&nbsp;</td>
    <td width="338"><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Zip Code:</font></p></td>
    <td width="100" align=right><cfoutput>#zip#</cfoutput></td>

  </tr>
  <tr>
    <td >&nbsp;</td>
    <td width="338"> <p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Are you married? </font></p ></td>
    <td width="100" valign=top align=right>
	<select  name="maritalstatus">
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
    <td width="338"><p align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Have you recently been one of the following: widowed, divorced, or separated?</font> </p></td>
    <td width="100" valign=top align=right><select type="select" name="recently"><option value="">-----------</option><option value="Yes">Yes</option><option value="No">No</option></select></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Does your State help you pay your Medicare Part A or Part B premiums? </font></p ></td>
    <td width="100" valign=top align=right><select type="select" name="statepay"><option value="">-----------</option><option value="Yes">Yes</option><option value="No">No</option></select></td>

  </tr>
    <tr>
    <td><A HREF="javascript:help3('dspEnrollHelp.cfm')"><IMG SRC="images/help.gif" width="46" height="18" BORDER="0" align="texttop" ALT="Help"></A></td>
    <td width="338" align=right><INPUT TYPE="button"  NAME="Submit" onclick="history.back(1)"  VALUE="Back to <cfif src eq 'frame'>Application Guide<cfelse>Recommendations</cfif>"></td>
    <td width="100" valign=top align=right><INPUT TYPE="submit"  NAME="Submit" VALUE="Continue" ></td>

  </tr>
 
</table>
</td></tr></table>
</TD></TR></TABLE>
</form>
<cfelse>
<table  bgcolor="#FFFFFF" align="center"  border="0"  width="100%" cellpadding=12 cellspacing=2      >
	<tr>
	<td bgcolor=#FFFFFF colspan=2 >
<table align=center  0><tr><td  >
<table height=200 valign=top align=center cellpadding=8   bgColor=#fFFFFF > 
  <tr>
    <th colspan=3 align=left  scope="col"><font size="+1" face="Geneva, Arial, Helvetica, sans-serif">Online enrollment for the Medicare-Approved Drug Discount Card through BenefitCheckUpRx is not yet available. Please check back soon!</font></th>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338" align=right><INPUT TYPE="button"  NAME="Submit" onclick="history.back(1)"  VALUE="Back to <cfif src eq 'frame'>Application Guide<cfelse>Recommendations</cfif>"></td>
    <td width="100" valign=top align=right></td>

  </tr>
</table>
</td></tr></table>
</TD></TR></TABLE>
</cfif>

<cf_tagFooter>