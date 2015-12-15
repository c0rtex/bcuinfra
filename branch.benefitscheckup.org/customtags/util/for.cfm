<!--- Practice tag for emulating a "for" loop  -->
<cfparam name="attributes.from" type="numeric">
<cfparam name="attributes.to" type="numeric">
<cfparam name="attributes.step" type="numeric" default="1">
<cfparam name="attributes.index" type="string">

<cfif ThisTag.ExecutionMode eq 'start'>
	<cfif sgn(attributes.step) eq 0 or (sgn(attributes.step) eq 1 and attributes.from gt attributes.to) or (sgn(attributes.step) eq -1 and attributes.from lt attributes.to)>
		<cfexit method="exitTag">
	</cfif>
	<cfset "caller.#attributes.index#" = attributes.from>
<cfelseif ThisTag.ExecutionMode eq 'end'>
	<cfset "caller.#attributes.index#" = Evaluate("caller.#attributes.index#") + attributes.step>
	<cfif (sgn(attributes.step) eq 1 and Evaluate("caller.#attributes.index#") lte attributes.to) or (sgn(attributes.step) eq -1 and Evaluate("caller.#attributes.index#") gte attributes.to)>
		<cfexit method="loop">
	</cfif>
</cfif>
