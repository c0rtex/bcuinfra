<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION:    displays search results for note search
CALLED BY: note_search.cfm
GOES TO: Update_notes1.cfm
=====================================================--->

<cfmodule template="../header.cfm">



<CFQUERY DATASOURCE="#application.dbSrc#" NAME="note">
		SELECT * 
		FROM tbl_notes
		WHERE added_dt = added_dt
	
	<CFIF isdefined("id")>
		AND recID = #id#
	</CFIF>
	
<CFIF isdefined("search")>
	<CFIF key_wrd IS NOT "">
		AND note LIKE '%#key_wrd#%'
	</CFIF>
	
		<CFIF st IS NOT "All">
			AND st = '#st#'
	</CFIF>
</CFIF>
	order by st
</CFQUERY>

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<FORM>

		<CFIF note.recordcount IS 0>
				Sorry, no matches found.
		</CFIF>

<CFLOOP QUERY="note">

    <CFOUTPUT>
    <p>
	<table border="0" width="100%" BGCOLOR="SILVER">
		<tr BGCOLOR="SILVER">
				<TD><a href="note_update.cfm?RecId=#recID#">Add additional</a></TD>
				<TD>#dateFORMat("#added_dt#","MM/DD/YY")#</TD>
				<TD>#ST#</td>
			</TR>
			<TR>
				<TD colspan="3" rowspan="2">#note#</TD>
			</TR>
		</TABLE>
    </CFOUTPUT>
    </p>
</CFLOOP>
</FORM>
</BODY>
</html>
<cfmodule template="../footer.cfm">