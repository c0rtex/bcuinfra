<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.onLoad" type="string" default="">
<cfparam name="attributes.onUnload" type="string" default="">
<cfparam name="attributes.allowBack" type="string" default="true">
<cfparam name="attributes.refreshurl" type="string" default="">
<cfparam name="attributes.refreshsec" type="numeric" default="5">
<cfparam name="attributes.sidebar" type="boolean" default="false">
<cfparam name="attributes.rightcol" type="string" default="">
<cfparam name="attributes.guts" type="string" default="">
<cfparam name="attributes.show_left_col" type="string" default="">
<cfparam name="attributes.show_title" type="string" default="">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.header" type="string" default="">
<cfparam name="attributes.randomimage" type="string" default="">
<cfparam name="attributes.showmenu" type="string" default="1">
<cfparam name="attributes.content_title_override" type="string" 
default="">
<cfparam name="attributes.popupwarning" type="boolean" default="0">
<cfparam name="attributes.js" type="string" default="">
<cfparam name="attributes.css" type="string" default="">

<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.subset_id') and session.subset_id neq 
'' and IsNumeric(session.subset_id)>
		<cf_cacheSubsetPool action="get" 
subset_id="#session.subset_id#" var="sobj">
		<cfset attributes.partner_id = sobj.brand>
	</cfif>
</cfif>
<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.partner_id') and session.partner_id neq 
'' and IsNumeric(session.partner_id)>
		<cfset attributes.partner_id = session.partner_id>
	<cfelse>
		<cfset attributes.partner_id = 0>
		<cfset session.partner_id = 0>
	</cfif>
</cfif>
<cf_cacheWrapperQuery query="wrapper" 
partner_id="#attributes.partner_id#">

<cfset approot = "approot">

<cfif attributes.onLoad neq ''>
	<cfset onLoadScript = " onLoad=""#attributes.onLoad#""">
<cfelse>
	<cfset onLoadScript = "">
</cfif>
<cfif attributes.onUnload neq ''>
	<cfset onUnloadScript = " onUnload=""#attributes.onUnload#""">
<cfelse>
	<cfset onUnloadScript = "">
</cfif>
<cfif attributes.allowBack eq 'debug'>
	<cfif application.debug>
		<cfset attributes.allowBack = true>
	<cfelse>
		<cfset attributes.allowBack = false>
	</cfif>
</cfif>
<cfif attributes.allowBack>
	<cfset nobackScript = ''>
<cfelse>
	<cfset nobackScript = '<script language="JavaScript">
<!--
	window.history.forward(1);
//-->
</script>'>
</cfif>

<cfset maintMsg = ''>
<cfif IsDefined('session.test_id') and session.test_id eq 1>
	<cf_sessionPassVars var="redirectURL" href="test/index.cfm" 
test_id="0">
	<cfset maintMsg = "You currently have a testing flag applied to 
this server.  To remove your testing flag from this server, <a 
href=""#redirectURL#"">click here</a>.">
</cfif>
<cfif session.maintenanceDatetime neq ''>
	<cfset maintDiff = DateDiff('n', Now(), 
ParseDateTime(session.maintenanceDatetime))>
	<cfif maintDiff lte 0 And GetFileFromPath(CGI.CF_TEMPLATE_PATH) 
neq 'maintenance.cfm'>
		<cfif session.test_id eq 1>
			<cfset maintMsg = "This site is currently 
undergoing scheduled maintenance, but you have a testing override 
applied.  To remove your testing override from this server, <a 
href=""#redirectURL#"">click here</a>.">
		<cfelse>
			<cf_sessionPassVars var="redirectURL" 
href="maintenance.cfm">
			<cflocation url="#redirectURL#" AddToken="No">
			<cfabort>
		</cfif>
	<cfelseif maintDiff lte 60 and maintDiff gt 0>
		<!---<cf_datetimeFormat var="maintDatetime" 
date="#session.maintenanceDatetime#">--->
		<cfif maintDiff eq 1>
			<cfset plural = ''>
		<cfelse>
			<cfset plural = 's'>
		</cfif>
		<cfif maintMsg neq ''>
			<cfset maintMsg = "#maintMsg#&nbsp; // &nbsp; ">
		</cfif>
		<cfset maintMsg = "#maintMsg#This site will be 
