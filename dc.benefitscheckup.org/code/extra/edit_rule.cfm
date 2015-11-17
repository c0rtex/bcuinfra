

<!---- To prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<H3> You are a Read Only User </H3>
<CFELSE> 
<!--  Mir End  -->

<!-- edit rule -->

<FORM action="prg_rule.cfm" method="post">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="rule">
select * from tbl_elig_rules where rule_id = #rule_id#
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.field_nm#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.op# op_NAME="op" criteria=#rule.criteria# criteria_NAME="criteria" inc_tbl=#rule.inc_tbl# inc_tbl_NAME="addt_inc_tbl" edit="yes">
<CFIF rule.addt is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op# op_NAME="addt_op" criteria=#rule.addt_criteria# criteria_NAME="addt_criteria" inc_tbl=#rule.addt_inc_tbl# inc_tbl_NAME="addt_inc_tbl" edit="yes"></CFIF>
<CFIF rule.addt2 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm2#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op2# op_NAME="addt_op2" criteria=#rule.addt_criteria2# criteria_NAME="addt_criteria2" inc_tbl=#rule.addt_inc_tbl2# inc_tbl_NAME="addt_inc_tbl2" edit="yes"></CFIF>
<CFIF rule.alt is "Y"><br>or
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.alt_field_nm#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.alt_op# op_NAME="alt_op" criteria=#rule.alt_criteria# criteria_NAME="alt_criteria" inc_tbl=#rule.alt_inc_tbl# inc_tbl_NAME="alt_inc_tbl" edit="yes"></CFIF>
<CFIF rule.addt3 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm3#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op3# op_NAME="addt_op3" criteria=#rule.addt_criteria3# criteria_NAME="addt_criteria3" inc_tbl=#rule.addt_inc_tbl3# inc_tbl_NAME="addt_inc_tbl3" edit="yes"></CFIF>
<CFIF rule.addt4 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm4#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op4# op_NAME="addt_op4" criteria=#rule.addt_criteria4# criteria_NAME="addt_criteria4" inc_tbl=#rule.addt_inc_tbl4# inc_tbl_NAME="addt_inc_tbl4" edit="yes"></CFIF>
<CFIF rule.alt2 is "Y"><br>or
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.alt_field_nm2#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.alt_op2# op_NAME="alt_op2" criteria=#rule.alt_criteria2# criteria_NAME="alt_criteria2" inc_tbl=#rule.alt_inc_tbl2# inc_tbl_NAME="alt_inc_tbl2" edit="yes"></CFIF>
<CFIF rule.addt5 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm5#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op5# op_NAME="addt_op5" criteria=#rule.addt_criteria5# criteria_NAME="addt_criteria5" inc_tbl=#rule.addt_inc_tbl5# inc_tbl_NAME="addt_inc_tbl5" edit="yes"></CFIF>
<CFIF rule.alt3 is "Y"><br>or
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.alt_field_nm3#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.alt_op3# op_NAME="alt_op3" criteria=#rule.alt_criteria3# criteria_NAME="alt_criteria3" inc_tbl=#rule.alt_inc_tbl3# inc_tbl_NAME="alt_inc_tbl3" edit="yes"></CFIF>
<CFIF rule.addt6 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm6#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op6# op_NAME="addt_op6" criteria=#rule.addt_criteria6# criteria_NAME="addt_criteria6" inc_tbl=#rule.addt_inc_tbl6# inc_tbl_NAME="addt_inc_tbl6" edit="yes"></CFIF>
<CFIF rule.alt4 is "Y"><br>or
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.alt_field_nm4#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc#a op=#rule.alt_op4# op_NAME="alt_op4" criteria=#rule.alt_criteria4# criteria_NAME="alt_criteria4" inc_tbl=#rule.alt_inc_tbl4# inc_tbl_NAME="alt_inc_tbl4" edit="yes"></CFIF>
<CFIF rule.addt7 is "Y"><br>and
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.addt_field_nm7#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.addt_op7# op_NAME="addt_op7" criteria=#rule.addt_criteria7# criteria_NAME="addt_criteria7" inc_tbl=#rule.addt_inc_tbl7# inc_tbl_NAME="addt_inc_tbl7" edit="yes"></CFIF>
<CFIF rule.alt5 is "Y"><br>or
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
	select field_desc
	from tbl_fields_list
	where field_nm = '#rule.alt_field_nm5#'
</CFQUERY>
<br><cf_tagsetrule field=#fld.field_desc# op=#rule.alt_op5# op_NAME="alt_op5" criteria=#rule.alt_criteria5# criteria_NAME="alt_criteria5" inc_tbl=#rule.alt_inc_tbl5# inc_tbl_NAME="alt_inc_tbl5" edit="yes"></CFIF>
<cf_taghidden prg_id=#prg_id#>
<CFOUTPUT><INPUT TYPE="hidden" NAME="rule_id" VALUE="#rule_id#"></CFOUTPUT>
<br><br><INPUT TYPE="submit" NAME="edit" VALUE="Done">
</FORM>
</cfif> <!---Mir added endif line 18-->