<CFSET TEMPLATE = 'LIS'>
<CFSET TYPE="">
<CFSET session.getLIS = "">
<!-- applied for lis benefit  -->
<cfif isdefined('session.lis_apply') and session.lis_apply eq 'y'>
		<CFSET benefit = 3 >
		<CFSET TYPE='receiving'>	
	<cfif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >
		<CFSET answerfield = 'rec_tricare'>	
		<CFSET session.getLIS = "No">			
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >
		<CFSET answerfield = 'receive_champva'>			
		<CFSET session.getLIS = "No">		
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >
		<CFSET answerfield = 'receive_fehbp'>		
		<CFSET session.getLIS = "No">		
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >
		<CFSET answerfield = 'receive_va'>	
		<CFSET session.getLIS = "No">			
	</cfif>
<!-- eligible for lis benefit -->	
<cfelseif findnocase( "103-311-2593-FD-FD", #prg_list#) gt 0 >
		<CFSET benefit = 2 >
		<CFSET TYPE='eligible'>	
	<cfif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >
		<CFSET answerfield = 'rec_tricare'>
		<CFSET session.getLIS = "No">				
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >
		<CFSET answerfield = 'receive_champva'>	
		<CFSET session.getLIS = "No">				
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >
		<CFSET answerfield = 'receive_fehbp'>		
		<CFSET session.getLIS = "No">			
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >
		<CFSET answerfield = 'receive_va'>	
		<CFSET session.getLIS = "No">			
	</cfif>
<!-- eligible for non lis benefit -->
<cfelseif findnocase( "103-311-2588-FD-FD", #prg_list#) gt 0 >
	<CFSET benefit = 1 >
		<CFSET TYPE='eligible'>	
	<cfif isdefined('session.rec_tricare') and   session.rec_tricare eq 'y' >
		<CFSET answerfield = 'rec_tricare'>		
		<CFSET session.getLIS = "No">		
	<cfelseif isdefined('session.receive_champva') and  session.receive_champva eq 'y' >
		<CFSET answerfield = 'receive_champva'>		
		<CFSET session.getLIS = "No">			
	<cfelseif isdefined('session.receive_fehbp') and  session.receive_fehbp eq 'y' >
		<CFSET answerfield = 'receive_fehbp'>	
		<CFSET session.getLIS = "No">				
	<cfelseif isdefined('session.receive_va') and   session.receive_va eq 'y' >
		<CFSET answerfield = 'receive_va'>		
		<CFSET session.getLIS = "No">		
	</cfif>
</cfif>

<cfif type neq 'NA' and isdefined('answerfield') >
<!-- Get content from db-->
<cfquery name="qryLIS" datasource="#session.datasrc#">
	SELECT      pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'LIS' and pt.benefit =<cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
	and answerfield = <cfqueryparam 
                        value="#answerfield#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25"> 
</cfquery>

<cfif isdefined('TYPE')>
<!-- OUTPUT RESULTS-->
<cfloop  query="qryLIS" startrow="1" endrow="1" >
<cfif mode eq "Summary">
		<li>
			<cfoutput>#Summary#</cfoutput>
		</li>

<cfelse>
	<cfinclude template="../dspOtherOptions.cfm">
		<cfset rec = "#qryLIS.rec#">
		<cfset actions = "#qryLIS.actions#">
		<cfif len('actions') gt 0 ><cfset result = #arrayAppend(arrayActions, "#actions#")#></cfif>
		<!---<cfset programNameText = "#prg_nm#">
		<cfset rec1 = #replace(rec,'{prg_nm}',programNameText,"all")# >
		<cfset rec2 = #replace(rec1,'prg_nm',programNameText,"all")# > --->
		<p>
			<li>
			<!--- Recommendation ---->
			<cfoutput>#rec#  </cfoutput>
			<!-- OTHER NOTES -->
			<cfif  session.receive_section_8 eq 'y' >
				<CFSET answerfield2 = 'receive_section_8'>		
			<cfelseif  session.receive_pub_housing eq 'y' >
				<CFSET answerfield2 = 'receive_pub_housing'>		
			<cfelseif  session.fdstmp_receive eq 'y' >
				<CFSET answerfield2 = 'fdstmp_receive'>
			<cfelseif  session.receive_hopwa eq 'y' >
				<CFSET answerfield2 = 'receive_hopwa'>
			<cfelse>
				<CFSET answerfield2 = ''>
			</cfif>
			<CFSET Keys.type = type >
			<CFSET Keys.template = 'LISKEYS' >
			<CFSET Keys.benefit = benefit>
			<CFSET Keys.answerfield = answerfield >
			<CFSET Keys.answerfield2 = answerfield2>
			<cfquery name="qryLISNOTES" datasource="#session.datasrc#">
				SELECT      pt.summary, pt.rec, pt.type, pt.benefit
				FROM        programtext pt
				WHERE     
				pt.template = 'LISNOTE' 
				and benefit =<cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
				and 
				(
				answerfield = <cfqueryparam 
                        value="#answerfield#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="50">
				or answerfield = <cfqueryparam 
                        value="#answerfield2#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="50">
				)
			</cfquery>
			<!-- EVEN MORE NOTES -->
			<cfoutput  query="qryLISNOTES"><br><br>#rec#<br></cfoutput>
			</li>
<cfif isdefined('applynow') and applynow eq 'y' and session.subset_id neq 14>
<br><br>
<table><tr><td width="140" valign=top>
<cf_displayLISPopup>
</td><td  valign=top>
Apply for extra help available through Medicare's Prescription Drug Coverage.
</td>
</tr>
</table>
<cfelse>
<br>
</cfif>
<br>
	<cfif benefit neq 3 and subset_id neq 14>
		<cfinclude template="../dspLinks.cfm">
	</cfif>
</p>
</cfif>
</cfloop>
</cfif>
</cfif>