<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Entry Point Administration" section="entrypoint">

<cf_buildList table="entrypoint" code="entrypoint" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="4">
	<cf_buildListProperty column="code" visible="false">
	<cf_buildListProperty column="subname" visible="false">
	<cf_buildListProperty column="address2" visible="false">
	<cf_buildListProperty column="address3" visible="false">
	<cf_buildListProperty column="zipcode_plus4" visible="false">
	<cf_buildListProperty column="email" visible="false">
	<cf_buildListProperty column="url" visible="false">
	<cf_buildListProperty column="hours_display_id" display="display" visible="false">
	<cf_buildListProperty column="info_display_id" display="display" visible="false">
	<cf_buildListProperty column="contact_title" visible="false">
	<cf_buildListProperty column="contact_first" visible="false">
	<cf_buildListProperty column="contact_middle" visible="false">
	<cf_buildListProperty column="contact_last" visible="false">
	<cf_buildListProperty column="contact_suffix" visible="false">
	<cf_buildListProperty column="privatephone" visible="false">
	<cf_buildListProperty column="last_update" visible="false">
	<cf_buildListProperty column="active_flag" display="yesno">
	<cf_buildListProperty column="notes" visible="false">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildlist>

</cf_buildpage>