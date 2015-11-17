<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cf_drugmenu title="Complete Listing of Programs">
<cfoutput>

<cfquery name="rx" datasource="#application.dbSrc#">
	select p.prg_id, p.prg_nm, ifnull(sp.base_flag, 0) rx_only
	from tbl_prg_all p left outer join tbl_subset_prg sp
		on p.prg_id=sp.prg_id
		and sp.subset_id=1
		and sp.base_flag=1
		and sp.staging_flag=0
	order by p.prg_nm
</cfquery>

<table border="0" cellpadding="3" cellspacing="3">
	<tr bgcolor="#application.color.program.med#">
		<td width="150"><b>ID</b></td>
		<td><b>Name</b></td>
		<td><b>Actions</b></td>
		<td><b>Rx?</b></td>
	</tr>
<cfloop query="rx">
	<tr bgcolor="#application.color.program.light#">
		<td valign="top">#prg_id#</td>
		<td valign="top">#prg_nm#</td>
		<td valign="top"><a href="programview.cfm?prg_id=#prg_id#">view&nbsp;details</a></td>
		<cfif rx_only eq 0>
		<td bgcolor="##ffffff"></td>
		<cfelse>
		<td align="center" valign="top">Rx</td>
		</cfif>
	</tr>
</cfloop>
</table>

</cfoutput></BODY>
</HTML>
