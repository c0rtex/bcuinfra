<cfquery name="partners" datasource="#application.dbsrc#">
	SELECT *
	FROM tbl_partner
	WHERE wrapper_id IS NULL OR wrapper_id = '' OR wrapper_id = 0
</cfquery>

<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<!--- <cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif> --->

<cf_buildPage title="Wrapper Administration" section="partner">

<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
	<tr bgcolor="##22737B">
		<td colspan="3"><font size="+2"><b>New Private Label</b></font></td>
	</tr>
	
	<tr bgcolor="##2E99AF">
		<td colspan="3"><strong>Step 1: Select Partner</strong></td>
	</tr>

</cfoutput>

<cfif partners.recordcount IS 0>
	<tr>
		<td bgcolor="##2E99AF" valign="top" colspan="3"><p>There are no partners eligible to become a private label.</p>  
		<p><b>You must create a partner prior to creating a private label.</b></p>
		<p><a href="partnerview.cfm?action=new">Click here to create a new partner</a></p>
		</td>
	</tr>

</cfif>

<cfoutput query="partners">
	<tr>
		<td bgcolor="##2E99AF" valign="top">#partner_name# (#partner_id#)</td>
		<td bgcolor="##2E99AF" valign="top"><a href="partnerview.cfm?id=#partner_id#">View Partner</a></td>		
		<td bgcolor="##2E99AF" valign="top"><a href="plnew2.cfm?partner_id=#partner_id#">Create Private Label</a></td>		
	</tr>
</cfoutput>
</table>
