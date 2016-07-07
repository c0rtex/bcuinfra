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

<h2>Other Programs You May Want to Consider</h2>

<p>Although your income and/or assets are slightly higher than the program guidelines, you may still want to consider getting help from the
following program or programs. Some programs have special considerations (such as deductions and disregards) that are specific to your situation.  These
considerations may help you qualify for a program that you may not otherwise meet the income and/or asset rules for. If you believe these programs could be
helpful to you, you may want to apply anyway so that you can find out for certain whether you qualify.</p>
</CFOUTPUT>

<ul class="striping">
<cfset prg_count = 0>

	<CFLOOP QUERY="buffer_prgs" startrow="1" endrow="#buffer_prgs.recordcount#">
		<cfset prg_count = prg_count + 1>
<CFOUTPUT>
<li class="questionBar"><span class="program_number">#prg_count#.</span><A HREF="frmDetails.cfm?prg_id=#buffer_prgs.prg_id#&src=elig&cfid=#session.cfid#&cftoken=#session.cftoken#">#buffer_prgs.prg_nm#</A> (#buffer_prgs.major_cat#)
</li>
</CFOUTPUT>
</CFLOOP>
</ul>
