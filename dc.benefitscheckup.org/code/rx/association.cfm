<cfparam name="program_id" type="numeric">
<cfparam name="answerfield_id" type="numeric">
<cfparam name="src" type="string" default="p">

<!--- get the program code --->
<cfquery name="prg" datasource="#application.dbSrc#">
	select program_code
	from program
	where program_id=#program_id#
</cfquery>

<!--- see if the program has an Rx rule already -- if so, get the associated answerfields --->
<cfquery name="ra" datasource="#application.dbSrc#">
	select rule_id
	from `rule` r
	where rx_program_id=#program_id#
</cfquery>
<cfif ra.RecordCount eq 0>
	<cfset rid = 0>
	<cfset ruleList = ''>
<cfelse>
	<cfset rid = ra.rule_id>
	<cfquery name="raf" datasource="#application.dbSrc#">
		select a.answerfield
		from rule_answerfield ra, answerfield a
		where ra.rule_id=#rid#
			and ra.answerfield_id=a.answerfield_id
	</cfquery>
	<cfset ruleList = ValueList(raf.answerfield)>
</cfif>

<!--- get the new answerfield to add to the list --->
<cfquery name="af" datasource="#application.dbSrc#">
	select answerfield
	from answerfield
	where answerfield_id=#answerfield_id#
</cfquery>

<!--- rewrite the rule with the new answerfield! --->
<cfset ruleText = "IsDefined('session." & ListChangeDelims(ListSort(ListAppend(ruleList, af.answerfield), 'text'), "') or IsDefined('session.") & "')">

<!--- save the rule! --->
<cfif rid eq 0>
	<cfquery name="ruleinsert" datasource="#application.dbSrc#">
		insert into `rule`
			(code, rule_text, rx_program_id)
		values
			('rxprogramrule_#prg.program_code#', '#ruleText#', #program_id#)
	</cfquery>
	<cfquery name="mx" datasource="#application.dbSrc#">
		select max(rule_id) mr
		from `rule`
	</cfquery>
	<cfset rid = mx.mr>
	<cfquery name="srt" datasource="#application.dbSrc#">
		select ifnull(max(sort) + 1, 1) as ms
		from program_rule
		where program_id=#program_id#
	</cfquery>
	<cfquery name="ruleinsert" datasource="#application.dbSrc#">
		insert into `program_rule`
			(program_id, rule_id, sort)
		values
			(#program_id#, #rid#, #srt.ms#)
	</cfquery>
<cfelse>
	<cfquery name="ruleupdate" datasource="#application.dbSrc#">
		update `rule`
		set rule_text='#ruleText#'
		where rule_id=#rid#
	</cfquery>
</cfif>
<cf_updateRuleAssociations rule_id="#rid#">

<cfif src eq 'p'>
	<cflocation url="programview.cfm?program_id=#program_id#">
<cfelseif src eq 'c'>
	<cflocation url="companyview.cfm?company_id=#answerfield_id#">
<cfelseif src eq 'g'>
	<cflocation url="genericview.cfm?generic_id=#answerfield_id#">
<cfelse>
	<cflocation url="drugview.cfm?brand_id=#answerfield_id#">
</cfif>