<cfparam name="src" default="">
<cfparam name="goto" default="">
<cf_tagHeader>
<table width=100% border="0" align="center" cellpadding="12" cellspacing="2">
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">
<FONT face="Arial"><FONT SIZE=+2><B>Starting a New Screening </B></FONT>
<hr>
	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'ec'>
		<cf_buttons goText="Back to Application Forms Center" goURL="javascript:history.go(-1)">
		<br>
	<cfelseif src neq 'frame'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	</cfif>
</font><p><font face="Arial">By clicking the link below you will be starting a new questionnaire. Once you start the <cfif goto eq 'pap'>Patient Assistance Program<cfelse>Medicare Card Finder</cfif> screening, you will not be able to return to your Recommendations page for the current screening. To print your recommendations before continuing, click the &quot;Back to Recommendations&quot; button above. </font></p>

<cfif goto eq 'Card'>
	<cfif isdefined('session.client_id') and session.client_id neq "NULL">
		<cf_sessionPassVars href="before_you_start.cfm"  extralist="preserve=true" partner_id="12" subset_id="12" client_id="#session.client_id#" >Start the Medicare Card Finder Screening</cf_sessionPassVars>
	<cfelseif isdefined('session.org_id') and session.org_id gt 0>
		<cf_sessionPassVars href="before_you_start.cfm"  extralist="preserve=true" partner_id="12" subset_id="12" client_id="#session.client_id#" >Start the Medicare Card Finder Screening</cf_sessionPassVars>	
	<cfelse>
		<cf_sessionPassVars href="startover.cfm"  extralist="preserve=true" partner_id="12" subset_id="12"  >Start the Medicare Card Finder Screening</cf_sessionPassVars>
	</cfif>  
<cfelseif goto eq 'PAP'>
	<cfif isdefined('session.client_id') and session.client_id neq "NULL">
		<cf_sessionPassVars href="before_you_start.cfm"  extralist="preserve=true" partner_id="12" subset_id="19" client_id="#session.client_id#" >Start the Patient Assistance Screening</cf_sessionPassVars>
	<cfelseif isdefined('session.org_id') and session.org_id gt 0>
		<cf_sessionPassVars href="before_you_start.cfm"  extralist="preserve=true" partner_id="12" subset_id="19" client_id="#session.client_id#" >Start the Patient Assistance Screening</cf_sessionPassVars>
	<cfelse>
		<cf_sessionPassVars href="startover.cfm"  extralist="preserve=true" partner_id="12" subset_id="19"  >Start the Patient Assistance Program Screening</cf_sessionPassVars>
	</cfif>
</cfif>

</td></tr></Table>
</td></tr></Table>
<cf_tagfooter>