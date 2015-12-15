<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
	qualifies
CALLED BY: proc_asset.cfm
GOES TO: N/A
REQUIRED: N/A
============================================---->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="buffer_prgs">
SELECT prg_id, prg_nm, order_num, st, Cat_ID, major_cat, id_number
FROM tbl_prg_all, tbl_major_cat_list
WHERE
<cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''>
	tbl_major_cat_list.id_number NOT IN (333, 334) AND
</cfif>
	tbl_major_cat_list.id_number = tbl_prg_all.Cat_ID
	AND prg_id IN (#preservesinglequotes(session.buff_list)#)
	ORDER BY order_num
</CFQUERY>

<CFOUTPUT>
<br>
<FONT SIZE=+2><b>Other Programs to Consider</b></FONT><br>
<hr>
<p><font face="Arial">There is some chance that you are eligible for the following programs, although your income and assets appear to be too high.  If these programs could be helpful to you, you may want to apply so that a formal determination can be made. </font></p>
</CFOUTPUT>

<table>
<cfset prg_count = 0>

<CFLOOP QUERY="buffer_prgs" startrow="1" endrow="#buffer_prgs.recordcount#">
<cfset prg_count = prg_count + 1>
<CFOUTPUT>
<tr><td valign="top">#prg_count#.</td><td><A HREF="frmDetails.cfm?prg_id=#buffer_prgs.prg_id#&src=elig&cfid=#session.cfid#&cftoken=#session.cftoken#"><FONT FACE="arial">#buffer_prgs.prg_nm#</FONT></A> (#buffer_prgs.major_cat#)</td></tr>
</CFOUTPUT>
</CFLOOP>
</table>
