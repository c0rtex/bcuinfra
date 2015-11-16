
<cfmodule template="../header.cfm">
<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="tbls">
select * from tbl_inc_new where tbl_id=#tbl_id#
</CFQUERY>
<cfFORM action="inc_tbl.cfm" method="post">
<CFOUTPUT query="tbls">
Do not leave any blank. If you don't have a value, put in 0.
<BR><BR>
	<table border="0" width="100%" BGCOLOR="SILVER">
<tr>
<td>Table Name</td>
<td><cfINPUT TYPE="text" NAME="tbl_nm" VALUE="#Trim(tbl_nm)#" size="100" required="Yes"></td></tr>
<tr><td>State</td><td><cfINPUT TYPE="text" NAME="st" VALUE="#Trim(st)#"></td></tr>
<tr><td>County</td><td><cfINPUT TYPE="text" NAME="county" VALUE="#Trim(county)#"></td></tr>
<tr><td><B>## in Household</B></td><td><B>Income Level</B></td></tr><tr>
<td width="25%">1</td><td>
<cfINPUT TYPE="text" NAME="hh_1" VALUE="#Trim(mem1)#" required="Yes"></td></tr>
<tr><td>2</td><td><cfINPUT TYPE="text" NAME="hh_2" VALUE="#Trim(mem2)#" required="yes"></td></tr>
<tr><td>3</td><td><cfINPUT TYPE="text" NAME="hh_3" VALUE="#Trim(mem3)#" required="yes"></td></tr>
<tr><td>4</td><td><cfINPUT TYPE="text" NAME="hh_4" VALUE="#Trim(mem4)#" required="Yes"></td></tr>
<tr><td>5</td><td><cfINPUT TYPE="text" NAME="hh_5" VALUE="#Trim(mem5)#" required="Yes"></td></tr>
<tr><td>6</td><td><cfINPUT TYPE="text" NAME="hh_6" VALUE="#Trim(mem6)#" required="Yes"></td></tr>
<tr><td>7</td><td><cfINPUT TYPE="text" NAME="hh_7" VALUE="#Trim(mem7)#" required="Yes"></td></tr>
<tr><td>8 or more</td><td><cfINPUT TYPE="text" NAME="hh_8" VALUE="#Trim(mem8)#" required="Yes"></td></tr>
</table>
</CFOUTPUT><BR>
<!---- Mir Begin To prevent the Read only user from inserting or updating the data base ---->
 <CFIF "#session.user#" IS  "READUSER"> 
<H3> You are a Read Only User </H3>
			<!--- <INPUT TYPE="submit" NAME="goback" VALUE="Back"> --->
<CFELSE> 
<!--  Mir End  --->
<INPUT TYPE="submit" NAME="edit" VALUE="Done">
</cfif>  <!---end mir--->
<CFOUTPUT>
<INPUT TYPE="hidden" NAME="tbl_id" VALUE="#tbl_id#">
</CFOUTPUT>
</cfFORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">