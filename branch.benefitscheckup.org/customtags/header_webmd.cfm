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
	<cfset title="BenefitsCheckUpRx - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelseif Find("before_you_start.cfm", BasePath) gt 0>
	<cfset title="BenefitsCheckUpRx - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUpRx From NCOA">
	<cfset AddBanner="No">
</cfif>
<!--- WebMD --->
	<cfset page_background = 'bgcolor="##ffffff"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##336699">
	<cfset table_color = "##ffffff">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##000000">	

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>


</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#"#onLoadScript#>
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>




<!-- set table values -->
	<cfset tablewidth="95%">
	<cfset cellpadding="5">
	<cfset session.cellpadding="12">
	<cfset session.cellspacing="2">
	<cfset session.innercellpadding="2">
	<cfset session.innercellspacing="2">


<!-- webmd header -->
<table align="center"  width="690" >
	<tr>
			<td align=left >
			<img src="webmd/images/webmdpresents3.jpg" alt="">
			</td>
			<td align="right" ><img src="webmd/images/closewindow.gif" alt=""></td><td ><a href="javascript:window.close();"><img border=0   src="webmd/images/closebcu.gif" alt=""></a>
			</td>
	</tr>
</table>
<table width="690" cellpadding="#cellpadding#" width="#tablewidth#" align="center" border="0">
  <tr>
  <td bgcolor="##FFFFFF">

		<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="webmd/images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b></b></font></td>
			</tr>
			
			<tr>
				
				<td align="left" valign="top"><img src="images/head-bcu.gif"  border="0" alt="BenefitsCheckUp"></td>
			</tr>
		
			
			<tr>
				<td align="center" valign="top" colspan="3"><img src="webmd/images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font><br></cfif><img src="webmd/images/bluelinetop.gif" alt=""></td></tr></table><table><tr><td align="center" width="690">
</cfoutput>