<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<cfmodule template="../header.cfm">
<HTML>
<HEAD>
	<TITLE>Counties Not in use</TITLE>
</HEAD>

<BODY>
<b>Search for Counties in the zip code table that are not listed in the Counties Served Field </b>

<CFQUERY NAME="qrySt" DATASOURCE="#application.dbSrc#">
	SELECT DISTINCT State FROM tbl_zip
	ORDER BY State
</CFQUERY>

<CFQUERY NAME="qryGrp" DATASOURCE="#application.dbSrc#">
	SELECT *
	FROM tbl_entry_grp
	ORDER BY group_name
</CFQUERY>

<FORM ACTION="getcn.cfm" METHOD="POST">

	Select State:
	<SELECT NAME="SelSt"  >
		<CFOUTPUT QUERY="qrySt">
			<OPTION VALUE="#state#">#state#
		</CFOUTPUT>
	</SELECT><BR><BR>	

	Select Group
	<SELECT NAME="SelGrp"  >
		<CFOUTPUT QUERY="qryGrp">
			<OPTION VALUE="#group_id#">#group_name# (#group_id#)
		</CFOUTPUT>
	</SELECT>
	<BR><BR>

	<INPUT TYPE="Submit" NAME="" VALUE="Go">
	
</FORM>


</BODY>
</HTML>
<cfmodule template="../footer.cfm">