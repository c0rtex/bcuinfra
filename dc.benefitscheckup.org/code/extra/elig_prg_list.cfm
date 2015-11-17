<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prglist">
Select *
From tbl_elig_rules_AK
</CFQUERY>

<CFLOOP QUERY="prglist">
<CFOUTPUT>
<a href="eligtest.cfm?rule=#URLEncodedFormat(prglist.session_rule)#">#prglist.prg_id#</A><BR>
</CFOUTPUT>
</CFLOOP>

