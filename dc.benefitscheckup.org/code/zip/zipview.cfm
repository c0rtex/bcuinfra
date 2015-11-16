<cfparam name="id" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Zip Code Data" section="zip">

<cf_buildView title="Zip Code Data" table="zip" code="zip" key="#id#" action="view" editlevel="0">
	<cf_buildViewProperty column="state_id" input="select" references="state" link="stateview.cfm?id=[[id]]">
	<cf_buildViewProperty column="county_id" input="select" references="county" link="countyview.cfm?id=[[id]]">
	<cf_buildViewProperty column="valid" input="flag">
</cf_buildView>

<cf_buildList name="cityAssociate" table="city" code="city" title="Cities in Zip Code" editlevel="2" condition="xtbl.valid=1 and c.valid=1" by="#by#" dir="#dir#" page="#page#" rows="#rows#" crosstable="city_zip" crosscolumn="zipcode" crossvalue="#id#" joincolumn="city_id" crossorder="c.city_name" crossorderlinks="true" crossadd="false" crossdelete="false" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="state_id" visible="false">
	<cf_buildListProperty column="pref_city_id" references="city">
	<cf_buildListProperty column="exclude_flag" display="yesno">
	<cf_buildListProperty column="valid" display="yesno">
</cf_buildList>

</cf_buildpage>