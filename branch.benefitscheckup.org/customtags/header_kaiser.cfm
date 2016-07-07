<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>

<script language="JavaScript" src="ValidationFunctions.js"></script>
<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) gt 0>
	<cfset title="Kaiser Permanente CheckUp">
	<cfset AddBanner = "Yes">
<cfelseif Find("before_you_start.cfm", BasePath) gt 0>
	<cfset title="Kaiser Permanente CheckUp">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="Kaiser Permanente CheckUp">
	<cfset AddBanner="No">
</cfif>

<!--- Kaiser Settings --->
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

<body link="#link_color#" vlink="#link_color#" alink="#link_color#"  bgcolor"##FFFFCC"#onLoadScript#>
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>

<!-- set table values -->
	<cfset tablewidth="95%">
	<cfset cellpadding="5">
	<cfset session.cellpadding="12">
	<cfset session.cellspacing="2">
	<cfset session.innercellpadding="2">
	<cfset session.innercellspacing="2">

<!-- Kaiser header -->
<table cellspacing="0" cellpadding="0" width="690" align="center" bgcolor"##FFFFFF" border="0">
	<tr>
		<td valign="top" align="center" colspan="5" height="72">
			<img src="kaiser/img/kp_checkup_newlogo.gif" width="368" height="75" alt="Kaiser Permanente CheckUp -- Kaiser Permanente"><br>
			<table align="center" width="680" border="0">
				<tr>
					<td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font></cfif><hr color="##0067A4"></td>
				</tr>
			</table>
			<a name="skipnav"></a>
			<table>
				<tr>
					<td align="center" width="690">
</cfoutput>