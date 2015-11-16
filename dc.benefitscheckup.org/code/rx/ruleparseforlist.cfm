<cfset rulelist=''>
<cfset drugnmpos = FindNoCase('dn_', testrule, 1)>
<cfset drugcopos = FindNoCase('dc_', testrule, 1)>
<cfif drugnmpos gt 0>
	<cfif drugcopos gt 0>
		<cfif drugnmpos lt drugcopos>
			<cfset rulepos = drugnmpos>
		<cfelse>
			<cfset rulepos = drugcopos>
		</cfif>
	<cfelse>
		<cfset rulepos = drugnmpos>
	</cfif>
<cfelse>
	<cfif drugcopos gt 0>
		<cfset rulepos = drugcopos>
	<cfelse>
		<cfset rulepos = 0>
	</cfif>
</cfif>
<cfloop condition="rulepos gt 0">
	<cfset quotpos = FindOneOf('''"', testrule, rulepos)>
	<cfif quotpos gt 0>
		<cfset subrule = Mid(testrule, rulepos, quotpos - rulepos)>
		<cfset rulelist = ListAppend(rulelist, subrule)>
		<cfset drugnmpos = FindNoCase('dn_', testrule, quotpos)>
		<cfset drugcopos = FindNoCase('dc_', testrule, quotpos)>
		<cfif drugnmpos gt 0>
			<cfif drugcopos gt 0>
				<cfif drugnmpos lt drugcopos>
					<cfset rulepos = drugnmpos>
				<cfelse>
					<cfset rulepos = drugcopos>
				</cfif>
			<cfelse>
				<cfset rulepos = drugnmpos>
			</cfif>
		<cfelse>
			<cfif drugcopos gt 0>
				<cfset rulepos = drugcopos>
			<cfelse>
				<cfset rulepos = 0>
			</cfif>
		</cfif>
	<cfelse>
		<cfset rulepos = 0>
	</cfif>
</cfloop>
<cfset rulelist = ListSort(rulelist, 'Text')>