<cfparam name="language_id" default="EN">
<cfparam name="form.lang" default="">

<cfif IsDefined('URL.partner_id') AND URL.partner_id EQ 22>
	<cfset SESSION.partner_id = 22>
</cfif>

<cfif IsDefined('URL.partner_id') AND URL.partner_id EQ 0>
	<cfset SESSION.partner_id = 0>
</cfif>

<cfif IsDefined('URL.partner_id')>
	<cfset SESSION.partner_id = URL.partner_id>
</cfif>

<cfif NOT IsDefined('SESSION.partner_id')>
	<cfset SESSION.partner_id = 0>
</cfif>

<cfif form.lang NEQ "" AND form.lang EQ "ES">
	<cfset language_id = "ES">
<cfelse>
	<cfset language_id = "EN">
</cfif>

	<cfparam name="state" default="">
	
	<cfif trim(state) IS "">
		<cflocation url="/cf/snap.cfm?partner_id=#SESSION.partner_id#" addtoken="yes">
	</cfif>
	
	<!---<cfif trim(SESSION.partner_id) EQ 0>
		<cflocation url="/cf/snap_state.cfm?partner_id=#SESSION.partner_id#&state=Alabama" addtoken="yes">
	</cfif>--->
	
	<cfquery name="getdisplay" datasource="#application.dbSrc#">
		SELECT *
		FROM display_language dl
		WHERE dl.display_id = 5946
	</cfquery>
    <!--- <cfdump var="#getdisplay#" expand="no"> --->
	
	<cfquery name="qState" datasource="#application.dbSrc#">
		SELECT *
		FROM state
		WHERE state_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(state)#" maxlength="64">
	</cfquery>
	
	<cfquery name="snap_state" datasource="#application.dbSrc#">
		SELECT p.url, dl.display_text AS title,  dl2.display_text AS description
		FROM program p 
		LEFT JOIN display_language dl ON dl.display_id = p.name_display_id AND dl.language_id = '#language_id#'
		LEFT JOIN display_language dl2 ON dl2.display_id = p.desc_display_id AND dl2.language_id = '#language_id#'
		WHERE p.program_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="nutrition_#qState.state_id#_snap_program" maxlength="64">
	</cfquery>
	
	
	
	<cfquery name="forms" datasource="#application.dbSrc#">
		SELECT *
		FROM program p
		LEFT JOIN program_form pf ON pf.program_id = p.program_id
		LEFT OUTER JOIN form f ON f.form_id = pf.form_id
		LEFT OUTER JOIN formtag ftg ON ftg.formtag_id = f.formtag_id
		LEFT OUTER JOIN form_formtype ft ON ft.form_id = pf.form_id
		WHERE p.program_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="nutrition_#qState.state_id#_snap_program" maxlength="64">
        <cfif listFindNoCase("PR", qState.state_id) GT 0 AND language_id IS "ES">
        	AND (f.form_id = 1011 OR f.form_id = 955)
        <cfelseif listFindNoCase("PR", qState.state_id) GT 0 AND language_id IS "EN">
        	AND (f.form_id = 1013 OR f.form_id = 972)
        <cfelse>
        	AND f.form_id > 0
        </cfif>
		 AND ftg.tag_name NOT LIKE '%Online%'
		ORDER BY pf.sort
	</cfquery>
     <cfquery name="forms_online" datasource="#application.dbSrc#">
		SELECT *
		FROM program p
		LEFT JOIN program_form pf ON pf.program_id = p.program_id
		LEFT OUTER JOIN form f ON f.form_id = pf.form_id
		LEFT OUTER JOIN formtag ftg ON ftg.formtag_id = f.formtag_id
		LEFT OUTER JOIN form_formtype ft ON ft.form_id = pf.form_id
		WHERE p.program_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="nutrition_#qState.state_id#_snap_program" maxlength="64">
		AND f.form_id > 0 and ftg.tag_name like '%Online Application%'
		ORDER BY pf.sort
	</cfquery>
	
	<!--- Set guts --->
	<cfset guts = "snap_state_cf.cfm">
	<!--- Initialize and load any session variable value passed into this page --->
	
	<cfif findnocase(trim(state), snap_state.title) GT 0>
		<cfset snap_title = snap_state.title>
	<cfelse>
		<cfset snap_title = "#state# #snap_state.title#">
	</cfif>
	

	<cfset title = "BenefitsCheckUp From NCOA - #snap_title#">

<!--- <cfdump var="#getdisplay#" label="GETDISPLAY" expand="no">
<cfdump var="#qState#" label="qState" expand="no">
<cfdump var="#snap_state#" label="snap_state" expand="no">
<cfdump var="#forms#" label="forms" expand="no"> --->
<!---<cf_sessionLoadVars>--->
<cfset showmenu = 1>

<cf_tagHeader guts="#guts#" show_left_col="n" title="#title#" showmenu="#showmenu#">
<cfinclude template="#guts#">
<cf_tagFooter>
