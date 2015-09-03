<cfsilent>
<cfparam name="attributes.table" type="string" default="subset_program_sum" >
<cfparam name="attributes.subset_id" type="numeric" default="0">
<cfparam name="attributes.full" type="boolean" default="false">
<!--- 2005-06-26 BShunn:  Only worry about updating these tables from views on dev machines --->
<cfif application.subsetsUseViews>
	<cfif attributes.table eq 'subset_program_base' Or attributes.table eq 'subset_program_sum'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM #attributes.table#
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM #attributes.table#
				<cfif not attributes.full>
				WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#attributes.subset_id#">
				</cfif>
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO #attributes.table#
					(subset_id, program_id)
				SELECT subset_id, program_id
				FROM view_#attributes.table#
				<cfif not attributes.full>
				WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="4" value="#attributes.subset_id#">
				</cfif>
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'program_parent'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM program_parent
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM program_parent
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO program_parent
					(program_id, parent_program_id)
				SELECT program_id, parent_program_id
				FROM view_program_parent
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'program_answerfield'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM program_answerfield
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM program_answerfield
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO program_answerfield
					(program_id, answerfield_id, rule_flag)
				SELECT program_id, answerfield_id, rule_flag
				FROM view_program_answerfield
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'xsubset'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset
					(subset_id, subsettype_id, subset_name, subset_longname, subset_description, subset_text, qaire_name, alt_name, all_flag, drug_flag, grid_flag, optional_flag, rec_flag, eform_flag, schip_flag, state_flag, report_flag)
				SELECT subset_id, subsettype_id, subset_name, subset_longname, subset_description, subset_text, qaire_name, alt_name, all_flag, drug_flag, grid_flag, optional_flag, rec_flag, eform_flag, schip_flag, state_flag, report_flag
				FROM view_xsubset
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'xsubset_xincometype'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xincometype
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xincometype
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_xincometype
					(subset_id, incometype_id)
				SELECT subset_id, incometype_id
				FROM view_xsubset_xincometype
			</cfquery>
		</cfif>
    <cfelseif attributes.table eq 'xsubset_xassettype'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xassettype
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xassettype
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_xassettype
					(subset_id, assettype_id)
				SELECT subset_id, assettype_id
				FROM view_xsubset_xassettype
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'xsubset_xincass'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_xincass
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_xincass
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_xincass
					(subset_id, incass_id)
				SELECT subset_id, incass_id
				FROM view_xsubset_xincass
			</cfquery>
		</cfif>
    <!--- MH Bug 5229: 5/12/10 Removed reference to view_xsubset_category and xsubset_category since it is being archived 
	<cfelseif attributes.table eq 'xsubset_category'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_category
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_category
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_category
					(subset_id, category_id, exclude_flag)
				SELECT subset_id, category_id, exclude_flag
				FROM view_xsubset_category
			</cfquery>
		</cfif>--->
	<cfelseif attributes.table eq 'xsubset_program'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM xsubset_program
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM xsubset_program
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO xsubset_program
					(subset_id, program_id, exclude_flag)
				SELECT subset_id, program_id, exclude_flag
				FROM view_xsubset_program
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'tbl_major_cat_list'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_major_cat_list
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_major_cat_list
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_major_cat_list
					(major_cat, code, id_number, added_by, added_dt, mod_by, mod_dt, RecID, Sort_order)
				SELECT major_cat, code, id_number, added_by, added_dt, mod_by, mod_dt, RecID, Sort_order
				FROM view_tbl_major_cat_list
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'tbl_prg_all'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_prg_all
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_prg_all
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_prg_all
					(RecID, code, prg_id, order_num, pri_sec, prg_nm, prg_desc, st, proximity, firstproximity, comment, added_dt, added_by, mod_by, mod_dt, id, include, source, dollar_amount, Cat_ID, exclude_flag, inactive_flag, significant_flag, childrens_flag)
				SELECT RecID, code, prg_id, order_num, pri_sec, prg_nm, prg_desc, st, proximity, firstproximity, comment, added_dt, added_by, mod_by, mod_dt, id, include, source, dollar_amount, Cat_ID, exclude_flag, inactive_flag, significant_flag, childrens_flag
				FROM view_tbl_prg_all
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'tbl_questions_new'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_questions_new
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_questions_new
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_questions_new
					(question_id, answerfield, category, order_num, pri_sec, question, type, validation, client, textlength, dep_field, dep_op, dep_criteria, dep_formula)
				SELECT question_id, answerfield, category, order_num, pri_sec, question, type, validation, client, textlength, dep_field, dep_op, dep_criteria, dep_formula
				FROM view_tbl_questions_new
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'tbl_rules'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_rules
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_rules
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_rules
					(prg_id, elig_rule, pri_sec)
				SELECT prg_id, elig_rule, pri_sec
				FROM view_tbl_rules
			</cfquery>
		</cfif>
	 <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_req_mat, tbl_req_mat_list which are being archived
    <cfelseif attributes.table eq 'tbl_req_mat_list'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_req_mat_list
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_req_mat_list
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_req_mat_list
					(code, req_mat, added_by, added_dt, mod_by, mod_dt, mat_id, definition)
				SELECT code, req_mat, added_by, added_dt, mod_by, mod_dt, mat_id, definition
				FROM view_tbl_req_mat_list
			</cfquery>
		</cfif>
	<cfelseif attributes.table eq 'tbl_req_mat'>
		<cfif attributes.full>
			<cfquery name="clearQuery" datasource="#application.dbSrc#">
				DELETE FROM tbl_req_mat
			</cfquery>
		<cfelse>
			<cfquery name="countQuery" datasource="#application.dbSrc#">
				SELECT COUNT(*) AS rowct
				FROM tbl_req_mat
			</cfquery>
		</cfif>
		<cfif attributes.full or countQuery.rowct eq 0>
			<cfquery name="populateTable" datasource="#application.dbSrc#">
				INSERT INTO tbl_req_mat
					(prg_id, req_mat, added_by, added_dt, mod_by, mod_dt, mat_id)
				SELECT prg_id, req_mat, added_by, added_dt, mod_by, mod_dt, mat_id
				FROM view_tbl_req_mat
			</cfquery>
		</cfif>--->
	</cfif>
</cfif>
</cfsilent>