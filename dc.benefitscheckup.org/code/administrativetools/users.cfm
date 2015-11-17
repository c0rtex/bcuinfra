
<cfmodule template="../header.cfm">

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="users">
	SELECT *
	FROM tbl_users
	WHERE user_name <> 'admin'
	order by user_name
</CFQUERY>

<body bgcolor="cococo" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<FORM method="post" action="add_user2.cfm">
	<table border="0" width="100%" BGCOLOR="cococo">
		<tr BGCOLOR="cococo">
		<TD COLSPAN="4"><BR><BR><font face=arial color=blue size=5>To add a new user; fill out the information below.<BR></TD>
	</TR>
	<TR>
		<td></td><TD colspan=2 ><font face=arial color=black size=4>User Name:</td><td align=left><INPUT TYPE="text" NAME="user_name" size="20"></TD>
	</TR>
	<TR>
		<td></td><TD colspan=2><font face=arial color=black size=4>Please have user enter password:</td><td align=left><INPUT TYPE="password" NAME="password" SIZE="20"></TD>
	</TR>
	<TR>
		<TD COLSPAN="2"><cfoutput>
			<INPUT TYPE="radio" NAME="user_level" VALUE="admin"><font face=arial color=blue size=4>Administrative Rights &nbsp;&nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="user_level" VALUE="user1"><font face=arial color=blue size=4>Basic User Rights  &nbsp;&nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="user_level" VALUE="ReadUser" checked="y"><font face=arial color=blue size=4>Read User Rights 
			<INPUT TYPE="hidden" NAME="added_by" VALUE="#session.user#"> 
			<INPUT TYPE="hidden" NAME="mod_by" VALUE="#session.user#"></cfoutput>
		</TD>
	</TR>
	<TR>
		<TD><INPUT TYPE="submit" NAME="add" VALUE="Add User"></TD>
	</TR>
</TABLE>
</FORM>

	<table border="0" width="100%" BGCOLOR="cococo">
		<CFOUTPUT QUERY="users">
		<TR>
			<FORM method="post" action="edit_user.cfm">
			<TD><INPUT TYPE="submit" NAME="add" VALUE="#user_name#"></TD>
			<TD>#user_level#</TD>
			<INPUT TYPE="hidden" NAME="RecID" VALUE="#RecID#"> 
			</FORM>

		</TR>
		</CFOUTPUT>
	</TABLE>

</BODY>
</HTML>
<cfmodule template="../footer.cfm">