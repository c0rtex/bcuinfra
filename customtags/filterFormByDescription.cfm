<cfparam name="attributes.description" type="string" default="">
<cfparam name="attributes.state" type="string" default="#session.st#">
<cfparam name="attributes.var" type="string" default="">

<cfset outval = (FindNoCase('Alaska', attributes.description) Eq 0 And FindNoCase('Hawaii', attributes.description) Eq 0 And FindNoCase('48', attributes.description) Eq 0) Or (attributes.state eq 'AK' and FindNoCase('Hawaii', attributes.description) Eq 0 And FindNoCase('48', attributes.description) Eq 0) Or (attributes.state eq 'HI' and FindNoCase('Alaska', attributes.description) Eq 0 and FindNoCase('48', attributes.description) Eq 0) Or (attributes.state neq 'HI' and attributes.state neq 'AK' and FindNoCase('48', attributes.description) Gt 0)>

<cfif attributes.var eq "">
	<cfoutput>#outval#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outval>
</cfif>