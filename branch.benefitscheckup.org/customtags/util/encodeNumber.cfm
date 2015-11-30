<cfparam name="attributes.value" type="numeric">
<cfparam name="attributes.key" type="string" default="">
<cfparam name="attributes.var" type="string" default="ciphernum">

<cfset enNum = attributes.value>
<cfset key = attributes.key>
<cfif key eq ''>
	<cf_encodeValues>
</cfif>

<cfset codebase = Len(key)>
<cfset enCoded = ''>
<cfset enPlace = 1>
<cfset enUnit = 1>

<cfloop condition="enNum gte enUnit * codebase">
	<cfset enPlace = enPlace + 1>
	<cfset enUnit = enUnit * codebase>
</cfloop>

<cfloop from="#enPlace#" to="1" step="-1" index="x">
	<cfset enDigit = Int(enNum / enUnit)>
	<cfset enCoded = enCoded & Mid(key, enDigit + 1, 1)>
	<cfset enNum = enNum - (enDigit * enUnit)>
	<cfset enUnit = enUnit / codebase>
</cfloop>

<cfset "caller.#attributes.var#" = enCoded>