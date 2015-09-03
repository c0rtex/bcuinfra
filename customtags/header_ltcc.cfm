<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>
<script language="JavaScript" src="ValidationFunctions.js"></script>

<cfset AddBanner="">

<cfoutput>
<cfset bodyTagMore = ' leftmargin="0" topmargin="0" marginheight="0" marginwidth="0"'>
<cfset title = 'LTCC Public Programs'>

<LINK rel="stylesheet" type="text/css" href="include/ltcc.css">

<title>#title#</title>
</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#" #page_background##bodyTagMore##onLoadScript#>
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>

<!--- Medicare LTCC cobranding --->
	<cfif IsDefined('session.randomname') And session.randomname neq ''>
		<cfset ltccQS = "bcupath=" & URLEncodedFormat("http://#application.serverPath#/pdf/#session.cftoken#-#session.cfid##session.randomname#.cfm")>
		<cfset qltccQS = "?#ltccQS#">
		<cfset altccQS = "&#ltccQS#">
	<cfelse>
		<cfset ltccQS = ''>
		<cfset qltccQS = ''>
		<cfset altccQS = ''>
	</cfif>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:##3366cc">
     <tr>
	<td valign='top' width="20%" rowspan="6">
	 <a href="http://www.medicare.gov"><img src="http://#session.ltccservername#/Graphics/flagmed2.gif" WIDTH="212" HEIGHT="110" border="0" alt="Medicare.gov site Flag Logo"></a>
         </td>
	<td width="3%" rowspan="6">&nbsp;</td>
	<td class="TopToolBar" width="100%" height="25" align="left">
	<a class="TopToolBar" href="http://www.medicare.gov/default.asp">Medicare Home</a>&nbsp;
	</td>
    </tr>
    <tr>
	<td width="100%" height="100%" align="left" class="TopToolBar">
	<span class="Tagline">
	The Official U.S. Government Site for People with Medicare
	</span>
	</td>
    </tr>					
</table>
<table width="765" align="center" cellpadding="2" border="0"><tr><td width="760">

<cfif maintMsg neq ''><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font><br><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br></cfif>

<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
	<TR>
		<TD>&nbsp;</td>
		<TD><A HREF="http://#session.ltccservername#/index.cfm#qltccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_01_welcome.gif" WIDTH="81" HEIGHT="27" ALT="Welcome" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doCalculateCosts#altccQS#"><IMG  border=0 SRC="http://#session.ltccservername#/Graphics/nav_02_risks.gif" WIDTH="125" HEIGHT="27" ALT="Risks and Costs" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doServiceOptions#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_03_services.gif" WIDTH="92" HEIGHT="27" ALT="Services" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doFinanceOptions#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_04_financing.gif" WIDTH="98" HEIGHT="27" ALT="Financing" BORDER="0"></A></TD>
		<TD><A HREF="ltcc.cfm"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_active_07_programs.gif" WIDTH="132" HEIGHT="27" ALT="Public Programs" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doLibrary#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_05_library.gif" WIDTH="83" HEIGHT="27" ALT="Library" BORDER="0"></A></TD>
		<TD><A HREF="http://#session.ltccservername#/index.cfm?method=ltcc.doReport#altccQS#"><IMG border=0 SRC="http://#session.ltccservername#/Graphics/nav_06_report.gif" WIDTH="77" HEIGHT="27" ALT="Your Personal Report" BORDER="0"></A></TD>
	</TR>
	<tr>
		<TD>&nbsp;</td>
		<td colspan="7"><img SRC="http://#session.ltccservername#/Graphics/header_pp.gif" WIDTH="688" HEIGHT="56" border="0" alt="Public Programs"></td>
	</tr>
	<tr>
		<TD colspan="8">&nbsp;</td>
	</tr>
</table>

<!---<img src="images/pixel.gif" width="1" height="7" border="0" alt=""><br>
<center><FONT face="Arial" color="#link_color#" size="2"><B><a href="javascript:help2('faq.cfm')">How&nbsp;to&nbsp;Use</a>
            &nbsp; &nbsp;|&nbsp; &nbsp; <a href="javascript:help2('tips.cfm')">Tips&nbsp;on&nbsp;Use</A></B></FONT></center>--->
<!--- end Medicare LTCC cobranding --->
	
	<!-- set table values -->
	<cfset tablewidth="100%">
	<cfset cellpadding="0">
	<cfset session.cellpadding="0">
	<cfset session.cellspacing="0">
	<cfset session.innercellpadding="0">
	<cfset session.innercellspacing="0">

</cfoutput>
<a name="skipnav"></a>
<table><tr><td width="680">