<cfparam name="id" type="numeric" default="0">
<cfparam name="tgt" type="numeric" default="0">
<cfparam name="noref" type="numeric" default="0">
<cfparam name="oe" type="numeric" default="0">
<cfparam name="article_id" type="numeric" default="0">
<cfparam name="partner_id" type="numeric" default="0">
<cfparam name="screeningID" type="numeric" default="0">
<cfparam name="visible" type="boolean" default="true"> 
<cfparam name="request_id" type="string" default=""> 
<cfparam name="shadowID" type="string" default=""> 
<!---<cf_sessionLoadVars>--->
<cfif visible>
	<cf_tagHeader guts="redirect.cfm">
</cfif>
<cfif id eq 0>
	<!---<cf_tagHeader guts="redirect.cfm">--->
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
	<cfquery name="urlinfo" datasource="#application.dbSrc#">
		SELECT p.protocol, u.url, u.active_flag
		FROM url u LEFT OUTER JOIN protocol p
			ON u.protocol_id=p.protocol_id
		WHERE u.url_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#id#" maxlength="4">
	</cfquery>
	<cfif urlinfo.RecordCount eq 0 Or urlinfo.active_flag eq 0>
		<!---<cf_tagHeader guts="redirect.cfm">--->
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
		<cfif Not IsDefined('session.prev_id') Or session.prev_id eq '' Or Not IsNumeric(session.prev_id)>
			<cfset lsPrevScreeningID = 'NULL'>
		<cfelse>
			<cfset lsPrevScreeningID = session.prev_id>
		</cfif>
		<cfif Not IsDefined('session.source_id') Or session.source_id eq '' Or Not IsNumeric(session.source_id)>
			<cfset lsSourceID = 'NULL'>
		<cfelse>
			<cfset lsSourceID = session.source_id>
		</cfif>
		<cfif Not IsDefined('session.org_id') Or session.org_id eq '' Or Not IsNumeric(session.org_id)>
			<cfset lsOrgID = 'NULL'>
		<cfelse>
			<cfset lsOrgID = session.org_id>
		</cfif>
		<cfif Not IsDefined('session.partner_id') Or session.partner_id eq '' Or Not IsNumeric(session.partner_id)>
			<cfset lsPartnerID = 'NULL'>
		<cfelse>
			<cfset lsPartnerID = session.partner_id>
		</cfif>
                <cfif Not IsDefined('session.screeningID') Or session.screeningID eq '' Or Not IsNumeric(session.screeningID)>
			<cfset lsScreeningID = 'NULL'>
		<cfelse>
			<cfset lsScreeningID = session.screeningID>
		</cfif>
		<cfif Not IsDefined('session.subset_id') Or session.subset_id eq '' Or Not IsNumeric(session.subset_id)>
			<cfset lsSubsetID = 'NULL'>
		<cfelse>
			<cfset lsSubsetID = session.subset_id>
		</cfif>
		<cfif Not IsDefined('session.language_id') Or session.language_id eq '' Or session.language_id eq 'NULL'>
			<cfset lsLanguageID = 'NULL'>
		<cfelse>
			<cfset lsLanguageID = "'#session.language_id#'">
		</cfif>
		<cfif Not IsDefined('session.access_id') Or session.access_id eq '' Or Not IsNumeric(session.access_id)>
			<cfset lsAccessID = 'NULL'>
		<cfelse>
			<cfset lsAccessID = session.access_id>
		</cfif>
		<cfif Not IsDefined('session.client_id') Or session.client_id eq '' Or Not IsNumeric(session.client_id)>
			<cfset lsClientID = 'NULL'>
		<cfelse>
			<cfset lsClientID = session.client_id>
		</cfif>
		<cfif Not IsDefined('session.user_id') Or session.user_id eq '' Or Not IsNumeric(session.user_id)>
			<cfset lsUserID = 'NULL'>
		<cfelse>
			<cfset lsUserID = session.user_id>
		</cfif>
		<cfif Not IsDefined('session.state_id') Or session.state_id eq '' Or session.state_id eq 'NULL'>
			<cfset lsPresetStateID = 'NULL'>
		<cfelse>
			<cfset lsPresetStateID = "'#session.state_id#'">
		</cfif>
		<cfif Not IsDefined('session.test_id') Or session.test_id eq '' Or Not IsNumeric(session.test_id)>
			<cfset lsTestID = 'NULL'>
		<cfelse>
			<cfset lsTestID = session.test_id>
		</cfif>
		<cfif IsDefined('session.click') and session.click.id eq id and DateDiff('s', session.click.timestamp, Now()) lte 45>
			<cfset session.click.count = session.click.count + 1>
		<cfelse>
			<cfquery name="logClick" datasource="#application.dbSrc#">
				INSERT INTO click 
					(url_id, screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, language_id,
						access_id, oe_client_id, oe_user_id, preset_state_id, test_flag, target_flag, oe_flag, click_datetime)
				VALUES
					(
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
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tgt#" maxlength="4">, 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#oe#" maxlength="4">, 
					#CreateODBCDateTime(Now())#)
			</cfquery>
			<cfset session.click = StructNew()>
			<cfset session.click.id = id>
			<cfset session.click.timestamp = Now()>
			<cfset session.click.count = 1>
		</cfif>
		<cfif urlinfo.protocol eq ''>
			<cfif findnocase('-contact',urlinfo.url) gt 0>
			   <cfset newURL = urlinfo.url >
			<cfelse>
			   <cf_sessionPassVars href="#urlinfo.url#" var="newURL">
			</cfif>
			<cfif request_id neq ''>
				<cfif findnocase('?',newURL) gt 0>
				 <cfset newURL = newURL & '&' & 'request_id=' & request_id >
				<cfelse>
				 <cfset newURL = newURL & '?' & 'request_id=' & request_id >
				</cfif>
			</cfif>
			<cfif screeningID neq ''>
				<cfif findnocase('?',newURL) gt 0>
				 <cfset newURL = newURL & '&' & 'screeningID=' & screeningID >
				<cfelse>
				 <cfset newURL = newURL & '?' & 'screeningID=' & screeningID >
				</cfif>
			</cfif>
			<cfif shadowID neq ''>
				<cfif findnocase('?',newURL) gt 0>
				 <cfset newURL = newURL & '&' & 'shadowID=' & shadowID >
				<cfelse>
				 <cfset newURL = newURL & '?' & 'shadowID=' & shadowID >
				</cfif>
			</cfif>
			<!---<cfoutput>
			<h2>Temporary Debugging Trap</h2>
			Please click below to continue to your destination URL:<br><br>
			<a href="#newURL#">#newURL#</a>
			</cfoutput>--->
			<!--- SE Temporily redirect link id 9--->
			<!---cfif id eq 9--->
				<!---cfset newURL = replaceNoCase(newURL,'dispatch.cfm','liscenter/index.cfm','ALL')--->
			<!---cfif--->
			<cflocation url="#Trim(newURL)#">
		<cfelseif noref eq 1>
			<cfset newURL = urlinfo.protocol & '://' & urlinfo.url>
			<cflocation url="#Trim(newURL)#" addtoken="no">
		<cfelse>
			<cfset newURL = urlinfo.protocol & '://' & urlinfo.url>
			<cfif article_id IS NOT 0>
				<cfset newURL = "#Trim(newUrl)#?article_id=#article_id#">
			</cfif>

	

			<cfif visible>
				<cfoutput><meta http-equiv="refresh" content="5; url=#Trim(newURL)#"></cfoutput>
           	<cfelse>
            	<cfoutput><meta http-equiv="refresh" content="0; url=#Trim(newURL)#"></cfoutput>
            </cfif>
			<!---cf_tagHeader refreshurl="#newURL#" refreshsec="5" guts="redirect.cfm"--->
			<!--- Open Main Table --->
			<cfif visible>
            <TABLE cellSpacing="0" cellPadding="10" width="700" align="center" border="0">
				<TR>
					<TD bgColor="#ffffff" align="center"><font size="4" face="Arial,Helvetica,Verdana"><b>
						In a moment, you will be redirected away from<br>
						<cfif session.partner_id eq 22>AARP Benefits QuickLINK<cfelse>BenefitsCheckUp.org</cfif> to a different Web site.<br><br>
						<font size="3">If the new page does not begin loading within 5 seconds,<br>
						please <cfoutput><a href="#newURL#">click here</a></cfoutput> to continue.</font>
					</b></font></td>
				</tr>
			</table>
			<cf_tagFooter>
            </cfif>
		</cfif>
	</cfif>
</cfif>
