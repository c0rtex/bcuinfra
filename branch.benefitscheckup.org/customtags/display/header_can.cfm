<cfif session.org_id eq 0><HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">

<script language="JavaScript" src="../ValidationFunctions.js"></script>
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>

<!--- ABCRx Settings --->
	<cfset page_background = 'bgcolor="##FFFFFF"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594B">
	<cfset table_color = "##0067A4">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##666633">	
	<cfset bodyTagMore = ''>
	<cfset tablewidth="95%">
	<cfset cellpadding="5">
	<cfset session.cellpadding="12">
	<cfset session.cellspacing="2">
	<cfset session.innercellpadding="2">
	<cfset session.innercellspacing="2">


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>BenefitsCheckup - Helping Seniors with Disaster Recovery</title>
<meta name="keywords" content="ncoa, benefitscheckup" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<cfif attributes.refreshurl neq ''>
<cfoutput><meta http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>
<link href="include/can_styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="ValidationFunctions.js"></script>
</head>

<body leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">

<!-- warning: tables abound.  i should be lashed for laying this out with tables -->



<table width="750" border="0" align="center" cellpadding="0" cellspacing="0">


<!-- head container: start -->
  <tr>
    <td height="140" valign="top"><img src="can/img/head_spc.jpg" alt="header space" width="750" height="10"><br>
	<img src="can/img/head.jpg" alt="header graphic" width="750" height="130"></td>
  </tr>
<!-- head container: end -->



<!-- master body container: begin --> 
  <tr>
    <td valign="top">

<table width="750" border="0" cellspacing="0" cellpadding="0">

<cfif attributes.sidebar>
<!-- body table row 1: start -->
  <tr>
    <td width="172"><img src="can/img/mainst_top.jpg" width="172" height="43"></td>
    <td height="43" valign="top"><img src="can/img/subnav.jpg" width="578" height="43" border="0" usemap="#Map"></td>
  </tr>
<!-- body table row 1: end --> 

<!-- body table row 2: start --> 
  <tr>
    <td valign="top" background="can/img/border_lft.jpg"><img src="can/img/mainst_bot.jpg" width="172" height="339"></td>
	<td valign="top" bgcolor="#ffffff">


	
<!-- content: begin -->
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" height="339">
		
  			<tr>
    		<td width="20">&nbsp;</td>
<cfelse>
  <tr>
    <td>
	
<!-- content: begin -->
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		
  			<tr>
    		<td width="20"background="can/img/border_lft02.jpg">&nbsp;</td>
</cfif>
    		
			<td valign="top" class="Black-b2"><cfif maintMsg neq ''><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b><cfoutput>#maintMsg#</cfoutput></b></font><hr color="##999966"></cfif><cfelse><HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>

<script language="JavaScript" src="../ValidationFunctions.js"></script>
<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) gt 0 Or Find("before_you_start.cfm", BasePath) gt 0>
	<cfset title="BenefitsCheckUp">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUp - NCOA's Online Screening Service">
	<cfset AddBanner="No">
</cfif>


<!--- ABCRx Settings --->
	<cfset page_background = 'bgcolor="##FFFFFF"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##0067A4">
	<cfset table_color = "##E2E2C6">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##0067A4">	

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>


</head>

<body text="#text_color#" link="#link_color#" vlink="#link_color#" alink="#link_color#" #page_background##onLoadScript#>
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>

<!-- set table values -->
	<cfset tablewidth="95%">
	<cfset cellpadding="5">
	<cfset session.cellpadding="12">
	<cfset session.cellspacing="2">
	<cfset session.innercellpadding="2">
	<cfset session.innercellspacing="2">

<!-- abc header -->
<TABLE cellSpacing="0" cellPadding="0" width="690" align="center" bgcolor"##FFFFFF" border="0"><TBODY>
  <TR>
    <TD vAlign=top align=left colSpan=5 height=72>
			<table cellpadding="0" cellspacing="0" align="center" border="0" width="664">
			<tr>
				<td><img src="can/img/oehead.jpg" width="684" height="83" border="0" alt="BenefitsCheckUp: Helping with Disaster Recovery"></td>
			</tr>
			<tr><td><img src="img/pixel.gif" width="1" height="10" border="0" alt=""></td></tr>
			<tr>
				<td align="center" valign="middle" width="658">#parent_name##right_logo##page_slogan#</span></td>
			</tr>
			</table>		 
		 <table align="center"  width="690"  border="0">
			<tr>
			<td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font></cfif><hr color="##0067A4"></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center" width="690">
</cfoutput></cfif>