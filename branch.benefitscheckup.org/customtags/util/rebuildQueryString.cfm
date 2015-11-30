<cfsilent>
<cfparam name="attributes.string" type="string" default="">
<cfparam name="attributes.extralist" type="string" default="">
<cfparam name="attributes.addtoken" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="queryString">

<cfif attributes.string eq '?'>
	<cfset attributes.string = ''>
<cfelseif attributes.string neq '' and Left(attributes.string, 1) eq '?'>
	<cfset attributes.string = Right(attributes.string, Len(attributes.string) - 1)>
</cfif>
<cfset newQS = ''>
<cfset paramsSeen = ''>
<cfloop list="#attributes.string#" delimiters="&" index="x">
	<cfset paramName = ListGetAt(x, 1, '=')>
	<cfif ListLen(x, '=') gt 1>
		<cfset paramVal = ListGetAt(x, 2, '=')>
	<cfelse>
		<cfset paramVal = ''>
	</cfif>
	<cfif paramName neq 'cfid' and paramName neq 'cftoken' and not ListFind(paramsSeen, x) and paramVal neq ''>
		<cfset newQS = ListAppend(newQS, x, '&')>
		<cfset paramsSeen = ListAppend(paramsSeen, x)>
	</cfif>
</cfloop>
<cfloop list="#attributes.extralist#" delimiters=",&" index="x">
	<cfset paramName = ListGetAt(x, 1, '=')>
	<cfif ListLen(x, '=') gt 1>
		<cfset paramVal = ListGetAt(x, 2, '=')>
	<cfelse>
		<cfset paramVal = ''>
	</cfif>
	<cfif paramName neq 'cfid' and paramName neq 'cftoken' and not ListFind(paramsSeen, x) and paramVal neq ''>
		<cfset newQS = ListAppend(newQS, x, '&')>
		<cfset paramsSeen = ListAppend(paramsSeen, x)>
	</cfif>
</cfloop>
<cfif attributes.addtoken>
	<cfif newQS eq ''>
		<cfset newQS = "cftoken=#session.cftoken#">
	<cfelse>
		<cfset newQS = ListInsertAt(newQS, 1, "cftoken=#session.cftoken#", '&')>
	</cfif>
	<cfset newQS = ListInsertAt(newQS, 1, "cfid=#session.cfid#", '&')>
</cfif>
<cfif newQS neq ''>
	<cfset newQS = '?' & newQS>
</cfif>

<cfset "caller.#attributes.var#" = newQS>
</cfsilent>