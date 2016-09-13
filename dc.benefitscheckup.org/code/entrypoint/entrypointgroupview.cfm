<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">
<cfparam name="state_id" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="4">
</cfif>

<cf_buildPage title="Entry Point Group Administration" section="entrypoint">

<cf_buildView title="Entry Point Group Data" table="entrypointgroup" code="entrypointgroup" key="#id#" action="#action#" saving="#saving#" editlevel="4" extraurllist="entrypointgroupmembers.cfm?id=#id#" extranamelist="entry points">
	<cf_buildViewProperty column="name" input="textarea" rows="2" limit="255">
	<cf_buildViewProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
	<cf_buildViewProperty column="active_flag" input="flag">
	<cf_buildViewProperty column="notes" input="textarea" rows="8" cols="60">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<cfif state_id eq ''>
		<cfset extraTitle = ''>
		<cfset extraPrgCondition = ''>
		<cfset extraEPCondition = ''>
		<cfset extraPrgAddCondition = ''>
		<cfset extraAddCondition = ''>
		<cfset extraAddLinkQS = ''>
	<cfelse>
		<cfset extraTitle = " <small><i>(limited by #state_id# &##151; <a href=""?id=#id#"" style=""color: white;"">remove limit</a> )</i></small>">
		<cfset extraPrgCondition = "p.state_id='#state_id#'">
		<cfset extraEPCondition = " and e.state_id='#state_id#'">
		<cfset extraPrgAddCondition = "p.state_id='#state_id#'">
		<cfset extraAddCondition = "e.state_id='#state_id#'">
		<cfset extraAddLinkQS = "&state_id=#state_id#">
	</cfif>

	<br />
	<cfoutput>
	<table cellpadding="3" cellspacing="3" border="0" width="600">
		<tr bgcolor="#application.color.state.dark#">
			<td><table cellpadding="0" cellspacing="0" border="0" width="100%">
				<form action="entrypointgroupview.cfm" method="get">
				<tr>
					<td align="left" style="font-size: 18pt; font-weight: bold;">Limit Display by State</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td align="right">
						<input type="hidden" name="id" value="#id#" />
						<cf_buildFormSelect table="state" name="state_id" selected="#state_id#" condition="statetype_id=1  or state_id = 'VI'">
						<input type="submit" value="limit" />
					</td>
				</tr>
				</form>
			</table></td>
		</tr>
	</table>
	</cfoutput>

	<cf_buildList name="programAssociate" table="program" code="program" title="Program Associations#extraTitle#" condition="#extraPrgCondition#" crosstable="program_entrypointgroup" crosscolumn="entrypointgroup_id" crossvalue="#id#" joincolumn="program_id" crossorder="sort" crossadd="false" crossdelete="false" linksection="program">
		<cf_buildListProperty column="programcategory_id" references="programcategory">
		<cf_buildListProperty column="programgroup_id" visible="false">
		<cf_buildListProperty column="name_display_id" display="display">
		<cf_buildListProperty column="desc_display_id" display="display" visible="searchonly">
		<cf_buildListProperty column="url" visible="false">
		<cf_buildListProperty column="exclude_flag" visible="false">
		<cf_buildListProperty column="significant_flag" visible="false">
		<cf_buildListProperty column="active_flag" visible="false">
		<cf_buildListProperty column="funder_id" visible="false">
		<cf_buildListProperty column="reference_id" visible="false">
		<cf_buildListProperty column="last_update" visible="false">
		<cf_buildListProperty column="notes" visible="false">
		<cf_buildListProperty column="supersort" visible="false">
		<cf_buildListProperty column="sort" visible="false">
		<cf_buildListProperty column="legacy_prg_id" visible="false">
		<cf_buildListProperty column="legacy_pri_sec" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

	<cfif state_id eq ''>
		<cfoutput>
		<br /><table cellpadding="5"><tr bgcolor="#application.color.entrypoint.med#"><td><font size="+1">Entry points only display here when page is limited by state.  <a href="entrypointgroupmembers.cfm?id=#id#" style="color: white;">Click here</a> for full listing.</font></td></tr></table>
		</cfoutput>
	<cfelse>
		<cf_buildList title="Entry Point Associations#extraTitle#" name="epAssociate" table="entrypoint" code="entrypoint" by="#by#" dir="#dir#" page="#page#" rows="#rows#" condition="xtbl.entrypointgroup_id=#ID##extraEPCondition#" editlevel="4" crossdeletelevel="4" crosstable="entrypoint_entrypointgroup" crosscolumn="entrypointgroup_id" crossvalue="#id#" joincolumn="entrypoint_id" crossorder="entrypoint_id" crossorderlinks="true" crossaddlink="?id=#id##extraAddLinkQS#" crossaddcondition="#extraAddCondition#" crossdelete="false" delete="true" deletelink="entrypointgroupdelete.cfm?id=#id#&entrypoint_id=[[entrypoint_id]]#extraAddLinkQS#&name=epAssociate" selflink="true" selflinkid="#id##extraAddLinkQS#">
			<cf_buildListProperty column="code" visible="false">
			<cf_buildListProperty column="subname" visible="false">
			<cf_buildListProperty column="address2" visible="false">
			<cf_buildListProperty column="address3" visible="false">
			<cf_buildListProperty column="zipcode_plus4" visible="false">
			<cf_buildListProperty column="email" visible="false">
			<cf_buildListProperty column="url" visible="false">
			<cf_buildListProperty column="hours_display_id" display="display" visible="false">
			<cf_buildListProperty column="info_display_id" display="display" visible="false">
			<cf_buildListProperty column="contact_title" visible="false">
			<cf_buildListProperty column="contact_first" visible="false">
			<cf_buildListProperty column="contact_middle" visible="false">
			<cf_buildListProperty column="contact_last" visible="false">
			<cf_buildListProperty column="contact_suffix" visible="false">
			<cf_buildListProperty column="privatephone" visible="false">
			<cf_buildListProperty column="last_update" visible="false">
			<cf_buildListProperty column="active_flag" display="yesno">
			<cf_buildListProperty column="notes" visible="false">
			<cf_buildListProperty column="create_user_id" visible="false">
			<cf_buildListProperty column="create_date" visible="false">
			<cf_buildListProperty column="modify_user_id" visible="false">
			<cf_buildListProperty column="modify_date" visible="false">
		</cf_buildList>
	</cfif>

</cfif>

</cf_buildpage>