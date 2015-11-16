<script language="JavaScript">
<!-- Force all the previous frames off
if (self.parent.frames.length != 0) self.parent.location=document.location.href;
// -->
</script>
<cfmodule template="../header.cfm">
<!-- grid for data entry of entry points -->
<cfFORM NAME="add_entry" action="add_spons.cfm">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="orgid">
select max(org_id) as org_id1 from tbl_entry
</CFQUERY>
<CFOUTPUT>
<INPUT TYPE="hidden" NAME="counter" VALUE="#evaluate("#orgid.org_id1# + 1")#">
</CFOUTPUT>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="groups">
select group_name,group_id from tbl_entry_grp
order by group_name
</CFQUERY>
Please select the group of entry points you will be entering.<br>
<select NAME="group_id"><option VALUE="0">[single entry point, no group]
<CFOUTPUT query="groups">
<option VALUE="#group_id#"><cfif Trim(group_name) eq ''>[untitled entry group, shame!]<cfelse>#Trim(group_name)#</cfif>
</CFOUTPUT>
</select>


<br><br>

<INPUT TYPE="submit" VALUE="Next">
<br><br><br>
<!---- Mir Begin To prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER">  
<H3> You are a Read Only User </H3>
<CFELSE> 
<CFOUTPUT><center><a href="new_grp.cfm" > Add a New group</a></center>
</CFOUTPUT>
</cfif> <!---- end Mir --->
</cfFORM>
<cfmodule template="../footer.cfm">