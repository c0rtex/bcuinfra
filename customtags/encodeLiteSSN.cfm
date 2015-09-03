<cfparam name="attributes.ssn" type="string">
<cfparam name="attributes.var" type="string" default="cipherSSN">

<cfset ssn = Replace(attributes.ssn, '-', '', 'ALL')>
<cfset randKey = RandRange(1, 9)>
<cfset outSSN = randKey>

<cfloop from="1" to="#Len(ssn)#" index="x">
	<cf_rotaryAdd num="#Mid(ssn, x, 1)#" addend="#randKey#">
	<cfset outSSN = outSSN & rotarySum>
</cfloop>

<cfset "caller.#attributes.var#" = outSSN>