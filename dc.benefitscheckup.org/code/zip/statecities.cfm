<cfparam name="id" type="string" default="">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="State Data" section="zip">

<cf_buildView title="State Data" table="state" code="state" key="#id#" action="view" editlevel="0" extraurllist="stateview.cfm?id=#id#,statezips.cfm?id=#id#,statecities.cfm?id=#id#,statecarrierview.cfm?id=#id#,statesnapview.cfm?id=#id#" extranamelist="counties,zips,cities,carriers,snap">
	<cf_buildViewProperty column="statetype_id" visible="false">
</cf_buildView>
<br/>

<cf_buildList title="Cities in State" table="city" code="city" condition="c.state_id='#id#' and c.valid=1" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="2" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="state_id" visible="false">
	<cf_buildListProperty column="pref_city_id" references="city">
	<cf_buildListProperty column="exclude_flag" display="yesno">
	<cf_buildListProperty column="valid" visible="false">
</cf_buildList>

</cf_buildpage>
