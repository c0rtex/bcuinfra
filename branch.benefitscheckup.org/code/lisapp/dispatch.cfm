<cfparam name="bcu_url" type="string">


<cfset session.skipLoad = ''>

<cf_sessionLoadVars>
<cfset session.skipLoad = "#session.cfid#|#session.cftoken#">


<cflocation url="#bcu_url#" addtoken="yes">
