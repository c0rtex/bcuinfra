<cfparam name="attributes.num" type="numeric">
<cfparam name="attributes.scale" type="numeric" default="100">
<cfparam name="attributes.var" type="string" default="">
<cfset outnum = Int((attributes.num / attributes.scale) + 0.5) * attributes.scale>
<cfif attributes.var eq "">
	<cfoutput>#outnum#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outnum>
</cfif>