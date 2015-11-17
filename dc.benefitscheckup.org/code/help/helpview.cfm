<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Help Administration" section="help"><cfoutput>

<cf_buildView table="help" code="help" key="#id#" action="#action#" saving="#saving#" title="Help Data">
	<cf_buildViewProperty column="helptype_id" input="select" references="helptype">
	<cf_buildViewProperty column="help_code" limit="64" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="keyword" limit="64">
	<cf_buildViewProperty column="title_display_id" input="display" rows="2" group="helptitle" namefrom="help_code" codefrom="help_code">
	<cf_buildViewProperty column="display_id" input="display" rows="8" group="help" namefrom="help_code" codefrom="help_code">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

</cfoutput></cf_buildPage>