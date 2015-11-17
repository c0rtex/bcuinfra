<cfparam name="id" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Program Subsets" section="program">

<cf_buildView title="Abbreviated Program Data" table="program" code="program" key="#id#" action="view" extraurllist="null,programanalyze.cfm?id=#id#" extranamelist="subsets,analyze" linkallactions="true">
	<cf_buildViewProperty column="programcategory_id" visible="false">
	<cf_buildViewProperty column="programgroup_id" visible="false">
	<cf_buildViewProperty column="state_id" input="select" references="state">
	<cf_buildViewProperty column="name_display_id" input="display">
	<cf_buildViewProperty column="desc_display_id" visible="false">
	<cf_buildViewProperty column="url" visible="false">
	<cf_buildViewProperty column="exclude_flag" visible="false">
	<cf_buildViewProperty column="significant_flag" visible="false">
	<cf_buildViewProperty column="active_flag" visible="false">
	<cf_buildViewProperty column="funder_id" visible="false">
	<cf_buildViewProperty column="reference_id" visible="false">
	<cf_buildViewProperty column="last_update" visible="false">
	<cf_buildViewProperty column="notes" visible="false">
	<cf_buildViewProperty column="supersort" visible="false">
	<cf_buildViewProperty column="sort" visible="false">
	<cf_buildViewProperty column="legacy_prg_id" visible="false">
	<cf_buildViewProperty column="legacy_pri_sec" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false">
	<cf_buildViewProperty column="create_date" visible="false">
	<cf_buildViewProperty column="modify_user_id" visible="false">
	<cf_buildViewProperty column="modify_date" visible="false">
</cf_buildView><br />

<cf_buildList title="Subsets Including This Program" table="subset" code="subset" order="subset_id" by="#by#" dir="#dir#" page="#page#" rows="#rows#" crosstable="view_subset_program_base" crosscolumn="program_id" crossvalue="#id#" joincolumn="subset_id" crossorder="subset_id" crossadd="false" crossdelete="false" crossorderlinks="true" linksection="subset" selflink="true" selflinkid="#id#">
	<cf_buildListProperty column="subsettype_id" references="subsettype">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="alt_display_id" display="display" visible="false">
	<cf_buildListProperty column="spq_display_id" display="display" visible="false">
	<cf_buildListProperty column="oe_name" visible="false">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="intro_display_id" display="display" visible="false">
	<cf_buildListProperty column="resultpage_id" visible="false">
	<cf_buildListProperty column="shadow_subset_id" visible="false">
	<cf_buildListProperty column="branding_partner_id" visible="false">
	<cf_buildListProperty column="active_flag" display="yesno">
	<cf_buildListProperty column="test_flag" display="yesno">
	<cf_buildListProperty column="eform_flag" display="yesno">
	<cf_buildListProperty column="report_flag" display="yesno">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>