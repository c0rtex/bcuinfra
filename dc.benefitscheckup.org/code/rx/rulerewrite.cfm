<cfif ListLen(rulelist) eq 0>
	<cfquery name="ruledelete" datasource="#application.dbSrc#">
		delete from tbl_rules
		where RecID=#testruleid#
	</cfquery>
<cfelse>
	<cfset testrulenew = "(IsDefined('session." & ListChangeDelims(rulelist, "') or IsDefined('session.") & "'))">
	<cfif testruleid eq 0>
		<cfquery name="ruleinsert" datasource="#application.dbSrc#">
			insert into tbl_rules
				(prg_id, elig_rule, pri_sec)
			values
				('#prg_id#', '#testrulenew#', 4)
		</cfquery>
	<cfelse>
		<cfquery name="ruleupdate" datasource="#application.dbSrc#">
			update tbl_rules
			set elig_rule='#testrulenew#'
			where RecID=#testruleid#
		</cfquery>
	</cfif>
</cfif>