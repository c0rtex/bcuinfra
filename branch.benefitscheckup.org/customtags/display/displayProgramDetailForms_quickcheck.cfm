
	<cfsilent>
	<cfparam name="session.partner_id" default="0">
	<cfparam name="application.formpath" type="string" default="forms">
	<cfparam name="attributes.program_id" type="numeric">
	<cfparam name="attributes.formtype_id" type="numeric" default="1">
	<cfparam name="attributes.eform" type="boolean" default="false">
	<cfparam name="attributes.source" type="string" default="details">
	<cfparam name="attributes.var" type="string" default="">
	<cfparam name="attributes.append" type="boolean" default="false">
	<cfparam name="attributes.state_id" type="string" default="">
	<cfparam name="attributes.format" type="string" default="html">
	
	
	<cfset outstr = ''>
	<cf_cacheProgramPool action="get" id="#attributes.program_id#" var="pobj" codevar="code">
	<cf_displayText group="prgdesc" code="prgdesc_#code#" var="programDescription">
	
	
	<cfif attributes.source eq 'details'>
		<cfquery datasource="#application.dbSrc#" name="appforms">
			SELECT ft.string, t.tag_name,f.form_id
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=<cfqueryparam cfsqltype="cf_sql_numeric" value="#attributes.program_id#" maxlength="6">
				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#url.state_id#')
				AND f.form_id=ft.form_id
				AND ft.formtype_id
				<cfif attributes.formtype_id eq 0> in (1, 4)
				<cfelse>=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.formtype_id#" maxlength="2">
				</cfif>
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort
		</cfquery>
		<cfif appforms.recordcount neq 0>
			<cfif attributes.format neq "xml">
			<cfset countAppsDisplayed = 0>

			
				
					<cfloop query="appforms"> 
						<!--- BShunn 2004-08-25  If form URL is in program description, do not display it --->
						<cfif FindNoCase("forms/#string#", programDescription) eq 0>
							<cfif countAppsDisplayed eq 0>
								<cfset outstr = outstr & '<div id="application_forms"><h3>Application Forms</h3><p>Click below to get the application and/or document(s) for this program:</p><ul class="striping" style="list-style: none outside none; margin-left: 0px; margin-top: 0px; margin-bottom: 0px;">'>
							</cfif>
                            <!--- Exclude AGIS from form tracking --->
                            <cfif isdefined('session.partner_id') and session.partner_id neq 69>
								<cfif attributes.formtype_id eq 1 or attributes.formtype_id eq 0>
                                    <cfif isdefined('session.partner_id') and session.partner_id eq 55>
                                        <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#appforms.form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#appforms.string#">
                                    <cfelse>
                                        <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#appforms.form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#appforms.string#">
                                    </cfif>
                                <cfelseif attributes.formtype_id eq 2>
                                    <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/eformsubmit.cfm?efitem=#appforms.string#">				
                                <cfelseif attributes.formtype_id eq 4 or attributes.formtype_id eq 0>
                                    <cfif isdefined('session.partner_id') and  session.partner_id eq 55>
                                        <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#appforms.form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#appforms.string#">								
                                    <cfelse>
                                        <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#appforms.form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#appforms.string#">								
                                    </cfif>
                                </cfif>
                        	<cfelse><!--- AGIS Forms --->
                            	<cfif attributes.formtype_id eq 1 or attributes.formtype_id eq 0>
									<cfset targetUrl = "#application.transfertype#://#application.serverPath#/forms/#appforms.string#">
                                <cfelseif attributes.formtype_id eq 2>
                                    <cfset targetUrl = "#application.transfertype#://#application.serverPath#/cf/eformsubmit.cfm?efitem=#appforms.string#">				
                                <cfelseif attributes.formtype_id eq 4 or attributes.formtype_id eq 0>
                                    <cfset targetUrl = "#application.transfertype#://#application.serverPath#/forms/#appforms.string#">
                                </cfif>
                            </cfif>
							
							<cfif right(trim(appforms.string),4) IS ".pdf">
								<cfset image_code = "img_pdf_gif">
							<cfelseif right(trim(appforms.string),4) IS ".doc">
								<cfset image_code = "img_word_doc_gif">
							<cfelse>
								<cfset image_code = "img_apply_gif">
							</cfif>
							
							<cfsavecontent variable="outstr">
								<cfoutput>
									#outstr#
										<li class="questionBar">
											<!---<a href="#targetUrl#" target="_blank"><cf_displayImage code="#image_code#" hspace="0" vspace="0" class="snap_icon2" border="0"></a>--->
											<span class="tag_name"><a href="#targetUrl#" target="_blank">#tag_name#</a></span>
										</li>
								</cfoutput>
							</cfsavecontent>
							
							<cfset countAppsDisplayed = countAppsDisplayed + 1>
						</cfif>
					</cfloop>
				
			<cfset outstr = outstr & "</ul></div>">
			<cfelse>
			<!-- output in xml format -->
					<cfset outstr = outstr & '<?xml version="1.0" encoding="UTF-8"?>
	<Forms>'>
			<cfloop query="appforms"> 
			<cfif attributes.formtype_id neq 2 >				
			<cfset outstr = outstr & '
	<Form Form_id="#appforms.form_id#" Program_id="#attributes.program_id#" Desc="#tag_name#" Baseurl="#application.transfertype#://#application.serverPath#" >#application.formpath#/#appforms.string#</Form>'>
			</cfif>	
			</cfloop>
	        
			<cfset outstr = outstr & '
	</Forms>'>
			</cfif>
	        
		</cfif>
	<cfelse>
		<cfquery datasource="#application.dbSrc#" name="appforms">
			SELECT ft.string, t.tag_name
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=<cfqueryparam cfsqltype="cf_sql_numeric" value="#attributes.program_id#" maxlength="6">
				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#url.state_id#')
				AND f.form_id=ft.form_id
				AND ft.formtype_id
				<cfif attributes.formtype_id eq 0> in (1, 4)
				<cfelse>=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.formtype_id#" maxlength="2">
				</cfif>
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort
		</cfquery>
		<cfif appforms.recordcount neq 0>
			<cfset countAppsDisplayed = 0>
			<cfloop query="appforms"> 
					<cfif formtype_id eq 4 or formtype_id eq 0>		
						<cfif countAppsDisplayed eq "0">
							<div class="question">
									<div class="questionHolder questionBar">
										<p>
											<a href="dsp_appforms.cfm?src=details&prg_id=#prg_id#&save_prg_desc=no&formtype_id=4" target="_blank">
												<img alt="Download fillable program application form" src="../images/button_get-form.gif" border="0" ></a>	
										</p>
										<p>
											Download fillable program application form 
											<em>(Clicking the button to the left will open a new window.)</em> 
										</p>
									</div><!-- questionHolder -->
								</div><!-- question -->	
						</cfif>		
							
						<cfset countAppsDisplayed = countAppsDisplayed + 1>
					<cfelseif formtype_id eq 1 or formtype_id eq 0>		
						<cfif countAppsDisplayed eq "0">
							<table    cellpadding=2 >
								<table><tr><td width="140" valign=top>
								<a href="dsp_appforms.cfm?src=details&prg_id=#prg_id#&save_prg_desc=no" target="_blank">
								<img alt="Download program application form to fill out by hand" src="../images/button_get-form.gif" border="0" ></a>			
								</td><td  valign=top><font size=+1>Download program application form to fill out by hand</font> <i>(Clicking the button to the left will open a new window.) </i></td></TR>
							</table>
						</cfif>				
						<cfset countAppsDisplayed = countAppsDisplayed + 1>
						<cfelseif formtype_id eq 2>	
							<table    cellpadding=2 >
								<table><tr><td width="140" valign=top>
								<a href="eformsubmit.cfm?efitem=#appforms.string#&prg_id=#prg_id#" target="_blank" >
								<img src="../images/button_eform.gif" border="0" alt="Fill out <cfif appforms.recordcount gt 1 >#tag_name#<cfelse>program application form</cfif> using your computer"></a>					
								</td><td  valign=top><font size=+1>Fill out <cfif appforms.recordcount gt 1 >#tag_name#<cfelse>program application</cfif> using your computer</font> <i>(Clicking the button to the left will open a new window.) </i>
								</td></TR>
							</table>
					</cfif>
			</cfloop>
	        
		</cfif>
	</cfif>
	
	</cfsilent><cfif attributes.var eq ''><cfsilent>
		</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
	</cfsilent><cfelseif attributes.append><cfsilent>
		<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
	</cfsilent><cfelse><cfsilent>
		<cfset "caller.#attributes.var#" = outstr>
	</cfsilent></cfif>
