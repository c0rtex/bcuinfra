<cfsilent>
<cfparam name="reset" type="boolean" default="true">
<cfparam name="flush" type="string" default="">
<cfif reset>
	<cf_loadApplicationVars resetApplication="true">
	<cflocation url="?reset=false" addtoken="no">
<cfelseif flush eq 'template'>
	<cf_loadApplicationVars flush="template">
	<cflocation url="./?cache=3" addtoken="no">
<cfelseif flush eq 'query'>
	<cf_loadApplicationVars flush="query">
	<cflocation url="./?cache=2" addtoken="no">
<cfelse>
	<cf_loadApplicationVars refresh="true">
	<h3>Application Data Refreshed</h3>
	<!---cflocation url="./?cache=1" addtoken="no"--->
</cfif>
</cfsilent>
<cfif reset neq 'true' and flush eq ''><h3>Application Data Refreshed</h3></cfif>