<cfsilent>
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.boolean_output" type="boolean" default="false">
<cfparam name="attributes.true_val" type="any" default="2">
<cfparam name="attributes.false_val" type="any" default="1">
<cfparam name="attributes.null_val" type="any" default="0">
<cfparam name="attributes.var" type="string" default="value">

<cfif attributes.condition eq '' and attributes.code neq ''>
	<cf_cacheRulePool action="get" code="#attributes.code#" var="robj">
	<cfset attributes.condition = robj.text>
</cfif>

<cfif attributes.boolean_output>
	<cfset attributes.true_val = true>
	<cfset attributes.false_val = false>
	<cfset attributes.null_val = ''>
</cfif>

<cfif attributes.condition eq ''>
	<cfset value = attributes.true_val>
<cfelse>
	<cfset attributes.condition = ReplaceNoCase(attributes.condition, 'gteq', 'gte', 'ALL')>
	<cfset attributes.condition = ReplaceNoCase(attributes.condition, 'lteq', 'lte', 'ALL')>
	<cftry>
		<cfset result = Evaluate(attributes.condition)>
		<cfif result>
			<cfset value = attributes.true_val>
		<cfelse>
			<cfset value = attributes.false_val>
		</cfif>
		<cfcatch type="Expression">
			<cfset value = attributes.null_val>
		</cfcatch>
	</cftry>
</cfif>
<cfset "caller.#attributes.var#" = value>
</cfsilent>