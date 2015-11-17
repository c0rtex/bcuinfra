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

<cfset redirect = false>
<cfif linktable eq 'program_rule' and linkaction eq 'delete' and IsNumeric(linkid)>
	<cfquery name="rxded" datasource="#application.dbSrc#">
		select rx_program_id
		from `rule`
		where rule_id=#linkid#
	</cfquery>
	<cfif rxded.RecordCount and rxded.rx_program_id neq ''>
		<cfset redirect = true>
	</cfif>
</cfif>

<cfif redirect>
	<cflocation url="../rule/ruleview.cfm?id=#linkid#&action=edit" addtoken="no">
<cfelse>
	<cfif action eq 'view'>
		<cf_checkAccess level="5">
	<cfelse>
		<cf_checkAccess level="3">
	</cfif>
	
	<cf_buildPage title="Individual Program" section="program">
	
	<cf_buildView table="program" code="program" key="#id#" action="#action#" saving="#saving#" title="Individual Program" extraurllist="programsubsets.cfm?id=#id#,programanalyze.cfm?id=#id#" extranamelist="subsets,analyze">
		<cf_buildViewProperty column="programcategory_id" input="select" references="programcategory">
		<cf_buildViewProperty column="programgroup_id" input="select" references="programgroup">
		<cf_buildViewProperty column="state_id" input="select" references="state" condition="statetype_id < 3" valuetovar="passStateID">
		<cf_buildViewProperty column="program_code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
		<cf_buildViewProperty column="name_display_id" input="display" rows="2" group="program" namefrom="program_code" codefrom="program_code">
		<cf_buildViewProperty column="desc_display_id" input="display" rows="8" group="prgdesc" namefrom="program_code" codefrom="program_code">
		<cf_buildViewProperty column="url" limit="255">
		<cf_buildViewProperty column="exclude_flag" input="flag" default="no">
		<cf_buildViewProperty column="significant_flag" input="flag" default="no">
		<cf_buildViewProperty column="active_flag" input="flag">
		<cf_buildViewProperty column="funder_id" input="select" references="funder" addlink="../misc/funderview.cfm">
		<cf_buildViewProperty column="reference_id" input="select" references="reference" addlink="../misc/referenceview.cfm">
		<cf_buildViewProperty column="supersort" input="supersort">
		<cf_buildViewProperty column="sort" visible="false" increment="1">
		<cf_buildViewProperty column="last_update" input="date">
		<cf_buildViewProperty column="notes" input="textarea" rows="8">
		<cf_buildViewProperty column="legacy_prg_id" visible="viewonly">
		<cf_buildViewProperty column="legacy_pri_sec" visible="viewonly">
		<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
		<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
		<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
		<cf_buildViewProperty column="modify_date" visible="false" input="date">
	</cf_buildView>
	
	<cfif action eq 'view' or hasSaved>
	
		<cf_buildList name="valueAssociate" title="Program Values" table="programvalue" code="programvalue" condition="pv.program_id=#id#" delete="true" order="state_id, start_date desc, pv.end_date" orderlinks="false" by="#by#" dir="#dir#" selflink="true" addlink="programvalueview.cfm?new_program_id=#id#&action=new&name=valueAssociate">
			<cf_buildListProperty column="programvalue_id" visible="false">
			<cf_buildListProperty column="program_id" visible="false">
			<cf_buildListProperty column="dollarvalue" display="dollar">
			<cf_buildListProperty column="start_date" display="date">
			<cf_buildListProperty column="end_date" display="date">
			<cf_buildListProperty column="rule_text" visible="false">
		</cf_buildList>
	
		<cf_buildList name="ruleAssociate" table="rule" code="rule" title="Eligibility Rules" key="#id#" crosstable="program_rule" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossaddcondition="rx_program_id is null" crossreorderlink="programruleorder.cfm?id=#id#&name=ruleAssociate" linkname="#linkname#" linksection="rule" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
			<cf_buildListProperty column="code" visible="false">
			<cf_buildListProperty column="description" visible="false">
			<cf_buildListProperty column="rx_program_id" display="notnull">
			<cf_buildListProperty column="legacy_pri_sec" visible="false">
		</cf_buildList>
	
		<cf_buildList title="Associated Answerfields" table="answerfield" code="answerfield" crosstable="view_program_answerfield" crosscolumn="program_id" crossvalue="#id#" joincolumn="answerfield_id" crossorder="a.answerfield" crossadd="false" crossdelete="false" linksection="answerfield">
			<cf_buildListProperty column="answerfieldtype_id" references="answerfieldtype">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="short_display_id" visible="false">
			<cf_buildListProperty column="spq_display_id" visible="false">
			<cf_buildListProperty column="print_display_id" visible="false">
			<cf_buildListProperty column="max_length" visible="false">
			<cf_buildListProperty column="default_value" visible="false">
			<cf_buildListProperty column="spq_default_value" visible="false">
			<cf_buildListProperty column="oe_default_value" visible="false">
			<cf_buildListProperty column="required_flag" visible="false">
			<cf_buildListProperty column="rx_required_flag" visible="false">
			<cf_buildListProperty column="rule_id" visible="false">
			<cf_buildListProperty column="validation_id" visible="false">
			<cf_buildListProperty column="answerfield_desc" visible="false">
			<cf_buildListProperty column="create_user_id" visible="false">
			<cf_buildListProperty column="create_date" visible="false">
			<cf_buildListProperty column="modify_user_id" visible="false">
			<cf_buildListProperty column="modify_date" visible="false">
		</cf_buildList>
	
		<cf_buildList name="proxAssociate" table="proximity" code="proximity" title="Associated Proximity Methods" editlevel="1" key="#id#" crosstable="program_proximity" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossreorderlink="programproximityorder.cfm?id=#id#&name=proxAssociate" linkname="#linkname#" linksection="zip" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
			<cf_buildListProperty column="description" visible="false">
		</cf_buildList>
	
		<cf_buildList name="reqAssociate" table="requisite" code="requisite" title="Requisite Items" key="#id#" crosstable="program_requisite" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossreorderlink="programrequisiteorder.cfm?id=#id#&name=reqAssociate" linkname="#linkname#" linksection="program" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="def_display_id" visible="false">
			<cf_buildListProperty column="description" visible="false">
		</cf_buildList>
	
		<cf_buildList name="formAssociate" table="form" code="form" title="Associated Forms" editlink="formedit.cfm?id=[[id]]" key="#id#" crosstable="program_form" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossreorderlink="programformorder.cfm?id=#id#&name=formAssociate" linkname="#linkname#" linksection="form" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
			<cf_buildListProperty column="formtag_id" visible="false">
			<cf_buildListProperty column="description" visible="false">
		</cf_buildList>

		<cfif passStateID eq ''>
			<cfset passStateParam = ''>
		<cfelse>
			<cfset passStateParam = "&state_id=#passStateID#">
		</cfif>
		<cf_buildList name="epgAssociate" table="entrypointgroup" code="entrypointgroup" title="Entry Group Associations" viewlink="entrypointgroupview.cfm?id=[[id]]#passStateParam#" editlevel="4" crosstable="program_entrypointgroup" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossreorderlink="programentrypointgrouporder.cfm?id=#id#&name=epgAssociate" linkname="#linkname#" linksection="entrypoint" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
			<cf_buildListProperty column="state_id" visible="false">
			<cf_buildListProperty column="active_flag" display="yesno">
			<cf_buildListProperty column="notes" visible="false">
		</cf_buildList>
	</cfif>
	
	</cf_buildPage>

</cfif>