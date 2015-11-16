<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Individual Program Category" section="program">

<cf_buildView title="Individual Program Category" table="programcategory" code="programcategory" key="#id#" action="#action#" saving="#saving#" extraurllist="programcategoryprogramorder.cfm?id=#id#" extranamelist="program order">
	<cf_buildViewProperty column="display_id" input="display" rows="6" group="prgcat" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="code" limit="16" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
	<cf_buildViewProperty column="legacy_code" visible="viewonly">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

<cfif action eq 'view' or hasSaved>
	
	<br />
	<cf_buildList name="programAssoc" title="Programs in Category" table="program" code="program" condition="p.programcategory_id=#id#" linksection="program" order="sort" orderlinks="false">
		<cf_buildListProperty column="programcategory_id" visible="false">
		<cf_buildListProperty column="programgroup_id" references="programgroup">
		<cf_buildListProperty column="name_display_id" display="display">
		<cf_buildListProperty column="desc_display_id" visible="false">
		<cf_buildListProperty column="url" visible="false">
		<cf_buildListProperty column="exclude_flag" visible="false">
		<cf_buildListProperty column="significant_flag" visible="false">
		<cf_buildListProperty column="active_flag" visible="false">
		<cf_buildListProperty column="funder_id" visible="false">
		<cf_buildListProperty column="reference_id" visible="false">
		<cf_buildListProperty column="notes" visible="false">
		<cf_buildListProperty column="last_update" visible="false">
		<cf_buildListProperty column="legacy_pri_sec" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

</cfif>

</cf_buildPage>