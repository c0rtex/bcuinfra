<cfcomponent>

<cffunction name="integerRoundOver">
	<cfargument name="num" type="numeric">
	<cfargument name="scale" type="numeric" default="100">

	<cfif scale gt num>
		<cfset outnum = num>
	<cfelse>
		<cfset outnum = Int((num - 1) / scale) * scale>
	</cfif>

	<cfreturn outnum>
</cffunction>

<cffunction name="integerSeparate">
	<cfargument name="num" type="numeric">
	<cfargument name="sep" type="string" default=",">
	<cfargument name="dec" type="string" default=".">
	<cfargument name="round" type="boolean" default="false">

	<cfif round>
		<cfset num = Int(num + 0.5)>
	</cfif>
	<cfset intarray = ListToArray(num, '.')>
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
			<cfset outnum = sep & outnum>
		</cfif>
	</cfloop>
	<cfif intdec neq "" and not round>
		<cfset outnum = outnum & dec & intdec>
	</cfif>
	<cfreturn outnum>
</cffunction>

<cffunction name="stripTags">
	<cfargument name="text" type="string">
	<cfargument name="all" type="boolean" default="false">

	<cfset text = REReplaceNoCase(text, '<script(\s[^>]*)?>.*</script>', '', 'ALL')>
	<cfif all>
		<cfset text = REReplaceNoCase(text, '<sub(\s[^>]*)?>.*</sub>', '', 'ALL')>
		<cfset text = REReplaceNoCase(text, '<sup(\s[^>]*)?>.*</sup>', '', 'ALL')>
		<cfset text = REReplaceNoCase(text, '</?[^>]*>', '', 'ALL')>
	<cfelse>
		<cfset text = REReplaceNoCase(text, '</?a(\s[^>]*)?>', '', 'ALL')>
	</cfif>
	<cfreturn text>
</cffunction>

</cfcomponent>