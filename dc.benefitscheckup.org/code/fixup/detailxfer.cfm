<!---
detailxfer.cfm
utility template for translating option associations to answerfield associations
in "tbl_RX_Detail"
--->
<cfquery name="rx" datasource="#session.datasrc#">
	select rd.rxdetail_id, rd.opt_id, o.fieldtext, a.answerfield_id
	from tbl_rx_detail rd, tbl_opt o, answerfield a
	where rd.opt_id=o.opt_id
        and o.fieldtext=a.answerfield
	order by rd.rxdetail_id
</cfquery>
<cfoutput>
<table border="1">
<tr>
	<td colspan="4">#rx.RecordCount#</td>
</tr>
<cfloop query="rx">
<tr>
	<td>#rxdetail_id#</td>
	<td>#opt_id#</td>
	<td>#fieldtext#</td>
	<td>#answerfield_id#</td>
	<cfquery name="rxupd" datasource="#session.datasrc#">
		update tbl_RX_Detail
		set answerfield_id=#answerfield_id#
		where rxdetail_id=#rxdetail_id#
	</cfquery>
</tr>
</cfloop>
</table>

</cfoutput>