<cfquery name="getLegRules" datasource="#application.dbSrc#">
	SELECT rule_id
        , rule_text
        FROM `rule`
        where rule_id = 1602
</cfquery>
<!--- where rule_text like '%prg%' --->
<html>
<head>
</head>
<title>MATCH LEGACY IDS WITH PROGRAM IDS</title>
<body>

<table border=1>
<cfloop query="getLegRules">
<cfoutput>
	<tr><td>Rule Text Before: |#rule_text#|</td></tr>
	
	<!--- Grab prgXXX-XXX-XXXX-XX-XX from rule_text--->
	<cfset ruleText = '#rule_text#'>
        <cfset rule_text1 = '#rule_text#'>

        <cfset myVar=false>
	<cfloop condition="myVar eq false">
	<cfset myLegWithPrefix = '#REFind("prg[0-9X]{3}-[0-9X]{3}-[0-9]{4}-[A-Z]{2}-[A-Z]{2}","#rule_text1#",1,"TRUE")#'>
        <cfif myLegWithPrefix.pos[1] eq 0>
          <cfset myVar = true>
        </cfif>
        <cfif myVar eq false>
		<!--- Get new program code associated with Legacy_ID --->
		<cfset withPrefix = '#Mid(rule_text1,myLegWithPrefix.pos[1],myLegWithPrefix.len[1])#'>
		<cfset withoutPrefix = "#ReplaceNoCase(withPrefix, 'prg', '')#">
		<tr><td>Rule to be replaced: |#withoutPrefix#|</td></tr>	
		<cfquery name="getProgCode" datasource="#application.dbSrc#">
			Select program_code as pcode
			from program
			where legacy_prg_id = '#withoutPrefix#'
		</cfquery>

		<!--- Replace the legacy_id with the program code in rule_text string --->
		<cfset newRuleText = '#Replace(rule_text1, withPrefix, getProgCode.pcode)#'>	
		<tr><td>Rule Text After: |#newRuleText#|</td></tr>

	        <cfset rule_text1 = '#newRuleText#'>
	</cfif>
	</cfloop>
        <cfquery name="updateRule" datasource="#application.dbSrc#">
		update `rule`
		set rule_text = '#newRuleText#'
		where rule_id = 1602
	</cfquery>
</cfoutput>
</cfloop>
</table>
</body>
</html>
