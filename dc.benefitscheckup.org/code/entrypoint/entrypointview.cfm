<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linkname" type="string" default="">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
	<cf_checkEntrypointErrors entrypoint_id="#id#" var="zipErrMsg">
<cfelse>
	<cf_checkAccess level="4">
	<cfset zipErrMsg = ''>
</cfif>

<cf_buildPage title="Entry Point Administration" section="entrypoint">

<cf_buildView table="entrypoint" code="entrypoint" key="#id#" action="#action#" saving="#saving#" title="Entry Point Data" editlevel="4">
	<cf_buildViewProperty column="code" visible="false" input="random" skipon="edit">
	<cf_buildViewProperty column="name" input="textarea" rows="2" cols="60" limit="255">
	<cf_buildViewProperty column="subname" size="60" limit="255">
	<cf_buildViewProperty column="address1" cols="60" limit="255">
	<cf_buildViewProperty column="address2" size="60" limit="255">
	<cf_buildViewProperty column="address3" size="60" limit="255">
	<cf_buildViewProperty column="city" size="60" limit="255">
	<cf_buildViewProperty column="state_id" input="select" references="state" condition="statetype_id in (1, 2)" valuetovar="passStateID">
	<cf_buildViewProperty column="zipcode" input="zip" validateagainst="state_id" message="#zipErrMsg#">
	<cf_buildViewProperty column="zipcode_plus4" input="plus4">
	<cf_buildViewProperty column="email" input="email" size="60" limit="255">
	<cf_buildViewProperty column="url" input="url" size="75" limit="255">
	<cf_buildViewProperty column="hours_display_id" input="display" rows="2" group="ephours" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="info_display_id" input="display" rows="8" group="epinfo" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="contact_title" limit="64">
	<cf_buildViewProperty column="contact_first" limit="64">
	<cf_buildViewProperty column="contact_middle" limit="64">
	<cf_buildViewProperty column="contact_last" limit="64">
	<cf_buildViewProperty column="contact_suffix" limit="64">
	<cf_buildViewProperty column="privatephone" limit="255">
	<cf_buildViewProperty column="last_update" input="date">
	<cf_buildViewProperty column="active_flag" input="flag">
	<cf_buildViewProperty column="notes" input="textarea" rows="10">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<br />
	<cf_buildList name="phoneAssociate" table="phone" code="phone" key="#id#" title="Phone Numbers" condition="entrypoint_id=#id#"order="sort" orderlinks="false" addlink="phoneview.cfm?new_entrypoint_id=#id#&action=new&name=phoneAssociate" editlevel="4" addlevel="4" delete="true" deletelevel="4" orderlink="phoneorder.cfm?id=#id#&name=phoneAssociate" orderlevel="4">
		<cf_buildListProperty column="phone_id" visible="false">
		<cf_buildListProperty column="entrypoint_id" visible="false">
		<cf_buildListProperty column="phonetype_id" references="phonetype">
	</cf_buildList>

	<cf_buildList name="cityAssociate" table="city" code="city" key="#id#" title="Cities Served" edit="false" crosstable="entrypoint_city" crosscolumn="entrypoint_id" crossvalue="#id#" joincolumn="city_id" crossorder="c.state_id, c.city_name" crossadd="false" crossdelete="false" linksection="zip" linkname="#linkname#" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" servedselectlink="cityselect.cfm?id=#id#" servedselectstate="#passStateID#" servedselectlevel="4">
		<cf_buildListProperty column="city_id" visible="false">
		<cf_buildListProperty column="pref_city_id" visible="false">
		<cf_buildListProperty column="exclude_flag" display="yesno">
		<cf_buildListProperty column="valid" display="yesno">
	</cf_buildList>

	<cf_buildList name="countyAssociate" table="county" code="county" key="#id#" title="Counties Served" edit="false" crosstable="entrypoint_county" crosscolumn="entrypoint_id" crossvalue="#id#" joincolumn="county_id" crossorder="cy.state_id, cy.county_name" crossadd="false" crossdelete="false" linksection="zip" linkname="#linkname#" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" servedselectlink="countyselect.cfm?id=#id#" servedselectstate="#passStateID#" servedselectlevel="4">
		<cf_buildListProperty column="county_id" visible="false">
		<cf_buildListProperty column="valid" display="yesno">
	</cf_buildList>

	<cf_buildList name="zipAssociate" table="zip" code="zip" key="#id#" title="Zip Codes Served" edit="false" crosstable="entrypoint_zip" crosscolumn="entrypoint_id" crossvalue="#id#" joincolumn="zipcode" crossorder="z.state_id, z.zipcode" crossadd="false" crossdelete="false" linksection="zip" linkname="#linkname#" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" servedselectlink="zipselect.cfm?id=#id#" servedselectstate="#passStateID#" servedselectlevel="4">
		<cf_buildListProperty column="county_id" references="county">
		<cf_buildListProperty column="valid" display="yesno">
		<cf_buildListProperty column="longitude" visible="false">
		<cf_buildListProperty column="latitude" visible="false">
	</cf_buildList>

	<cf_buildList name="entrypointgroupAssociate" table="entrypointgroup" code="entrypointgroup" key="#id#" title="Entry Point Group Associations" viewlink="entrypointgroupview.cfm?id=[[entrypointgroup_id]]&state_id=#passStateID#" editlevel="4" crossdeletelevel="4" crosstable="entrypoint_entrypointgroup" crosscolumn="entrypoint_id" crossvalue="#id#" joincolumn="entrypointgroup_id" crossorder="entrypointgroup_id" linkname="#linkname#" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false">
		<cf_buildListProperty column="state_id" references="state">
		<cf_buildListProperty column="active_flag" display="yesno">
		<cf_buildListProperty column="notes" visible="false">
	</cf_buildList>

</cfif>

</cf_buildpage>