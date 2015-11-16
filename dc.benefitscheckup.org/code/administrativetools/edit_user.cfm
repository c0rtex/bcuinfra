<cfmodule template="../header.cfm">
<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: edits a user's login information
CALLED BY: add_user.cfm
GOES TO: add_user2.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="users">
	SELECT *
	FROM tbl_users
	WHERE RecID = '#RecID#'
</CFQUERY>

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<FORM action="add_user2.cfm" method="post">
	<table border="0" width="100%" BGCOLOR="4D3BFA">
	<CFOUTPUT query="users">
		<tr BGCOLOR="4D3BFA">
			<TD>
				User Name
			</TD>
			<TD>
				<INPUT TYPE="text" VALUE="#user_name#" NAME="user_name">
			</TD>
		</TR>
		<TR>
			<TD>
				Password
			</TD>
			<TD>
				<INPUT TYPE="password" VALUE="#password#" NAME="password">
			</TD>
		</TR>
		<TR>
			<TD COLSPAN="2">
				<CFIF #user_level# is "admin">
					<INPUT TYPE="radio" NAME="user_level" VALUE="admin" checked>Admin Rights &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="user_level" VALUE="user1">User Rights &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="user_level" VALUE="ReadUser">Read Only
				<CFELSE>
					<INPUT TYPE="radio" NAME="user_level" VALUE="admin">Admin Rights &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="user_level" VALUE="user1" checked>User Rights &nbsp;&nbsp;
					<INPUT TYPE="radio" NAME="user_level" VALUE="ReadUser">Read Only
				</CFIF>
			</TD>
		</TR>
		<TR>
			<TD>
				<INPUT TYPE="hidden" NAME="RecID" VALUE="#RecID#"> 
				<INPUT TYPE="hidden" NAME="mod_by" VALUE="#session.user#"> 
				<INPUT TYPE="hidden" NAME="mod_dt" VALUE="#session.mod_dt#">
				<INPUT TYPE="submit" NAME="edit" VALUE="Update">
			</TD>
		</TR>
		
		<TR>
			<TD>
				
			
				<INPUT TYPE="submit" NAME="Delete" VALUE="Delete">
			</TD>
		</TR>
	</CFOUTPUT>
</TABLE>

</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">