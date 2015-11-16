<CFQUERY DATASOURCE="#application.dbSrc#" NAME="tbls">
delete from tbl_inc_new where tbl_id=#tbl_id#
</CFQUERY>
<cflocation url="inc_tbl2.cfm">