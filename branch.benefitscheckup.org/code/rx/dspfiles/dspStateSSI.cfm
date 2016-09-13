<cfinclude template="qryStateSSI.cfm">

<!-- display AutoEnroll  -->
<cfoutput query="qryStateSSI" >
	<CFIF listcontains( #prg_list#, "#prg_id#") >
		<cfif mode eq "Summary">
			<li>Apply for #prg_nm#  (SSI) which can offer you additional cash assistance beyond the Federal SSI amount. </li>
		<cfelse>
			<cfset RxPrgList = #ListAppend(RxPrgList, "#prg_id#", ",")# >
			<p>
				<li>
					Apply for #prg_nm# (SSI), which can offer you additional cash assistance beyond the Federal SSI program.
				</li>
			</p>
			<cfset prg_id = "#prg_id#">
			<cfinclude template="../dspLinks.cfm">
		</cfif>
	</CFIF>
</cfoutput>



