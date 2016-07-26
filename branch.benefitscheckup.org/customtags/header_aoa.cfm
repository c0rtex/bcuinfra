<HTML><HEAD>
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
	<cfset text_color = "##00594B">
	<cfset link_color = "##666633">
	<cfset table_color = "##E2E2C6">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##666633">	

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>


</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#" bgcolor"##FFFFFF"#onLoadScript#>
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
		 <cfif session.org_id gt 0>
			<table cellpadding="0" cellspacing="0" align="left" border="0">
			<tr>
				<td align="right" valign="middle" width="185" rowspan="4"</td>
				<td align="right" valign="middle" width="5" rowspan="4"><img src="images/pixel.gif" width="5" height="1" border="0" alt=""></td>
				<td align="center" valign="top" width="405"><img src="images/pixel.gif" width="405" height="5" border="0" alt=""></td>
				<td align="right" valign="middle" width="5" rowspan="4"><img src="images/pixel.gif" width="5" height="1" border="0" alt=""></td>
				<td align="left" valign="middle" width="90" rowspan="4"></td>
			</tr>
			<tr>
				<td align="center" valign="top"><font face="Arial" size="4"><b>#parent_name#</b></font></td>
			</tr>
			<tr>
				<td align="center" valign="top">#right_logo#</td>
			</tr>
			</table><br clear="left">
		 
		 <cfelse>
			<img src="img/bculogo.gif" border="0" alt="Administration on Aging, United States Department of Health and Human Services present BenefitsCheckUpRx, a decision-support and enrollment service">
		 </cfif>
		 <table align="center"  width="690"  border="0">
			<tr>
			<td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font></cfif><hr color="##999966"></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center" width="690">
</cfoutput>