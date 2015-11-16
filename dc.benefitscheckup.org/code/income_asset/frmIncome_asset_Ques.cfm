<cfinclude TEMPLATE="../Header.cfm">
<body bgcolor="#F8ECFF" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<FORM ACTION="frmIncome_asset_proc.cfm" METHOD="POST">
<TABLE ALIGN="center" BGCOLOR="#C0C0C0" WIDTH="100%" CELLSPACING="2" CELLPADDING="2" BORDER="1">
<TR>
	<TD COLSPAN="7"><B>Income Grid Questions</B></TD>
</TR>
<TR>
    <TD>Question</TD>
    <TD>S</TD>
    <TD>Sp</TD>
    <TD>S & Sp</TD>
    <TD>HH</TD>
    <TD>Answerfield</TD>
    <TD>Number</TD>
</TR>
<TR BGCOLOR="WHITE">
    <TD><INPUT TYPE="Text" NAME="question" SIZE="50" TABINDEX="1">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="self" TABINDEX="2">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="spouse" TABINDEX="3">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="self_spouse" TABINDEX="4">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="household" TABINDEX="5">
	</TD>
    <TD><INPUT TYPE="Text" NAME="answerfield" SIZE="20" TABINDEX="6">
	</TD>
    <TD><INPUT TYPE="Text" NAME="number" SIZE="3" TABINDEX="7">
	</TD>
</TR>
</TABLE>
<INPUT TYPE="Submit" NAME="addincome" VALUE="ADD" TABINDEX="8">
</FORM>
<BR><BR>
<FORM ACTION="frmIncome_asset_proc.cfm" METHOD="POST">
<TABLE ALIGN="center" BGCOLOR="#C0C0C0" WIDTH="100%" CELLSPACING="2" CELLPADDING="2" BORDER="1">
<TR>
	<TD COLSPAN="7"><B>Asset Grid Questions</B></TD>
</TR>
<TR>
    <TD>Question</TD>
    <TD>S</TD>
    <TD>Sp</TD>
    <TD>S & Sp</TD>
    <TD>HH</TD>
    <TD>Answerfield</TD>
    <TD>Number</TD>
</TR>
<TR BGCOLOR="WHITE">
    <TD><INPUT TYPE="Text" NAME="question" SIZE="50" TABINDEX="1">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="self" TABINDEX="2">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="spouse" TABINDEX="3">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="self_spouse" TABINDEX="4">
	</TD>
    <TD><INPUT TYPE="Checkbox" NAME="household" TABINDEX="5">
	</TD>
    <TD><INPUT TYPE="Text" NAME="answerfield" SIZE="20" TABINDEX="6">
	</TD>
    <TD><INPUT TYPE="Text" NAME="number" SIZE="3" TABINDEX="7">
	</TD>
</TR>
</TABLE>
<INPUT TYPE="Submit" NAME="addasset" VALUE="ADD" TABINDEX="8">
</FORM>