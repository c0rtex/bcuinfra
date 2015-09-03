<cfparam name="attributes.text" type="string">
<cfparam name="attributes.var" type="string" default="plaintext">

<cfset dsText = attributes.text>
<cfset delim = Left(dsText, 1)>
<cfset dsArray = ListToArray(Right(dsText, Len(dsText) - 1), delim)>

<cf_encodeValues delimiter="#delim#">
<cfset dsUncoded = ''>

<cfloop from="1" to="#ArrayLen(dsArray)#" index="x">
	<cfif x eq 1>
		<cf_decodeNumber value="#dsArray[x]#" key="#key#" var="dsKey">
	<cfelse>
		<cf_decodeNumber value="#dsArray[x]#" key="#key#">
		<cfset dsUncoded = dsUncoded & Chr(ciphernum / dsKey)>
	</cfif>
</cfloop>

<cfset "caller.#attributes.var#" = dsUncoded>