<cfparam name="id" type="numeric" default="0">
<cfparam name="tgt" type="any" default="">
<cfparam name="noref" type="numeric" default="0">
<cfparam name="oe" type="numeric" default="0">
<cfparam name="tgtPartner" default="">

<cf_sessionLoadVars>

<cfif id eq 0>
	<cf_tagHeader guts="form_redirect.cfm">
	<!--- Open Main Table --->
	<TABLE cellSpacing="0" cellPadding="10" width="100%" align="center" border="0">
		<TR>
			<TD bgColor="#ffffff" align="center"><font size="4" face="Arial,Helvetica,Verdana"><b>
				We're sorry, but that does not appear to be a valid link.
			</b></font></td>
		</tr>
	</table>
	<cf_tagFooter>
<cfelse>

		<cfif Not IsDefined('session.screening_id') Or session.screening_id eq '' Or Not IsNumeric(session.screening_id)>
			<cfset lsScreeningID = 'NULL'>
		<cfelse>
			<cfset lsScreeningID = session.screening_id>
		</cfif>
		<cfif session.prev_id eq '' Or Not IsNumeric(session.prev_id)>
			<cfset lsPrevScreeningID = 'NULL'>
		<cfelse>
			<cfset lsPrevScreeningID = session.prev_id>
		</cfif>
		<cfif session.source_id eq '' Or Not IsNumeric(session.source_id)>
			<cfset lsSourceID = 'NULL'>
		<cfelse>
			<cfset lsSourceID = session.source_id>
		</cfif>
		<cfif session.org_id eq '' Or Not IsNumeric(session.org_id)>
			<cfset lsOrgID = 'NULL'>
		<cfelse>
			<cfset lsOrgID = session.org_id>
		</cfif>
		<cfif isdefined('tgtOrg_id') and tgtOrg_id neq ''>
			<cfset lsOrgID = tgtOrg_id>
		</cfif>
		<cfif session.partner_id eq '' Or Not IsNumeric(session.partner_id)>
			<cfset lsPartnerID = 'NULL'>
		<cfelse><cfoutput>#session.partner_id#</cfoutput><br />
			<cfset lsPartnerID = session.partner_id>
		</cfif>
		<cfif session.subset_id eq '' Or Not IsNumeric(session.subset_id)>
			<cfset lsSubsetID = 'NULL'>
		<cfelse>
			<cfset lsSubsetID = session.subset_id>
		</cfif>
		<cfif session.language_id eq '' Or session.language_id eq 'NULL'>
			<cfset lsLanguageID = 'NULL'>
		<cfelse>
			<cfset lsLanguageID = "'#session.language_id#'">
		</cfif>
		<cfif session.access_id eq '' Or Not IsNumeric(session.access_id)>
			<cfset lsAccessID = 'NULL'>
		<cfelse>
			<cfset lsAccessID = session.access_id>
		</cfif>
		<cfif session.client_id eq '' Or Not IsNumeric(session.client_id)>
			<cfset lsClientID = 'NULL'>
		<cfelse>
			<cfset lsClientID = session.client_id>
		</cfif>
		<cfif session.user_id eq '' Or Not IsNumeric(session.user_id)>
			<cfset lsUserID = 'NULL'>
		<cfelse>
			<cfset lsUserID = session.user_id>
		</cfif>
		<cfif session.state_id eq '' Or session.state_id eq 'NULL'>
			<cfset lsPresetStateID = 'NULL'>
		<cfelse>
			<cfset lsPresetStateID = "'#session.state_id#'">
		</cfif>
		<cfif session.test_id eq '' Or Not IsNumeric(session.test_id)>
			<cfset lsTestID = 'NULL'>
		<cfelse>
			<cfset lsTestID = session.test_id>
		</cfif>
		
		<cfif tgtPartner GT 0>
			<cfset lsPartnerID = tgtPartner>
		</cfif>

	<cfif IsDefined('session.click') and session.click.id eq id and DateDiff('s', session.click.timestamp, Now()) lte 45>
		<cfset session.click.count = session.click.count + 1>
	<cfelse>
		<cfquery name="logClick" datasource="#application.dbSrc#">
			INSERT INTO click 
				(url_id, form_id, screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, language_id,
					access_id, oe_client_id, oe_user_id, preset_state_id, test_flag, target_flag, form_target, oe_flag, click_datetime)
			VALUES
				(0,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#id#" maxlength="4">, 
				#lsScreeningID#, 
				#lsPrevScreeningID#, 
				#session.cfid#, 
				#session.cftoken#, 
				#lsSourceID#, 
				#lsOrgID#,
				#lsPartnerID#, 
				#lsSubsetID#, 
				#PreserveSingleQuotes(lsLanguageID)#, 
				#lsAccessID#, 
				#lsClientID#, 
				#lsUserID#,
				#PreserveSingleQuotes(lsPresetStateID)#, 
				#lsTestID#, 
				0,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#tgt#" maxlength="250">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#oe#" maxlength="4">,
				#CreateODBCDateTime(Now())#
				
				)
		</cfquery>
		<cfset session.click = StructNew()>
		<cfset session.click.id = id>
		<cfset session.click.timestamp = Now()>
		<cfset session.click.count = 1>
	</cfif>

	<cflocation url="#tgt#" addtoken="no">
</cfif>