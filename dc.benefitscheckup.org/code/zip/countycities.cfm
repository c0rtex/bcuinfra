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

<cf_buildPage title="Cities in County" section="zip">

<cf_buildView title="County Data" table="county" code="county" key="#id#" action="view" saving="#saving#" editlevel="0" extraurllist="countyzips.cfm?id=#id#,null" extranamelist="zips,cities" linkallactions="true">
	<cf_buildViewProperty column="county_id" visible="false">
	<cf_buildViewProperty column="state_id" input="select" references="state" link="stateview.cfm?id=[[id]]">
	<cf_buildViewProperty column="valid" visible="false">
</cf_buildView>

<cf_buildList title="Cities in County" table="city" code="city" editlevel="2" condition="c.valid=1" by="#by#" dir="#dir#" page="#page#" rows="#rows#" crosstable="view_city_county" crosscolumn="county_id" crossvalue="#id#" joincolumn="city_id" crossorder="c.city_name" crossadd="false" crossdelete="false" crossorderlinks="true" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="state_id" visible="false">
	<cf_buildListProperty column="pref_city_id" references="city">
	<cf_buildListProperty column="exclude_flag" display="yesno">
	<cf_buildListProperty column="valid" visible="false">
</cf_buildList>

</cf_buildpage>