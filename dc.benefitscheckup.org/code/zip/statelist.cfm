<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="75">

<cf_checkAccess level="5">
<cf_buildPage title="States" section="zip">

<cf_buildList title="States" table="state" code="state" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="0" condition="st.statetype_id != 4">
	<cf_buildListProperty column="statetype_id" references="statetype">
</cf_buildlist>

</cf_buildpage>