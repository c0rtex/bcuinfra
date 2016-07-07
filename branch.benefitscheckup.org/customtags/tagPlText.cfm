<!----=======================================
DESCRIPTION: Tag that pulls custom text strings for private labels
CALLED BY: N/A
GOES TO: N/A
REQUIRED:N/A
============================================---->
<cfparam name="attributes.column_name" type="any" default="">
<cfquery datasource="#application.dbSrc#" name="tbl_partner"> 
SELECT * FROM tbl_partner WHERE partner_id =<cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#session.partner_id#">
</cfquery>
<cfset var1 = 'tbl_partner.#attributes.column_name#'>
<cfif trim(evaluate(var1)) IS NOT ''>
<cfoutput>
<p class="text1" align="right" style="font-size:11px;">#evaluate(var1)#</p>
</cfoutput>
</cfif>