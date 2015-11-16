<cfmodule template="../header.cfm">
<!--- reports --->

<FORM ACTION="reports.cfm" METHOD="post">

<CFIF IsDefined("first")><!-- if first load, give OPTIONs of reports -->
	Please choose the report you would like to run.<BR><BR>
	<SELECT NAME="report">
		<OPTION VALUE="count">Program Count
		<OPTION VALUE="prg">Complete Program Info
	</SELECT>
	<INPUT TYPE="submit" NAME="continue" VALUE="Continue">
<CFELSEIF IsDefined("report")><!-- if report chosen, get details -->
	<CFIF report IS "count"><!-- if count report chosen, get state -->
		What state would you like to run this report for?<BR>
		<CF_tagState all="no"><BR>
		<INPUT TYPE="submit" NAME="count" VALUE="Continue">
	<CFELSEIF report IS "prg"><!-- if program report chosen, get program -->
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
			SELECT distinct prg_nm,prg_id,st
			FROM tbl_prg
		</CFQUERY>
		Please choose a program to run this for.<BR>
		Program ID <INPUT TYPE="text" NAME="prg_id"><BR>
		or<BR>
		Program Name
		<SELECT NAME="prg_nm">
			<CFOUTPUT QUERY="prgs">
				<OPTION VALUE="#prg_id#">#prg_nm# - #st#
			</CFOUTPUT>
		</SELECT>
		<BR>
		<INPUT TYPE="submit" NAME="prg" VALUE="Continue">
	</CFIF>
<CFELSEIF IsDefined("prg")><!-- if prg report already chosen, run report -->
	<CFIF prg_id IS "">
		<CFSET prg_id = prg_nm>
	</CFIF>
	<CFLOCATION URL="report_prg.cfm?datasrc=#application.dbSrc#&level=#session.user_level#&user=#session.user#&prg_id=#prg_id#&dontshow=report">
<CFELSEIF IsDefined("count")><!-- if count report already chosen, run report -->
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="cnt">
		SELECT COUNT(prg_id) AS prg_count
		FROM tbl_prg_#st#
	</CFQUERY>
	<CFOUTPUT QUERY="cnt">#st# - #prg_count#<BR></CFOUTPUT>
</CFIF>
<INPUT TYPE="hidden" NAME="dontshow" VALUE="report">
</FORM>
<cfmodule template="../footer.cfm">