<!----=======================================
DESCRIPTION: checks for eligibility of one program depending on another
CALLED BY: procBuffer.cfm
GOES TO: N/A
REQUIRED: rule--which is the eligibility rule.
				prg_list--list of programs that are already qualified in the buffer
============================================---->
<!--- put the rule passed in into a var I can use --->
<CFSET StrFullRule = attributes.rule>
<CFSET prg_list = attributes.prg_list>
<!---CFOUTPUT>#strFullRule#</cfoutput--->
<!--- Put the whole routine in a loop in case this program
Depends on the eligibility of more than one other --->
<CFLOOP INDEX="count" FROM="1" TO="10">

<!--- Find out where prg is in the rule --->
<cfset CharNumP = FindNoCase("prg",StrFullRule,1)>

<!--- If there are no more prg,  then break outta loop --->
<CFIF CharNumP EQ 0>
<CFSET temp = #Evaluate(StrFullRule)#>
<CFSET caller.answer = temp>
	<CFBREAK>
</cfif>

<!--- Find the next Y or N in the rule --->
<cfset CharNumY = FindNoCase("Y'",StrFullRule,CharNumP)>
<cfset CharNumN = FindNoCase("N'",StrFullRule,CharNumP)>

<!--- if it can find a Y then it must be a N value --->
<CFIF CharNumY EQ 0>
	<CFSET Criteria = "N">
	<CFSET CharNumCrit = CharNumN>
<!--- if it can find a N then it must be a Y value --->
<CFELSEIF CharNumN EQ 0>
	<CFSET Criteria = "Y">
	<CFSET CharNumCrit = CharNumY>
<!--- If it finds both,  find which came closest to the prg --->
<CFELSE>
		<CFIF CharNumY GT CharNumN>
			<CFSET Criteria = "N">
			<CFSET CharNumCrit = CharNumN>
		<CFELSE>
			<CFSET Criteria = "Y">
			<CFSET CharNumCrit = CharNumY>
		</CFIF>
</CFIF>


<!--- Strip the rule down to the portion that invovles the prg --->
<CFSET prgRule = #LEFT(StrFullRule, CharNumCrit + 1)#>
<CFIF CharNumP NEQ 1>
	<CFSET StrToRemove = #Left(StrFullRule, CharNumP - 1)#>
	<CFSET prgRule = #Replace(prgRule, StrToRemove, "")#>
</CFIF>

<!--- Strip the rule down to the portion that is the prg_id --->
<CFSET prg_id = #LEFT(StrFullRule, CharNumCrit - 6)#>
<CFSET StrToRemove = #Left(StrFullRule, CharNumP + 2)#>
<CFSET prg_id = #Replace(prg_id, StrToRemove, "")#>

<!--- Changes to code 12/11/2000 --->
<CFIF criteria is "N">
	<!--- Look for the prg_id in the session list --->
	<CFIF #ListFindNoCase("#prg_list#", "'#prg_id#'")# IS 0>
	<CFSET strFind = "N">
	<CFELSE>
	<CFSET strFind = "Y">
	</CFIF>
	<!---Look for the prg in the reg session list --->
	<CFIF #ListFindNoCase("#session.prg_list#", "'#prg_id#'")# IS 0>
	<CFSET strFind1 = "N">
	<CFELSE>
	<CFSET strFind1 = "Y">
	</CFIF>

	<!--- compare the finding to whether it should be found --->
	<CFIF strFind1 EQ criteria>
	<CFSET evaluate = "0 EQ 0">
	<CfELSE>
	<CFSET evaluate = "0 EQ 1">
	</cfif>
	
<CFElse>
	<!--- Look for the prg_id in the session list --->
	<CFIF #ListFindNoCase("#prg_list#", "'#prg_id#'")# IS 0>
	<CFSET strFind = "N">
	<CFELSE>
	<CFSET strFind = "Y">
	</CFIF>
	
	<!--- compare the finding to whether it should be found --->
	<CFIF strFind EQ criteria>
	<CFSET evaluate = "0 EQ 0">
	<CfELSE>
	<CFSET evaluate = "0 EQ 1">
	</cfif>
	
</CFIF>


<!--- Rplace the section of the rule for another program with an equation that will
	evaluate to true or false, depending on what is needed --->
<CFSET StrFullRule = #Replace(StrFullRule, prgRule, evaluate)#>

<!--- Once all prg portions of the rules have been replaced....end the loop --->
</cfloop>

<!--- evaluate the rule with the replacement equations, and send out the answer --->
<CFSET temp = #Evaluate(StrFullRule)#>

<CFSET answer = temp>
