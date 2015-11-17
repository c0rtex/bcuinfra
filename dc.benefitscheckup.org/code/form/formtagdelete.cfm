<cfparam name="id" type="numeric">
<cfparam name="deleting" type="numeric" default="0">

<cf_checkAccess level="3">

<cfif deleting eq 1>

	<cfquery name="del" datasource="#application.dbSrc#">
		delete
		from formtag
		where formtag_id=#id#
	</cfquery>
	<cflocation url="formtaglist.cfm" addtoken="no">

<cfelse>

	<cfquery name="info" datasource="#application.dbSrc#">
		select tag_name
		from formtag
		where formtag_id=#id#
	</cfquery>
	<cfquery name="check" datasource="#application.dbSrc#">
		select count(*) as c
		from form
		where formtag_id=#id#
	</cfquery>

	<cf_buildPage title="Delete Form Tag" section="form"><cfoutput>
	
		<table cellpadding="3" cellspacing="3" border="0">
			<tr bgcolor="#application.color.formtag.dark#">
				<td valign="bottom" style="font-size: 18pt; font-weight: bold;">
					Delete: #info.tag_name#
				</td>
			</tr>
			<tr bgcolor="#application.color.formtag.med#">
				<td>
					<cf_checkAccessLink level="5" href="formtagview.cfm?id=#id#">view</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="formtagview.cfm?id=#id#&action=edit">edit</cf_checkAccessLink> | <b>delete</b>
				</td>
			</tr>
			<tr bgcolor="#application.color.formtag.light#">
				<td>
		
					<cfif check.c eq 0>
						<b>Are you sure you want to delete the <b>"#info.tag_name#"</b> form tag?<br /><br />
						
						<a href="?id=#id#&deleting=1">Yes</a>
						&nbsp;
						<a href="javascript:history.back();">No</a>

				</td>
			</tr>
		</table>
					<cfelse>
						Sorry, but this form tag <b>cannot</b> currently be deleted since it is still associated with one or more forms.

				</td>
			</tr>
		</table>

						<br />
						<cf_buildList title="Forms Using This Form Tag" table="form" code="form" condition="f.formtag_id=#id#" editlink="formedit.cfm?id=[[id]]" orderlinks="false">
							<cf_buildListProperty column="formtag_id" visible="false">
							<cf_buildListProperty column="description" visible="false">
							<cf_buildListProperty column="state_id" references="state">
						</cf_buildList>

					</cfif>

	</cfoutput></cf_buildPage>

</cfif>