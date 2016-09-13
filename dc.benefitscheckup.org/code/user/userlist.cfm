<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="3">
<cf_buildPage title="User Administration" section="user">

<cf_buildList table="user" code="user" viewlevel="3" editlevel="2" editcondition="session.level lte getdata.usertype_id" activate="true" activatelevel="2" activatecondition="session.level lte getdata.usertype_id" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="usertype_id" references="usertype">
	<cf_buildListProperty column="password" visible="false">
	<cf_buildListProperty column="active" display="yesno">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>