<cfparam name="attributes.delimiter" type="string" default="">
<cfparam name="attributes.delimvar" type="string" default="delim">
<cfparam name="attributes.keyvar" type="string" default="key">

<cfset keyString = 'oetNglIYKha4F31xSOkibzL9sZq0yBWf78r2RmCJcjXQPudwTHv6DVnGA5pUME'>
<cfif Len(attributes.delimiter) eq 1 and Find(attributes.delimiter, keyString)>
	<cfset "caller.#attributes.keyvar#" = Replace(keyString, attributes.delimiter, '', 'ONE')>
<cfelse>
	<cfset delimiter = Mid(keyString, RandRange(1, Len(keyString)), 1)>
	<cfset "caller.#attributes.delimvar#" = delimiter>
	<cfset "caller.#attributes.keyvar#" = Replace(keyString, delimiter, '', 'ONE')>
</cfif>