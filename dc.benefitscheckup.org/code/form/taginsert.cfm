<cfinclude template="tagqueries.cfm">
<cfif tag_id eq 0>
	<cfquery name="taginsert" datasource="#application.dbSrc#">
		insert into formtag
			(formclass_id, tag_name)
		values
			(#class_id#, '#tagline#')
	</cfquery>
	<cfinclude template="tagqueries.cfm">
</cfif>
