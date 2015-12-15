<cfsilent>
<cfset nullStr = '[zzz[null]zzz]'>
<cfparam name="attributes.action" type="string" default="set">
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.val" type="any" default="#nullStr#">
<cfparam name="attributes.pre" type="any" default="#nullStr#">
<cfparam name="attributes.req" type="any" default="#nullStr#">
<cfparam name="attributes.group" type="any" default="#nullStr#">
<cfparam name="attributes.error" type="any" default="#nullStr#">
<cfparam name="attributes.ins" type="any" default="#nullStr#">
<cfparam name="attributes.type" type="any" default="#nullStr#">
<cfparam name="attributes.recap" type="any" default="#nullStr#">
<cfparam name="attributes.element" type="string" default="val">
<cfparam name="attributes.var" type="string" default="hsaOutput">
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode neq 'print'>
	<cfif attributes.action eq 'set'>
		<cfset init = false>
		<cfif not IsDefined("session.screening.a.#attributes.code#") or not IsStruct(Evaluate("session.screening.a.#attributes.code#"))>
			<cfset "session.screening.a.#attributes.code#" = StructNew()>
			<cfset "session.screening.a.#attributes.code#.active" = false>
			<cfset init = true>
		</cfif>
		<cfif attributes.val eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.val" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.val" = attributes.val>
			<cfset "session.screening.a.#attributes.code#.active" = true>
		</cfif>
		<cfif attributes.pre eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.pre" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.pre" = attributes.pre>
		</cfif>
		<cfif attributes.req eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.req" = 0>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.req" = attributes.req>
		</cfif>
		<cfif attributes.group eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.group" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.group" = attributes.group>
		</cfif>
		<cfif attributes.error eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.error" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.error" = attributes.error>
		</cfif>
		<cfif attributes.ins eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.ins" = 0>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.ins" = attributes.ins>
		</cfif>
		<cfif attributes.type eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.type" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.type" = attributes.type>
		</cfif>
		<cfif attributes.recap eq nullStr>
			<cfif init>
				<cfset "session.screening.a.#attributes.code#.recap" = ''>
			</cfif>
		<cfelse>
			<cfset "session.screening.a.#attributes.code#.recap" = attributes.recap>
		</cfif>	
	<cfelseif attributes.action eq 'exists'>
		<cfif IsDefined("session.screening.a.#attributes.code#") and IsStruct(Evaluate("session.screening.a.#attributes.code#"))>
			<cfset outStr = Evaluate("session.screening.a.#attributes.code#.active")>
		<cfelse>
			<cfset outStr = false>
		</cfif>
		<cfset "caller.#attributes.var#" = outStr>
	<cfelseif attributes.action eq 'get'>
		<cfif IsDefined("session.screening.a.#attributes.code#") and IsStruct(Evaluate("session.screening.a.#attributes.code#"))>
			<cfset outStr = Evaluate("session.screening.a.#attributes.code#.#attributes.element#")>
		<cfelse>
			<cfset outStr = ''>
		</cfif>
		<cfset "caller.#attributes.var#" = outStr>	
	<cfelseif attributes.action eq 'clear'>
		<cfif IsDefined("session.screening.a.#attributes.code#") and IsStruct(Evaluate("session.screening.a.#attributes.code#"))>
			<cfset "session.screening.a.#attributes.code#.val" = ''>
			<cfset "session.screening.a.#attributes.code#.type" = ''>
			<cfset "session.screening.a.#attributes.code#.active" = false>
		</cfif>	
	</cfif>
</cfif>
</cfsilent>