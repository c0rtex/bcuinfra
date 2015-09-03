<!--Display LIS Recommendations Info -->
<cfif session.subset_id eq 14 >
	<CFIF listcontains( #prg_list#, "103-311-2593-FD-FD") >
		<cfif mode eq "Summary">
			<li>You may be eligible for Medicare Prescription Drug Coverage for People with Limited Incomes and Resources.</li>
		<cfelse>
			<cfset RxPrgList = #ListAppend(RxPrgList, "103-311-2593-FD-FD", ",")# >
			<li>
			You may be eligible for Medicare Prescription Drug Coverage for People with Limited Incomes and Resources.  We will provide necessary information about the program and what steps they need to take to enroll in a Medicare Prescription Drug Plan. Click <a href="frmDetails.cfm?prg_id=103-311-2593-FD-FD">here</a> for details. 
			</li>
		</cfif>
	<CFELSEIF listcontains( #prg_list#, "129-311-2703-FD-FD") >
		<cfif mode eq "Summary">
			<li>You may be eligible for Medicare Prescription Drug Coverage for People with Medicare Savings Programs.</li>
		<cfelse>
			<cfset RxPrgList = #ListAppend(RxPrgList, "129-311-2703-FD-FD", ",")# >
			<li>
			This program is for individuals who will automatically be deemed eligible for LIS because they are currently receiving Medicaid, SSI, or a Medicare Savings Program.  We will provide necessary information about the program and what steps they need to take to enroll in a Medicare Prescription Drug Plan. Click <a href="frmDetails.cfm?prg_id=129-311-2703-FD-FD">here</a> for details.
			</li>
		</cfif>
	<CFELSEIF listcontains( #prg_list#, "129-311-2702-FD-FD") >
		<cfif mode eq "Summary">
			<li>You may be eligible for Medicare Prescription Drug Coverage for People with SSI.</li>
		<cfelse>
			<cfset RxPrgList = #ListAppend(RxPrgList, "129-311-2702-FD-FD", ",")# >
			<li>
			This program is for individuals who will automatically be deemed eligible for LIS because they are currently receiving Medicaid, SSI, or a Medicare Savings Program.  We will provide necessary information about the program and what steps they need to take to enroll in a Medicare Prescription Drug Plan. Click <a href="frmDetails.cfm?prg_id=129-311-2702-FD-FD">here</a> for details.
			</li>
		</cfif>
	<CFELSEIF listcontains( #prg_list#, "129-311-2702-FD-FD") >
		<cfif mode eq "Summary">
			<li>You may be eligible for Medicare Prescription Drug Coverage for People with SSI.</li>
		<cfelse>
			<cfset RxPrgList = #ListAppend(RxPrgList, "129-311-27", ",")# >
			<li>
			This program is for individuals who will automatically be deemed eligible for LIS because they are currently receiving Medicaid, SSI, or a Medicare Savings Program.  We will provide necessary information about the program and what steps they need to take to enroll in a Medicare Prescription Drug Plan. Click <a href="frmDetails.cfm?prg_id=129-311-2702-FD-FD">here</a> for details.
			</li>
		</cfif>
	</CFIF>
</cfif>