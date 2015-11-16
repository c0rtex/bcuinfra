<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Form List" section="form"><cfoutput>

<cf_buildList title="Form List" table="form" code="form" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlink="formedit.cfm?id=[[id]]">
	<cf_buildListProperty column="formtag_id" references="formtag">
	<cf_buildListProperty column="state_id" references="state">
</cf_buildList>

</cfoutput></cf_buildPage>