undergoing scheduled maintenance starting in #maintDiff# minute#plural# 
and will be unavailable for about an hour.">
	</cfif>
</cfif>

<cfoutput>#maintMsg#</cfoutput>
<!--- BS 11/05/02 include color values for the page, based of partner or 
CSO cobranding --->
<cfset partner_id = attributes.partner_id>
<cfinclude template="tagCobrandValues.cfm">

<cfset reaccessFileURL = GetFileFromPath(CGI.CF_TEMPLATE_PATH)>
<cfif reaccessFileURL neq 'index.cfm' And reaccessFileURL neq 
'before_you_start.cfm'>
	<cfset reaccessFileURL = 'frmwelcome2.cfm'>
</cfif>

<cf_sessionPassVars var="accessURL" href="#reaccessFileURL#" 
access_id="1">

<cfif wrapper.wrapper_header IS NOT 'header_normal.cfm' AND 
wrapper.wrapper_header IS NOT ''>

	<cfif IsDefined('session.subset_id') AND (session.subset_id eq 
41 OR session.subset_id eq 40)>
		<cfinclude template="header_liscenter_hs.cfm">
	<cfelse>
		<cfinclude template="#wrapper.wrapper_header#">
	</cfif>
<cfelseif wrapper.wrapper_header IS "">
<cfelse>
	
	<cfif IsDefined('session.subset_id') and (session.subset_id eq 
40 or session.subset_id eq 41)>
				<cfinclude 
template="header_liscenter.cfm">
	<cfelse>
		<cfswitch expression="#attributes.partner_id#">
			<cfcase value="5">
				<cfinclude template="header_ltcc.cfm">
			</cfcase>
			<cfcase value="6">
				<cfinclude template="header_webmd.cfm">
			</cfcase>
			<cfcase value="7">
				<cfinclude template="header_abcrx.cfm">
			</cfcase>
			<cfcase value="8">
				<cfinclude template="header_aarp.cfm">	
			</cfcase>
			<cfcase value="9">
				<cfinclude template="header_pparx.cfm">	
			</cfcase>
			<cfcase value="10">
				<cfinclude template="header_ag.cfm">	
			</cfcase>
			<cfcase value="11">
				<cfinclude template="header_afc.cfm">	
			</cfcase>
			
			<cfcase value="12">
				<cfif  session.source_id GT 1>
					<cfinclude 
template="header_aoa.cfm">
				<cfelse>
					<cfinclude 
template="header_normal.cfm">
				</cfif>
	
			</cfcase>
			<cfcase value="13">
				<cfinclude template="header_il.cfm">
			</cfcase>
			<cfcase value="14">
				<cfinclude template="header_mmm.cfm">
			</cfcase>
			<cfcase value="15">
				<cfinclude template="header_mmm.cfm">
			</cfcase>
			<cfcase value="16">
				<cfif session.source_id GT 1>
					<cfinclude 
template="header_can.cfm">
				<cfelse>
					<cfinclude 
template="header_normal.cfm">
				</cfif>
			</cfcase>
			<cfcase value="17">
				<cfinclude template="header_kaiser.cfm">
			</cfcase>
			<cfcase value="18">
				<cfinclude template="header_naacp.cfm">
			</cfcase>
			<cfcase value="19">
					<cfinclude 
template="header_liscenter.cfm">
			</cfcase>
			<cfcase value="21">
				<cfinclude 
template="header_liscenter.cfm">
			</cfcase>
			<cfcase value="22">
				<cfinclude template="header_aarp2.cfm">
			</cfcase>
			<cfcase value="80">
				<cfinclude template="header_care.cfm">
			</cfcase>
			<cfdefaultcase>
			
				<cfinclude template="header_normal.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfif>

</cfif>

<!--- cfif not application.debug> --->

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? 
"https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + 
"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>

<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-2674020-2");
pageTracker._setDomainName(".benefitscheckup.org");
pageTracker._trackPageview();
} catch(err) {}

try {
var pageTracker2 = _gat._getTracker("UA-3271369-18");
pageTracker2._setDomainName(".benefitscheckup.org");
pageTracker2._trackPageview();
} catch(err) {}
</script>

<!--- </cfif> --->
