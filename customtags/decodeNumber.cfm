<cfparam name="attributes.value" type="string">
<cfparam name="attributes.key" type="string">
<cfparam name="attributes.var" type="string" default="ciphernum">

<cfset dnNum = attributes.value>
<cfset key = attributes.key>
<cfset codebase = Len(key)>

<cfset dnUncoded = 0>
<cfset dnUnit = 1>

<cfloop from="#Len(dnNum)#" to="1" step="-1" index="x">
	<cfset dnChr = Mid(dnNum, x, 1)>
	<cfset dnUncoded = dnUncoded + ((Find(dnChr, key) - 1) * dnUnit)>
	<cfset dnUnit = dnUnit * codebase>
</cfloop>

<cfset "caller.#attributes.var#" = dnUncoded>