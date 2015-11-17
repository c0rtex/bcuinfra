<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="View Display Group" section="display"><cfoutput>

<cf_buildView table="displaygroup" code="displaygroup" editlevel="1" key="#id#" action="#action#" saving="#saving#" title="Display Group Data">
	<cf_buildViewProperty column="displaygroup_code" limit="16">
	<cf_buildViewProperty column="displaygroup_name" limit="64">
	<cf_buildViewProperty column="displaygroup_desc" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>