<!--shows eligibility rules-->
<CFOUTPUT><CFSET st = gettoken(#prg_id#,4,"-")></CFOUTPUT>
<!-- ==== commented out 8/23/99 not needed anymore === -->
<!-- if duplicating another program's rules -->
<!---CFIF isdefined("like")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="rules">
		select field_nm, criteria, alt_criteria, op, alt_field_nm, alt_op, alt, inc_table, alt_inc_table, alt2_inc_table, addt_inc_table, addt2_inc_table from tbl_elig_rules
		where prg_id = '#like#'
	</CFQUERY>
	<cfloop query="rules">
		<cfinsert DATASOURCE="#application.dbSrc#" tableNAME="tbl_elig_rules" FORMfields="prg_id, field_nm,op,criteria,addt,addt_field_nm,addt_op,addt_criteria,addt2,addt_field_nm2,addt_op2,addt_criteria2,
			alt,alt_field_nm,alt_op,alt_criteria,addt3,addt_field_nm3,addt_op3,addt_criteria3,addt4,addt_field_nm4,addt_op4,addt_criteria4,
			alt2,alt_field_nm2,alt_op2,alt_criteria2,addt5,addt_field_nm5,addt_op5,addt_criteria5,addt7,addt_field_nm7,addt_op7,addt_criteria7
			alt3,alt_field_nm3,alt_op3,alt_criteria3,addt6,addt_field_nm6,addt_op6,addt_criteria6,
			alt4,alt_field_nm4,alt_op4,alt_criteria4,alt5,alt_field_nm5,alt_op5,alt_criteria5,
			inc_tbl, alt_inc_tbl, alt_inc_tbl2,alt_inc_tbl3,alt_inc_tbl4,alt_inc_tbl5, addt_inc_tbl, addt_inc_tbl2, addt_inc_tbl3, addt_inc_tbl4, addt_inc_tbl5, addt_inc_tbl6,addt_inc_tbl7,
			added_by, added_dt, mod_by, mod_dt">
	</cfloop>
</CFIF--->
<!---========================--->

<!-- if adding, insert rule -->

<CFIF #isdefined("FORM.add")#>
<cfinsert DATASOURCE="#application.dbSrc#" tableNAME="tbl_elig_rules" FORMfields="prg_id,field_nm,op,criteria,addt,addt_field_nm,addt_op,addt_criteria,addt2,addt_field_nm2,addt_op2,addt_criteria2,
alt,alt_field_nm,alt_op,alt_criteria,addt3,addt_field_nm3,addt_op3,addt_criteria3,addt4,addt_field_nm4,addt_op4,addt_criteria4,
alt2,alt_field_nm2,alt_op2,alt_criteria2,addt5,addt_field_nm5,addt_op5,addt_criteria5,addt7,addt_field_nm7,addt_op7,addt_criteria7
alt3,alt_field_nm3,alt_op3,alt_criteria3,addt6,addt_field_nm6,addt_op6,addt_criteria6,
alt4,alt_field_nm4,alt_op4,alt_criteria4,alt5,alt_field_nm5,alt_op5,alt_criteria5,
inc_tbl, alt_inc_tbl, alt_inc_tbl2,alt_inc_tbl3,alt_inc_tbl4,alt_inc_tbl5, addt_inc_tbl, addt_inc_tbl2, addt_inc_tbl3, addt_inc_tbl4, addt_inc_tbl5, addt_inc_tbl6,addt_inc_tbl7,
calc_field,calc_field2,calc_op,added_by, mod_by, note">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qryID">
	SELECT max(rule_id) as updateID
	FROM tbl_elig_rules
</CFQUERY>
<CFQUERY DATASOURCE="#application.dbSrc#">
	UPDATE tbl_elig_rules
	SET added_dt = #added_dt#, mod_dt = #mod_dt# 
	where rule_id = #qryID.updateID#
</CFQUERY>
	<CFIF isdefined("sec")><!-- if a rule was added that was based on another program's eligibility, change pri_sec as appropriate -->
		<cfloop list="#inc#" index="prg">
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="pri">
		select pri_sec from tbl_prg_#st# where prg_id = '#evaluate(prg)#'
		</CFQUERY><!-- if first program is primary set this program to secondary, if first program is sec set this one to secdep -->
		<CFIF pri.pri_sec is "1">
			<CFSET pri_sec_value = "2">
		<cfelseif pri.pri_sec is "2">
			<CFSET pri_sec_value = "3">
		<cfelse>
			<CFSET pri_sec_value = "2">
		</CFIF>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_prg_#st# set pri_sec = '#pri_sec_value#' where prg_id = '#evaluate(prg)#'
		</CFQUERY>
		</cfloop>
	</CFIF>
</CFIF>

<!-- if editing, make changes -->
<CFIF isdefined("edit")>
<CFQUERY DATASOURCE="#application.dbSrc#">
update tbl_elig_rules set criteria='#criteria#'
<CFIF isdefined("addt_criteria")>, addt_criteria='#addt_criteria#'</CFIF>
<CFIF isdefined("addt_criteria2")>, addt_criteria2='#addt_criteria2#'</CFIF>
<CFIF isdefined("alt_criteria")>, alt_criteria='#alt_criteria#'</CFIF>
<CFIF isdefined("addt_criteria3")>, addt_criteria3='#addt_criteria3#'</CFIF>
<CFIF isdefined("addt_criteria4")>, addt_criteria4='#addt_criteria4#'</CFIF>
<CFIF isdefined("alt_criteria2")>, alt_criteria2='#alt_criteria2#'</CFIF>
<CFIF isdefined("addt_criteria5")>, addt_criteria5='#addt_criteria5#'</CFIF>
<CFIF isdefined("alt_criteria3")>, alt_criteria3='#alt_criteria3#'</CFIF>
<CFIF isdefined("addt_criteria6")>, addt_criteria6='#addt_criteria6#'</CFIF>
<CFIF isdefined("alt_criteria4")>, alt_criteria4='#alt_criteria4#'</CFIF>
<CFIF isdefined("addt_criteria7")>, addt_criteria7='#addt_criteria7#'</CFIF>
<CFIF isdefined("alt_criteria5")>, alt_criteria5='#alt_criteria5#'</CFIF>
,mod_by='#session.user#',mod_dt=#mod_dt#
where rule_id = #rule_id#
</CFQUERY>
</CFIF>

<!--- display rules ---->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="rule">
	select *
	from tbl_elig_rules
	where prg_id = '#prg_id#'
</CFQUERY>

<HTML>
<HEAD>
<title>Eligibility Rules</title>
</HEAD>
<!-- show each rule. when applicable link to other program, or income table values -->
<BODY bgcolor="#F3FEF7"> 
<p><CFOUTPUT><!-- if running for report, don't show links -->
<CFIF isdefined("dontshow") is "no">
<!---- To prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<H3> You are a Read Only User </H3>
<CFELSE> 
<!--  Mir End  --->
<a href="add_rule.cfm?prg_id=#prg_id#&user=#session.user#&datasrc=#application.dbSrc#&level=#session.user_level#">Add</a> | 
<a href="del_rule.cfm?prg_id=#prg_id#&user=#session.user#&datasrc=#application.dbSrc#&level=#session.user_level#">Delete</a></CFIF>
</cfif> <!---Mir added endif --->
</CFOUTPUT></p><CFIF rule.recordcount is 0>No Eligibility Rules</CFIF>
<cfloop query="rule">
<li>
<!---- Mir Begin Passing a Parameter 'ReadUser' to prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<CFELSE> <!--  Mir End  --->
<CFOUTPUT><a href="edit_rule.cfm?datasrc=#application.dbSrc#&user=#session.user#&level=#session.user_level#&rule_id=#rule_id#&prg_id=#prg_id#"><font color="Green">#rule_id#</font></a></CFOUTPUT>
</cfif> <!---Mir added endif --->
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fld">
		select field_desc
		from tbl_fields_list
		where field_nm = '#field_nm#'
	</CFQUERY>
	<CFOUTPUT>
	<CFIF #op# is "eq"><CFSET operator = "must be">
		<cfelseif #op# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #op# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #op# is "gt"><CFSET operator = "must be >">
		<cfelseif #op# is "lt"><CFSET operator = "must be <">
		<cfelseif #op# is " "><CFSET operator = "must be">
		<cfelseif #op# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
	</CFIF></CFOUTPUT>
	<CFIF #field_nm# is "program">
	<CFSET prgst = mid("#inc_tbl#",14,3)>
	<CFIF prgst is not "MN2"><CFSET prgst = left(prgst,2)></CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#inc_tbl#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#inc_tbl#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #field_nm# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT>#fld.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator#</CFOUTPUT>
	<CFIF #left(criteria,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#inc_tbl#&user=#session.user#&table=ind" target="new">#inc_tbl#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl.cfm?datasrc=#application.dbSrc#&inc_tbl=#inc_tbl#&user=#session.user#&table=county2" target="new">#inc_tbl#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#criteria#</CFOUTPUT></CFIF>
	
<CFIF #addt# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm#'
	</CFQUERY>
		<CFIF #addt_op# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op# is " "><CFSET operator = "must be">
		<cfelseif #addt_op# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
	AND <CFIF #addt_field_nm# is "program">
	<CFSET prgst = mid("#addt_inc_tbl#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #addt_field_nm# is "calc"><CFOUTPUT>#calc_field#</CFOUTPUT> <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF><CFOUTPUT> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #addtfld.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator#</CFOUTPUT>
	<CFIF #left(addt_criteria,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl#&user=#session.user#&table=ind" target="new">#addt_inc_tbl#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl#&user=#session.user#&table=county2" target="new">#addt_inc_tbl#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#addt_criteria#</CFOUTPUT>
	</CFIF>
</CFIF>
<CFIF #addt2# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld2">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm2#'
	</CFQUERY>
		<CFIF #addt_op2# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op2# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op2# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op2# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op2# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op2# is " "><CFSET operator = "must be">
		<cfelseif #addt_op2# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
	AND <CFIF #addt_field_nm2# is "program">
	<CFSET prgst = mid("#addt_inc_tbl2#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#D
		where prg_id = '#addt_inc_tbl2#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl2#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #addt_field_nm2# is "calc"><CFOUTPUT>#calc_field#</CFOUTPUT><CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF><CFOUTPUT> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT>#addtfld2.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator# </CFOUTPUT>
	<CFIF #left(addt_criteria2,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl2#&user=#session.user#&table=ind" target="new">#addt_inc_tbl2#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl2#&user=#session.user#&table=county2" target="new">#addt_inc_tbl2#</a></CFOUTPUT>
		</CFIF>
	<cfelse>
		<CFOUTPUT>#addt_criteria2#</CFOUTPUT>
	</CFIF>
</CFIF>
<CFIF #alt# is "Y"><br>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="altfld">
		select field_desc
		from tbl_fields_list
		where field_nm = '#alt_field_nm#'
	</CFQUERY><CFOUTPUT>
	<CFIF #alt_op# is "eq"><CFSET operator2 = "must be">
	<cfelseif #alt_op# is "gteq"><CFSET operator2 = "must be >=">
	<cfelseif #alt_op# is "lteq"><CFSET operator2 = "must be <=">
	<cfelseif #alt_op# is "gt"><CFSET operator2 = "must be >">
	<cfelseif #alt_op# is "lt"><CFSET operator2 = "must be <">
	<cfelseif #alt_op# is " " or #alt_op# is ""><CFSET operator2 = "must be">
	<cfelseif #alt_op# is "neq"><CFSET operator2 = "must not be">
	</CFIF></CFOUTPUT>
	 OR <CFIF #alt_field_nm# is "program">
	<CFSET prgst = mid("#alt_inc_tbl#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#alt_inc_tbl#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#alt_inc_tbl#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	 <cfelseif #alt_field_nm# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT>#altfld.field_desc#</CFOUTPUT></CFIF>
	 <CFOUTPUT>#operator2#</CFOUTPUT>
	 <CFIF #left(alt_criteria,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl#&user=#session.user#&table=ind" target="new">#alt_inc_tbl#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl#&user=#session.user#&table=county2" target="new">#alt_inc_tbl#</a></CFOUTPUT>
		</CFIF>
	 <cfelse><CFOUTPUT>#alt_criteria#</CFOUTPUT></CFIF>
</CFIF>
<CFIF #addt3# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld3">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm3#'
	</CFQUERY>
		<CFIF #addt_op3# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op3# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op3# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op3# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op3# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op3# is " "><CFSET operator = "must be">
		<cfelseif #addt_op3# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
	AND <CFIF #addt_field_nm3# is "program">
	<CFSET prgst = mid("#addt_inc_tbl3#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl3#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl3#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #addt_field_nm3# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT>#addtfld3.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator#</CFOUTPUT>
	<CFIF #left(addt_criteria3,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl3#&user=#session.user#&table=ind" target="new">#addt_inc_tbl3#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl3#&user=#session.user#&table=county2" target="new">#addt_inc_tbl3#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#addt_criteria3#</CFOUTPUT></CFIF>
</CFIF>
<CFIF #addt4# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld4">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm4#'
	</CFQUERY>
		<CFIF #addt_op4# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op4# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op4# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op4# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op4# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op4# is " "><CFSET operator = "must be">
		<cfelseif #addt_op4# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
	 AND <CFIF #addt_field_nm4# is "program">
	<CFSET prgst = mid("#addt_inc_tbl4#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl4#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl4#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #addt_field_nm4# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT>#addtfld4.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator#</CFOUTPUT>
	<CFIF #left(addt_criteria4,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl4#&user=#session.user#&table=ind" target="new">#addt_inc_tbl4#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl4#&user=#session.user#&table=county2" target="new">#addt_inc_tbl4#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#addt_criteria4#</CFOUTPUT></CFIF>
</CFIF>
	<CFIF #alt2# is "Y"><br>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="altfld2">
			select field_desc
			from tbl_fields_list
			where field_nm = '#alt_field_nm2#'
		</CFQUERY><CFOUTPUT>
		<CFIF #alt_op2# is "eq"><CFSET operator2 = "must be">
		<cfelseif #alt_op2# is "gteq"><CFSET operator2 = "must be >=">
		<cfelseif #alt_op2# is "lteq"><CFSET operator2 = "must be <=">
		<cfelseif #alt_op2# is "gt"><CFSET operator2 = "must be >">
		<cfelseif #alt_op2# is "lt"><CFSET operator2 = "must be <">
		<cfelseif #alt_op2# is " " or #alt_op2# is ""><CFSET operator2 = "must be">
		<cfelseif #alt_op2# is "neq"><CFSET operator2 = "must not be">
		</CFIF></CFOUTPUT>
 OR <CFIF #alt_field_nm2# is "program">
	<CFSET prgst = mid("#alt_inc_tbl2#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#alt_inc_tbl2#'
	</CFQUERY>
<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#alt_inc_tbl2#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
 <cfelseif #alt_field_nm2# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #altfld2.field_desc#</CFOUTPUT></CFIF>
 <CFOUTPUT>#operator2# </CFOUTPUT>
 <CFIF #left(alt_criteria2,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl2#&user=#session.user#&table=ind" target="new">#alt_inc_tbl2#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl2#&user=#session.user#&table=county2" target="new">#alt_inc_tbl2#</a></CFOUTPUT>
		</CFIF>
 <cfelse><CFOUTPUT>#alt_criteria2#</CFOUTPUT></CFIF>
</CFIF>
<CFIF #addt5# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld5">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm5#'
	</CFQUERY>
		<CFIF #addt_op5# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op5# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op5# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op5# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op5# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op5# is " "><CFSET operator = "must be">
		<cfelseif #addt_op5# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
 AND <CFIF #addt_field_nm5# is "program">
	<CFSET prgst = mid("#addt_inc_tbl5#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl5#'
	</CFQUERY>
<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl4#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
<cfelseif #addt_field_nm5# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #addtfld5.field_desc#</CFOUTPUT></CFIF>
<CFOUTPUT>#operator#</CFOUTPUT>
<CFIF #left(addt_criteria5,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl5#&user=#session.user#&table=ind" target="new">#addt_inc_tbl5#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl5#&user=#session.user#&table=county2" target="new">#addt_inc_tbl5#</a></CFOUTPUT>
		</CFIF>
<cfelse><CFOUTPUT>#addt_criteria5#</CFOUTPUT></CFIF>

</CFIF>
	<CFIF #alt3# is "Y"><br>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="altfld3">
			select field_desc
			from tbl_fields_list
			where field_nm = '#alt_field_nm3#'
		</CFQUERY>
		<CFIF #alt_op3# is "eq"><CFSET operator2 = "must be">
		<cfelseif #alt_op3# is "gteq"><CFSET operator2 = "must be >=">
		<cfelseif #alt_op3# is "lteq"><CFSET operator2 = "must be <=">
		<cfelseif #alt_op3# is "gt"><CFSET operator2 = "must be >">
		<cfelseif #alt_op3# is "lt"><CFSET operator2 = "must be <">
		<cfelseif #alt_op3# is " " or #alt_op3# is ""><CFSET operator2 = "must be">
		<cfelseif #alt_op3# is "neq"><CFSET operator2 = "must not be">
		</CFIF>
	OR <CFIF #alt_field_nm3# is "program">
	<CFSET prgst = mid("#alt_inc_tbl3#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#alt_inc_tbl3#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#alt_inc_tbl3#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #alt_field_nm3# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse> <CFOUTPUT>#altfld3.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator2#</CFOUTPUT>
	<CFIF #left(alt_criteria3,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl3#&user=#session.user#&table=ind" target="new">#alt_inc_tbl3#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl3#&user=#session.user#&table=county2" target="new">#alt_inc_tbl3#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#alt_criteria3#</CFOUTPUT></CFIF>
	</CFIF>
<CFIF #addt6# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld6">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm6#'
	</CFQUERY>
		<CFIF #addt_op6# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op6# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op6# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op6# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op6# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op6# is " "><CFSET operator = "must be">
		<cfelseif #addt_op6# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
 AND <CFIF #addt_field_nm6# is "program">
	<CFSET prgst = mid("#addt_inc_tbl6#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl6#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl6#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
<cfelseif #addt_field_nm6# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #addtfld6.field_desc#</CFOUTPUT></CFIF>
<CFOUTPUT>#operator#</CFOUTPUT>
<CFIF #left(addt_criteria6,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl6#&user=#session.user#&table=ind" target="new">#addt_inc_tbl6#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl6#&user=#session.user#&table=county2" target="new">#addt_inc_tbl6#</a></CFOUTPUT>
		</CFIF>
<cfelse><CFOUTPUT>#addt_criteria6#</CFOUTPUT></CFIF>
</CFIF>
<CFIF #alt4# is "Y"><br>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="altfld4">
			select field_desc
			from tbl_fields_list
			where field_nm = '#alt_field_nm4#'
		</CFQUERY>
		<CFIF #alt_op4# is "eq"><CFSET operator2 = "must be">
		<cfelseif #alt_op4# is "gteq"><CFSET operator2 = "must be >=">
		<cfelseif #alt_op4# is "lteq"><CFSET operator2 = "must be <=">
		<cfelseif #alt_op4# is "gt"><CFSET operator2 = "must be >">
		<cfelseif #alt_op4# is "lt"><CFSET operator2 = "must be <">
		<cfelseif #alt_op4# is " " or #alt_op4# is ""><CFSET operator2 = "must be">
		<cfelseif #alt_op4# is "neq"><CFSET operator2 = "must not be">
		</CFIF>
	OR <CFIF #alt_field_nm4# is "program">
	<CFSET prgst = mid("#alt_inc_tbl4#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#alt_inc_tbl4#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#alt_inc_tbl3#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
	<cfelseif #alt_field_nm4# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #altfld4.field_desc#</CFOUTPUT></CFIF>
	<CFOUTPUT>#operator2#</CFOUTPUT>
	<CFIF #left(alt_criteria4,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl4#&user=#session.user#&table=ind" target="new">#alt_inc_tbl4#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl4#&user=#session.user#&table=county2" target="new">#alt_inc_tbl4#</a></CFOUTPUT>
		</CFIF>
	<cfelse><CFOUTPUT>#alt_criteria4#</CFOUTPUT></CFIF>	
</CFIF>
<CFIF #addt7# is "Y">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="addtfld7">
		select field_desc
		from tbl_fields_list
		where field_nm = '#addt_field_nm7#'
	</CFQUERY>
		<CFIF #addt_op7# is "eq"><CFSET operator = "must be">
		<cfelseif #addt_op7# is "gteq"><CFSET operator = "must be >=">
		<cfelseif #addt_op7# is "lteq"><CFSET operator = "must be <=">
		<cfelseif #addt_op7# is "gt"><CFSET operator = "must be >">
		<cfelseif #addt_op7# is "lt"><CFSET operator = "must be <">
		<cfelseif #addt_op7# is " "><CFSET operator = "must be">
		<cfelseif #addt_op7# is "neq"><CFSET operator = "must not be">
		<cfelse><CFSET operator = "must be">
		</CFIF>
 AND <CFIF #addt_field_nm7# is "program">
	<CFSET prgst = mid("#addt_inc_tbl7#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#addt_inc_tbl7#'
	</CFQUERY>
	<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#addt_inc_tbl7#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
<cfelseif #addt_field_nm7# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #addtfld7.field_desc#</CFOUTPUT></CFIF>
<CFOUTPUT>#operator#</CFOUTPUT>
<CFIF #left(addt_field_nm7,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl7#&user=#session.user#&table=ind" target="new">#addt_inc_tbl7#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#addt_inc_tbl7#&user=#session.user#&table=county2" target="new">#addt_inc_tbl7#</a></CFOUTPUT>
		</CFIF>
<cfelse><CFOUTPUT>#addt_criteria7#</CFOUTPUT></CFIF>
</CFIF>
<CFIF #alt5# is "Y"><br>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="altfld5">
		select field_desc
		from tbl_fields_list
		where field_nm = '#alt_field_nm5#'
	</CFQUERY>
	<CFIF #alt_op5# is "eq"><CFSET operator2 = "must be">
	<cfelseif #alt_op5# is "gteq"><CFSET operator2 = "must be >=">
	<cfelseif #alt_op5# is "lteq"><CFSET operator2 = "must be <=">
	<cfelseif #alt_op5# is "gt"><CFSET operator2 = "must be >">
	<cfelseif #alt_op5# is "lt"><CFSET operator2 = "must be <">
	<cfelseif #alt_op5# is " " or #alt_op4# is ""><CFSET operator2 = "must be">
	<cfelseif #alt_op5# is "neq"><CFSET operator2 = "must not be">
	</CFIF>
OR <CFIF #alt_field_nm5# is "program">
	<CFSET prgst = mid("#alt_inc_tbl5#",14,3)>
	<CFIF prgst is not "MN2">
		<CFSET prgst = left(prgst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prg">
		select prg_nm
		from tbl_prg_#prgst#
		where prg_id = '#alt_inc_tbl5#'
	</CFQUERY>
<CFOUTPUT><a href="prg_frm.cfm?user=#session.user#&prg_id=#alt_inc_tbl3#&datasrc=#application.dbSrc#&level=#session.user_level#" target="new">#prg.prg_nm#</a></CFOUTPUT>
<cfelseif #alt_field_nm5# is "calc"><CFOUTPUT>#calc_field#  <CFIF #calc_op# is "sub">-<cfelseif #calc_op# is "add">+<cfelseif #calc_op# is "div">/<cfelseif #calc_op# is "mul">*</CFIF> #calc_field2#</CFOUTPUT><cfelse><CFOUTPUT> #altfld5.field_desc#</CFOUTPUT></CFIF>
<CFOUTPUT>#operator2#</CFOUTPUT>
<CFIF #left(alt_criteria5,5)# is "table">
		<CFIF criteria is "table">
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl5#&user=#session.user#&table=ind" target="new">#alt_inc_tbl5#</a></CFOUTPUT>
		<cfelse>
			<CFOUTPUT><a href="inc_tbl2.cfm?datasrc=#application.dbSrc#&inc_tbl=#alt_inc_tbl5#&user=#session.user#&table=county2" target="new">#alt_inc_tbl5#</a></CFOUTPUT>
		</CFIF>
<cfelse><CFOUTPUT>#alt_criteria5#</CFOUTPUT></CFIF>
</CFIF>
</li>
<CFIF #note# is not ""><br><cf_tagwhitespace><CFOUTPUT>#note#</CFOUTPUT></CFIF>

</cfloop><BR><BR><BR>
<cfinclude TEMPLATE="req_mat.cfm">
<cf_taghidden>
</BODY>
</HTML>
