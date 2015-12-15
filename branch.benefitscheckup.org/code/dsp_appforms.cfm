<cfparam name="application.formpath" default="forms">
<cfparam name="formtype_id" default="1" >
<cfparam name="prg_id" default="" type="any">
<cfparam name="source" default="details">
<cfif source eq "details" >
<cfif isdefined('url.formtype_id')>
	<cfset formtype_id = url.formtype_id >
</cfif>
<cfoutput><b>DISPLAY FORM</b><br><br></cfoutput>
<CFQUERY datasource="#application.dbSrc#" name="appforms">
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id =<cfqueryparam cfsqltype="cf_sql_varchar" value="#prg_id#" maxlength="30">
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id<cfif formtype_id eq 0> IN (1, 4)<cfelse>=<cfqueryparam cfsqltype="cf_sql_integer" value="#formtype_id#" maxlength="3"></cfif>
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
</CFQUERY>
	<cfif appforms.recordcount neq 0>
	<div <cfif session.partner_id EQ 22>class="appforms"</cfif>>
		<cfset countAppsDisplayed = 0>
		<cfoutput query="appforms"> 
			<!--- BShunn 2004-08-25  If form URL is in program description, do not display it --->
			<cfif FindNoCase("forms/#string#", save_prg_desc) eq 0>
				<cfif countAppsDisplayed eq 0>
				<B>Click below to get application(s) and/or document(s) for this program:</B>
				<ul>
				</cfif>
				<cfif formtype_id eq 1 or formtype_id eq 0>
				<li><a 
href="forms/#appforms.string#">#tag_name#</a></li>
				<cfelseif formtype_id eq 2>
				<li><a href="eformsubmit.cfm?efitem=#appforms.string#" target="_blank">#tag_name#</a></li>
				<cfelseif formtype_id eq 4 or formtype_id eq 0>
				<li><a 
href="forms/#appforms.string#">#tag_name#</a></li>
				</cfif>
				<cfset countAppsDisplayed = countAppsDisplayed + 1>
			</cfif>
		</cfoutput>
		<cfif countAppsDisplayed gt 0>
			</ul>
		</cfif>
	</div>
	</cfif>

<cfelse>
<CFQUERY datasource="#application.dbSrc#" name="appforms">
	SELECT ft.string, t.tag_name
	FROM tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
	WHERE p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#prg_id#" maxlength="30">
		AND p.RecID=pf.program_id
		AND pf.form_id=f.form_id
		and (f.state_id is null or f.state_id='#session.st#')
		AND f.form_id=ft.form_id
		AND ft.formtype_id<cfif formtype_id eq 0> IN (1, 4)<cfelse>=<cfqueryparam cfsqltype="cf_sql_integer" value="#formtype_id#" maxlength="3"></cfif>
		AND ft.active=1
		AND f.formtag_id=t.formtag_id
	ORDER BY pf.sort
</CFQUERY>
	<cfif appforms.recordcount neq 0>
		<cfset countAppsDisplayed = 0>
		<cfoutput query="appforms"> 
				<cfif formtype_id eq 4 or formtype_id eq 0>		
				<cfif countAppsDisplayed eq "0">
					<div class="button_fact_sheet">
						<a href="dsp_appforms.cfm?src=details&prg_id=#prg_id#&save_prg_desc=no&formtype_id=4" target="_blank">
						<img id="getform_gif_one" alt="Download fillable program application form" src="images/button_get-form.gif" border="0" ></a>
						<div class="read_more">
							<strong>Download fillable program application form</strong> <em>(Clicking the button to the left will open a new window.) </em>					
						</div>		
					</div>	
				</cfif>				
				<cfset countAppsDisplayed = countAppsDisplayed + 1>
				<cfelseif formtype_id eq 1 or formtype_id eq 0>		
				<cfif countAppsDisplayed eq "0">
					<div class="button_fact_sheet">
						<a href="dsp_appforms.cfm?src=details&prg_id=#prg_id#&save_prg_desc=no" target="_blank">
						<img id="getform_gif_two" alt="Download program application form to fill out by hand" src="images/button_get-form.gif" border="0" ></a>	
						<div class="read_more">	
							<strong>Download program application form to fill out by hand</strong> <em>(Clicking the button to the left will open a new window.) </em>
						</div>
					</div>	
				</cfif>				
				<cfset countAppsDisplayed = countAppsDisplayed + 1>
				<cfelseif formtype_id eq 2>	
					<div class="button_fact_sheet">
						<a href="eformsubmit.cfm?efitem=#appforms.string#&prg_id=#prg_id#" target="_blank" >
						<img src="images/button_eform.gif" border="0" alt="Fill out <cfif appforms.recordcount gt 1 >#tag_name#<cfelse>program application form</cfif> using your computer"></a>	
						<div class="read_more">	
							<strong>Fill out <cfif appforms.recordcount gt 1 >#tag_name#<cfelse>program application</cfif> using your computer</strong> <em>(Clicking the button to the left will open a new window.) </em>
						</div>
					</div>
					
				</cfif>
		</cfoutput>
	</cfif>
</cfif>
