<cfparam name="attributes.num" type="numeric">
<cfparam name="attributes.addend" type="numeric">
<cfparam name="attributes.base" type="numeric" default="10">
<cfparam name="attributes.subtract" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="rotarySum">

<cfif attributes.addend gte attributes.base>
	<cfset attributes.addend = attributes.addend mod attributes.base>
</cfif>
<cfif attributes.subtract>
	<cfset sum = attributes.num - attributes.addend>
<cfelse>
	<cfset sum = attributes.num + attributes.addend>
</cfif>
<cfif sum gte attributes.base>
	<cfloop condition="sum gte attributes.base">
		<cfset sum = sum - attributes.base>
	</cfloop>
<cfelseif sum lt 0>
	<cfloop condition="sum lt 0">
		<cfset sum = sum + attributes.base>
	</cfloop>
</cfif>

<cfset "caller.#attributes.var#" = sum>