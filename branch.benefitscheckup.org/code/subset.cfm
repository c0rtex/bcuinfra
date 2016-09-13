<cfquery name="subsets" datasource="#application.dbSrc#">
	SELECT subset_id, subset_name
	FROM xsubset
	WHERE subsettype_id in (1<cfif IsDefined('session.subsetTest') eq 1>, 2</cfif>)
	ORDER BY subset_id
</cfquery>
<cfquery name="partners" datasource="#application.dbSrc#">
	SELECT partner_id, partner_code
	FROM tbl_partner
	ORDER BY partner_id
</cfquery>
<cf_sessionLoadVars>
<cf_tagHeader>
<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<h2>Subset Demo</h2>

<font face="+1">
<cfif subsets.RecordCount gt 0>
<b>Choose a subset and partner below to perform a screening:</b><br><br>

<table border="0">
<tr>
	<td colspan="2" rowspan="2">&nbsp;</td>
	<td align="right"><b>Partner</b></td>
	<td>&nbsp;</td>
	<td align="center" width="40"><b>0.</b></td>
	<cfoutput><cfloop query="partners">
	<td align="center" width="40"><b>#partner_id#.</b></td>
	</cfloop></cfoutput>
</tr>
<tr>
	<td colspan="2" valign="bottom"><b>Subset</b></td>
	<td align="center">none</td>
	<cfoutput><cfloop query="partners">
	<td align="center">#partner_code#</td>
	</cfloop></cfoutput>
</tr>
<cfoutput query="subsets">
<cfset sid = subset_id>
<cfset sname = subset_name>
<tr>
	<td align="right" valign="top"><b>#sid#.</b></td>
	<td></td>
	<td valign="top">#subset_name#</td>
	<td>&nbsp;</td>
	<td align="center" valign="top"><cf_sessionPassVars href="before_you_start.cfm" subset_id="#sid#" partner_id="0" extralist="preserve=true">&nbsp;go&nbsp;</cf_sessionPassVars></td>
	<cfloop query="partners">
	<td align="center" valign="top"><cf_sessionPassVars href="before_you_start.cfm?partner_id=#partner_id#" subset_id="#sid#" partner_id="#partner_id#" extralist="preserve=true">&nbsp;go&nbsp;</cf_sessionPassVars></td>
	</cfloop>
</tr>
</cfoutput>
</table>
<br>

<cfelse>
No subsets available.
</cfif>
</font>

</FONT></TD></TR></TBODY></TABLE>
<cf_tagFooter>
