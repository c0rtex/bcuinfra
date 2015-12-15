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
	<cfset page_background = 'bgcolor="##9ECFCF"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##144F4F">
	<cfset table_color = "##E2E2C6">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##666633">	

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>


</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#" #page_background##onLoadScript#>
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
		 <cfif IsDefined('session.org_id') AND session.org_id gt 0>

			<table cellpadding="0" cellspacing="0" align="left" border="0">
			<tr>
				<td align="left" valign="top" width="226" rowspan="4"><img src="il/images/il_logo.gif" width="262" height="127" border="0" alt="Illinois Department on Aging"></td>
				<td align="center" valign="top" width="10" rowspan="4"><img src="images/pixel.gif" width="10" height="1" border="0" alt=""></td>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="left" valign="top" colspan="3"><font face="Arial" size="4"><b>#parent_name#</b></font></td>
			</tr>
			<tr>
				<td align="left" valign="bottom" colspan="3">#right_logo#</td>
			</tr>
			</table><br clear="left">
		 
		 <cfelse>
			<img src="il/images/il_full.gif" width="693" height="70" border="0" alt="">
		 </cfif>
		 <table align="center"  width="680"  border="0">
			<tr>
			<td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font></cfif><hr color="##3E8686"></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center" width="690">
</cfoutput>