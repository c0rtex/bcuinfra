<!--- Display if VA ELIGIBLE  --- 105-309-1034-FD-FD --->
<cfset TEMPLATE = 'VA'>
<cfset TYPE="">
<cfset answerfield = "">
<cfif isdefined('session.rec_tricare') and session.rec_tricare eq 'y'  >
	<cfset answerfield = 'rec_tricare'>
	<cfset TYPE='receiving'>
<cfelseif isdefined('session.receive_va') and session.receive_va eq 'y'  >
	<cfset answerfield = 'receive_va'>
	<cfset TYPE='receiving'>
<cfelseif listcontains( #prg_list#, "129-309-2591-FD-FD") >
	<cfset PRG_ID = '129-309-2591-FD-FD'>
	<cfset TYPE='ELIGIBLE'>
	<cfif mode eq "Summary">
		<cfset RxPrgList = #ListAppend(RxPrgList, "129-309-2591-FD-FD", ",")# >
	</cfif>
<cfelseif listcontains( #prg_list#, "105-309-1034-FD-FD") >
	<cfif mode eq "Summary">
		<cfset RxPrgList = #ListAppend(RxPrgList, "105-309-1034-FD-FD", ",")# >
	</cfif>
	<cfset PRG_ID = '105-309-1034-FD-FD'>
	<cfset TYPE='ELIGIBLE'>
</cfif>

<cfif isdefined('TYPE')>
	<cfif findnocase( "103-311-2593-FD-FD", #prg_list#) gt 0 >
		<cfset lisbenefit = 2 >
	<cfelse>
		<cfset lisbenefit = 0 >
	</cfif>
	<!--- Get content from db--->
	<cfquery name="qryVA" datasource="#application.dbSrc#">
		SELECT      pt.summary, pt.rec, pt.type, pt.benefit
		FROM        programtext pt
		WHERE     	pt.type = <cfqueryparam 
                        value="#type#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="50">
		and pt.template = 'VA' 
		AND benefit = <cfqueryparam 
                        value="#lisbenefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
		<cfif TYPE neq 'ELIGIBLE'>
		AND answerfield = <cfqueryparam 
                        value="#answerfield#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="50">
		</cfif>
	</cfquery>
	
	<!--- OUTPUT RESULTS--->
	<cfloop  query="qryVA" startrow="1" endrow="1" >
		<cfif mode eq "Summary">
			<cfif session.subset_id neq 14>
					<li>
						<cfoutput>#Summary#</cfoutput>
					</li>
			</cfif>
		<cfelse>
			<cfinclude template="../dspOtherOptions.cfm">
			<cfset rec = "#qryVA.rec#">
			<!---<cfset programNameText = "#prg_nm#">
			<cfset rec1 = #replace(rec,'{prg_nm}',programNameText,"all")# >
			<cfset rec2 = #replace(rec1,'prg_nm',programNameText,"all")# > --->
				<li>
					<cfoutput>#rec#</cfoutput>
				</li>
			<cfif TYPE eq 'ELIGIBLE'>
				<cfinclude template="../dspLinks.cfm">
			</cfif>
		</cfif>
	</cfloop>
</cfif>