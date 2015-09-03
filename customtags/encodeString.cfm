<cfparam name="attributes.text" type="string">
<cfparam name="attributes.var" type="string" default="ciphertext">

<cfset esText = attributes.text>

<cf_encodeValues>
<cfset esRand = RandRange(1, 1024)>
<cfset esCoded = delim>

<cf_encodeNumber value="#esRand#" key="#key#">
<cfset esCoded = esCoded & ciphernum>
<cfloop from="1" to="#Len(esText)#" index="x">
	<cf_encodeNumber value="#Evaluate("Asc(Mid(esText, x, 1)) * esRand")#" key="#key#">
	<cfset esCoded = esCoded & delim & ciphernum>
</cfloop>

<cfset "caller.#attributes.var#" = esCoded>