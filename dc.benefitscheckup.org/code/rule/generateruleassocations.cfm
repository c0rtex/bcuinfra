<!--- Generate all answerfield assocatinos for a rule or set of rules based on the rule_id --->
<cfset rule_id = "50">
<cfquery name="getrules" datasource="#application.dbSrc#">
Select rule_id from rule_answerfield ra WHERE ra.answerfield_id in (#rule_id#)
</cfquery>
<cfoutput>There are #getrules.recordcount# answerfield associations for rule_id #rule_id#</cfoutput>
<cfloop query="getrules">
<cf_updateRuleAssociations rule_id=#getrules.rule_id# debug="true">
<cfflush>
</cfloop>
<cfquery name="getrules" datasource="#application.dbSrc#">
Select rule_id from rule_answerfield ra WHERE ra.answerfield_id in (#rule_id#)
</cfquery>
<br><br>
<cfoutput>There are now #getrules.recordcount# answerfield associations for rule_id #rule_id#</cfoutput>
