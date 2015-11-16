<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
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

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Requisite Item" section="program">

<cf_buildView table="requisite" code="requisite" key="#id#" action="#action#" saving="#saving#" title="Requisite Item">
	<cf_buildViewProperty column="code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="display_id" input="display" rows="2" group="requisite" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="def_display_id" input="display" rows="6" group="prgdesc" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="description" input="textarea" rows="3" cols="50" limit="255">
</cf_buildView>

<!--- MH: 4-6-10 Added Associated Programs List to Requisite View Page --->
<cfif action eq 'view' or hasSaved>
	<cf_buildList title="Associated Programs" table="program" code="program" by="#by#" dir="#dir#" page="#page#" rows="#rows#" crosstable="program_requisite" crosscolumn="requisite_id" crossvalue="#id#" joincolumn="program_id" crossorder="program_id" crossadd="false" crossdelete="false" crossorderlinks="true" linksection="program" selflink="true" selflinkid="#id#">
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
		<cf_buildListProperty column="legacy_pri_sec" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>
</cfif>
</cf_buildPage>