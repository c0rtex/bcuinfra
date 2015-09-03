<cfif IsDefined("SESSION.partner_id") AND (SESSION.partner_id EQ 0 )>
 <cfinclude template="frmeligibility_bcu.cfm">
<cfelse>
 <cfinclude template="frmeligibility_pl.cfm">
</cfif>
