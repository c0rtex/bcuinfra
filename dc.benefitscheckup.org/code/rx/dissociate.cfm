<cfif IsDefined('url.generic_id')>

	<cfset generic_id=url.generic_id>
	<cfset brand_id=url.brand_id>
	<cfset src=url.src>

	<cfquery name="dissociate" datasource="#application.dbSrc#">
		delete from answerfield_relationship
		where left_answerfield_id=#brand_id#
			and right_answerfield_id=#generic_id#
			and relationship_id=1
	</cfquery>

	<cfif src eq 'g'>
		<cflocation url="genericview.cfm?generic_id=#generic_id#">
	<cfelse>
		<cflocation url="drugview.cfm?brand_id=#brand_id#">
	</cfif>
	
<cfelse>

	<cfset program_id=url.program_id>
	<cfset answerfield_id=url.answerfield_id>
	<cfset src=url.src>

	<!--- get the rule and the associated answerfields --->
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
	
	<!--- get the answerfield to remove from the list --->
	<cfquery name="af" datasource="#application.dbSrc#">
		select answerfield
		from answerfield
		where answerfield_id=#answerfield_id#
	</cfquery>
	
	<!--- rewrite the rule! --->
	<cfset ruleText = "IsDefined('session." & ListChangeDelims(ListSort(ListDeleteAt(ruleList, ListFind(ruleList, af.answerfield)), 'text'), "') or IsDefined('session.") & "')">
	
	<!--- delete or save the rule! --->
	<cfif ruleText eq "IsDefined('session.')">
		<cfquery name="prgruledelete" datasource="#application.dbSrc#">
			delete from program_rule
			where program_id=#program_id#
				and rule_id=#rid#
		</cfquery>
		<cfquery name="ruledelete" datasource="#application.dbSrc#">
			delete from `rule`
			where rule_id=#rid#
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
	<cfelseif src eq 'd'>
		<cflocation url="drugview.cfm?brand_id=#answerfield_id#">
	<cfelseif src eq 'g'>
		<cflocation url="genericview.cfm?generic_id=#answerfield_id#">
	<cfelse>
		<cflocation url="companyview.cfm?company_id=#answerfield_id#">
	</cfif>

</cfif>