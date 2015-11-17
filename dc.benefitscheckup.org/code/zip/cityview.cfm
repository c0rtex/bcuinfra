<cfparam name="id" type="string" default="">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cfquery name="citystate" datasource="#application.dbSrc#">
	select state_id
	from city
	where city_id='#id#'
</cfquery>
<cfif citystate.RecordCount>
	<cfset prefCityCondition = "state_id='#citystate.state_id#' and city_id != '#id#' and pref_city_id is null">
<cfelse>
	<cfset prefCityCondition = ''>
</cfif>

<cfquery name="preferred" datasource="#application.dbSrc#">
	select count(*) prefCount
	from city
	where pref_city_id='#id#'
</cfquery>

<cfquery name="postal" datasource="#application.dbSrc#">
	select count(*) postCount
	from city_zip
	where city_id='#id#'
		and postal_city_id is not null
		and valid=1
</cfquery>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="City Data" section="zip">

<cf_buildView title="City Data" table="city" code="city" key="#id#" action="#action#" saving="#saving#" editlevel="2">
	<cf_buildViewProperty column="city_id" visible="disableonedit">
	<cf_buildViewProperty column="city_name" visible="disableonedit">
	<cf_buildViewProperty column="state_id" input="select" references="state" link="stateview.cfm?id=[[id]]" visible="disableonedit">
	<cf_buildViewProperty column="pref_city_id" input="select" references="city" link="cityview.cfm?id=[[id]]" condition="#prefCityCondition#">
	<cf_buildViewProperty column="exclude_flag" input="flag">
	<cf_buildViewProperty column="valid" input="flag" visible="disableonedit">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<cfif preferred.prefCount>
		<br />
		<cf_buildList title="Preferred over Variants" table="city" code="city" editlevel="2" condition="c.pref_city_id='#id#'">
			<cf_buildListProperty column="state_id" visible="false">
			<cf_buildListProperty column="pref_city_id" visible="false">
			<cf_buildListProperty column="exclude_flag" display="yesno">
			<cf_buildListProperty column="valid" display="yesno">
		</cf_buildList>
	</cfif>

	<cf_buildList title="County" table="county" code="county" editlevel="2" condition="cy.valid=1" crosstable="view_city_county" crosscolumn="city_id" crossvalue="'#id#'" joincolumn="county_id" crossorder="cy.county_name" edit="false" crossadd="false" crossdelete="false">
		<cf_buildListProperty column="state_id" visible="false">
		<cf_buildListProperty column="valid" visible="false">
	</cf_buildList>

	<cf_buildList name="zipAssociate" table="zip" code="zip" title="Zip Codes in City" by="#by#" dir="#dir#" page="#page#" rows="#rows#" condition="xtbl.valid=1 and z.valid=1" crosstable="city_zip" crosscolumn="city_id" crossvalue="'#id#'" joincolumn="zipcode" crossorder="zipcode" crossorderlinks="true" edit="false" crossadd="false" crossdelete="false" selflink="true" selflinkid="#id#">
		<cf_buildListProperty column="state_id" visible="false">
		<cf_buildListProperty column="county_id" references="county">
		<cf_buildListProperty column="valid" visible="false">
	</cf_buildList>

	<cfif session.level eq 1 and postal.postCount>
		<cf_buildList title="Preferred P.O. Name for Some Zips" table="city" code="city" editlevel="2" condition="xtbl.city_id='#id#' and xtbl.postal_city_id is not null and xtbl.valid=1" crosstable="city_zip" crosscolumn="city_id" crossvalue="'#id#'" joincolumn="postal_city_id" crossadd="false" crossdelete="false">
			<cf_buildListProperty column="state_id" visible="false">
			<cf_buildListProperty column="pref_city_id" visible="false">
			<cf_buildListProperty column="exclude_flag" visible="false">
			<cf_buildListProperty column="valid" visible="false">
		</cf_buildList>
	</cfif>

</cfif>

</cf_buildpage>