<!----=======================================
DESCRIPTION: gets called when there is an error caught, 
					displays message to user, and sends error info to text file
CALLED BY: N/A
GOES TO: N/A
REQUIRED: N/A
============================================---->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0031)http://www.spintrific.com/ncoa/ -->
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<cf_tagyejavascript>
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
<TITLE>#TITLE#</TITLE>
</cfoutput>
<META content="MSHTML 5.50.4134.600" name=GENERATOR></HEAD>

<BODY vLink=#00594b aLink=#00594b link=#00594b background="images/BCUback.jpg">

<TABLE cellPadding=5 width="95%" align=center border=0>
  <TBODY>
  <TR>
    <TD bgColor=#bdcfc8>
	
      <TABLE cellPadding=5 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD vAlign=top bgColor=#bdcfc8><!--NCOA Logo & BCU header-->&nbsp; 
            <A target=blank href="http://www.ncoa.org/"><IMG 
            src="images/ncoa.gif" border=0 valign="top" ALT="National Council on Aging logo"></A><BR>
            </TD>
          <TD width="25%">&nbsp; </TD>
          <TD bgColor=#bdcfc8 vAlign=top halign="right"><IMG 
            src="images/BCUlogo.gif" valign=top 
            border=0 ALT="BenefitsCheckUp logo"><FONT face="Arial" size=2>
            <CENTER><I><B>A service of the National Council on Aging 
            </B></I></CENTER></FONT></TD></TR>
        <cfif addbanner is "yes"><TR>
          <TD bgColor=#ffffff colSpan=3><!--Banner Ads-->
            <CENTER><a href="http://www.newyorklife.com/NYL2/CategoryDisplay/0,1233,10473,00.html
" target="blank"><IMG height=65 src="images/NYLifelogo.jpe" 
            width=134 border="0" ALT="New York Life logo"></a> &nbsp; &nbsp; <a href="http://www.lucent.com" target="blank"><IMG  src="images/WandF.gif" border="0" ALT="Lucent Technologies Work and Family logo"></a> &nbsp; &nbsp; <a href="http://www.merck.com/" target="blank"><IMG  src="images/mercknew.gif"  border="0" ALT="The Merck Foundation logo"></a> &nbsp; &nbsp; <a href="http://www.archstone.com/" target="blank"><IMG height=65 src="images/archstone.jpe" width=134 border="0" ALT="The Archstone Foundation logo"></a> </CENTER></TD></TR></cfif></TBODY></TABLE>
      <TABLE cellSpacing=2 cellPadding=2 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD vAlign=center bgColor=#ffffff colSpan=2><!--Navigate Menu-->
            <CENTER><FONT face="Arial" color=#00594b size=3><B><a href="javascript:help2('FAQ.cfm?keyword=residence&type=Definition')">How to Use</a> &nbsp; 
            &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; <a href="javascript:help2('tips.cfm?keyword=residence&type=Definition')">Tips on Use</A> 
            &nbsp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; <a href="javascript:help2('About.cfm?keyword=residence&type=Definition')">About</A> &nbsp; 
            &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; <a href="javascript:help2('Sponsors.cfm?keyword=residence&type=Definition')">Sponsors &amp; 
            Partners</A> </B></FONT></CENTER></TD></TR></TBODY></TABLE>
<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font size="4" face="arial" color="#000000">
	<br>
   <p>For your protection, your session with <cfinclude template="bcu.cfm"> has expired.  For security reasons, each user is allowed up to 40 minutes since the last mouse click or keyboard entry.  For more information on using <cfinclude template="bcu.cfm">, visit the Tips on Use help section. </p>  
   
   <p>It is also possible that you've reached this page, because you have at least one other browser window open and pointed to the <cfinclude template="bcu.cfm"> site.  If this is true, please close all other browsers.</p>
   
   <p>We sincerely apologize for this inconvenience, please return to the <cfinclude template="bcu.cfm"> Welcome page and start over.</p>
   <br><br>
   <a href="before_you_start.cfm">Restart the Questionnaire</a>.
	<br><br>
	

		<TABLE cellSpacing=2 cellPadding=12 width="100%" align=center border=0>
        <TBODY>	
        <TR>
          <TD bgColor=#bdcfc8 colSpan=2><!--Copyright--><FONT 
            face="Arial" color=#00594b size=1>
            <CENTER>
		<table width="25%" border="0"><tr><td>
		<img src="images/seashell2.gif" ALT="Powered by VitalAging"></td> 
		<td valign="center">
		<FONT face="Arial" color=#00594b size=1>Powered by VitalAging	
		</td></tr></table>
	    Copyright &copy; 2001 National Council on Aging 
            &nbsp; | <a href="javascript:help2('Privacy.cfm?keyword=residence&type=Definition')">Privacy 
            Policy</A> | <a href="javascript:help2('frmFeedback2.cfm?keyword=residence&type=Definition')">Feedback</A> | <A href="mailto:Feedback@BenefitsCheckUp.org">Contact Us</A> 
            </CENTER></FONT></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
			

			
			
			
			</BODY></HTML>
</TD></TR>
</TBODY></TABLE>

<!--- dump any answers that the user may have --->
<!---CF_TagYeDumpSessionVariables--->

<cfloop collection = "#session#" item = "variable">
<CFIF variable NEQ "questionarray" AND variable NEQ "questionsecarray" AND variable NEQ "questionsecdeparray" AND variable NEQ "FIELDNAMES">
	<CFIF variable NEQ "income">
	<CFIF variable NEQ "incometable">
	<CFIF variable NEQ "prg_list">
	<CFIF variable NEQ "zip">
	<CFIF variable NEQ "email">
		
			<!--- dump the remaining variables, wheather numeric or not --->
			<CFIF #StructFind(session, "#variable#")# NEQ "Z" AND #StructFind(session, "#variable#")# NEQ "0">
		          <CFSET temp = #StructFind(session, "#variable#")#>
			  <CFIF IsNumeric(temp)>
			  	<CFQuERY datasource="#application.dbSrc#">
				INSERT INTO tbl_answers (ID, FIELD, ANSWER)
				Select #session.clientnum#, '#variable#', #temp#
				</cfquery>
			<CFELSE>			  
			  	<CFQuERY datasource="#application.dbSrc#">
				INSERT INTO tbl_answers (ID, FIELD, ANSWER)
				Select #session.clientnum#, '#variable#', '#temp#'
				</cfquery>
			  </cfif>
		<CFELSE>	  
			  
		</CFIF>
	</cfif>
	</CFIF>
	</cfif>
	</CFIF>
	</CFIF>
</CFIF>
</cfloop> 
<Cflock Timeout="30" Name="#Session.SessionID#" Type="Exclusive">
<CFSet StructClear(Session)>
</cflock>




<CFCOOKIE NAME="CFID" VALUE="0">
<CFCOOKIE NAME="CFTOKEN" VALUE="0">

