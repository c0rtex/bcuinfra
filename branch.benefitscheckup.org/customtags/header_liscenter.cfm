<cfset link_color = "##00656C">
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

<cfoutput>
<HTML><HEAD>
<link rel=stylesheet href="css/lis.css" type="text/css" />
<link rel=stylesheet href="css/print.css" type="text/css" media="print" />
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#">
</cfif>
#nobackScript#
<script language="JavaScript" src="ValidationFunctions.js"></script>
<title>#title#</title>
<cfinclude template="../util/google_data_tracking.cfm">	
</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#" #onLoadScript#>
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->

<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>
<table cellpadding="#cellpadding#" width="#tablewidth#" align="center" border="0">
  <tr>

     <td bgcolor="white" >
		<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"></td>
			</tr>
			<tr>
				<td align="left" rowspan="2" width="199"><div id="ncoa_logo"><img src="/wp-content/uploads/2011/11/BCUfooter-ncoa-logo.png" width="189" height="65" border="0" alt="National Council on Aging" title="National Council on Aging"></div>&nbsp;&nbsp;&nbsp;</td>
				<td align="left" valign="top"><div id="bcu_logo"><img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" border="0" alt="BenefitsCheckUp" title="BenefitsCheckUp"></div></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			</table>
		      <TABLE cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
		        <TR>
		          <td valign="center" bgcolor="##ffffff" colspan="2"><!--Navigate Menu-->
		            
					<CENTER>
					<FONT face="Arial, Helvetica, sans-serif" color="#link_color#" size="6"><strong>Medicare Rx Extra Help Online Application</strong></FONT>
					<FONT face="Arial" color="#link_color#" size="3">
					<cfif maintMsg neq ''><br>
					<img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br>
					<font color="##800000"><b>#maintMsg#</b></font>
					</cfif>
					</FONT>
					</CENTER>

				</TD></TR></TABLE>
<a name="skipnav"></a>
</cfoutput>
