<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- shows income TABLE values -->
<cfmodule template="../header.cfm">
<form action="add_inc_tbl.cfm">
<h2>Add a new income value:</h2><input type=submit value=ADD method=post>
</form>
<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">



<font FACE="ARIAL">
	<CFIF IsDefined('tbl_id')>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="inc">
			SELECT *
			FROM tbl_inc_new
			WHERE tbl_id=#tbl_id#
			ORDER BY st
		</CFQUERY>
	<CFELSEIF IsDefined('tbl_nm')>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="inc">
			SELECT *
			FROM tbl_inc_new
			WHERE tbl_nm LIKE '#tbl_nm#%'
			ORDER BY st
		</CFQUERY>
	<CFELSE>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="inc">
			SELECT *
			FROM tbl_inc_new
			WHERE tbl_nm not like 'public housing%'
				AND tbl_nm not like 'section 8%'
				AND tbl_nm not like 'liheap%'
				AND tbl_nm not like 'weather%'
				AND tbl_nm not like 'lasset%'
				AND tbl_nm <> 'TANF'
				AND tbl_nm not like 'child ssi%'
			ORDER BY proc_id
		</CFQUERY>
	</CFIF>

<BR>
	<table border="0" width="750" BGCOLOR="white">
		<tr BGCOLOR="cococo">
			<TD><a href="inc_tbl2.cfm">Individual</A></TD>
			<TD><a href="inc_tbl2.cfm?tbl_nm=public+housing">Public Housing</A></TD>
			<TD><a href="inc_tbl2.cfm?tbl_nm=section+8">Section 8</A></TD>
			<TD><a href="inc_tbl2.cfm?tbl_nm=liheap">LIHEAP</a></td>
			<TD><a href="inc_tbl2.cfm?tbl_nm=weather">Weatherization</a></td>
			<TD><a href="inc_tbl2.cfm?tbl_nm=lasset">LIHEAP Asset</a></td>
			<TD><a href="inc_tbl2.cfm?tbl_nm=tanf">TANF</a></td>
			<TD><a href="inc_tbl2.cfm?tbl_nm=child+ssi">Child SSI</a></td>
		</TR>
		<TR BGCOLOR="WHITE">
			<TD COLSPAN="7">
			<HR color=red>
			</TD>
		</TR>
</TABLE>

<table border="0" width="750" BGCOLOR="white">

<CFOUTPUT QUERY="inc">
		<tr BGCOLOR="SILVER">
			<TD>
			<cfif session.user_level neq "readUser"><a href="edit_inc_tbl.cfm?tbl_id=#inc.tbl_id#">Edit</a> &nbsp; <a href="del_inc_tbl.cfm?tbl_id=#inc.tbl_id#">Delete</a></cfif>
			</TD>
			<TD COLSPAN="8"><B><FONT COLOR="Red">#proc_id#</FONT></B>
			#inc.tbl_nm# - #inc.st#
			</TD>
		</TR>
		<TR>
			<TD></TD>
			<TD><B>1</B></TD>
			<TD><B>2</B></TD>
			<TD><B>3</B></TD>
			<TD><B>4</B></TD>
			<TD><B>5</B></TD>
			<TD><B>6</B></TD>
			<TD><B>7</B></TD>
			<TD><B>8 or more</B></TD>
		</TR>
		<TR>
			<TD>INCOME LIMIT</TD>
			<TD>$#inc.mem1#</TD>
			<TD>$#inc.mem2#</TD>
			<TD>$#inc.mem3#</TD>
			<TD>$#inc.mem4#</TD>
			<TD>$#inc.mem5#</TD>
			<TD>$#inc.mem6#</TD>
			<TD>$#inc.mem7#</TD>
			<TD>$#inc.mem8#</TD>
		</TR>
		<TR BGCOLOR="WHITE">
			<TD COLSPAN="9">
			
			</TD>
		</TR>
</CFOUTPUT>
	</TABLE>

</BODY>
</HTML>
<cfmodule template="../footer.cfm">