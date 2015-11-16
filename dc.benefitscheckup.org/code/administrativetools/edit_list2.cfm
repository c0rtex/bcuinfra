<cfmodule template="../header.cfm">
    <!-- edit list continued. This screen gives the option to add to the list, or edit an existing entry -->

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<FORM method="post" action="edit_list3.cfm">
<font size="+1">
<CFIF list is "funding">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="funding">
		select * 
		from tbl_funding_list 
		order by funding_type
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="new_id">
		select MAX(id_number) AS id_number 
		from tbl_funding_list 
		where id_number <> 'XXX'
	</CFQUERY>
	<CFOUTPUT><CFSET idnum = new_id.id_number + 1>
	<INPUT TYPE="hidden" NAME="id_number" VALUE="#idnum#">
	</CFOUTPUT>
	This list is a list of all funding types. It is used in the pull down list on the New Program ID screen.<br><br>
	Add a new listing<br>
	<INPUT TYPE="text" NAME="funding_type" size="50"><br>
	<INPUT TYPE="submit" NAME="add" VALUE="Add">
	<br><br>
	OR<br><br>
	Edit a listing <br>
	<select NAME="funding">
	<CFOUTPUT query="funding">
	<option VALUE="#id_number#">#funding_type#
	</CFOUTPUT>
	</select><br>
	<INPUT TYPE="submit" NAME="edit" VALUE="Edit">
<cfelseif list is "maj_cat">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_maj_cat">
		select * 
		from tbl_major_cat_list 
		order by major_cat
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="new_id">
		select MAX(id_number) as id_number
		from tbl_major_cat_list 
	</CFQUERY>
	<CFOUTPUT>
	<CFSET idnum = new_id.id_number + 1><INPUT TYPE="hidden" NAME="id_number" VALUE="#idnum#">
	</CFOUTPUT>
	This list is a list of all Major Program Categories. It is used in the pull down list on the New Program ID screen.<br><br>
	Add a new listing<br>
	<INPUT TYPE="text" NAME="major_cat" size="50"><br>
	<INPUT TYPE="submit" NAME="add" VALUE="Add">
	<br><br>
	OR<br><br>
	Edit a listing <br>
	<select NAME="maj_cat">
	<CFOUTPUT query="qry_maj_cat">
	<option VALUE="#id_number#">#major_cat#
	</CFOUTPUT>
	</select><br>
	<INPUT TYPE="submit" NAME="edit" VALUE="Edit">
<cfelseif list is "req_mat">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qry_req_mat">
		select req_mat 
		from tbl_req_mat_list 
		order by req_mat
	</CFQUERY>
		This list of choices for required materials. It is used in the pull down list on the Add Required Material screen.<br><br>
	Add a new listing<br>
	<INPUT TYPE="text" NAME="req_mat" size="50"><br>
	<INPUT TYPE="submit" NAME="add" VALUE="Add">
	<br><br>
	OR<br><br>
	Edit a listing <br>
	<select NAME="edit_req">
	<CFOUTPUT query="qry_req_mat">
	<option VALUE="#req_mat#">#req_mat#
	</CFOUTPUT>
	</select><br>
	<INPUT TYPE="submit" NAME="edit" VALUE="Edit">
<cfelseif list is "ep">
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry">
		select group_id, group_name 
		from tbl_entry_grp 
		order by group_name
	</CFQUERY>	
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="grp_id">
		select MAX(group_id) as group_id 
		from tbl_entry_grp 
	</CFQUERY>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="grp_id" VALUE="#evaluate(grp_id.group_id + 1)#">
	</CFOUTPUT>
	This is a list of group names for entry points. 
	<br>Add a new listing<br>
	<INPUT TYPE="text" NAME="group_name" size="50"><br>
	<INPUT TYPE="submit" NAME="add" VALUE="Add"><br><br>
	OR<br><br>
	Edit a listing<br>
	<select NAME="edit_ep">
	<CFOUTPUT query="entry">
	<option VALUE="#group_id#">#group_name#
	</CFOUTPUT>
	</select><br>
	<INPUT TYPE="submit" NAME="edit" VALUE="Edit">
</CFIF>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="list" VALUE="#list#"></CFOUTPUT>

	
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">