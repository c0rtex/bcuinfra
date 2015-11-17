<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Error Administration" section="help"><cfoutput>

<cf_buildView table="error" code="error" key="#id#" action="#action#" saving="#saving#" title="Error Data">
	<cf_buildViewProperty column="error_code" limit="64" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="display_id" input="display" rows="8" group="error" namefrom="error_code" codefrom="error_code">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

</cfoutput></cf_buildPage>