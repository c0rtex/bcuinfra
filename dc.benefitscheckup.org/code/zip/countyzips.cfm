<cfparam name="id" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Zip Codes in County" section="zip">

<cf_buildView title="County Data" table="county" code="county" key="#id#" action="view" editlevel="0" extraurllist="null,countycities.cfm?id=#id#" extranamelist="zips,cities" linkallactions="true">
	<cf_buildViewProperty column="county_id" visible="false">
	<cf_buildViewProperty column="state_id" input="select" references="state" link="stateview.cfm?id=[[id]]">
	<cf_buildViewProperty column="valid" visible="false">
</cf_buildView>

<cf_buildList title="Zip Codes in County" table="zip" code="zip" condition="z.county_id='#id#' and z.valid=1" by="#by#" dir="#dir#" page="#page#" rows="#rows#" edit="false" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="state_id" visible="false">
	<cf_buildListProperty column="county_id" visible="false">
	<cf_buildListProperty column="valid" visible="false">
</cf_buildList>

</cf_buildpage>