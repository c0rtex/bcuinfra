<cfparam name="id" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Subset Administration" section="subset">

<cf_buildView title="Abbreviated Subset Data" table="subset" code="subset" key="#id#" action="view" extraurllist="subsetverbose.cfm?id=#id#,null,subsetquestions.cfm?id=#id#" extranamelist="programs,helpers,app&nbsp;questions" linkallactions="true">
	<cf_buildViewProperty column="subsettype_id" input="select" references="subsettype" condition="subsettype_id not in (2, 4)">
	<cf_buildViewProperty column="code" limit="32" case="lower" visible="disableonedit">
	<cf_buildViewProperty column="description" visible="false">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="subset" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="alt_display_id" visible="false">
	<cf_buildViewProperty column="spq_display_id" visible="false">
	<cf_buildViewProperty column="intro_display_id" visible="false">
	<cf_buildViewProperty column="oe_name" visible="false">
	<cf_buildViewProperty column="resultpage_id" visible="false">
	<cf_buildViewProperty column="shadow_subset_id" visible="false">
	<cf_buildViewProperty column="branding_partner_id" visible="false">
	<cf_buildViewProperty column="active_flag" visible="false">
	<cf_buildViewProperty column="test_flag" visible="false">
	<cf_buildViewProperty column="eform_flag" visible="false">
	<cf_buildViewProperty column="report_flag" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false">
	<cf_buildViewProperty column="create_date" visible="false">
	<cf_buildViewProperty column="modify_user_id" visible="false">
	<cf_buildViewProperty column="modify_date" visible="false">
</cf_buildView><br />

<cf_buildList title="Helper Programs in Subset" table="program" code="program" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#" crosstable="view_subset_program_diff" crosscolumn="subset_id" crossvalue="#id#" joincolumn="program_id" crossorder="program_id" crossadd="false" crossdelete="false" crossorderlinks="true" linksection="program" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="programcategory_id" references="programcategory">
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
	<cf_buildListProperty column="supersort" visible="false">
	<cf_buildListProperty column="sort" visible="false">
	<cf_buildListProperty column="legacy_pri_sec" visible="false">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>