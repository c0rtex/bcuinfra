table does not exist:
mp_dataelement 

tbl_hints
tbl_questions_new
- check autoincrement


add_ques3.cfm:
	update tbl_opt
	set field_nm = '1'
	where `option` in (1)
	;

`option` not found ???

add_user.cfm, add_user2.cfm:
	tbl_users does not exist

edit_list2.cfm:
	tbl_funding_list , tbl_entry_grp do not exist

edit_list3.cfm:
	tbl_fields_list, tbl_funding_list,tbl_entry_grp, tbl_req_mat_list, 	tbl_entry_grp do not exist

insert into tbl_major_cat_list major_cat,id_number,added_by,added_dt,mod_by,mod_dt)
			select '1', 1, '1', 1, '1', 1;

- unknown error


edit_ques2.cfm
		insert into tbl_hints
		(keyword, definition)
		values
		('1', '1')
hangs up ..


edit_user.cfm
- tbl_users  does not exist


reports.cfm:
	select distinct prg_nm,prg_id,st
	from tbl_prg;
	select count(prg_id) as prg_count
	from tbl_prg_1:

	tbl_prg, tbl_prg_1 do not exist


users.cfm
	tbl_users does not exist


contact_action.cfm:
	tbl_contacts does not exist

contact_srch2.cfm
	tbl_contacts does not exist

table 
	tbl_entry_grp  does not exist

getce.cfm
	tbl_entry does not exist

getcn.cfm:
	tbl_questions does not exist


frmMultipleChips_cf.cfm
	tbl_entry does not exist


displayinsert.cfm
	getactivelanguages - active_flag  -> active
	
code\entrypoint
	checkserved.cfm: tbl_entry does not exist

code\entrypoints\
	add_entry.cfm: tbl_entry, tbl_entry_grp do not exist
	add_spons2.cfm, deleteentry.cfm, editspons.cfm: tbl_entry do not exist


code\extra
	add_req_mat.cfm
		tbl_req_mat_list does not exist
	add_rule.cfm
		tbl_fields_list does not exist
	add_rule2_old.cfm
		tbl_fields_list does not exist, option-> option_nm
	add_rule3.cfm		
		tbl_prg does not exist
	del_rule.cfm
		tbl_elig_rules does not exist
	edit_rule.cfm
		tbl_elig_rules, tbl_fields_list do not exist
	elig_prg_list.cfm
		tbl_elig_rules_ak
	


code\fixup
	afxfer.cfm
		tbl_answerfield_prg does not exist


code\extra
	prg_rule.cfm	
		tbl_fields_list does not exist
	req_mat_del.cfm
		tbl_req_mat does not exist
	tagsetrule.cfm
		tbl_fields_list does not exist
		tbl_prg_fd does not exist
		tbl_inc does not exist
		tbl_inc_cnty does not exist


G:\LTN\W\DC\code\fixup\
	afxfer.cfm
		tbl_answerfield_prg does not exist




G:\LTN\W\DC\code\fixup\
	qxfer.cfm
		insert works ok - "set identity_insert tbl_questions_new on/off" dropped



G:\LTN\W\DC\code\fixup\
	rx.cfm
		insert into answerfield - "required_flag" does not have a default value
		"set identity_insert tbl_answerfield_list on/off" dropped 
		insert into tbl_opt - "opt_id" does not have a default value
		"set identity_insert tbl_generic on/off" dropped
		tbl_opt_generic does not exist


\DC\code\goto\
	goto.cfm
		tbl_entry, tbl_prg_entry do not exist

\DC\code\income_asset\
	asset_delete.cfm
		tbl_assetgrid does not exist


\DC\code\income_asset\
	frmIncome_asset_proc.cfm
		tbl_incomegrid does not exist
		tbl_assetgrid does not exist


\DC\code\income_asset\
	frmIncome_asset_show.cfm
		tbl_incomegrid does not exist
		tbl_assetgrid does not exist

\DC\code\income_asset\
	income_delete.cfm
		tbl_incomegrid does not exist

\DC\code\notes\
	note_display.cfm
		tbl_notes does not exist


\DC\code\notes\
	note_proc.cfm
		tbl_notes does not exist

\DC\code\notes\
	note_update.cfm
		tbl_notes does not exist


\DC\code\phoneno\
	phone_no.cfm
		tbl_entry does not exist


\DC\code\phoneno\
	proc_phone_no.cfm
		tbl_entry2 does not exist + suspicious syntax




\DC\code\rx\
	druglist.cfm
		<cfquery name="rx" datasource="#application.dbSrc#"> never ends


\DC\code\rx\
	drugqueries.cfm
		difference(substring('1', 1, 255), dl.display_text) returns 4 in MSSQL and 0 in MySQL - check UDF difference


\DC\code\tablescanner\
	tablecleaner.cfm, tablescanner.cfm
		sp_tables, sp_columns - rewrite 



\DC\code\upload\
	swap.cfm
	update.cfm
		check query sources



	


