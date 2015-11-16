<cfparam name="attributes.title" type="string" default="Drug Administration">

<cfoutput>
<cfmodule template="../header.cfm" title="#attributes.title#">

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#application.color.drug.dark#"><b>drugs</b></td>
		<td></td>
		<td bgcolor="#application.color.drug.med#"><cf_checkAccessLink level="3" href="drugnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="druglist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="drugsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.generic.dark#"><b>generics</b></td>
		<td></td>
		<td bgcolor="#application.color.generic.med#"><cf_checkAccessLink level="3" href="genericnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="genericlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="genericsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.drugcompany.dark#"><b>companies</b></td>
		<td></td>
		<td bgcolor="#application.color.drugcompany.med#"><cf_checkAccessLink level="3" href="companynew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="companylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="companysearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.program.dark#"><b>programs</b></td>
		<td></td>
		<td bgcolor="#application.color.program.med#"><cf_checkAccessLink level="5" href="programlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="programsearch.cfm">search</cf_checkAccessLink></td>
	</tr>
</table>

<cfif attributes.title eq 'Drug Administration'>
	<h1>#attributes.title#</h1>
<cfelse>
	<h2>#attributes.title#</h2>
</cfif>
</cfoutput>