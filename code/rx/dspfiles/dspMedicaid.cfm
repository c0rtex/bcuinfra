<cfif #qryMedicaid.recordCount# gt 0 >

<cfif mode eq "Summary">
<li>

Apply for  <cfif session.st eq 'CA'>Medicaid/Medi-Cal<cfelseif session.st eq 'ME' >Medicaid/MaineCare<cfelse>Medicaid</cfif><cfif session.medicare_receive eq 'Y'>, which will pay nearly all of your health care costs, excluding your prescription drugs.<cfelse>, which will pay nearly all of your prescription drug costs and other health care costs.</cfif> 

</li>

<cfelse>

<cfinclude template="../dspOtherOptions.cfm">

<cfloop query="qryMedicaid">
	<cfset prg_code = "#qryMedicaid.program_code#">
	<cfset spenddowncode = "medicaid_" & session.st & "_medicaid_spend_down">
	<cfset getnextval = false>
	<cfif qryMedicaid.recordCount gt 1>
		<cfif prg_code eq spenddowncode>
			<cfset getnextval = true>
		</cfif>
		<cfif NOT getnextval >
			<cfset prg_id = "#qryMedicaid.prg_id#">
		</cfif>
	<cfelse>
		<cfset prg_id = "#qryMedicaid.prg_id#">
	</cfif>
	<cfset RxPrgList = #ListAppend(RxPrgList, "#prg_id#", ",")# > 
</cfloop>

<p>
	<li>
	
	Apply for <cfif session.st eq 'CA'>Medicaid/Medi-Cal<cfelseif session.st eq 'ME' >Medicaid/MaineCare<cfelse>Medicaid</cfif>.<CFIF isdefined('session.medicare_receive') and session.medicare_receive eq 'y'> Although we cannot be 100% certain that you will qualify, we strongly recommend that you go ahead and apply for this valuable coverage. Medicaid will pay for nearly all of your health care costs, excluding your prescription drugs.  If you are enrolled in both Medicaid and Medicare, you will be auto-enrolled in the Medicare Prescription Drug Coverage with the Extra Help which will pay for between 85% and 100% of your prescription drug costs.  In addition, Medicaid may pay for some prescription drugs that are excluded from the Medicare Prescription Drug Coverage.<cfelse> Although we cannot be 100% certain that you will qualify, we strongly recommend that you go ahead and apply for this valuable coverage. Medicaid will pay for nearly all of your prescription drug and other health care costs. </cfif> 
	
	</li>
</p>

<cfinclude template="../dspLinks.cfm">

</cfif>

</cfif>

