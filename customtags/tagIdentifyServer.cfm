<!-- Get OE Server so that BCU remembers how to get back to oe -->
<cfif isdefined('url.sn') or isdefined('form.sn')>
	<cfif sn eq 'localhost' or sn eq '127.0.0.1'>
		<cfset application.serverPathOE = "#sn#/oe">
	<cfelse>
		<cfset application.serverPathOE = "#sn#.benefitscheckup.org/oe">
	</cfif>
</cfif>