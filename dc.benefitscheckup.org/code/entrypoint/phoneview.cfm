<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_entrypoint_id" type="any" default="">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfset redirectURL = ''>
<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="4">
	<cfif saving eq 1 and name neq ''>
		<cfset redirectURL = "entrypointview.cfm?id=#entrypoint_id####name#">
	</cfif>
</cfif>

<cf_buildPage title="Entrypoint Phone Number" section="entrypoint">

<cf_buildView name="#name#" table="phone" code="phone" key="#id#" action="#action#" saving="#saving#" title="Entrypoint Phone Number" redirect="#redirectURL#" editlevel="4">
	<cf_buildViewProperty column="entrypoint_id" input="select" references="entrypoint" skipon="edit" link="entrypointview.cfm?id=[[id]]#anchorname#" valueonadd="#new_entrypoint_id#">
	<cf_buildViewProperty column="phonetype_id" input="select" references="phonetype">
	<cf_buildViewProperty column="number" input="textarea" rows="2" limit="255">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

</cf_buildPage>