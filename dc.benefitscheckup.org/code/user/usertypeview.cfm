<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="3">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="User Type Group" section="user"><cfoutput>

<cf_buildView table="usertype" code="usertype" viewlevel="3" editlevel="1" key="#id#" action="#action#" saving="#saving#" title="User Type Data">
	<cf_buildViewProperty column="usertype_code" limit="16">
	<cf_buildViewProperty column="usertype_name" limit="64">
	<cf_buildViewProperty column="usertype_desc" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>