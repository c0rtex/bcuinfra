* countDrugsRounded.cfm - view_tally <-- view does not exist (references inexistent table)

* countProgramsRounded.cfm - view_tally <-- view does not exist (references inexistent table)

* loopRxStruct.cfm - #alias# ??? - could not run; however, syntax is ok

* populateTableFromView.cfm - #attributes.table#??? - could not run; however, syntax is ok
<cfquery name="clearQuery" datasource="#application.dbSrc#">
DELETE FROM tbl_req_mat  <-- table does not exist in source database
</cfquery>


* queryDisplaySorted.cfm

incorrect source code:

select d.display_id, d.display_code, max(l.default_flag + q.target_flag + sign(len(cast( dl.display_text))) as varchar(255)) language_key_id


* tagYeDumpSessionVariables.cfm

tbl_inc_cnty <-- table does not exist in source database


* tagYeReportEntry.cfm

tbl_entry, tbl_prg_entry, tbl_userprograms <-- tables do not exist in source database

* tagZipRad.cfm - check cast as int


