<!----=======================================
DESCRIPTION: Adds the users answers, first accross, then down.
CALLED BY: procIncome
GOES TO: Caller
REQUIRED: N/A		
============================================---->
<!--- This is custom tag to set income variables --->
<cfif session.skipinc eq 'n'>

<CFSET #session.s_sp_income_pri_retire# = '1000000'>
<CFSET #session.hh_income_pri_retire# = '1000000'>

<CFSET #session.s_sp_income_DIVIDENDS# = '1000000'>
<CFSET #session.hh_income_DIVIDENDS# = '1000000'>

<CFSET #session.s_sp_income_SS_DISABLE# = '1000000'>
<CFSET #session.hh_income_SS_DISABLE# = '1000000'>

<CFSET #session.s_sp_income_SSI# = '1000000'>
<CFSET #session.hh_income_SSI# = '1000000'>

<CFSET #session.s_sp_income_VET_BEN# = '1000000'>
<CFSET #session.hh_income_VET_BEN# = '1000000'>

<CFSET #session.s_sp_income_RR_BEN# = '1000000'>
<CFSET #session.hh_income_RR_BEN# = '1000000'>

<CFSET #session.s_sp_income_TANF# = '1000000'>
<CFSET #session.hh_income_TANF# = '1000000'>

<CFSET #session.s_sp_income_CASH_ASSIST# = '1000000'>
<CFSET #session.hh_income_CASH_ASSIST# = '1000000'>

<CFSET #session.s_sp_income_OTHER_NW# = '1000000'>
<CFSET #session.hh_income_OTHER_NW# = '1000000'>

<!--- Unearned Total Monthly Non-Work Income --->
<CFSET #SESSION.S_INCOME_TOTAL_UNEARNED# =  '4000000'>
<CFSET #SESSION.SP_INCOME_TOTAL_UNEARNED# =  '4000000'>
<CFSET #SESSION.S_SP_INCOME_TOTAL_UNEARNED# =  '4000000'>
<CFSET #SESSION.HH_INCOME_TOTAL_UNEARNED# =  '4000000'>

<!--- Earned Income (Work Income) --->
<CFSET #session.s_sp_income_EARNED# = '4000000'>
<CFSET #session.hh_income_EARNED# = '4000000'>

<!--- Total Income --->
<CFSET #SESSION.S_INCOME_TOTAL_COMPLETE# = '50000000'>
<CFSET #SESSION.SP_INCOME_TOTAL_COMPLETE# = '50000000'>
<CFSET #SESSION.S_SP_INCOME_TOTAL_COMPLETE# = '50000000'>
<CFSET #SESSION.HH_INCOME_TOTAL_COMPLETE# = '50000000'>





<cfelse>

<CFSET #session.s_sp_income_pri_retire# = #session.s_income_pri_retire# + #session.sp_income_pri_retire# + #session.s_sp_income_pri_retire#>
<CFSET #session.hh_income_pri_retire# = #session.hh_income_pri_retire# + #session.s_sp_income_pri_retire#>

<CFSET #session.s_sp_income_DIVIDENDS# = #session.s_income_DIVIDENDS# + #session.sp_income_DIVIDENDS# + #session.s_sp_income_DIVIDENDS#>
<CFSET #session.hh_income_DIVIDENDS# = #session.hh_income_DIVIDENDS# + #session.s_sp_income_DIVIDENDS#>

<CFSET #session.s_sp_INCOME_SS_RETIRE# = #session.s_INCOME_SS_RETIRE# + #session.sp_INCOME_SS_RETIRE# + #session.s_sp_INCOME_SS_RETIRE#>
<CFSET #session.hh_INCOME_SS_RETIRE# = #session.hh_INCOME_SS_RETIRE# + #session.s_sp_INCOME_SS_RETIRE#>





<CFSET #session.s_sp_income_SS_DISABLE# = #session.s_income_SS_DISABLE# + #session.sp_income_SS_DISABLE# + #session.s_sp_income_SS_DISABLE#>
<CFSET #session.hh_income_SS_DISABLE# = #session.hh_income_SS_DISABLE# + #session.s_sp_income_SS_DISABLE#>

<cfset #session.s_sp_income_unemploy# = #session.s_sp_income_unemploy# + #session.sp_income_unemploy# + #session.s_income_unemploy# >
<cfset #session.hh_income_unemploy# = #session.hh_income_unemploy# + #session.S_sp_income_unemploy#>

<CFSET #session.s_sp_income_SSI# = #session.s_income_SSI# + #session.sp_income_SSI# + #session.s_sp_income_SSI#>
<CFSET #session.hh_income_SSI# = #session.hh_income_SSI# + #session.s_sp_income_SSI#>

<CFSET #session.s_sp_income_VET_BEN# = #session.s_income_VET_BEN# + #session.sp_income_VET_BEN# + #session.s_sp_income_VET_BEN#>
<CFSET #session.hh_income_VET_BEN# = #session.hh_income_VET_BEN# + #session.s_sp_income_VET_BEN#>


<CFSET #session.s_sp_income_RR_BEN# = #session.s_income_RR_BEN# + #session.sp_income_RR_BEN# + #session.s_sp_income_RR_BEN#>
<CFSET #session.hh_income_RR_BEN# = #session.hh_income_RR_BEN# + #session.s_sp_income_RR_BEN#>

