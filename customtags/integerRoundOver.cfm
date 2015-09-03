<cfparam name="attributes.num" type="numeric">
<cfparam name="attributes.scale" type="numeric" default="100">
<cfparam name="attributes.var" type="string" default="">
<cfif attributes.scale gt attributes.num>
	<cfset outnum = attributes.num>
<cfelse>
	<cfset outnum = Int((attributes.num - 1) / attributes.scale) * attributes.scale>
</cfif>
<cfif attributes.var eq "">
	<cfoutput>#outnum#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outnum>
</cfif>