<cfparam name="prg_id" default="" type="string">
<CFQUERY datasource="#application.dbSrc#" name="appforms">
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#prg_id#" maxlength="30">
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id=2
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
</CFQUERY>
<cfif appforms.recordcount neq 0>
	<cfset countAppsDisplayed = 0>
	<cfoutput query="appforms"> 
		<cfif countAppsDisplayed eq 0>
		<B>The following eForms are available for this program (clicking links will open new browser window):</B>
		<ul>
		</cfif>
		<li><a href="eformsubmit.cfm?efitem=#appforms.string#&prg_id=#prg_id#&cftoken=#session.cftoken#&cfif=#session.cfid#" target="_blank">#tag_name#</a>
		<cfif application.subsetsUseViews>
			<form action="xml.cfm" method="post" name="eform" target="_blank">
				<cf_genAssistGuideXML code="#appforms.string#" prg_id="#prg_id#">
				<input type="hidden" name="#appforms.string#" value="include">
				<input type="hidden" name="startxml" value="#startAssistGuideXML#">
				<input type="hidden" name="endxml" value="#endAssistGuideXML#">
				<input type="hidden" name="xml" value="">
				<input type="button" value="Show XML for Debugging" onClick="javascript:document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">
				</form>
		</cfif>
		<cfset countAppsDisplayed = countAppsDisplayed + 1>
	</cfoutput>
	<cfif countAppsDisplayed gt 0>
		</ul>
	</cfif>
</cfif>