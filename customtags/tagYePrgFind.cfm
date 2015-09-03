<!----=======================================
DESCRIPTION: checks for eligibility of one program depending on another
CALLED BY: procEligibility.cfm
GOES TO: N/A
REQUIRED: rule--which is the eligibility rule.
============================================---->
<cfsilent>
<!--- put the rule passed in into a var I can use --->	
<cfset StrFullRule = attributes.rule>
<!--- Put the whole routine in a loop in case this program
Depends on the eligibility of more than one other --->
<cfloop index="count" from="1" to="10">
	<!--- Find out where prg is in the rule --->	
	<cfset CharNumP = FindNoCase("prg",StrFullRule,1)>
	<!--- If there are no more prg,  then break outta loop --->
	<cfif CharNumP EQ 0>	
		<cfset temp = Evaluate("#StrFullRule#")>	
		<cfset caller.answer = temp>
		<cfbreak>
	</cfif>
	<!--- Find the next Y or N in the rule --->	
	<cfset CharNumY = FindNoCase("Y'",StrFullRule,CharNumP)>	
	<cfset CharNumN = FindNoCase("N'",StrFullRule,CharNumP)>
	<!--- if it can find a Y then it must be a N value --->
	<cfif CharNumY EQ 0>	
			<cfset Criteria = "N">	
			<cfset CharNumCrit = CharNumN>
	<!--- if it can find a N then it must be a Y value --->
	<cfelseif CharNumN EQ 0>	
			<cfset Criteria = "Y">	
			<cfset CharNumCrit = CharNumY>
	<!--- If it finds both,  find which came closest to the prg --->
	<cfelse>
		<cfif CharNumY GT CharNumN>	
			<cfset Criteria = "N">	
			<cfset CharNumCrit = CharNumN>
		<cfelse>
			<cfset Criteria = "Y">	
			<cfset CharNumCrit = CharNumY>
		</cfif>
	</cfif>
	<!--- Strip the rule down to the portion that invovles the prg --->	
	<cfset prgRule = LEFT(StrFullRule, CharNumCrit + 1)>
	<cfif CharNumP NEQ 1>	
		<cfset StrToRemove = Left(StrFullRule, CharNumP - 1)>	
		<cfset prgRule = Replace(prgRule, StrToRemove, "")>
	</cfif>
	<!--- Strip the rule down to the portion that is the prg_id --->	
	<cfset prg_id = LEFT(StrFullRule, CharNumCrit - 6)>	
	<cfset StrToRemove = Left(StrFullRule, CharNumP + 2)>	
	<cfset prg_id = Replace(prg_id, StrToRemove, "")>
	<!--- Add in the "'" qualifiers to compare it to the list elements --->
	<cfset prg_id = ListQualify(prg_id, "'")>
	<!--- Look for the prg_id in the session list --->
	<cfoutput> caller program list: #caller.tmp_prg_list#   ....Need to find: #prg_id# CRITERIA #criteria#</cfoutput>
	<cfset tmp_prg_list = caller.tmp_prg_list>
	<cfif NOT attributes.ynDoBuffer>
		<cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 >
			<cfoutput>#tmp_prg_list# NOT Found </cfoutput>
			<cfset strFind = "N">
		<cfelse>
			<cfoutput> Found IT </cfoutput>
			<cfset strFind = "Y">
		</cfif>
	<cfelse>
		<!--- 07/09/2002 REM  For buffer progs, we want to return the dependent program 
		if the parent program is in either the buffer list (which will be the same as
		tmp_prg_list) or the normal list --->
		<cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 AND
			ListFindNoCase(session.prg_list, prg_id) IS 0>	
			<cfset strFind = "N">
		<cfelse>
			<cfset strFind = "Y">
		</cfif>
	</cfif>
	<!--- compare the finding to whether it should be found --->
	<cfif strFind EQ criteria>	
		<cfset evaluate = "0 EQ 0">
	<cfelse>
		<cfset evaluate = "1 EQ 0">
	</cfif>
	<!--- Rplace the section of the rule for another program with an equation that will
		evaluate to true or false, depending on what is needed --->	
	<cfset StrFullRule = Replace(StrFullRule, prgRule, evaluate)>
	<!--- Once all prg portions of the rules have been replaced....end the loop --->
</cfloop>
<!--- evaluate the rule with the replacement equations, and send out the answer --->	
<cfoutput>Full Rule: #StrFullRule#  ....  prgRule: #prgRule#    evaluation replaced: #evaluate#:   answer: #Evaluate(StrFullRule)#</cfoutput>
<cfset caller.answer = Evaluate(StrFullRule)>
</cfsilent>