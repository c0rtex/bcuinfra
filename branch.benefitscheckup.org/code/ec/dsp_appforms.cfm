<cfparam name="application.formpath" default="forms">
<CFQUERY datasource="#application.dbSrc#" name="appforms">
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#prg_id#" maxlength="25">
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		AND f.form_id=ft.form_id
		AND ft.formtype_id=1
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
</CFQUERY>
<cfif appforms.recordcount neq 0>
	<cfset countAppsDisplayed = 0>
	<cfoutput query="appforms"> 
		<!-- BShunn 2004-08-25  If form URL is in program description, do not display it -->
		<cfif FindNoCase("forms/#string#", save_prg_desc) eq 0>
			<cfif countAppsDisplayed eq 0>
			<B>The following downloadable documents are available for this program:</B>
			<ul>
			</cfif>
			<li><a href="../forms/#appforms.string#">#tag_name#</a>
			<cfset countAppsDisplayed = countAppsDisplayed + 1>
		</cfif>
	</cfoutput>
	<cfif countAppsDisplayed gt 0>
		</ul>
	</cfif>
</cfif>