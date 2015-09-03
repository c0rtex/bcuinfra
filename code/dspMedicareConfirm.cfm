
<cf_tagHeader>
<cfparam name="form.SponsorID" default="">
<!--- Verify single/couple then compute income values for TA level --->
<cfif form.maritalstatus eq 'No'>
	<cfif session.st eq 'AK'>
		<cfset maxIncome = 11950/12 >
	<cfelseif session.st eq 'HI'>
	    <cfset maxIncome = 11010/12 >
	<cfelse>
	    <cfset maxIncome = 9570/12 >
	</cfif>
<cfelse>
	<cfif session.st eq 'AK'>
		<cfset maxIncome = 16030/12 >
	<cfelseif session.st eq 'HI'>
	    <cfset maxIncome = 14760/12 >
	<cfelse>
	    <cfset maxIncome = 12830/12 >
	</cfif>
</cfif>
<cfif session.hh_income_total_complete gt maxIncome>
	<cfset TALevel = "TA2">
<cfelse>
	<cfset TALevel = "TA1">
</cfif>
<cfquery name="GetName" datasource="#application.dbSrc#">
SELECT     CardName
FROM      tbl_rx_prgdetail
where DNumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SponsorID#" maxlength="20">
</cfquery>

<cfoutput>
<form name="MedEnroll" method="post" action="procMedicareEnroll.cfm?#session.URLToken#">
</cfoutput>
<table align="center"  border="0"  width="100%" cellpadding=12 cellspacing=2 >
	<tr>
	<td bgcolor=#FFFFFF colspan=2 >
<table align=center  bgColor=#f0f0f0><tr><td >
<table valign=top align=center cellpadding=8 bgColor=#fFFFFF> 

  <tr>
    <th colspan=3  scope="col"><font size="+1" face="Geneva, Arial, Helvetica, sans-serif">Medicare-Approved Drug Discount Card Enrollment</font></th>
  </tr>
   <tr>
    <td colspan=3  scope="col"><font  face="Geneva, Arial, Helvetica, sans-serif"><em>&nbsp;&nbsp;&nbsp;<strong>Step 2: Confirm Responses</strong></em></font></td>
  
  </tr>
   <tr>
    <td width="27">&nbsp;</td>
    <td width="338"><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Card Name:</font></p></td>
    <td width="150"><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif"><cfoutput>#GetName.CardName#</cfoutput></font></p></td>
   
  </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="338"><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Total Income:</font></p></td>
    <td width="175"><cfoutput>#Dollarformat(session.hh_income_total_complete)#</cfoutput></td>
   
  </tr>
  <tr>
    <td width="27">&nbsp;</td>
    <td width="338"><p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Zip Code:</font></p></td>
    <td width="175"><cfoutput>#session.zip# </cfoutput></td>
    
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td width="338"> <p  align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Are you married? </font></p ></td>
    <td width="175" valign=top><cfoutput>#form.maritalstatus#</cfoutput></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Have you recently been one of the following: widowed, divorced, or separated?</font> </p></td>
    <td width="175" valign=top><cfoutput>#form.recently#</cfoutput></td>
  
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left"><font  face="Geneva, Arial, Helvetica, sans-serif">Does your State help you pay your Medicare Part A or Part B premiums? </font></p ></td>
    <td width="175" valign=top><cfoutput>#form.statepay#</cfoutput></td>
  
  </tr>
    <tr>
    <td><A HREF="javascript:help3('dspEnrollHelp.cfm')"><IMG SRC="images/help.gif" width="46" height="18" BORDER="0" align="texttop" ALT="Help"></A></td>
    <td width="200" align=right><INPUT TYPE="button"  NAME="Submit" onclick="history.back(1)"  VALUE="Change Responses" ></td>
    <td width="238"><INPUT TYPE="submit"  NAME="Submit"  VALUE="Enroll with Medicare.gov" ></td>
  
  </tr>
  
</table>
</td></tr></table>
</TD></TR></TABLE>

<cfoutput>
<input type="hidden" name="TALevel" value="#Trim(TALevel)#">
<input type="hidden" name="SponsorID" value="#Trim(form.SponsorID)#">
<input type="hidden" name="Recently" value="#Trim(form.Recently)#">
<input type="hidden" name="MaritalStatus" value="#Trim(form.MaritalStatus)#">
<input type="hidden" name="Zip" value="#Trim(session.Zip)#">
<input type="hidden" name="StatePay" value="#Trim(form.StatePay)#">
</cfoutput>
</form>

<cf_tagFooter>