<CFSET #session.s_sp_income_TANF# = #session.s_income_TANF# + #session.sp_income_TANF# +  #session.s_sp_income_TANF#>
<CFSET #session.hh_income_TANF# = #session.hh_income_TANF# + #session.s_sp_income_TANF#>

<CFSET #session.s_sp_income_CASH_ASSIST# = #session.s_income_CASH_ASSIST# + #session.sp_income_CASH_ASSIST# + #session.s_sp_income_CASH_ASSIST#>
<CFSET #session.hh_income_CASH_ASSIST# = #session.hh_income_CASH_ASSIST# + #session.s_sp_income_CASH_ASSIST#>

<CFSET #session.s_sp_income_OTHER_NW# = #session.s_income_OTHER_NW# + #session.sp_income_OTHER_NW# + #session.s_sp_income_OTHER_NW#>
<CFSET #session.hh_income_OTHER_NW# = #session.hh_income_OTHER_NW# + #session.s_sp_income_OTHER_NW#>

<!--- Unearned Total Monthly Non-Work Income --->
<CFSET #SESSION.S_INCOME_TOTAL_UNEARNED# =  #SESSION.S_INCOME_pri_retire# + #SESSION.S_INCOME_DIVIDENDS# +  #SESSION.S_INCOME_SS_DISABLE# + #SESSION.S_INCOME_SS_RETIRE# + #SESSION.S_INCOME_SSI# + #SESSION.S_INCOME_VET_BEN# +  + #SESSION.S_INCOME_RR_BEN# + #SESSION.S_INCOME_TANF# + #SESSION.S_INCOME_CASH_ASSIST# + #SESSION.S_INCOME_OTHER_NW# + #session.s_income_unemploy#>
<CFSET #SESSION.SP_INCOME_TOTAL_UNEARNED# =  #SESSION.SP_INCOME_pri_retire# + #SESSION.SP_INCOME_DIVIDENDS# +  #SESSION.SP_INCOME_SS_DISABLE# + #SESSION.SP_INCOME_SS_RETIRE# + #SESSION.SP_INCOME_SSI# + #SESSION.SP_INCOME_VET_BEN# +  + #SESSION.SP_INCOME_RR_BEN# + #SESSION.SP_INCOME_TANF# + #SESSION.SP_INCOME_CASH_ASSIST# + #SESSION.SP_INCOME_OTHER_NW# + #session.sp_income_unemploy#>
<CFSET #SESSION.S_SP_INCOME_TOTAL_UNEARNED# =  #SESSION.S_SP_INCOME_pri_retire# + #SESSION.S_SP_INCOME_DIVIDENDS# +  #SESSION.S_SP_INCOME_SS_DISABLE# + #SESSION.S_SP_INCOME_SS_RETIRE# + #SESSION.S_SP_INCOME_SSI# + #SESSION.S_SP_INCOME_VET_BEN# +  + #SESSION.S_SP_INCOME_RR_BEN# + #SESSION.S_SP_INCOME_TANF# + #SESSION.S_SP_INCOME_CASH_ASSIST# + #SESSION.S_SP_INCOME_OTHER_NW# + #session.s_sp_income_unemploy#>
<CFSET #SESSION.HH_INCOME_TOTAL_UNEARNED# =  #SESSION.HH_INCOME_pri_retire# + #SESSION.HH_INCOME_DIVIDENDS# +  #SESSION.HH_INCOME_SS_DISABLE# + #SESSION.HH_INCOME_SS_RETIRE# + #SESSION.HH_INCOME_SSI# + #SESSION.HH_INCOME_VET_BEN# +  + #SESSION.HH_INCOME_RR_BEN# + #SESSION.HH_INCOME_TANF# + #SESSION.HH_INCOME_CASH_ASSIST# + #SESSION.HH_INCOME_OTHER_NW# + #session.HH_income_unemploy#>


<!--- Earned Income (Work Income) --->
<CFSET #session.s_sp_income_EARNED# = #session.s_income_EARNED# + #session.sp_income_EARNED# + #session.s_sp_income_EARNED#>
<CFSET #session.hh_income_EARNED# = #session.hh_income_EARNED# + #session.s_sp_income_EARNED#>

<!--- Total Income --->
<CFSET #SESSION.S_INCOME_TOTAL_COMPLETE# = #SESSION.S_INCOME_EARNED# + #SESSION.S_INCOME_TOTAL_UNEARNED#>
<CFSET #SESSION.SP_INCOME_TOTAL_COMPLETE# = #SESSION.SP_INCOME_EARNED# + #SESSION.SP_INCOME_TOTAL_UNEARNED#>
<CFSET #SESSION.S_SP_INCOME_TOTAL_COMPLETE# = #SESSION.S_SP_INCOME_EARNED# + #SESSION.S_SP_INCOME_TOTAL_UNEARNED#>
<CFSET #SESSION.HH_INCOME_TOTAL_COMPLETE# = #SESSION.HH_INCOME_EARNED# + #SESSION.HH_INCOME_TOTAL_UNEARNED#>

</cfif>

