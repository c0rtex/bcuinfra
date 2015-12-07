<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfset title="BenefitsCheckUp - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUp From NCOA">
	<cfset AddBanner="No">
</cfif>
<!-- set table values -->
<cfset tablewidth="95%">
<cfset cellpadding="5">
<cfset session.cellpadding="12">
<cfset session.cellspacing="2">
<cfset session.innercellpadding="2">
<cfset session.innercellspacing="2">

<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">

<cfoutput><META http-equiv="refresh" content="600"></cfoutput>

<script language="JavaScript" src="../ValidationFunctions.js"></script>
<cfoutput>
<STYLE type=text/css>@import url( ../ec/themes/EC/style.css );

</STYLE>
<SCRIPT src="GUIFiles/sugar.js"></SCRIPT>
<title>#title#</title>
</head>

<body >
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>
<TABLE cellSpacing=0 cellPadding=0 width="765" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2> 
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
			<tr>
			<td  colSpan=3>&nbsp;
			
			</td></tr>
<cfif not isdefined('url.prg_id')>
	<tr>
			<td align=left >&nbsp;
			
			</td>
			<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-2"><strong><em>Click the button to the right to close this window</em></strong> </font></td><td >&nbsp;&nbsp;<a href="javascript:window.close();"><img border=0   src="webmd/images/closebcu.gif" alt=""></a>
			</td>
	</tr>
</cfif>
  <TR height=50>
    <TD  bgcolor=white noWrap colSpan=3 align=center><img src="../images/head-bcu.gif"  alt="BenefitsCheckUpRx"></TD>
  </TR>
  <TR height=10>
    <TD colSpan=2></TD></TR>

</TBODY>
</TABLE>
<a name="skipnav"></a>
<table width="765" align="left"><tr><td>
</cfoutput>