<cfparam name="id" type="numeric" default="0">

<cf_checkAccess level="5">

<cf_buildPage title="County Data" section="zip">

<cf_buildView title="County Data" table="county" code="county" key="#id#" action="view" editlevel="0" extraurllist="countyzips.cfm?id=#id#,countycities.cfm?id=#id#" extranamelist="zips,cities">
	<cf_buildViewProperty column="state_id" input="select" references="state" link="stateview.cfm?id=[[id]]">
	<cf_buildViewProperty column="valid" input="flag">
</cf_buildView>

</cf_buildpage>