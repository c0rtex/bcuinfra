<cfparam name="attributes.list" type="string" default="">
<cfparam name="attributes.var" type="string" default="hasMedicareCards">

<cfset outval = false>
<cfloop index="i" list="#attributes.list#">
	<cfif ListLen(i, '-') gt 1>
		<cfset majorCat = ListGetAt(i, 2, '-')>
		<cfif majorCat eq 333 >
			<cfset outval = true>
		</cfif>
	</cfif>
</cfloop>

<cfset "caller.#attributes.var#" = outval>