<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">

<cfif partnerQuery.wrapper_screening_order IS "">
	<cfset screenings = "custom1,comprehensive,external,pda,rx,pap,disaster,custom2">
<cfelse>
	<cfset screenings = partnerQuery.wrapper_screening_order>
</cfif>
<cfif session.partner_id IS 22>
	<cfinclude template="moreprograms_aarp_cf.cfm">
<cfelse>
<cfoutput>
<div style="padding:8px 16px;">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td><h1 class="indexh1">Find Benefits Programs</h1>
<p class="text1">#partnerQuery.wrapper_more_programs#</p>
<p class="text1">Ready to begin your search? Please choose an option below.</p>
<cfloop list="#screenings#" index="i">
	<cfinclude template="moreprograms/#i#_cf.cfm">
</cfloop>
</td>
</tr>
</table>
</div>
</cfoutput>
</cfif>