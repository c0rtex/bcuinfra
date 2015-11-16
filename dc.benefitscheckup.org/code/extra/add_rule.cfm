<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: First stage of adding a new rule. Shows choices for field names
CALLED BY: prg_rule.cfm
GOES TO: add_rule2.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields">
	SELECT *
	FROM tbl_fields_list
	ORDER BY field_desc
</CFQUERY>

<HTML>
<HEAD>
	<TITLE>Add Rule</TITLE>
</HEAD>

<BODY>
<FORM ACTION="add_rule2.cfm" METHOD="post">
<cf_tagHidden level=#level#>
<BR>
Select the fields you want to set rules for, 
for each part of the rule.<BR>

<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="field">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field2">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
</TABLE>
If that's all the parts of this rule. Click here. &nbsp;<INPUT TYPE="submit" VALUE="Next >"><BR><BR> 

<B> OR </B>
<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="alt_field">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field3">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field4">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
</TABLE>
If that's all the parts of this rule. Click here. &nbsp;<INPUT TYPE="submit" VALUE="Next >"><BR><BR> 

<b>OR</b>
<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="alt_field2">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field5">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
</TABLE>
If that's all the parts of this rule. Click here. &nbsp;<INPUT TYPE="submit" VALUE="Next >"><BR><BR> 

<b>OR</b>
<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="alt_field3">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field6">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>	
			</SELECT>
		</TD>
	</TR>
</TABLE>
If that's all the parts of this rule. Click here. &nbsp;<INPUT TYPE="submit" VALUE="Next >"><BR><BR> 

<b>OR</b>
<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="alt_field4">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>and</TD>
	</TR>
	<TR>
		<TD>
			<SELECT NAME="addt_field7">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
</TABLE>
If that's all the parts of this rule. Click here. &nbsp;<INPUT TYPE="submit" VALUE="Next >"><BR><BR> 

<b>OR</b>
<TABLE BORDER="1">
	<TR>
		<TD>
			<SELECT NAME="alt_field5">
				<OPTION>
				<CFOUTPUT query="fields">
					<OPTION VALUE="#field_nm#">#field_desc#
				</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
</TABLE>
<!--- commented out. no longer do it this way. it's now an option for field --->
<!---
OR<BR>
Click<CFOUTPUT> <a href="add_rule2.cfm?user=#user#&prg_id=#prg_id#&datasrc=#datasrc#&level=#level#&st=#st#"></CFOUTPUT>here</a> if the rules for this program are the same as another program's.<br--->
<BR><INPUT TYPE="submit" VALUE="Next >">
</FORM>
</BODY>
</HTML>
