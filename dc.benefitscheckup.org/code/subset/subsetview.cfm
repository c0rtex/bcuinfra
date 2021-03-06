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

<cf_buildPage title="Subset Administration" section="subset">

<cf_buildView title="Subset Data" table="subset" code="subset" key="#id#" action="#action#" saving="#saving#" extraurllist="subsetverbose.cfm?id=#id#,subsetdiff.cfm?id=#id#,subsetquestions.cfm?id=#id#" extranamelist="programs,helpers,app&nbsp;questions">
	<cf_buildViewProperty column="subsettype_id" input="select" references="subsettype" condition="subsettype_id not in (2, 4)" valuetovar="subsetTypeID">
	<cf_buildViewProperty column="code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="subset" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="alt_display_id" input="display" rows="1" group="subalt" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="spq_display_id" input="display" rows="1" group="subspq" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="intro_display_id" input="display" rows="8" group="subintro" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="resultpage_id" input="select" references="resultpage">
	<cf_buildViewProperty column="shadow_subset_id" input="select" references="subset" condition="subset_id != #id#">
	<cf_buildViewProperty column="branding_partner_id" input="select" references="tbl_partner">
	<cf_buildViewProperty column="active_flag" input="flag">
	<cf_buildViewProperty column="test_flag" input="flag" default="no">
	<cf_buildViewProperty column="eform_flag" input="flag" default="no">
	<cf_buildViewProperty column="report_flag" input="flag">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<br />
	<cf_buildList name="defaultAssociate" title="Answerfield Default Values" table="answerfield_subset_partner" code="answerfield" condition="asp.subset_id=#id#" order="partner_id, answerfield_id" orderlinks="false" view="false" editlink="subsetdefaultedit.cfm?answerfield_id=[[answerfield_id]]&subset_id=[[subset_id]]&partner_id=[[partner_id]]&action=edit&name=defaultAssociate" delete="true" deletelink="subsetdefaultdelete.cfm?answerfield_id=[[answerfield_id]]&subset_id=[[subset_id]]&partner_id=[[partner_id]]" reverseadd="true" reverseaddtable="answerfield" reverseaddcolumn="subset_id" reverseaddvalue="#id#" reverseaddlink="subsetdefaultview.cfm?action=new">
		<cf_buildListProperty column="answerfield_id" references="answerfield">
		<cf_buildListProperty column="subset_id" visible="false">
		<cf_buildListProperty column="partner_id" references="tbl_partner">
		<cf_buildListProperty column="default_value" display="default">
		<cf_buildListProperty column="background_flag" display="yesno">
	</cf_buildList>

	<cfif subsetTypeID eq 5>
		<br />
		<cf_buildList name="afAssociate" title="Other Answerfield Attributes" table="subset_answerfield" code="answerfield" condition="sa.subset_id=#id#" order="answerfield_id" orderlinks="false" view="false" editlink="subsetanswerfieldedit.cfm?subset_id=[[subset_id]]&answerfield_id=[[answerfield_id]]&action=edit&name=afAssociate" delete="true" deletelink="subsetanswerfielddelete.cfm?subset_id=[[subset_id]]&answerfield_id=[[answerfield_id]]" reverseadd="true" reverseaddtable="answerfield" reverseaddcolumn="subset_id" reverseaddvalue="#id#" reverseaddcondition="answerfield_id not in (select answerfield_id from subset_answerfield where subset_id=#id#)" reverseaddlink="subsetanswerfieldview.cfm?action=new">
			<cf_buildListProperty column="subset_id" visible="false">
			<cf_buildListProperty column="answerfield_id" references="answerfield">
			<cf_buildListProperty column="recap_id" display="yesno">
			<cf_buildListProperty column="required" display="yesno">
			<cf_buildListProperty column="preset_value" visible="false">
		</cf_buildList>
	</cfif>

	<cf_buildList name="shadowAssociate" title="Alternate Partner Shadow Subsets" table="subset_partner_shadow" code="partner" condition="spw.subset_id=#id#" order="partner_id" orderlinks="false" view="false" editlink="partnershadowedit.cfm?subset_id=[[subset_id]]&partner_id=[[partner_id]]&action=edit&name=shadowAssociate" delete="true" deletelink="partnershadowdelete.cfm?subset_id=[[subset_id]]&partner_id=[[partner_id]]" selflink="true" reverseadd="true" reverseaddtable="tbl_partner" reverseaddcolumn="subset_id" reverseaddvalue="#id#" reverseaddcondition="pr.partner_id not in (select partner_id from subset_partner_shadow where subset_id=#id#)" reverseaddlink="partnershadowview.cfm?action=new">
		<cf_buildListProperty column="subset_id" visible="false">
		<cf_buildListProperty column="partner_id" references="tbl_partner">
		<cf_buildListProperty column="shadow_subset_id" references="subset">
	</cf_buildList>

	<cfif subsetTypeID neq 5>
		<cf_buildList name="questionInclude" table="question" code="question" title="Included Questions" key="#id#" crosstable="subset_question" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=0" crossorder="q.sort" linkname="#linkname#" linksection="question" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="required_flag|0,exclude_flag|0,options_flag|0">
			<cf_buildListProperty column="dep_question_id" visible="false">
			<cf_buildListProperty column="questioncategory_id" references="questioncategory">
			<cf_buildListProperty column="questionheader_id" visible="false">
			<cf_buildListProperty column="questiontype_id" visible="false">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="short_display_id" visible="false">
			<cf_buildListProperty column="spq_display_id" visible="false">
			<cf_buildListProperty column="print_display_id" visible="false">
			<cf_buildListProperty column="format_id" visible="false">
			<cf_buildListProperty column="rule_id" visible="false">
			<cf_buildListProperty column="include_flag" visible="false">
			<cf_buildListProperty column="exclude_flag" visible="false">
			<cf_buildListProperty column="suppress_qno_flag" visible="false">
			<cf_buildListProperty column="spq_exclude_flag" visible="false">
			<cf_buildListProperty column="sort" visible="false">
			<cf_buildListProperty column="create_user_id" visible="false">
			<cf_buildListProperty column="create_date" visible="false">
			<cf_buildListProperty column="modify_user_id" visible="false">
			<cf_buildListProperty column="modify_date" visible="false">
		</cf_buildList>
	</cfif>
	
	<cf_buildList name="questionExclude" table="question" code="question" title="Excluded Questions" key="#id#" crosstable="subset_question" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=1" crossorder="q.sort" linkname="#linkname#" linksection="question" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="required_flag|0,exclude_flag|1,options_flag|0">
		<cf_buildListProperty column="dep_question_id" visible="false">
		<cf_buildListProperty column="questioncategory_id" references="questioncategory">
		<cf_buildListProperty column="questionheader_id" visible="false">
		<cf_buildListProperty column="questiontype_id" visible="false">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="short_display_id" visible="false">
		<cf_buildListProperty column="spq_display_id" visible="false">
		<cf_buildListProperty column="print_display_id" visible="false">
		<cf_buildListProperty column="format_id" visible="false">
		<cf_buildListProperty column="rule_id" visible="false">
		<cf_buildListProperty column="include_flag" visible="false">
		<cf_buildListProperty column="exclude_flag" visible="false">
		<cf_buildListProperty column="suppress_qno_flag" visible="false">
		<cf_buildListProperty column="spq_exclude_flag" visible="false">
		<cf_buildListProperty column="sort" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>
	
	<cfif subsetTypeID neq 5>
		<cf_buildList name="gridrowExclude" table="gridrow" code="gridrow" title="Excluded Grid Rows" key="#id#" crosstable="subset_gridrow" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=1" crossorder="gr.sort" linkname="#linkname#" linksection="question" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|1">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="help_id" visible="false">
			<cf_buildListProperty column="description" visible="false">
			<cf_buildListProperty column="sort" visible="false">
			<cf_buildListProperty column="exclude_flag" visible="false">
		</cf_buildList>
	
		<cf_buildList name="gridrowInclude" table="gridrow" code="gridrow" title="Included Grid Rows" key="#id#" crosstable="subset_gridrow" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=0" crossorder="gr.sort" linkname="#linkname#" linksection="question" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|0">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="help_id" visible="false">
			<cf_buildListProperty column="description" visible="false">
			<cf_buildListProperty column="sort" visible="false">
			<cf_buildListProperty column="exclude_flag" visible="false">
		</cf_buildList>
	</cfif>

	<cfif subsetTypeID neq 5>
		<cfif IsDefined('subsetTypeID') and subsetTypeID eq 6>
			<cfset prgLoopList = '1,0'>
			<cf_buildList name="categoryExclude" table="programcategory" code="programcategory" title="Excluded Categories" key="#id#" crosstable="subset_programcategory" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=1" crossorder="pc.code" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|1">
				<cf_buildListProperty column="display_id" display="display">
				<cf_buildListProperty column="description" visible="false">
				<cf_buildListProperty column="legacy_code" visible="false">
				<cf_buildListProperty column="sort" visible="false">
			</cf_buildList>
		<cfelse>
			<cfset prgLoopList = '0,1'>
			<cf_buildList name="categoryInclude" table="programcategory" code="programcategory" title="Included Categories" key="#id#" crosstable="subset_programcategory" crosscolumn="subset_id" crossvalue="#id#" condition="xtbl.exclude_flag=0" crossorder="pc.code" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|0">
				<cf_buildListProperty column="display_id" display="display">
				<cf_buildListProperty column="description" visible="false">
				<cf_buildListProperty column="legacy_code" visible="false">
				<cf_buildListProperty column="sort" visible="false">
			</cf_buildList>
		</cfif>

		<cfloop list="#prgLoopList#" index="prgLoopPos">
			<cfswitch expression="#prgLoopPos#">
				<cfcase value="0">
					<cf_buildList name="programExclude" table="program" code="program" title="Excluded Programs" key="#id#" crosstable="subset_program" crosscolumn="subset_id" crossvalue="#id#" joincolumn="program_id" condition="xtbl.exclude_flag=1" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|1">
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
				</cfcase>
				<cfcase value="1">
					<cf_buildList name="programInclude" table="program" code="program" title="Included Programs" key="#id#" crosstable="subset_program" crosscolumn="subset_id" crossvalue="#id#" joincolumn="program_id" condition="xtbl.exclude_flag=0" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#" linkhassort="false" linkextrainsert="exclude_flag|0">
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
				</cfcase>
			</cfswitch>
		</cfloop>
	</cfif>

	<cf_buildList name="reqAssociate" table="requisite" code="requisite" title="Requisite Items (Needed Info)" key="#id#" crosstable="subset_requisite" crosscolumn="subset_id" crossvalue="#id#" crossorder="sort" crossreorderlink="subsetrequisiteorder.cfm?id=#id#&name=reqAssociate" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="def_display_id" visible="false">
		<cf_buildListProperty column="description" visible="false">
	</cf_buildList>

		<br />
	
	<cfquery name="subset_sections" datasource="#application.dbSrc#">
	select distinct(section_code) from subset_content
	WHERE subset_id=#id#
	</cfquery>
	<cfloop query="subset_sections" >
	<!--- MQC3 consumer_recs --->
	 <cfset section_code = subset_sections.section_code>
         <cf_buildList view=false  name="subsetContentWaysToGetHelpConsumerAssociate" table="subset_content" code="subset_content" title="Subset Content (Report Content Sorting): #section_code# recs" order="section_code, sort_order" condition="section_code='#section_code#' and subset_id=#id#" orderlink="subsetcontentorder.cfm?id=#id#&name=subsetContentAssociate&section_code=#section_code#" addlink="subset_contentview.cfm?subset_id=#id#&post_code=[[post_code]]&section_code=[[section_code]]&action=new" editlink="subset_contentview.cfm?subset_id=#id#&post_code=[[post_code]]&section_code=[[section_code]]&action=edit" delete="true" deletelink="subset_contentdelete.cfm?subset_id=#id#&post_code=[[post_code]]&section_code=[[section_code]]"add=true>
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="def_display_id" visible="false">
		<cf_buildListProperty column="description" visible="false"> 
	</cf_buildList>  

		<br />
	</cfloop>







</cfif>

</cf_buildPage>
