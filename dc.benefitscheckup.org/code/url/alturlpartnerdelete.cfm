<cfparam name="id" type="numeric">
<cfparam name="confirm" type="boolean" default="false">

<cf_checkAccess level="3">

<cfquery name="prg" datasource="#application.dbSrc#">
	select url_id
	from alt_url_partner
	where alt_url_partner_id=#id#
</cfquery>


<cfif not confirm>

	<cf_buildPage title="Alternate Partner URL Administration" section="url">
	<cfoutput>
	Are you sure you want to delete that alternate partner URL?<br /><br />
	<a href="?id=#id#&url_id=#prg.url_id#&confirm=true">YES</a> &nbsp; &nbsp; <a href="urlview.cfm?id=#prg.url_id###alturl">NO</a>
	</cfoutput>
	</cf_buildpage>

<cfelse>

	<cfquery name="delete" datasource="#application.dbSrc#">
		delete from alt_url_partner
		where alt_url_partner_id=#id#
	</cfquery>
	<cflocation url="urlview.cfm?id=#url.url_id###alturl" addtoken="no">

</cfif>