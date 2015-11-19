<cfparam name="attributes.table" type="string">
<cfparam name="attributes.keyvar" type="string" default="refKey">
<cfparam name="attributes.tagvar" type="string" default="refTag">
<cfparam name="attributes.colvar" type="string" default="refCol">

<cfif IsDefined('request.refcount')>
	<cfset request.refcount = request.refcount + 1>
<cfelse>
	<cfset request.refcount = 1>
</cfif>

<cf_tableLoad table="#attributes.table#">
<cfset "caller.#attributes.keyvar#" = keys>
<cfset "caller.#attributes.tagvar#" = "#tag##request.refcount#ref">
<cfset "caller.#attributes.colvar#" = name>