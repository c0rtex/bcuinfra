<cfparam name="attributes.array" type="string">
<cfparam name="attributes.base" type="string">
<cfparam name="attributes.sortType" type="string" default="text">
<cfparam name="attributes.sortOrder" type="string" default="asc">
<cfset "caller.#attributes.array#" = StructKeyArray(Evaluate("caller.#attributes.base#"))>
<cfset ArraySort(Evaluate("caller.#attributes.array#"), attributes.sortType, attributes.sortOrder)>