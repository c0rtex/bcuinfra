<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: Collects income limit information
CALLED BY: inc_tbl.cfm
GOES TO: inc_tbl.cfm
=====================================================--->
<cfmodule template="../header.cfm">

<cf_checkAccess level="3">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<br>
Please enter data in ALL<font color="Red"> * </font>fields

<CFFORM action="inc_tbl.cfm" method="post" >
	<table border="0" width="100%" BGCOLOR="SILVER">
<tr><td><font color="Red"> * </font>Table Name</td><td><CFINPUT TYPE="text" NAME="tbl_nm" size="50" required="Yes"></td></tr>
<tr><td>State</td><td><CFINPUT TYPE="text" NAME="st" size="50"></td></tr>
<tr><td>County</td><td><CFINPUT TYPE="text" NAME="county" size="50"></td></tr>
<tr><td NOWRAP><B># in Household&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></td><td><B>Income Level</B></td></tr>
<tr><td width="3%"><font color="Red"> * </font>1</td><td><cfINPUT TYPE="text" NAME="hh_1"  required="Yes"> </td></tr>
<tr><td><font color="Red"> * </font>2</td><td><CFINPUT TYPE="text" NAME="hh_2" required="Yes"></td></tr>
<tr><td><font color="Red"> * </font>3</td><td><CFINPUT TYPE="text" NAME="hh_3"  required="YES"></td></tr>
<tr><td><font color="Red"> * </font>4</td><td><CFINPUT TYPE="text" NAME="hh_4" required="Yes"></td></tr>
<tr><td><font color="Red"> * </font>5</td><td><CFINPUT TYPE="text" NAME="hh_5" required="Yes"></td></tr>
<tr><td><font color="Red"> * </font>6</td><td><CFINPUT TYPE="text" NAME="hh_6" required="Yes"></td></tr>
<tr><td><font color="Red"> * </font>7</td><td><CFINPUT TYPE="text" NAME="hh_7" required="Yes"></td></tr>
<tr><td><font color="Red"> * </font>8 or more</td><td><CFINPUT TYPE="text" NAME="hh_8" required="yes"></td></tr>

</table>
<br>

 <CFIF "#session.user#" IS  "READUSER">
<H3> You are a Read Only User </H3>
			<!--- <INPUT TYPE="submit" NAME="goback" VALUE="Back"> --->
<CFELSE> 
<!--  Mir End  --->
<INPUT  TYPE="submit" NAME="add" VALUE="Done">
</cfif> <!---end mir --->

</CFFORM>
</center>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">