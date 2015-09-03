<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfset title="BenefitsCheckUp for CVS - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUp for CVS From NCOA">
	<cfset AddBanner="No">
</cfif>
<!-- set table values -->
<cfset tablewidth="95%">
<cfset cellpadding="5">
<cfset session.cellpadding="12">
<cfset session.cellspacing="2">
<cfset session.innercellpadding="2">
<cfset session.innercellspacing="2">
<cfparam name="link" default="">
<cfparam name="showmenu" default="0">
<cfparam name="guts" default="">
<cfparam name="content_title_override" default="">


<cfset title1 = "Benefits CheckUp">
<cfset images = 24>
<cfset randimage = fix((rand() * images + .5))>
<cfif randimage IS 0>
	<cfset randimage = 1>
<cfelseif randimage GT images>
	<cfset randimage = images>
<cfelse>
</cfif>

<cfset approot = "approot">
<cfset imgroot = "img">

<cfif session.partner_id IS 0>
	<cfset qpartner = 1>
<cfelse>
	<cfset qpartner = session.partner_id>
</cfif>

<cf_cachePartnerQuery query="partnerQuery" partner_id="#qpartner#">



<cfparam name="contenttitle" default="">

<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>


<cfif session.subset_id IS 0>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Pay For Prescription Drugs, Get Energy Assistance, and More.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>

<cfelseif session.subset_id IS 39>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Reduce Prescription Drug Costs.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>

<cfelseif session.subset_id IS 38>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You With Disaster Recovery.'>
	<cfparam name='meta' default='<meta name="description" content="Affected by a hurricane or other disaster? Find programs that offer financial help, health care and prescription drugs, housing and more.">
 
<meta name="keywords" content="hurricane benefits, hurricane Katrina benefits, benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
<cfelse>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
</cfif>

<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfparam name="title" default="BenefitsCheckUp - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfparam name="title" default="BenefitsCheckUp From NCOA">
	<cfset AddBanner="No">
</cfif>

<cfif session.partner_id GT 0 OR partner_id GT 0>
	<cfset content_title = partnerQuery.partner_titlebar>
<cfelse>
	<cfparam name="content_title" default="#partnerQuery.partner_titlebar#">
</cfif>



<head>

<cfoutput>

<title>#title#</title>
#meta#



<!-- Style sheets start -->
<link rel=stylesheet href="css/pl.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/menu.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/screening.css" type="text/css" />


<!--[if IE]>
<link rel=stylesheet href="css/pl.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/menuie.css" type="text/css" media="screen" />
<![endif]-->


<!-- Style sheets end -->

<link rel=stylesheet href="css/print.css" type="text/css" media="print">

<script language="JavaScript" src="ValidationFunctions.js"></script>

<script language="JavaScript">

function highlight_off(item) {
var tag = item + "h";
if (document.getElementById(tag)) {
		var oetag = document.getElementById(tag);
		oetag.id = item;
	}
}
</script>


<script language="JavaScript">

function highlight(item) {
if (document.getElementById(item))
{
var oetag = document.getElementById(item);
oetag.id = item + "h";
}
}
</script>

<script language="JavaScript">
function fixpopups() {

var tag = "privacy";
if (document.getElementById(tag))
{
var oetag = document.getElementById(tag);
oetag.href = "javascript:help2('privacy.cfm')";
}

var tag2 = "terms";
if (document.getElementById(tag2))
{
var oetag2 = document.getElementById(tag2);
oetag2.href = "javascript:help2('terms.cfm')";
}

}
</script>

<script language="JavaScript">

function backstyleon(thisId) {
	elem = document.getElementById(thisId);
	elem.className='back2';
	}

function backstyleoff(thisId) {
	elem = document.getElementById(thisId);
	elem.className='back1';
	}
</script>


</head>

<body onLoad="fixpopups();#attributes.onload#">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000"></div> 
<div class="print">
<div class="bcu">
	<h1>Benefits Checkup</h1>
	<h3>A Service of the National Council on Aging</h3>
</div>

<div class="container1">


<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)>
	<div class="topheader2">
<cfelse>
	<cfif attributes.showmenu IS 1>
		<div class="topheader">
	<cfelse>
		<div class="topheader2">
	</cfif>
</cfif>

<div class="bculogo">

<cfif session.org_id GT 1>
	<cfif showmenu IS 1>
		<cf_sessionPassVars href="before_you_start.cfm"><cf_displayimage code="img_bculogo_gif"></cf_sessionPassVars>
	<cfelse>
		<cf_displayimage code="img_bculogo_gif">
	</cfif>
<cfelse>
	<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)>
		<cf_displayimage code="img_bculogo_gif">
	<cfelse>
		<cfif attributes.showmenu IS 1>
			<cf_sessionPassVars href="index.cfm"><cf_displayimage code="img_bculogo_gif"></cf_sessionPassVars>
		<cfelse>
			<cf_displayimage code="img_bculogo_gif">
		</cfif>
	</cfif>
</cfif>

</div>

<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)><cfelse>

	<cfif attributes.showmenu IS 1>
		<div class="asof1">
		<a href="http://www.cvs.com" target="www.cvs.com" target="cvs"><img src="img/partners/cvs/logo.gif" alt="#partnerQuery.wrapper_logo_alt_text#" title="#partnerQuery.wrapper_logo_alt_text#" border="0" style="margin:24px 20px 0px 0px; float:right;"></a>
		
		</div>

	<cfelse>

	</cfif>


</cfif>
</div>

<div class="clear"></div>


<cfif showmenu IS 1>
		<cfinclude template="/#approot#/menu.cfm">
		<div class="clear"></div>		
<cfelse>
</cfif>

<div class="noprint">
<div class="contenttitle0"></div>
</div>
<table cellpadding="0" cellspacing="0" width="770" border="0">
<tr>
<cfif wrapper.wrapper_left_col IS 'y'>
	<td valign="top" class="clients" width="150"><img src="#imgroot#/left#randimage#.jpg">
	<h3 class="clientsh3">What People Are Saying...</h3>
<blockquote><cf_displayQuote action="random"></blockquote></td>
<cfelse>
</cfif>
<cfif wrapper.wrapper_left_col IS 'y'>
	<cfif attributes.rightcol IS "">
		<cfparam name="colstyle" default="contentcol">
	<cfelse>
		<cfparam name="colstyle" default="contentcol1">
	</cfif>
<cfelse>
	<cfif wrapper.wrapper_right_col IS "n">
		<cfparam name="colstyle" default="contentcol2">
	<cfelse>
		<cfparam name="colstyle" default="contentcol3">
	</cfif>

</cfif>
<td valign="top" class="#colstyle#"><cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>
<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b>#parent_name#</b></font></td>
			</tr>
			<cfif trim(center_logo) eq ''>
			<tr>
				<td align="center" valign="top" colspan="3">#right_logo#</td>
			</tr>
			<tr>
				<td align="center" valign="bottom" colspan="3">#page_slogan#</td>
			</tr>
			<cfelseif trim(left_logo) neq ''>
			<tr>
				<td rowspan="2" align="right">#left_logo#</td>
				<td rowspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			<tr>
				<td align="left" valign="bottom">#page_slogan#</td>
			</tr>
			<cfelse>
			<cfif session.org_id IS 0>
			<cfelse>
			<tr>
				<td rowspan="2" align="right">#center_logo#</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			<tr>
				<td align="left" valign="bottom">#page_slogan#</td>
			</tr>
			</cfif>
			</cfif>
			</table>
</cfoutput>