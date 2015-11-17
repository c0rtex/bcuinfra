<!---==================================================================== 
Description :This code displays the form to adds the firstname, last name into tbl_contacts
                      it also prevents  the read only user  to add any data 
Called BY: Header.cfm
Goes TO: Contact_action.cfm
======================================================================== --->

<cfmodule template="../header.cfm">
<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">


<FORM action="contact_action.cfm" method="post">
<table border="0" width="100%" BGCOLOR="SILVER">

	<TR>
		<TD>Or you can enter the First Name and Last Name of a contact you wish to enter</TD>
	</tr>
	<tr>
		<TD>First Name:&nbsp; <INPUT TYPE="text" NAME="firstname"></TD>
	</TR>
	<TR>
		<TD>Last Name: &nbsp;<INPUT TYPE="text" NAME="lastname"></TD>
	</TR>

</table>

<!---- Mir Begin Code: 03 -To prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
	<H3> You are a Read Only User </H3>
	<CFELSE> 
	<p><INPUT TYPE="submit" NAME="Add" VALUE="Add"></p>
</cfif> <!---End Code: 03 --->
</FORM>
<cfmodule template="../footer.cfm">


