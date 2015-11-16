<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="3">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="User Administration" section="user"><cfoutput>

<cf_buildView table="user" code="user" viewlevel="3" editlevel="2" editcondition="session.level lte getdata.usertype_id" key="#id#" action="#action#" saving="#saving#" title="User Type Data">
	<cf_buildViewProperty column="usertype_id" input="select" references="usertype" condition="usertype_id >= #session.level#" order="usertype_id">
	<cf_buildViewProperty column="username" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="firstname" limit="64">
	<cf_buildViewProperty column="lastname" limit="64">
	<cf_buildViewProperty column="password" input="password" limit="16">
	<cf_buildViewProperty column="active" visible="false" value="1">
	<cf_buildViewProperty column="last_login_date" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

</cfoutput></cf_buildPage>