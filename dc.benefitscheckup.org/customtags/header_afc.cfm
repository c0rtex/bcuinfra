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

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><meta http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
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

<!-- Style sheets start -->
<link rel=stylesheet href="/css/afc.css" type="text/css" media="screen" />
<link rel=stylesheet href="/css/afcmenu.css" type="text/css" media="screen" />
<link rel=stylesheet href="/css/screening.css" type="text/css" />
<link rel=stylesheet href="/css/screening.css" type="text/css" />

<!--[if IE]>
<link rel=stylesheet href="/css/afc.css" type="text/css" media="screen" />
<link rel=stylesheet href="/css/afcmenuie.css" type="text/css" media="screen" />
<![endif]-->

<!-- Style sheets end -->

<cfoutput>
<title>#title#</title>
#meta#

<link rel=stylesheet href="/css/print.css" type="text/css" media="print">

<script language="JavaScript" src="ValidationFunctions.js"></script>
<script language="JavaScript">

function highlight_off(item) {
var tag = item + "h";
if (document.getElementById(tag))
{
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
oetag.href = "javascript:help2('/privacy.cfm')";
}

var tag2 = "terms";
if (document.getElementById(tag2))
{
var oetag2 = document.getElementById(tag2);
oetag2.href = "javascript:help2('/terms.cfm')";
}

}
</script>


</head>

<body onLoad="fixpopups();#attributes.onload#">
<div class="print">
<div class="bcu">
	<h1>Benefits Checkup</h1>
	<h3>A Service of the National Council on Aging</h3>
</div>

<div class="container1">

<div class="topheader">

	<div class="bculogo">
		<cf_displayimage code="img_bculogo_gif">
	</div>
	
	<div class="asof1">
		<h1 class="h0">Application Forms Center</h1>
	</div>

</div>

<div class="clear"></div>
	<cfinclude template="/#approot#/afcmenu.cfm">
<div class="noprint">
<div class="contenttitle0"></div>

</div>
<table cellpadding="0" cellspacing="0" width="770">
<tr>

<cfif attributes.show_left_col IS 'y'>
	<cfif attributes.rightcol IS "">
		<cfparam name="colstyle" default="contentcol">
	<cfelse>
		<cfparam name="colstyle" default="contentcol1">
	</cfif>
<cfelse>
	<cfif attributes.rightcol IS "">
		<cfparam name="colstyle" default="contentcol2">
	<cfelse>
		<cfparam name="colstyle" default="contentcol3">
	</cfif>

</cfif>
<td valign="top" class="#colstyle#"><cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>

</cfoutput>