<cfmodule template="../header.cfm">
<script language="JavaScript">
	<!--
	  function deleteConfirm() {
		return (confirm ("Are you certain you want to delete this item?"));
    	}
	//-->
</script>
<body bgcolor="#F8ECFF" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<TABLE ALIGN="center" BGCOLOR="#C0C0C0" WIDTH="100%" CELLSPACING="2" CELLPADDING="2" BORDER="1">
<TR>
	<TD><B><a href="frmIncome_asset_ques.cfm">ADD QUESTIONS</A></B></TD>
</TR>
</table>
<BR><BR>
<TABLE ALIGN="center" BGCOLOR="#C0C0C0" WIDTH="100%" CELLSPACING="2" CELLPADDING="2" BORDER="1">
<TR>
	<TD COLSPAN="8"><B>Income Grid Questions</B></TD>
</TR>
<TR>
    <TD>Question</TD>
    <TD>S</TD>
    <TD>Sp</TD>
    <TD>S & Sp</TD>
    <TD>HH</TD>
    <TD>Answerfield</TD>
    <TD>Number</TD>
    <TD>&nbsp;</TD>
</TR>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="income">
	SELECT *
	FROM tbl_incomegrid
</CFQUERY>

<CFOUTPUT QUERY="income">
<TR BGCOLOR="WHITE">
    <TD>#income.question#
	</TD>
    <TD>#income.self#
	</TD>
    <TD>#income.spouse#
	</TD>
    <TD>#income.self_spouse#
	</TD>
    <TD>#income.household#
	</TD>
    <TD>#income.answerfield#
	</TD>
    <TD>#income.number#
	</TD>
	<TD><a href="income_delete.cfm?id=#RecID#&answer=#answerfield#" onClick="return deleteConfirm();">D</A></TD>
</TR>

</CFOUTPUT>
</TABLE>
<BR><BR>
<TABLE ALIGN="center" BGCOLOR="#C0C0C0" WIDTH="100%" CELLSPACING="2" CELLPADDING="2" BORDER="1">
<TR>
	<TD COLSPAN="8"><B>Asset Grid Questions</B></TD>
</TR>
<TR>
    <TD>Question</TD>
    <TD>S</TD>
    <TD>Sp</TD>
    <TD>S & Sp</TD>
    <TD>HH</TD>
    <TD>Answerfield</TD>
    <TD>Number</TD>
    <TD>&nbsp;</TD>
</TR>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="asset">
	SELECT *
	FROM tbl_assetgrid
</CFQUERY>

<CFOUTPUT QUERY="asset">
<TR BGCOLOR="WHITE">
    <TD>#asset.question#
	</TD>
    <TD>#asset.self#
	</TD>
    <TD>#asset.spouse#
	</TD>
    <TD>#asset.self_spouse#
	</TD>
    <TD>#asset.household#
	</TD>
    <TD>#asset.answerfield#
	</TD>
    <TD>#asset.number#
	</TD>
	<TD><a href="asset_delete.cfm?id=#RecID#&answer=#answerfield#" onClick="return deleteConfirm();">D</A></TD>	
</TR>
</CFOUTPUT>
</TABLE>
