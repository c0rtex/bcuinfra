<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Questions</TITLE>
</HEAD>

<BODY>

<CFOUTPUT><H2> STATE = #SelSt#<BR> <BR>
</H2></CFOUTPUT>

<CFQUERY NAME="qryQ" DATASOURCE="#application.dbSrc#">
	SELECT * 
	FROM tbl_questions
	WHERE answerfield IN (select field_nm from _#SelSt#)
</CFQUERY>
<BR>
<CFOUTPUT><H3>#qryQ.recordCount# Reults<BR><BR><BR></H3></CFOUTPUT>

	
	 <TABLE>
		<TR bgcolor="tan">
				<TD><B>Question</B></TD>
				<TD><B>Field Name</B></TD>
				
		</TR>
				
	<CFLOOP QUERY="qryQ">
		<CFSET Currentquestion = question>


		<CFINCLUDE TEMPLATE="Incsettrbgcolor.cfm">
		<CFOUTPUT>
		<TR BGCOLOR="#Bgclr#">
			<TD>#question#</TD>
			<TD>#answerfield#</TD>
			<TD > </TD>
		</TR>
		</CFOUTPUT>

	</CFLOOP> 
	</TABLE>
	
	<BR><BR>



 

</BODY>
</HTML>
