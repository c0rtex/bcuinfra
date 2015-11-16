<cfparam name="id" type="string" default="">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Language Administration" section="display"><cfoutput>

<cf_buildView table="language" code="language" viewlevel="5" editlevel="1" editurl="languageview.cfm?id=#id#&action=edit" key="#id#" action="#action#" saving="#saving#" title="Language Data">
	<cf_buildViewProperty column="language_id" limit="2" case="upper">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="language" namefrom="display_id" codefrom="language_id">
	<cf_buildViewProperty column="default_flag" visible="false" value="0">
	<cf_buildViewProperty column="active" visible="false" value="0">
</cf_buildView>

</cfoutput></cf_buildPage>