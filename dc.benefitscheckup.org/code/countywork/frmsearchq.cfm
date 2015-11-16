<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Counties Not in use</TITLE>
</HEAD>

<BODY>

<CFQUERY NAME="qrySt" DATASOURCE="#application.dbSrc#">
	SELECT DISTINCT state FROM tbl_zip
	ORDER BY state
</CFQUERY>


<FORM ACTION="getq.cfm" METHOD="POST">

	Select State:
	<SELECT NAME="SelSt"  >
		<OPTION VALUE="FD">FD
		<OPTION VALUE="FD">MN2
		<CFOUTPUT QUERY="qrySt">
			<OPTION VALUE="#state#">#state#
		</CFOUTPUT>
	</SELECT><BR><BR>

	<INPUT TYPE="Submit" NAME="" VALUE="Go">
	
</FORM>


</BODY>
</HTML>
