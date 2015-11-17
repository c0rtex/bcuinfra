<!-- Edit lists (field lists, funding type, categories, etc) -->

<cfmodule template="../header.cfm">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<FORM action="edit_list2.cfm" method="post">
Please choose a list to edit<br><br>
<select NAME="list">
<option VALUE="answerfield">Answerfield
<option VALUE="Funding">Funding Types
<option VALUE="maj_cat">Major Categories
<option VALUE="req_mat">Required Materials
<!--- option VALUE="fields">Fields --->
<option VALUE="ep">Entry Point Groups
</select><br><br>

<INPUT TYPE="submit" VALUE="Next >">
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">