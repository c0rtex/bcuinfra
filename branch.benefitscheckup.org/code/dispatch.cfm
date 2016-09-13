<cfparam name="bcu_url" type="string">


<cfset session.skipLoad = ''>

<cf_sessionLoadVars>
<cfset session.skipLoad = "#session.cfid#|#session.cftoken#">
<cfif NOT FindNoCase('partner_id',bcu_url) AND FindNoCase('?',bcu_url)>
	<cfset bcu_url = bcu_url & '&partner_id=' & SESSION.partner_id>
</cfif>
<cfif NOT FindNoCase('subset_id',bcu_url) AND FindNoCase('?',bcu_url)>
	<cfset bcu_url = bcu_url & '&subset_id=' & SESSION.subset_id>
</cfif>
<cflocation url="#bcu_url#" addtoken="yes">
