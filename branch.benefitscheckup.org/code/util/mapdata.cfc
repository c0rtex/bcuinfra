<cfcomponent>
	<cffunction name="setvalues" returntype="struct"  >
		<cfargument required="yes" name="BatchQuery" type="query">
		<cfset mappeddata = structnew()>
			<!-- dob -->
			<cfset mappeddata.dob_month = BatchQuery.ApplicantDOBMonth >
			<cfset mappeddata.dob_year = BatchQuery.ApplicantDOBYear >
			<!-- city -->
			<cfset mappeddata.city = BatchQuery.ApplicantCity >
			<!-- state -->
			<cfset mappeddata.st = BatchQuery.ApplicantState >
			<!-- zip-->
			<cfset mappeddata.zip = BatchQuery.ApplicantZip >
			<!-- spouse dob -->
			<cfset mappeddata.sp_dob_month = BatchQuery.SpouseDOBMonth >
			<cfset mappeddata.sp_dob_year = BatchQuery.SpouseDOBYear >
			<!-- marital status -->
			<cfif BatchQuery.MaritalStatus eq "Married-Living Together">
				<cfset mappeddata.marital_stat = "4-Married">
				<cfset mappeddata.no_hh_members = 2>
			<cfelse>
				<cfset mappeddata.marital_stat = "6-Single">
				<cfset mappeddata.no_hh_members = 1>
			</cfif>
			
			<!-- disabled -->
			<cfif BatchQuery.HasDisabilityBenefits eq "yes">
				<cfset mappeddata.disabled = "y">
			<cfelse>
				<cfset mappeddata.disabled = "n">
			</cfif> 
			
			<!-- conert empty srtings to numeric value -->
			<cfif BatchQuery.ApplicantSelfEmpNetEarn eq ""   >
				<cfset BatchQuery.ApplicantSelfEmpNetEarn = 0>				
			</cfif>	
			<cfif BatchQuery.ApplicantWageAmount eq  ""  >
				<cfset BatchQuery.ApplicantWageAmount = 0>
			</cfif>
			<cfif BatchQuery.ApplicantOtherIncomeMonthly eq "" >
				<cfset BatchQuery.ApplicantOtherIncomeMonthly = 0>
			</cfif>
			<cfif BatchQuery.ApplicantPensionMonthly eq "" >
				<cfset BatchQuery.ApplicantPensionMonthly   = 0>
			</cfif>
			<cfif BatchQuery.ApplicantRailroadMonthly eq "" >
				<cfset BatchQuery.ApplicantRailroadMonthly  = 0>
			</cfif>
			<cfif BatchQuery.ApplicantSSMonthly eq "" >
				<cfset BatchQuery.ApplicantSSMonthly  = 0>
			</cfif>
			<cfif BatchQuery.ApplicantVetMonthly eq "" >
				<cfset BatchQuery.ApplicantVetMonthly  = 0>
			</cfif>
			<cfif BatchQuery.SpouseSelfEmpNetEarn eq "" >
				<cfset BatchQuery.SpouseSelfEmpNetEarn  = 0>
			</cfif>
			<cfif BatchQuery.SpouseWageAmount eq "" >
				<cfset BatchQuery.SpouseWageAmount = 0>
			</cfif>
			<cfif BatchQuery.SpouseOtherIncomeMonthly eq "" >
				<cfset BatchQuery.SpouseOtherIncomeMonthly  = 0>
			</cfif>
			<cfif BatchQuery.SpousePensionMonthly eq "" >
				<cfset BatchQuery.SpousePensionMonthly  = 0>
			</cfif>
			<cfif BatchQuery.SpouseRailroadMonthly eq "" >
				<cfset BatchQuery.SpouseRailroadMonthly = 0>
			</cfif>

				<cfset BatchQuery.SpouseVetMonthly  = 0>

			<cfif BatchQuery.LifeInsuranceAmount eq "" >
				<cfset BatchQuery.LifeInsuranceAmount = 0> 
			</cfif>
			<cfif BatchQuery.ApplicantBankAmount eq "" >
				<cfset BatchQuery.ApplicantBankAmount = 0>
			</cfif>
			<cfif BatchQuery.ApplicantOtherCashAmount eq "" >
				<cfset BatchQuery.ApplicantOtherCashAmount  = 0> 
			</cfif>
			<cfif BatchQuery.ApplicantInvestAmount eq "" >
				<cfset BatchQuery.ApplicantInvestAmount  = 0>
			</cfif>
			<cfif BatchQuery.LifeInsuranceAmount eq "" >
				<cfset BatchQuery.LifeInsuranceAmount  = 0>
			</cfif>
			<cfif BatchQuery.ApplicantBankAmount eq "" >
				<cfset BatchQuery.ApplicantBankAmount  = 0>
			</cfif>
			<cfif BatchQuery.ApplicantOtherCashAmount eq "" >
				<cfset BatchQuery.ApplicantOtherCashAmount   = 0>
			</cfif>
			<cfif BatchQuery.ApplicantInvestAmount eq "" >
				<cfset BatchQuery.ApplicantInvestAmount  = 0>
			</cfif>
		
			<!-- s_income_total_earned -->
			<cfset mappeddata.s_income_earned = ((BatchQuery.ApplicantSelfEmpNetEarn/12) + (BatchQuery.ApplicantWageAmount/12)) >
			<!-- s_income_total_unearned -->
			<cfset mappeddata.s_income_total_unearned = BatchQuery.ApplicantOtherIncomeMonthly + BatchQuery.ApplicantPensionMonthly + BatchQuery.ApplicantRailroadMonthly + BatchQuery.ApplicantSSMonthly + BatchQuery.ApplicantVetMonthly>
			<!-- sp_income_total_earned -->
			<cfset mappeddata.sp_income_earned = ((BatchQuery.SpouseSelfEmpNetEarn/12) + (BatchQuery.SpouseWageAmount/12)) >
			<!-- sp_income_total_unearned -->
			<cfset mappeddata.sp_income_total_unearned = BatchQuery.SpouseOtherIncomeMonthly + BatchQuery.SpousePensionMonthly + BatchQuery.SpouseRailroadMonthly  > 
			<!--  s_sp_asset_total_complete -->
			<cfif mappeddata.marital_stat eq "4-Married">
				<cfset mappeddata.s_sp_asset_total_complete = BatchQuery.LifeInsuranceAmount + BatchQuery.ApplicantBankAmount + BatchQuery.ApplicantOtherCashAmount + BatchQuery.ApplicantInvestAmount>
			<cfelseif mappeddata.marital_stat eq "6-Single">
				<cfset mappeddata.s_asset_total_complete = BatchQuery.LifeInsuranceAmount + BatchQuery.ApplicantBankAmount + BatchQuery.ApplicantOtherCashAmount + BatchQuery.ApplicantInvestAmount>
			</cfif>	

			<!-- over_60  -->
			<!-- if dob and sp_dob over 60 then over_60 = 2, if one is over 60 then over_60 = 1, if neither over 60 then over_60 = 2 -->
			<cfif mappeddata.marital_stat eq "4-Married" and  BatchQuery.SpouseDOBYear lte 1946 and BatchQuery.ApplicantDOBYear lte 1946>
				<cfset mappeddata.over_60 = 2>
			<cfelseif mappeddata.marital_stat eq "4-Married" and BatchQuery.SpouseDOBYear lte 1946>
				<cfset mappeddata.over_60 = 1>
			<cfelseif BatchQuery.ApplicantDOBYear lte 1946>
				<cfset mappeddata.over_60 = 1>
			<cfelse>
				<cfset mappeddata.over_60 = 0>
			</cfif>
		<cfreturn mappeddata>
	</cffunction>
</cfcomponent>