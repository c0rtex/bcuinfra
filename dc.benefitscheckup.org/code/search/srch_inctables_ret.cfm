<!--- ========================================================================
Name		:	srch_inctables_ret.cfm
Description : 	Processes Query and outputs 
				 
Called By   : 	HeaderSrch.cfm
Goes To     : 	
ModDate		:	6/20/2000
Author		:	junior
========================================================================= --->

<HTML>
<HEAD>
<TITLE>DATA COLLECTOR:  Search Income Tables   -RESULTS-</TITLE>
</HEAD>
<BODY bgcolor="ffffcc">
<cfmodule template="../header.cfm">
<CFINCLUDE template="headersrch.cfm">
<CFIF #Type# IS "Individual">
	<CFQUERY datasource="#application.dbSrc#" name="GetIncTablesFromDB">
		SELECT 	*
		FROM 	tbl_inc_new
		WHERE 	tbl_nm <> 'public housing'
		AND		tbl_nm <> 'section 8'
		AND		tbl_nm	LIKE	'%#SearchWord#%'
	<CFIF NOT (#state# IS "all")>
		AND		st	= '#State#'
	</CFIF>
		ORDER 	BY 	tbl_nm
	</CFQUERY>
<CFELSE>
	<CFQUERY datasource="#application.dbSrc#" name="GetIncTablesFromDB">
		SELECT 	*
		FROM 	tbl_inc_new
		WHERE 	tbl_nm = '#Type#'
		AND		tbl_nm	LIKE	'%#SearchWord#%'
	<CFIF NOT (#state# IS "all")>
		AND		st	= '#State#'
	</CFIF>
		ORDER BY tbl_nm
	</CFQUERY>
</CFIF>

<HR>

<CFOUTPUT>
<H3><CENTER>Income Tables: #Type#</CENTER></H3>
</CFOUTPUT>

<CENTER>
<TABLE border="1">
	<TR>
	<CFOUTPUT>
		<TD><A href="srch_inctables_ret.cfm?Type=Individual&SearchWord=#SearchWord#&State=#State#">Individual</A></TD>
		<TD><A href="srch_inctables_ret.cfm?Type=Public Housing&SearchWord=#SearchWord#&State=#State#">Public Housing</A></TD>
		<TD><A href="srch_inctables_ret.cfm?Type=Section 8&SearchWord=#SearchWord#&State=#State#">Section 8</A></TD>
	</CFOUTPUT>
	</TR>
</TABLE>
</CENTER>
<TABLE border="0" width="100%">
	<CFOUTPUT query="GetIncTablesFromDB">
		<TR>
			<TD colspan="9"><B>#tbl_nm# - #st# - #tbl_id#</B></TD>
		</TR>
		<TR>
			<TD> </TD>
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
			<TD>$#mem1#</TD>
			<TD>$#mem2#</TD>
			<TD>$#mem3#</TD>
			<TD>$#mem4#</TD>
			<TD>$#mem5#</TD>
			<TD>$#mem6#</TD>
			<TD>$#mem7#</TD>
			<TD>$#mem8#</TD>
		</TR>
		<TR>
			<TD colspan="9">
				<HR>
			</TD>
		</TR>
	</CFOUTPUT>
</TABLE>
</BODY>
<cfmodule template="../footer.cfm">