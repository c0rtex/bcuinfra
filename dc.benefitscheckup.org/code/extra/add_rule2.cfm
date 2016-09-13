<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: second half of adding a rule. Collects operator and criteria
CALLED BY: add_rule.cfm
GOES TO: prg_rule.cfm
=====================================================--->

<!--- If no value for the first rule field send user back to add_rule.cfm --->
<CFIF #field# IS "">
	<FONT COLOR="Red">The first part of A can not be left blank. Please go back and choose a field.</FONT>
	<CF_tagHidden><BR>
	<CFOUTPUT>
		<A HREF="add_rule.cfm?datasrc=#datasrc#&user=#user#&prg_id=#prg_id#">Go Back</A>
	</CFOUTPUT>
	<CFABORT>
</CFIF>

<HTML>
<HEAD>
	<TITLE>New Rule</TITLE>
</HEAD>

<BODY>
Please choose the most delimiting factor.<BR>
<EM><FONT COLOR="Red"><B>If you have a question about a rule, PLEASE ASK!!! This is VERY important!</FONT></B></EM><BR>
<FORM ACTION="prg_rule.cfm" METHOD="post">
<!--- cf_tagsetrule sets the appropriate options for operator and criteria --->
<TABLE BORDER="1">
	<TR>
		<TD>
			<CF_tagSetRule field = #field# op_NAME="op" criteria_NAME="criteria" inc_tbl_NAME="inc_tbl">
		<CFOUTPUT>
			<INPUT TYPE="hidden" NAME="field_nm" VALUE="#field#">
		</CFOUTPUT>
		</TD>
	</TR>
	<CFIF IsDefined("addt_field")>
		<CFIF addt_field IS NOT "">
			<TR>
				<TD>and</TD>
			</TR>
			<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm" VALUE="#addt_field#"></CFOUTPUT>
			<INPUT TYPE="hidden" NAME="addt" VALUE="Y">
			<TR>
				<TD>
					<CF_tagSetRule field = #addt_field# op_NAME="addt_op" criteria_NAME="addt_criteria" inc_tbl_NAME="addt_inc_tbl">
				</TD>
			</TR>
		</CFIF>
	</CFIF>
	<CFIF IsDefined("addt_field2")>
		<CFIF addt_field2 IS NOT "">
			<TR>
				<TD>and</TD>
			</TR>
			<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm2" VALUE="#addt_field2#"></CFOUTPUT>
			<INPUT TYPE="hidden" NAME="addt2" VALUE="Y">
			<TR>
				<TD>
					<CF_tagSetRule field = #addt_field2# op_NAME="addt_op2" criteria_NAME="addt_criteria2" inc_tbl_NAME="addt_inc_tbl2">
				</TD>
			</TR>
		</CFIF>
	</CFIF>
</TABLE>

<CFIF IsDefined("alt_field")>
	<CFIF alt_field IS NOT "">
		or
		<CFOUTPUT><INPUT TYPE="hidden" NAME="alt_field_nm" VALUE="#alt_field#"></CFOUTPUT>
		<BR>
		<INPUT TYPE="hidden" NAME="alt" VALUE="Y">
		<TABLE BORDER="1">
			<TR>
				<TD>
					<CF_tagSetRule field = #alt_field# op_NAME="alt_op" criteria_NAME="alt_criteria" inc_tbl_NAME="alt_inc_tbl">
				</TD>
			</TR>
			<CFIF IsDefined("addt_field3")>
				<CFIF addt_field3 IS NOT "">
					<TR>
						<TD>and</TD>
					</TR>
					<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm3" VALUE="#addt_field3#"></CFOUTPUT>
					<INPUT TYPE="hidden" NAME="addt3" VALUE="Y">
					<TR>
						<TD>
							<cf_tagsetrule field = #addt_field3# op_NAME="addt_op3" criteria_NAME="addt_criteria3" inc_tbl_NAME="addt_inc_tbl3">
						</TD>
					</TR>
				</CFIF>
			</CFIF>
			<CFIF IsDefined("addt_field4")>
				<CFIF addt_field4 IS NOT "">
					<TR>
						<TD>and</TD>
					</TR>
					<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm4" VALUE="#addt_field4#"></CFOUTPUT>
					<INPUT TYPE="hidden" NAME="addt4" VALUE="Y">
					<TR>
						<TD>
							<cf_tagsetrule field = #addt_field4# op_NAME="addt_op4" criteria_NAME="addt_criteria4" inc_tbl_NAME="addt_inc_tbl4">
						</TD>
					</TR>
				</CFIF>
			</CFIF>
		</TABLE>
	</CFIF>
</CFIF>

