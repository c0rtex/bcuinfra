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

<script type="text/javascript">

  document.domain="benefitscheckup.org";
  alert(document.domain);
</script>

<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>
<script language="JavaScript" src="ValidationFunctions.js"></script>
<cfoutput>
<title>#title#</title>
</head>

<body >
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif>
<table width="765" align="center"><tr><td>
</cfoutput>