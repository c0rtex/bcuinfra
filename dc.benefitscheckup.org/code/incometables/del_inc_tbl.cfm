<CFQUERY DATASOURCE="#application.dbSrc#" NAME="tbls">
select tbl_nm from tbl_inc_new where tbl_id=#tbl_id#
</CFQUERY>

<cfmodule template="../header.cfm"><cfoutput>
<font FACE="ARIAL">

Are you sure you want to delete the income table "#tbls.tbl_nm#"?  This cannot be undone.

<form action="del_inc_tbl2.cfm" method="post">
<input type="submit" value="Delete"> &nbsp; <cfinclude template="../cancel.cfm">
<input type="hidden" name="tbl_id" value="#tbl_id#">
</form>

</font>
</CFOUTPUT><cfmodule template="../footer.cfm">