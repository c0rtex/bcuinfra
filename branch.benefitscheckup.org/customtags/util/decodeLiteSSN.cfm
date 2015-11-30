<cfparam name="attributes.str" type="string">
<cfparam name="attributes.var" type="string" default="clearSSN">

<cfset ssn = attributes.str>
<cfset key = Left(ssn, 1)>
<cfset outSSN = ''>

<cfloop from="2" to="#Len(ssn)#" index="x">
	<cf_rotaryAdd num="#Mid(ssn, x, 1)#" addend="#key#" subtract="true">
	<cfset outSSN = outSSN & rotarySum>
</cfloop>

<cfset "caller.#attributes.var#" = outSSN>