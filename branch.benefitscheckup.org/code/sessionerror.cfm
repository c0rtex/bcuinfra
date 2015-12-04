<!----=======================================
DESCRIPTION: 		gets called when there is an error caught, 
					displays message to user, and sends error info to text file
CALLED BY: Application.cfm (if the error handling is turned on)
GOES TO: N/A
REQUIRED: N/A
LAST UPDATED BY:  David Dring - 020510
============================================---->

<cfparam name="sesssion.cfid" default="0">
<cfparam name="sesssion.cftoken" default="0">

<cfparam name="cfid" default="#sesssion.cfid#">
<cfparam name="cftoken" default="#sesssion.cftoken#">

<cfquery name="findOldSession" datasource="#application.dbSrc#">
		SELECT * FROM screening WHERE cfid = <cfqueryparam cfsqltype="cf_sql_integer" value="#cfid#" maxlength="10"> AND cftoken =<cfqueryparam cfsqltype="cf_sql_integer" value="#cftoken#" maxlength="10"> ORDER BY start_datetime DESC
</cfquery>

<cfset partner_id = val(findOldSession.partner_id)>
<cfset org_id = val(findOldSession.org_id)>
<cfset session.partner_id = val(findOldSession.partner_id)>
<cfset session.org_id = val(findOldSession.org_id)>

<!cf_sessionLoadVars>

<script language="JavaScript1.1">
<!--
function openMain() {
		setTimeout('window.close()', 1000);
		window.open('/cso/servlet/Menu', 'main');
		main.focus();
}

function exitQuestionnaire() {
	if (document.layers) {
		if (window.opener.closed) {
			setTimeout('window.close()', 1000);
			window.open('/cso/servlet/Menu', 'main');
			main.focus();
		} else {
			window.opener.focus();
			window.close();
		}
	} else {
		window.onerror = openMain;
		if (!(window.opener.closed)) {
			window.opener.focus();
			window.close();
		}
	}
}
// -->
</script>
<cfif (IsDefined('session.saveqs'))>
	<cfset saveqs = "#session.saveqs#">
</cfif>
<cfif (not IsDefined('saveqs')) or saveqs eq "">
	<cfset savedIt = False>
	<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
		<cfset repeatURL = "frmwelcome2.cfm">
	<cfelse>
		<cfset repeatURL = "index.cfm">
	</cfif>
	<cfset exitURL = "frmgoodbye.cfm">
<cfelse>
	<cfset savedIt = True>
	<cfset repeatURL = "frmwelcome2.cfm?#session.saveqs#">
	<cfset exitURL = "javascript:exitQuestionnaire()">
</cfif>

<cf_tagHeader>
<CFIF IsDefined('Attributes.Page')>
	<CFSWITCH Expression=#Attributes.Page#>
		<CFCASE value="index">
			<CFSET Title="BenefitsCheckUp From NCOA">
			<CFSET AddBanner = "Yes">
		</CFCASE>
		<CFCASE value="before_you_start">
			<CFSET Title="BenefitsCheckUp From NCOA">
			<CFSET AddBanner = "Yes">
		</CFCASE>
	</CFSWITCH>
<CFELSE>
	<CFSET Title="BenefitsCheckUp From NCOA">
	<CFSET AddBanner="No">
</CFIF>

<!--- Table 3 Open: main body table --->
<table width=100% border="0" align="center" cellpadding=5 cellspacing=2>
	<TBODY>
     <tr>
	  <td bgcolor=#FFFFFF colspan=2>
      <!--- Message to Users --->
	  		<font size="4" face="arial" color="#000000"><br>
      		<p>We're sorry, but your eligibility report is no longer available, probably because you started a new questionnaire after generating your results.  We sincerely apologize for this inconvenience.  Please click the link below to start over again.</p>

   			<p><cfif savedIt><cfoutput><a href="#repeatURL#" target="_top">Restart the questionnaire</a></cfoutput><cfelse><cf_sessionPassVars href="#repeatURL#" target="_top">Restart the questionnaire</cf_sessionPassVars></cfif></p>
			</FONT>

</TD></TR></TBODY></TABLE>
<!--- Table 3 Close --->

<cf_tagFooter>

</BODY></HTML>