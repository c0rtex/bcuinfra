<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.rightcol" type="string" default="">
<cfparam name="attributes.footer" type="string" default="">
<cfparam name="attributes.showmenu" type="string" default="1">

<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.subset_id') and session.subset_id neq '' and IsNumeric(session.subset_id)>
		<cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="sobj">
		<cfset attributes.partner_id = sobj.brand>
	</cfif>
</cfif>
<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.partner_id') and session.partner_id neq '' and IsNumeric(session.partner_id)>
		<cfset attributes.partner_id = session.partner_id>
	<cfelse>
		<cfset attributes.partner_id = 0>
		<cfset session.partner_id = 0>
	</cfif>
</cfif>
<cf_cacheWrapperQuery query="wrapper" partner_id="#attributes.partner_id#">

<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>

<cfif Find("index.cfm", BasePath) gt 0>
	<cfset AddBanner = "Yes">
<cfelseif Find("before_you_start.cfm", BasePath) gt 0>
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset AddBanner="No">
</cfif>

<cfset partner_id = attributes.partner_id>
<cfinclude template="tagCobrandValues.cfm">

<!---footer --->
<cfoutput>
<script language="JavaScript">
<!--
function openComment() {
    url = "http://beta.benefitscheckup.org/cso/contact/form.jsp?src=#session.feedbacksrc#";
    window.open(url, "comment", "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=640,height=420");
}
// -->
</script>
</cfoutput>
<!--- choose footer  --->
<cfif wrapper.wrapper_footer IS NOT 'footer_normal.cfm' AND wrapper.wrapper_footer IS NOT ''>
	<cfif session.subset_id eq 41 OR session.subset_id eq 40>
		<cfinclude template="footer_liscenter_hs.cfm">
	<cfelse>
		<cfinclude template="#wrapper.wrapper_footer#">
	</cfif>
<cfelse>

	<cfif IsDefined('session.subset_id') and (session.subset_id eq 41 or session.subset_id eq 40)>
				<cfinclude template="footer_liscenter.cfm">
	<cfelseif wrapper.wrapper_header IS "">				
	<cfelse>
		<cfswitch expression="#attributes.partner_id#">
			<cfcase value="5">
				<cfinclude template="footer_ltcc.cfm">
			</cfcase>
			<cfcase value="6">
				<cfinclude template="footer_webmd.cfm">
			</cfcase>
			<cfcase value="7">
				<cfinclude template="footer_abcrx.cfm">
			</cfcase>
			<cfcase value="8">
				<cfinclude template="footer_aarp.cfm">
			</cfcase>
			<cfcase value="9">
				<cfinclude template="footer_pparx.cfm">
			</cfcase>
			<cfcase value="10">
				<!cfinclude template="footer_ag.cfm">
			</cfcase>
			<cfcase value="11">
				<cfinclude template="footer_afc.cfm">		
			</cfcase>
			<cfcase value="12">
				<cfif  session.source_id GT 1>
					<cfinclude template="footer_aoa.cfm">
				<cfelse>
					<cfinclude template="footer_normal.cfm">
				</cfif>
			</cfcase>
			<cfcase value="13">
				<cfinclude template="footer_il.cfm">
			</cfcase>
			<cfcase value="14">
				<cfinclude template="footer_mmm.cfm">
			</cfcase>
			<cfcase value="15">
				<cfinclude template="footer_mmm.cfm">
			</cfcase>
			<cfcase value="16">
				<cfif session.source_id GT 1>
					<cfinclude template="footer_can.cfm">
				<cfelse>
					<cfinclude template="footer_normal.cfm">
				</cfif>
			</cfcase>
			<cfcase value="17">
				<cfinclude template="footer_kaiser.cfm">
			</cfcase>
			<cfcase value="18">
				<cfinclude template="footer_naacp.cfm">
			</cfcase>
			<cfcase value="19">
					<cfinclude template="footer_liscenter.cfm">
			</cfcase>
			<cfcase value="21">
				<cfinclude template="footer_liscenter.cfm">
			</cfcase>
			<cfcase value="22">
				<cfinclude template="footer_aarp2.cfm">
			</cfcase>
			<cfcase value="80">
				<cfinclude template="footer_care.cfm">
			</cfcase>
			<cfcase value="86">
				<cfinclude template="footer_wordpress.cfm">
			</cfcase>
			<cfcase value="100">
				<cfinclude template="footer_wordpress.cfm">
			</cfcase>
			
			<cfdefaultcase>
				<cfinclude template="footer_normal.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfif>
</cfif>

<cfif findnocase('bcudebug', cgi.query_string) GT 0>
<cfoutput>
<h3>Server Debug Information</h3>
<p>Server Name: #cgi.server_name#</p>
<p>Document Root: #cgi.PATH_TRANSLATED#/p>
</cfoutput>
</cfif>
<!-- Piwik -->
<!--- COMMENTING OUT THIS CODE FOR NOW
<script type="text/javascript">
var pkBaseURL = (("https:" == document.location.protocol) ? "https://64.236.110.194/stats/" : "https://64.236.110.194/stats/");
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
</script><script type="text/javascript">
try {
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</script><noscript><p><img src="https://64.236.110.194/stats/piwik.php?idsite=1" style="border:0" alt=""/></p></noscript>
--->
<!-- End Piwik Tag --> 

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-2674020-5");
pageTracker._setDomainName(".benefitscheckup.org");
pageTracker._trackPageview();
} catch(err) {}</script>


</body>
</html>
