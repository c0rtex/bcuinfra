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

<cf_buildList view=false  name="stateCarrierAssociate" table="statecarrier" code="state" title="List of Carriers by State" order="state_id, name" condition="state_id='#id#'" addlink="statecarrier_edit.cfm?state=#id#&action=new" editlink="statecarrier_edit.cfm?state=#id#&statecarrier_id=[[statecarrier_id]]&action=edit" delete="true" deletelink="statecarrier_delete.cfm?state=#id#&statecarrier_id=[[statecarrier_id]]"add=true>
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="def_display_id" visible="false">
		<cf_buildListProperty column="description" visible="false"> 
	</cf_buildList>

</cf_buildpage>
