<cfsilent>
<cfset nullStr = '[zzz[null]zzz]'>
<cfparam name="attributes.action" type="string" default="set">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.pg" type="any" default="#nullStr#">
<cfparam name="attributes.spg" type="any" default="#nullStr#">
<cfparam name="attributes.qno" type="any" default="#nullStr#">
<cfparam name="attributes.status" type="any" default="#nullStr#">
<cfparam name="attributes.element" type="string" default="val">
<cfparam name="attributes.var" type="string" default="hsqOutput">
<cfif attributes.action eq 'set'>
	<cfset init = false>
	<cfif not IsDefined("session.screening.q.#attributes.code#") or not IsStruct(Evaluate("session.screening.q.#attributes.code#"))>
		<cfset "session.screening.q.#attributes.code#" = StructNew()>
		<cfset init = true>
	</cfif>
	<cfif attributes.pg eq nullStr>
		<cfif init>
			<cfset "session.screening.q.#attributes.code#.pg" = 0>
		</cfif>
	<cfelse>
		<cfset "session.screening.q.#attributes.code#.pg" = attributes.pg>
	</cfif>
	<cfif attributes.spg eq nullStr>
		<cfif init>
			<cfset "session.screening.q.#attributes.code#.spg" = 0>
		</cfif>
	<cfelse>
		<cfset "session.screening.q.#attributes.code#.spg" = attributes.spg>
	</cfif>
	<cfif attributes.qno eq nullStr>
		<cfif init>
			<cfset "session.screening.q.#attributes.code#.qno" = 0>
		</cfif>
	<cfelse>
		<cfset "session.screening.q.#attributes.code#.qno" = attributes.qno>
	</cfif>
	<cfif attributes.status eq nullStr>
		<cfif init>
			<cfset "session.screening.q.#attributes.code#.status" = 0>
		</cfif>
	<cfelse>
		<cfset "session.screening.q.#attributes.code#.status" = attributes.status>
	</cfif>
<cfelseif attributes.action eq 'exists'>
	<cfif IsDefined("session.screening.q.#attributes.code#") and IsStruct(Evaluate("session.screening.q.#attributes.code#"))>
		<cfset outStr = true>
	<cfelse>
		<cfset outStr = false>
	</cfif>
	<cfset "caller.#attributes.var#" = outStr>
<cfelseif attributes.action eq 'get'>
	<cfif IsDefined("session.screening.q.#attributes.code#") and IsStruct(Evaluate("session.screening.q.#attributes.code#"))>
		<cfset outStr = Evaluate("session.screening.q.#attributes.code#.#attributes.element#")>
	<cfelse>
		<cfset outStr = ''>
	</cfif>
	<cfset "caller.#attributes.var#" = outStr>
</cfif>
</cfsilent>