<cfmodule template="../header.cfm">
<!-- lists names of sponsoring agencies that match search criteria-->

<!--- Changed by Chaim 01/03/2000 to show only groups --->
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="org">
	select a.group_name, a.group_id
	from tbl_entry_grp a 
	WHERE a.group_id in (SELECT group_id FROM tbl_entry
	WHERE st = '#st#' <CFIF  #st#  EQ "FD" > OR st = ''</CFIF>
	)
	AND a.group_name like '#group_name#%'
	order by a.group_name
</CFQUERY>

<HTML>

<HEAD>
	<TITLE>Spons Search 2</TITLE>
</HEAD>
<BODY>
<FORM>
<CFOUTPUT query="org">
	<li><a href="entry_group.cfm?user=#session.user#&group_id=#group_id#&datasrc=#application.dbSrc#&level=#session.user_level#&st=#st#<CFIF isdefined("delete")>&delete=yes</CFIF>">#group_name#</a></li>
</CFOUTPUT>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">