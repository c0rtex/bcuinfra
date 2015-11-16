<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Site Text Administration" section="display"><cfoutput>

<cf_buildView table="sitetext" code="sitetext" key="#id#" action="#action#" saving="#saving#" title="Site Text Data">
	<cf_buildViewProperty column="sitetext_code" limit="64" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="display_id" input="display" rows="25" cols="75" group="site" namefrom="sitetext_code" codefrom="sitetext_code">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

</cfoutput></cf_buildPage>