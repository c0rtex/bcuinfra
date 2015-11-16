<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Template Listing" section="url">

<cf_buildList title="Template Listing" table="template" code="template" order="filename" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="canonical_flag" display="yesno">
	<cf_buildListProperty column="source_flag" visible="false">
	<cf_buildListProperty column="prev_flag" visible="false">
	<cf_buildListProperty column="org_flag" display="yesno">
	<cf_buildListProperty column="partner_flag" display="yesno">
	<cf_buildListProperty column="subset_flag" display="yesno">
	<cf_buildListProperty column="language_flag" visible="false">
	<cf_buildListProperty column="access_flag" visible="false">
	<cf_buildListProperty column="client_flag" visible="false">
	<cf_buildListProperty column="user_flag" visible="false">
	<cf_buildListProperty column="state_flag" display="yesno">
	<cf_buildListProperty column="test_flag" visible="false">
	<cf_buildListProperty column="description" visible="false">
</cf_buildList>

</cf_buildPage>