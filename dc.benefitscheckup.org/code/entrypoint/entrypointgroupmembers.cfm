<cfparam name="id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linkname" type="string" default="">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Entry Point Group Members" section="entrypoint">

<cf_buildView title="Entry Point Group Members" table="entrypointgroup" code="entrypointgroup" key="#id#" action="view" saving="#saving#" editlevel="4" extraurllist="null" extranamelist="entry points" linkallactions="true">
	<cf_buildViewProperty column="state_id" visible="false">
	<cf_buildViewProperty column="active_flag" visible="false">
	<cf_buildViewProperty column="notes" visible="false">
</cf_buildView>

<cf_buildList table="entrypoint" code="entrypoint" title="Entry Point Associations" condition="xtbl.entrypointgroup_id=#ID#" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="4" crosstable="entrypoint_entrypointgroup" crosscolumn="entrypointgroup_id" crossvalue="#id#" joincolumn="entrypoint_id" crossorder="entrypoint_id" crossorderlinks="true" crossadd="false" linkname="#linkname#" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" selflink="true" selflinkid="#id#">
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
</cf_buildList>

</cf_buildpage>