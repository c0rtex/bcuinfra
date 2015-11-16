<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: Used by Admin to add a new user 
CALLED BY: sidebar.cfm
GOES TO: add_user2.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="users">
	SELECT *
	FROM tbl_users
	WHERE user_name <> 'admin'
</CFQUERY>

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<FORM method="post" action="add_user2.cfm">
	<table border="0" width="100%" BGCOLOR="4D3BFA">
		<tr BGCOLOR="4D3BFA">
		<CFOUTPUT QUERY="users">
			<TD>
				<A HREF="edit_user.cfm?user=#user#&edituser=#user_name#">#user_name#</A>
			</TD>
			<TD>
				#level#
			</TD>
		</CFOUTPUT>
	</TR>
	<TR>
		<TD COLSPAN="2">
			To add a new user; fill out the information below.<BR>
		</TD>
	</TR>
	<TR>
		<TD>
			User Name
		</TD>
		<TD>
			<INPUT TYPE="text" NAME="user_name" size="20">
		</TD>
	</TR>
	<TR>
		<TD>
			User's Password
		</TD>
		<TD>
			<INPUT TYPE="password" NAME="password" size="20">
		</TD>
	</TR>
	<TR>
		<TD>
			<INPUT TYPE="radio" NAME="user_level" VALUE="admin">Administrative Rights &nbsp;&nbsp;&nbsp;
			<INPUT TYPE="radio" NAME="user_level" VALUE="user1">Basic User Rights
			<BR><INPUT TYPE="submit" NAME="add" VALUE="Add User">
			<cfoutput>#session.added_dt#</cfoutput>
		</TD>
	</TR>
</TABLE>
<CF_tagHidden>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">