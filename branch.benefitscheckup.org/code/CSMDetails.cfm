<!----=======================================
DESCRIPTION:  Displays the Cuyahoga County Suburb Matrix when accessed from FrmEligibility.cfm
CALLED BY: FrmEligibility.cfm
GOES TO: N/A
REQUIRED: N/A
LAST UPDATED BY:  David Dring - 020510
============================================---->
<cf_tagHeader>

<CFIF IsDefined('Attributes.Page')>
	<CFSWITCH Expression=#Attributes.Page#>
		
		<CFCASE value="index">
			<CFSET Title="BenefitsCheckUp From NCOA">
			<CFSET AddBanner = "Yes">
		</CFCASE>
		<CFCASE value="before_you_start">
			<CFSET Title="BenefitsCheckUp From NCOA">
			<CFSET AddBanner = "Yes">
		</CFCASE>

	</CFSWITCH>
<CFELSE>
			<CFSET Title="BenefitsCheckUp From NCOA">
			
			<CFSET AddBanner="No">
</CFIF>
<cfoutput>
</cfoutput>

<!--- DD: note that there are two tables that enter this file from cf_tagheader, which had previously caused some confusing display issues in Netscape --->

<!--- Table 3 Open: main body table --->
<table width=100% border="0" align="center" cellpadding=5 cellspacing=2>
	<TBODY>
     <tr>
	  <td bgcolor=#FFFFFF colspan=2>
      <!--- Message to Users --->
	 
	<CENTER>
	<IMG SRC="images/CCSM.JPG" WIDTH="650" alt="Cuyahoga Suburban table">
	</center>

<!--- Table 4 Open:  The footer --->
	<TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
	 <tr> 
	  <TD align=top bgColor=#bdcfc8>
	  <CENTER><FONT face="Arial" size=2> 
	  <I>Powered by National Council on Aging and Hosted by AOL's GovernmentGuide.com</I></FONT>
	  <BR>
	  <FONT FACE="Arial" SIZE="1">
      Copyright &copy 2002 National Council on Aging 
      &nbsp; | <a href="javascript:help2('privacy.cfm')">Privacy Policy</A> | <a href="javascript:help2('termsofuse.cfm')">Terms of Use</A> | 
	  <a href="javascript:help2('frmFeedback.cfm')">Feedback</A> | <A href="http://www.ncoa.org/press/index.html" target="blank">NCOA's Press Room</A> | 
	  <a href="javascript:help2('LinktoUs.cfm')">Link to Us</A> 
      </CENTER></FONT>
	  </TD>
	 </TR>
	</TABLE>
<!--- Table 4 Close --->


</TD></TR></TBODY></TABLE>
<!--- Table 3 Close --->

<!--- Table 2 is the navigation table - tips on use, how to use, etc. it is contained within cf_tagHeader --->

</TD></TR></TBODY></TABLE>
<!--- Table 1 Close --->


<CFCOOKIE NAME="CFID" VALUE="0">
<CFCOOKIE NAME="CFTOKEN" VALUE="0">

</BODY></HTML>