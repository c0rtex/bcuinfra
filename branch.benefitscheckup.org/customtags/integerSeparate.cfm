<cfparam name="attributes.num" type="numeric">
<cfparam name="attributes.sep" type="string" default=",">
<cfparam name="attributes.dec" type="string" default=".">
<cfparam name="attributes.round" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="">
<cfif attributes.round>
	<cfset attributes.num = Int(attributes.num + 0.5)>
</cfif>
<cfset intarray = ListToArray(attributes.num, '.')>
<cfset intnum = intarray[1]>
<cfif ArrayLen(intarray) gt 1>
	<cfset intdec = intarray[2]>
<cfelse>
	<cfset intdec = "">
</cfif>
<cfset outnum="">
<cfloop index="i" from="1" to="#len(intnum)#">
	<cfset outnum = Mid(intnum, len(intnum) - i + 1, 1) & outnum>
	<cfif i mod 3 eq 0 and i lt len(intnum)>
		<cfset outnum = attributes.sep & outnum>
	</cfif>
</cfloop>
<cfif intdec neq "" and not attributes.round>
	<cfset outnum = outnum & attributes.dec & intdec>
</cfif>
<cfif attributes.var eq "">
	<cfoutput>#outnum#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outnum>
</cfif>