<CFIF IsDefined("alt_field2")>
	<CFIF alt_field2 IS NOT "">
		or
		<CFOUTPUT><INPUT TYPE="hidden" NAME="alt_field_nm2" VALUE="#alt_field2#"></CFOUTPUT>
		<BR><INPUT TYPE="hidden" NAME="alt2" VALUE="Y">
		<TABLE BORDER="1">
			<TR>
				<TD>
					<CF_tagSetRule field = #alt_field2# op_NAME="alt_op2" criteria_NAME="alt_criteria2" inc_tbl_NAME="alt_inc_tbl2">
				</TD>
			</TR>
			<CFIF IsDefined("addt_field5")>
				<CFIF addt_field5 IS NOT "">
					<TR>
						<TD>and</TD>
					</TR>
					<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm5" VALUE="#addt_field5#"></CFOUTPUT>
					<INPUT TYPE="hidden" NAME="addt5" VALUE="Y">
					<TR>
						<TD>
							<CF_tagSetRule field = #addt_field5# op_NAME="addt_op5" criteria_NAME="addt_criteria5" inc_tbl_NAME="addt_inc_tbl5">
						</TD>
					</TR>
				</CFIF>
			</CFIF>
		</TABLE>
	</CFIF>	
</CFIF>

<CFIF IsDefined("alt_field3")>
	<CFIF alt_field3 IS NOT "">
		or
		<CFOUTPUT><INPUT TYPE="hidden" NAME="alt_field_nm3" VALUE="#alt_field3#"></CFOUTPUT>
		<BR><INPUT TYPE="hidden" NAME="alt3" VALUE="Y">
		<TABLE BORDER="1">
			<TR>
				<TD>
					<CF_tagSetRule field = #alt_field3# op_NAME="alt_op3" criteria_NAME="alt_criteria3" inc_tbl_NAME="alt_inc_tbl3">
				</TD>
			</TR>
			<CFIF IsDefined("addt_field6")>
				<CFIF addt_field6 IS NOT "">
					<TR>
						<TD>and</TD>
					</TR>
					<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm6" VALUE="#addt_field6#"></CFOUTPUT>
					<INPUT TYPE="hidden" NAME="addt6" VALUE="Y">
					<TR>
						<TD>
							<CF_tagSetRule field = #addt_field6# op_NAME="addt_op6" criteria_NAME="addt_criteria6" inc_tbl_NAME="addt_inc_tbl6">
						</TD>
					</TR>
				</CFIF>
			</CFIF>
		</TABLE>
	</CFIF>
</CFIF>

<CFIF IsDefined("alt_field4")>
	<CFIF alt_field4 IS NOT "">
		or
		<CFOUTPUT><INPUT TYPE="hidden" NAME="alt_field_nm4" VALUE="#alt_field4#"></CFOUTPUT>
		<BR><INPUT TYPE="hidden" NAME="alt4" VALUE="Y">
		<TABLE BORDER="1">
			<TR>
				<TD>
					<CF_tagSetRule field = #alt_field4# op_NAME="alt_op4" criteria_NAME="alt_criteria4" inc_tbl_NAME="alt_inc_tbl4">
				</TD>
			</TR>
			<CFIF IsDefined("addt_field7")>
				<CFIF addt_field7 IS NOT "">
					<TR>
						<TD>and</TD>
					</TR>
					<CFOUTPUT><INPUT TYPE="hidden" NAME="addt_field_nm7" VALUE="#addt_field7#"></CFOUTPUT>
					<INPUT TYPE="hidden" NAME="addt7" VALUE="Y">
					<TR>
						<TD>
							<CF_tagSetRule field = #addt_field7# op_NAME="addt_op7" criteria_NAME="addt_criteria7" inc_tbl_NAME="addt_inc_tbl7">
						</TD>
					</TR>
				</CFIF>
			</CFIF>	
		</TABLE>
	</CFIF>
</CFIF>

<CFIF IsDefined("alt_field5")>
	<CFIF alt_field5 IS NOT "">
		or
		<CFOUTPUT><INPUT TYPE="hidden" NAME="alt_field_nm5" VALUE="#alt_field5#"></CFOUTPUT>
		<BR><INPUT TYPE="hidden" NAME="alt5" VALUE="Y">
		<TABLE BORDER="1">
			<TR>
				<TD>
					<cf_tagsetrule field = #alt_field5# op_NAME="alt_op5" criteria_NAME="alt_criteria5" inc_tbl_NAME="alt_inc_tbl5">
				</TD>
			</TR>
		</TABLE>
	</CFIF>
</CFIF>

<BR><BR>
Note:<TEXTAREA NAME="note" COLS="45" ROWS="2"></TEXTAREA><BR>
<CF_tagHidden level=#level#><BR>
<INPUT TYPE="submit" NAME="add" VALUE="Add">
<INPUT TYPE="submit" VALUE="Cancel" ONCLICK="history.go(-1)">
</FORM>
</BODY>
</HTML>
