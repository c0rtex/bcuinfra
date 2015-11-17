<!--========================================================================
Description: This Code displays a form where a user can search by entering data in the form fields
Called By: Header.cfm, Contact_action.cfm
Goes To: Contact_srch2.cfm
 ========================================================================= --->

<cfmodule template="../header.cfm">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<FORM action="contact_srch2.cfm" method="post">
<b><p>Enter any words to search for:</p>

<b>First Name:&nbsp;
<INPUT TYPE="text" NAME="firstname"><br><p>
<b>Last Name:&nbsp;
<INPUT TYPE="text" NAME="lastname"><br><p>
<b>State:&nbsp;
<INPUT TYPE="text" NAME="state"><p>
<INPUT TYPE="submit" NAME="search" VALUE="Search"></p>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">