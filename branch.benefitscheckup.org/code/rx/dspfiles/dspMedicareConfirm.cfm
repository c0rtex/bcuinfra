
<cf_tagHeader>
<!--- Verify single/couple then compute income values for TA level --->
<cfif form.maritalstatus eq 'No'>
	<cfif session.st eq 'AK'>
		<cfset maxIncome = 11630/12 >
	<cfelseif session.st eq 'HI'>
	    <cfset maxIncome = 10700/12 >
	<cfelse>
	    <cfset maxIncome = 8980/12 >
	</cfif>
<cfelse>
	<cfif session.st eq 'AK'>
		<cfset maxIncome = 15610/12 >
	<cfelseif session.st eq 'HI'>
	    <cfset maxIncome = 14360/12 >
	<cfelse>
	    <cfset maxIncome = 12120/12 >
	</cfif>
</cfif>
<cfif session.hh_income_total_complete gt maxIncome>
	<cfset TALevel = "TA2">
<cfelse>
	<cfset TALevel = "TA1">
</cfif>


<form name="MedEnroll" method="post" action="procMedicareEnroll.cfm">
<table align="center"  border="0"  width="100%" cellpadding=12 cellspacing=2 >
	<tr>
	<td bgcolor=#FFFFFF colspan=2 >
<table align=center  bgColor=#f0f0f0><tr><td >
<table valign=top align=center cellpadding=8 bgColor=#fFFFFF> 

  <tr>
    <th colspan=3  scope="col">Medicare-Approved Drug Discount Card Enrollment</th>
  </tr>
   <tr>
    <td colspan=3  scope="col"><em>&nbsp;&nbsp;&nbsp;<strong>Step 2: Confirm Responses</strong></em></td>
  
  </tr>
   <tr>
    <td width="47">&nbsp;</td>
    <td width="338"><p  align="left">Card Sponsor:</p></td>
    <td width="100"><cfoutput>#sponsorID#</cfoutput></td>
   
  </tr>
  <tr>
    <td width="47">&nbsp;</td>
    <td width="338"><p  align="left">Total Income:</p></td>
    <td width="100"><cfoutput>#Dollarformat(session.hh_income_total_complete)#</cfoutput></td>
   
  </tr>
  <tr>
    <td width="47">&nbsp;</td>
    <td width="338"><p  align="left">Zip Code:</p></td>
    <td width="100"><cfoutput>#form.zip#</cfoutput></td>
    
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td width="338"> <p  align="left">Are you married? </p ></td>
    <td width="100" valign=top><cfoutput>#form.maritalstatus#</cfoutput></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left">Have you recently been one of the following: widowed, divorced, or separated? </p></td>
    <td width="100" valign=top><cfoutput>#form.recently#</cfoutput></td>
  
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="338"><p align="left">Does your State help you pay your Medicare Part A or Part B premiums? </p ></td>
    <td width="100" valign=top><cfoutput>#form.statepay#</cfoutput></td>
  
  </tr>
    <tr>
    <td>&nbsp;</td>
    <td width="200" align=right><INPUT TYPE="submit"  NAME="Submit"  VALUE="Enroll with Medicare.gov" ></td>
    <td width="238"><INPUT TYPE="button"  NAME="Submit" onclick="history.back(1)"  VALUE="Change Responses" ></td>
  
  </tr>
  
</table>
</td></tr></table>
</TD></TR></TABLE>

<cfoutput>
<input type="hidden" name="TALevel" value="#TALevel#">
<input type="hidden" name="SponsorID" value="#form.SponsorID#">
<input type="hidden" name="Recently" value="#form.Recently#">
<input type="hidden" name="MaritalStatus" value="#form.MaritalStatus#">
<input type="hidden" name="Zip" value="#form.Zip#">
<input type="hidden" name="StatePay" value="#form.StatePay#">
</cfoutput>
</form>

<cf_tagFooter>