<cfmodule template="../header.cfm">
<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION:    adds a new group to entry points list
CALLED BY:	
GOES TO:  self
=====================================================--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<cfset temp_grp_id =" ">
<HTML>
<HEAD>
	<TITLE>New Group</TITLE>
</HEAD>

<BODY>
<FORM ACTION="new_grp.cfm" MEHTOD="post">
<CFIF IsDefined("add")>
<CFQUERY  DATASOURCE="#application.dbSrc#" NAME="GROUP" maxrows="1">
select  max(group_id) as temp_group_id  from tbl_entry_grp 
</cfquery>  
<cfoutput query="group">
<cfset  session.temp_grp_id = temp_group_id + 1>
	The New Group ID  is:  <b> #session.temp_grp_id#</b> <br>
	Group Name is:  <b>#group_name#</b><br>
	<a href="add_entry.cfm">Return to Add Entry Points</a>
<br>
<cfmodule template="../footer.cfm">
</CFOUTPUT>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_entry_grp(group_name,group_id)
		Select  group_name='#group_name#',  group_id ='#session.temp_grp_id#'
		<!--- SELECT '#group_name#' , 'temp_group_id' --->
	</CFQUERY>	
	

	
	<CFABORT>
</CFIF>
Group Name: <INPUT TYPE="text" NAME="group_name" SIZE="50"><BR>
<INPUT TYPE="submit" VALUE="Continue" NAME="add">

</FORM>

</BODY>
<cfmodule template="../footer.cfm">
</HTML>