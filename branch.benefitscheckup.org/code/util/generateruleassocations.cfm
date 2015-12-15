<!--- Generate all answerfield assocatinos for a rule or set of rules based on the rule_id --->
<cfquery name="getrules" datasource="#application.dbSrc#">
Select rule_id from rule_answerfield ra WHERE ra.answerfield_id in (507)
</cfquery>
<cfloop query="getrules">
<cf_updateRuleAssociations rule_id=#getrules.rule_id# debug="true">
<cfflush>
</cfloop>
