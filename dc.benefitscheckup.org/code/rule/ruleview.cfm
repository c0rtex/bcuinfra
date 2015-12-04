<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">





<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<!--- Don't allow editing if this is an rx-dedicated rule --->
<cfset rxdedit = ''>
<cfif action eq 'edit'>
	<cfquery name="rxded" datasource="#application.dbSrc#">
		select r.code, r.rule_text, r.rx_program_id, p.program_id, p.program_code
		from `rule` r, program p
		where r.rule_id=#id# 
			and r.rx_program_id=p.program_id
                    
	</cfquery>
	<cfif rxded.RecordCount gt 0>
		<cfset rxdedit = rxded.rx_program_id>
	</cfif>
</cfif>

<cf_buildPage title="Eligibility Rule" section="rule">

<cfquery name="postCode" datasource="#application.dbSrcWp#">
		select r.code, wppm.post_id
		from #preservesinglequotes(application.dbNameBCU)#.rule r, #preservesinglequotes(application.dbNameWP)#.wp_postmeta wppm, #preservesinglequotes(application.dbNameWP)#.wp_posts wpp
		where r.rule_id=#id#
                        and wppm.meta_key='post_code'				
                        and r.code=wppm.meta_value
			and wppm.post_id = wpp.id
			and wpp.post_type = 'post'
	</cfquery>

<cfoutput query="postCode" > <!---Lynna Cekova: starting at 2 --->

		<tr bgcolor="#application.color.rule.med#">
			<td valign="top"><font size="+1"><b>WordPress Post:</b></font></td>
			<td bgcolor="#application.color.rule.light#"><font size="+1"><a target="_new" href="https://redesign.benefitscheckup.org/wp-admin/post.php?post=#post_id#&action=edit">https://redesign.benefitscheckup.org/wp-admin/post.php?post=#post_id#&action=edit</font></td></a>
		</tr>
</cfoutput>


<cfif rxdedit eq ''>
	<cf_buildView table="rule" code="rule" key="#id#" action="#action#" saving="#saving#" title="Eligibility Rule" callonsave="updateRuleAssociations">
		<cf_buildViewProperty column="code" limit="64" case="lower" restriction="alphanumeric">
		<cf_buildViewProperty column="description" input="textarea" rows="3" cols="75" limit="255">
		<cf_buildViewProperty column="rule_text" input="rule" rows="12" cols="75">

		<cf_buildViewProperty column="rx_program_id" input="select" references="program" skipon="new" visible="disableonedit" link="../program/programview.cfm?id=[[id]]">
		<cf_buildViewProperty column="legacy_pri_sec" visible="viewonly">
	</cf_buildView>
<cfelse>
	<cfoutput>
	<cfset hasSaved = false>
	<table border="0" cellpadding="3" cellspacing="3">
		<tr bgcolor="#application.color.rule.dark#">
			<td colspan="2"><font size="+2"><b>Eligibility Rule</b></font></td>
		</tr>
		<tr bgcolor="#application.color.rule.med#">
			<td colspan="2"><cf_checkAccessLink level="5" href="ruleview.cfm?id=#id#">view</cf_checkAccessLink> | <b>edit</b></td>
		</tr>
		<tr bgcolor="#application.color.error.med#">
			<td valign="top" width="10%"><font size="+1"><b>IMPORTANT&nbsp;NOTE</b></font></td>
			<td bgcolor="#application.color.error.light#">This is a dedicated Rx-program rule, which means that it is only applicable to a single program <b>(#rxded.program_code#)</b> and cannot ever be associated with any other program.  Furthermore, this rule can only be edited through the <b>rx</b> interface, by associating and dissociating drugs.  If you want to go to that interface, please <cf_checkAccessLink level="5" href="../rx/programview.cfm?program_id=#rxded.program_id#">click here</cf_checkAccessLink>.</td>
		</tr>
		<tr bgcolor="#application.color.rule.med#">
			<td valign="top" width="10%"><font size="+1"><b>ID</b></font></td>
			<td bgcolor="#application.color.rule.light#"><font size="+1">#id#</font></td>
		</tr>
		<tr bgcolor="#application.color.rule.med#">
			<td valign="top"><font size="+1"><b>Code</b></font></td>
			<td bgcolor="#application.color.rule.light#"><font size="+1">#rxded.code#</font></td>
		</tr>
		<tr bgcolor="#application.color.rule.med#">
			<td valign="top"><font size="+1"><b>Rule</b></font></td>
			<td bgcolor="#application.color.rule.light#"><font size="+1">#rxded.rule_text#</font></td>
		</tr>

		<tr bgcolor="#application.color.rule.med#">
			<td valign="top"><font size="+1"><b>Dedicated</b></font></td>
			<td bgcolor="#application.color.rule.light#"><font size="+1"><cf_checkAccessLink level="5" href="../program/programview.cfm?id=#rxded.program_id#">#rxded.program_code#</cf_checkAccessLink></font></td>
		</tr>
	</table>
	</cfoutput>
</cfif>

<cfif action eq 'view' or hasSaved>

	<cf_buildList title="Answerfield Associations" table="answerfield" code="answerfield" crosstable="rule_answerfield" crosscolumn="rule_id" crossvalue="#id#" crossorder="a.answerfield" crossadd="false" crossdelete="false" linksection="answerfield">
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

	<cf_buildList table="program" code="program" title="Program Associations" crosstable="program_rule" crosscolumn="rule_id" crossvalue="#id#" crossorder="sort" crossadd="false" crossdelete="false" linksection="program">
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
