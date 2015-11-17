<cfmodule template="../header.cfm">

<!----Begin Code:02-this code displays the form to adds  note to  tbl_notes, displays the 
           the firstname, last name and  all states from tbl_contacts  also it prevents  the read 
		                                          only user  to add any data--->

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<CFOUTPUT>
<FORM action="note_proc.cfm" method="post">
<table border="0" width="100%" BGCOLOR="SILVER">
	<tr BGCOLOR="SILVER">
		<td><strong>State</strong></td>
		<td><cf_tagstate></td>
	</tr>
	<tr>
		<td><strong>Note</strong></td>
		<td colspan="2"><textarea NAME="note" cols="100" rows="10" wrap="virtual"></textarea></td>
	</tr>
</table><BR><BR>
<!----Begin Mir code:03 To prevent the Read only user from inserting or updating the data base ---->
  <CFIF "#session.user#" IS  "READUSER"> 
		<H3> You are a Read Only User </H3>
  <CFELSE>
		<INPUT TYPE="submit" NAME="add" VALUE="Submit">
  </cfif> <!---End code:03----> 
  
</FORM>
</CFOUTPUT>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">