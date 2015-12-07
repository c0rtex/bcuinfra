<cfif not isdefined('request.dontapply')>
	<cfset request.dontapply = "No">
</cfif>

<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	

<cfset source="recommendations">

<cfoutput>
	<div class="button_fact_sheet">
			<cfif session.partner_id neq 55>
				<cf_sessionPassVars href="#urlType#://#application.serverPathCanonical#/frmDetails.cfm" state_id="#session.st#" extralist="prg_id=#prg_id#,ReportType=#url.reporttype#,county=#session.county#,city=#session.city#,zip=#session.zip#">
				<img id="fact_sheet_gif" alt="View Fact Sheet" src="images/button_fact-sheet.gif" border=0>
				</cf_sessionPassVars>
			<cfelse>
				<a href="#urlType#://#application.serverPathCanonical#/frmDetails.cfm?prg_id=#prg_id#&CFID=#session.CFID#&CFTOKEN=#session.cftoken#&ReportType=#url.reporttype#&county=#session.county#&city=#session.city#&zip=#session.zip#"><img alt="View Fact Sheet" src="images/button_fact-sheet.gif" border=0></a>
			</cfif>
			
			<div class="read_more">
				<strong>Read more about this program</strong>
			</div>
	</div>
	
</cfoutput>

<cfif request.dontapply neq "Yes" >
<cfset formtype_id = "1">
<cfinclude template="../dsp_appforms.cfm">
<cfset formtype_id = "2">
<cfinclude template="../dsp_appforms.cfm">
<cfset formtype_id = "4">
<cfinclude template="../dsp_appforms.cfm">
</cfif>
<cfset request.dontapply = "No">