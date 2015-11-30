<cfsilent>
<cfparam name="attributes.view" type="string" default="">
<cfparam name="attributes.var" type="string" default="viewList">

<!--- MH: 5/12/10 Removed reference to view_program_sort, view_subset_program_derived, view_xsubset_category since it is being archived on BCUQA --->
<!--- MH: Bug 5579 7/21/10 Removed reference to view_prg_dep, view_prg_dep_dep, view_tbl_req_mat, view_tbl_req_mat_list which are being archived--->
<cfif attributes.view eq ''>
	<cfset "caller.#attributes.var#" = 'view_city_county,view_city_zip_preferred,view_program_answerfield,view_program_parent,view_program_parent_1,view_program_parent_2,view_program_parent_3,view_program_parent_4,view_rule_answerfield,view_subset_program_base,view_subset_program_diff,view_subset_program_sum,view_subset_question,view_tbl_major_cat_list,view_tbl_prg_all,view_tbl_questions_new,view_tbl_rules,view_xsubset,view_xsubset_xincass,view_xsubset_xincometype,view_xsubset_xassettype,view_xsubset_program,view_zip_distance'>
<cfelse>

	<cfset caller.columns = ''>
	<cfset caller.keys = ''>
	<cfset caller.unique = ''>
	<cfset caller.identity = false>
	<cfset caller.tag = ''>
	<cfset caller.name = ''>
	<cfset caller.view = false>

	<cfswitch expression="#attributes.view#">

		<cfcase value="view_city_zip_preferred">
			<cfset caller.columns = 'city_id|City|s|1,zipcode|Zip|s|1'>
			<cfset caller.keys = 'city_id,zipcode'>
			<cfset caller.tag = 'vczp'>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="view_subset_question">
			<cfset caller.columns = 'subset_id|Subset|s|1,question_id|Question|s|1,display_id|Question&nbsp;Text|n|1,page_id|Page|s|1,pgsort|Pg.&nbsp;Sort|n|1,qsort|Q.&nbsp;Sort|n|1'>
			<cfset caller.keys = 'subset_id,question_id'>
			<cfset caller.tag = 'vsq'>
			<cfset caller.view = true>
		</cfcase>

	</cfswitch>

</cfif>
</cfsilent>