<cfmodule template="../header.cfm">
<!-- Edit list cont; if user added a new list, this screen inserts the new record. if user chose to edit an existing entry, this screen takes the changes and comes back to this page to update the record. -->
<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<CFIF isdefined("add")>
	<CFIF #list# is "funding">
		<CFQUERY DATASOURCE="#application.dbSrc#">
			insert into tbl_funding_list(funding_type, id_number,added_by,added_dt,mod_by,mod_dt)
			select '#funding_type#', '#id_number#', '#session.user#', #session.added_dt#, '#session.user#', #session.mod_dt#
		</CFQUERY>
		<font size="+1">New Funding Type successfully added.</font>
	<cfelseif #list# is "maj_cat">
		<CFQUERY DATASOURCE="#application.dbSrc#">
			insert into tbl_major_cat_list(major_cat,id_number,added_by,added_dt,mod_by,mod_dt)
			select '#major_cat#', #id_number#, '#session.user#', #session.added_dt#, '#session.user#', #session.mod_dt#
		</CFQUERY>
		<font size="+1">New Major Category successfully added.</font>
	<cfelseif #list# is "req_mat">
		<CFQUERY DATASOURCE="#application.dbSrc#">
			insert into tbl_req_mat_list(req_mat,added_by,added_dt,mod_by,mod_dt)
			select '#req_mat#', '#session.user#', #session.added_dt#, '#session.user#', #session.mod_dt#
		</CFQUERY>
		<font size="+1">New Required Material successfully added.</font>
	<cfelseif #list# is "ep">
		<CFQUERY DATASOURCE="#application.dbSrc#">
			insert into tbl_entry_grp (group_name)
			select '#group_name#'
		</CFQUERY>
		<font size="+1">New Group Name successfully added.</font>
	</CFIF>
<cfabort>
</CFIF>


<CFIF isdefined("update")>
	<CFIF isdefined("funding")>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_funding_list set funding_type = '#funding_type#', mod_by = '#session.user#', mod_dt = #session.mod_dt# where id_number = '#id_number#'
		</CFQUERY>
	<cfelseif isdefined("major_cat")>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_major_cat_list set major_cat = '#major_cat#', mod_by = '#session.user#', mod_dt = #session.mod_dt# where id_number = '#id_number#'
		</CFQUERY>
	<cfelseif isdefined("req_mat")>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_req_mat_list set req_mat = '#req_mat#', mod_by = '#session.user#', mod_dt = #session.mod_dt# where req_mat = '#edit_req#'
		</CFQUERY>
	<cfelseif isdefined("edit_field")>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_fields_list set field_desc = '#field_desc#', type = '#type#', mod_by = '#session.user#', mod_dt = #session.mod_dt# where field_desc = '#edit_field#'
		</CFQUERY>
	<cfelseif isdefined("group_name")>
		<CFQUERY DATASOURCE="#application.dbSrc#">
			update tbl_entry_grp set group_name = '#group_name#' where group_id = #edit_ep#
		</CFQUERY>
</CFIF>
Update successful.
<cfabort>
</CFIF>

<FORM action="edit_list3.cfm" method="post">
<CFIF isdefined("funding")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_funding">
		select *
		from tbl_funding_list
		where id_number = '#funding#'
	</CFQUERY>
	<CFOUTPUT query="qry_funding">
	<INPUT TYPE="text" size="50" VALUE="#funding_type#" NAME="funding_type"><br>
	<INPUT TYPE="hidden" NAME="id_number" VALUE="#id_number#">
	</CFOUTPUT>
<cfelseif isdefined("maj_cat")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_maj_cat">
		select *
		from tbl_major_cat_list
		where id_number = '#maj_cat#'
	</CFQUERY>
	<CFOUTPUT query="qry_maj_cat">
	<INPUT TYPE="text" size="50" VALUE="#major_cat#" NAME="major_cat"><br>
	<INPUT TYPE="hidden" NAME="id_number" VALUE="#id_number#">
	</CFOUTPUT>
<cfelseif isdefined("req_mat")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_req_mat">
		select *
		from tbl_req_mat_list
		where req_mat = '#edit_req#'
	</CFQUERY>
	<CFOUTPUT query="qry_req_mat">
	<INPUT TYPE="text" size="50" VALUE="#req_mat#" NAME="req_mat"><br>
	</CFOUTPUT>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="edit_req" VALUE="#edit_req#">
	</CFOUTPUT>
<cfelseif isdefined("edit_field")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_elig_rules">
		select *
		from tbl_fields_list
		where field_desc = '#edit_field#'
	</CFQUERY>
	<CFOUTPUT query="qry_elig_rules">
	<INPUT TYPE="text" size="50" VALUE="#field_desc#" NAME="field_desc"><br>
	<select NAME="type">
	<CFIF #type# is "txt">
	<option VALUE="txt" selected>
	<cfelse><option VALUE="txt">
	</CFIF>Value
	<CFIF #type# is "opt">
	<option VALUE="opt" selected>
	<cfelse><option VALUE="opt">
	</CFIF>Option
	<CFIF #type# is "yn">
	<option VALUE="yn" selected>
	<cfelse>
	<option VALUE="yn">
	</CFIF>Yes/No
	</select>
	</CFOUTPUT>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="edit_field" VALUE="#edit_field#">
	</CFOUTPUT>
<cfelseif isdefined("edit_ep")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_ep">
		select group_name
		from tbl_entry_grp
		where group_id = #edit_ep#
	</CFQUERY>
	<CFOUTPUT query="qry_ep">
	<INPUT TYPE="text" size="50" VALUE="#group_name#" NAME="group_name"><br>
	</CFOUTPUT>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="edit_ep" VALUE="#edit_ep#">
	</CFOUTPUT>
</CFIF>

<INPUT TYPE="submit" NAME="update" VALUE="Update">

</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">