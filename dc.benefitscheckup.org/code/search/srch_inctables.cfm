<!--- ========================================================================
Name		:	srch_inctables.cfm
Description : 	Displays Form for search against income tables and 
				sends user response to processing page. 
Called By   : 	HeaderSrch.cfm
Goes To     : 	srch_inctables_ret.cfm
ModDate		:	6/20/2000
Author		:	junior
========================================================================= --->

<HTML>
<HEAD>
<TITLE>DATA COLLECTOR:  Search Income Tables</TITLE>
</HEAD>
<BODY bgcolor="ffffcc">
<cfmodule template="../header.cfm">
<CFINCLUDE template="headersrch.cfm">

<CFQUERY datasource="#application.dbSrc#" name="StateLookup">
	SELECT 	st 
	FROM 	tbl_st
</CFQUERY>

<HR>

<H3>
<CENTER>Search: Income Tables</CENTER></H3>
<TABLE align="center">
	<TR>
		<TD>
		<CFFORM action="srch_inctables_ret.cfm" method="post">
		<CENTER>
		<P>
		Enter Search Term:<BR>
			<CFINPUT type="Text" name="SearchWord" required="No" size="30">
		</P>
		Select State:<BR>
			<CFSELECT name="State">
			<OPTION value="all">all
			<CFOUTPUT query="StateLookup">
				<OPTION value="#st#">#st#
			</CFOUTPUT>
			</CFSELECT>
		</P>
		<P>
		Choose Type:<BR>
			<CFSELECT name="Type">
				<OPTION value="Individual">Individual</OPTION>
				<OPTION value="Public Housing">Public Housing</OPTION>
				<OPTION value="Section 8">Section 8</OPTION>
			</CFSELECT>
		</P>
		<P>
			<INPUT type="submit" name="submit" value="Search">
		</P>
		</CENTER>
		</CFFORM>
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">