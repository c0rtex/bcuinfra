	<cfsilent>
	<cfparam name="title" type="boolean" default="true">
	<cfparam name="attributes.program_id" type="numeric" default="0">
	<cfparam name="attributes.prg_id" type="string" default="">
	<cfparam name="attributes.mode" type="string" default="screen">
	<cfparam name="attributes.source" type="string" default="">
	<cfparam name="attributes.report_type" type="string" default="">
	<cfparam name="attributes.number" type="numeric" default="0">
	<cfparam name="attributes.description" type="boolean" default="true">
	<cfparam name="attributes.entrypoints" type="boolean" default="true">
	<cfparam name="attributes.eplimit" type="numeric" default="3">
	<cfparam name="attributes.requisites" type="boolean" default="true">
	<cfparam name="attributes.county" type="string" default="">
	<cfparam name="attributes.state_id" type="string" default="">
	<cfparam name="attributes.zip" type="string" default="">
	<cfparam name="attributes.var" type="string" default="">
	<cfparam name="attributes.supressforms" type="boolean" default="false">
	<cfparam name="attributes.suppressOfficesLink" type="boolean" default="false">
	<cfparam name="attributes.append" type="boolean" default="false">
	<cfparam name="attributes.getWebResources" type="boolean" default="true">
	<cfparam name="attributes.getWebResourcesOnly" type="boolean" default="FALSE">
	<cfparam name="session.partner_id" type="numeric" default="0">
	<cfparam name="session.org_id"  default="0">
	<cfparam name="src" default="">
	<cfparam name="attributes.title" type="boolean" default="true">
	
	<cfset outstr = ''>
	<cfset validInput = true>
    <!--- Start 7139 --->
    <cfoutput>
		<cfif attributes.prg_id eq ''>
            <cfif IsDefined('url.prg_id') and url.prg_id NEQ ''>
                <cfset attributes.prg_id = '#url.prg_id#'>
            </cfif>
        </cfif>
    </cfoutput>
    <!--- End 7139 --->
	<cfif attributes.program_id eq 0 and attributes.prg_id eq ''>
		<cfset outstr = '<strong>[no program specified]</strong>'>
		<cfset validInput = false>
		<cfelseif attributes.program_id eq 0>
		<cf_cacheProgramPool action="get" legacy="#attributes.prg_id#" var="pobj" codevar="code">
		<cfset attributes.program_id = pobj.id>
		<cfelse>
		<cf_cacheProgramPool action="get" id="#attributes.program_id#" var="pobj" codevar="code">
		<cfset attributes.prg_id = pobj.legacy>
	</cfif>
	<cfif attributes.eplimit lt 1>
		<cfset attributes.entrypoints = false>
	</cfif>
	<cfif validInput>
	
		<cf_displayText group="program" code="program_#code#" var="programName">
		
		<cfif attributes.mode eq 'print'>
			<cf_displayText group="prgdesc" code="prgdesc_#code#" stripTags="true" var="programDescription">
			<cfelse>
			<cf_displayText group="prgdesc" code="prgdesc_#code#" var="programDescription">
		</cfif>
		
		<cf_displayText group="prgcat" code="prgcat_#pobj.cat#" var="categoryName">
		
		<cfif attributes.mode eq 'print'>
			<cfif attributes.title eq true>
			<cfset outstr = outstr & "<h2><strong>">
			<cfif attributes.number gt 0>
				<cfset outstr = outstr & "#attributes.number#. ">
			</cfif>
			<cfset outstr = outstr & "#programName# (#categoryName#)</strong></h2>">
			</cfif>
		<cfelse>
			
			<cfif attributes.source EQ 'elig' OR attributes.source EQ 'quickcheck' OR attributes.source EQ 'ec' OR (attributes.source NEQ 'ec' AND attributes.source NEQ 'eforms' AND attributes.report_type NEQ '')>
			<cfif NOT IsDefined('sr')>
				<cfset sr = 1>
			</cfif>
				<cfif attributes.title eq true>
				
					<cfset outstr = outstr & '<div id="fact_sheet"><h1>Fact Sheet</h1>'>
				
				</cfif>
				
			</cfif>
			
			<cfif attributes.title eq true><cfset outstr = outstr & '<h2>#programName#</h2>'></cfif>
		</cfif>
		
		<cfquery name="webResources" datasource="#application.dbSrc#">
			SELECT *
			FROM program p
			LEFT JOIN program_form pf ON pf.program_id = p.program_id
			LEFT OUTER JOIN form f ON f.form_id = pf.form_id
			LEFT OUTER JOIN formtag ftg ON ftg.formtag_id = f.formtag_id
			LEFT OUTER JOIN form_formtype ft ON ft.form_id = pf.form_id
	        WHERE p.legacy_prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.prg_id#" maxlength="64">
			AND f.form_id > 0 and ftg.tag_name like '%Online Application%'
			AND ((f.state_id = '#trim(attributes.state_id)#') OR (f.state_id IS NULL and p.program_code like '%_fd_%'))
			ORDER BY pf.sort
		</cfquery>
		
		<!--- MH: 7/15/2010 Bug 5400 Comment 24 --->
		<cfquery name="snapProgram" datasource="#application.dbSrc#">
	   		SELECT program_code
			FROM program
			where legacy_prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.prg_id#" maxlength="64">
	        	and programcategory_id = 23 
	        	and program_code <> 'nutrition_fd_food_stamp_program'
	            and program_code <> 'nutrition_fd_food_stamp_program'
	            and program_code <> 'nutrition_fd_food_stamp_program'
	   </cfquery>
		<cfquery name="programWebsite" datasource="#application.dbSrc#">
			SELECT p.url, dl.display_text AS title,  dl2.display_text AS description
			FROM program p 
			LEFT JOIN display_language dl ON dl.display_id = p.name_display_id AND dl.language_id = 'EN'
			LEFT JOIN display_language dl2 ON dl2.display_id = p.desc_display_id AND dl2.language_id = 'EN'
			WHERE p.legacy_prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.prg_id#" maxlength="64">
			AND p.url <> '' AND p.url IS NOT NULL
		</cfquery>
		<cfquery datasource="#application.dbSrc#" name="appformcheck">
			SELECT ft.string, t.tag_name,f.form_id
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=<cfqueryparam cfsqltype="cf_sql_numeric" value="#attributes.program_id#" maxlength="6">
				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#attributes.state_id#')
				AND f.form_id=ft.form_id
				AND ft.formtype_id =<cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="2">
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort
		</cfquery>
		<cfquery datasource="#application.dbSrc#" name="eformcheck">
			SELECT ft.string, t.tag_name
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=<cfqueryparam cfsqltype="cf_sql_numeric" value="#attributes.program_id#" maxlength="6">
				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#attributes.state_id#')
				AND f.form_id=ft.form_id
				AND ft.formtype_id=2
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort
		</cfquery>
		
		<cfif webResources.recordcount GT 0 OR programWebsite.recordcount GT 0>
			<cfset displayWeb = "block">
		<cfelse>
			<cfset displayWeb = "none">
		</cfif>
		
		<cfset outstr = outstr & ''>
		
		<cfif attributes.description>
			<cfset outstr = outstr & "#programDescription#<div style='clear:both;'></div>">
		</cfif>
		
		<cfif pobj.url neq '' AND attributes.mode eq 'print'>
			<cfset outstr = outstr & "<br />Web address: ">
			<cfif attributes.mode eq 'print'>
				<cfset outstr = outstr & pobj.url>
				<cfelse>
				<cfset maxlen = 70>
				<cfif len(pobj.url) GT maxlen>
					<cfset findslash = refindnocase("[=/+-_.##]", pobj.url, maxlen)>
					<cfif findslash IS 0>
						<cfset topPart = left(pobj.url, maxlen)>
						<cfset bottomPart = right(pobj.url, len(pobj.url) - maxlen)>
						<cfelse>
						<cfset topPart = left(pobj.url, findslash)>
						<cfset bottomPart = right(pobj.url, len(pobj.url) - findslash)>
					</cfif>
					<cfset outstr = outstr & "<a href=""#pobj.url#"" target=""_blank"" class=""programLink2"">#topPart# #bottomPart#</a>">
					<cfelse>
					<cfset outstr = outstr & "<a href=""#pobj.url#"" target=""_blank"" class=""programLink"">#pobj.url#</a>">
				</cfif>
			</cfif>
			<cfset outstr = outstr & "<br />">
		</cfif>
		<cfset outstr = outstr & "<br />">
		
		<cfif attributes.report_type eq "webservice" and ( 1 eq 0) >
			<cfset outstr = outstr & webresources & "<br />">
		</cfif>
		
		<cf_displayProgramDetailRx program_id="#attributes.program_id#" var="outstr" append="true">
		<cfif attributes.entrypoints>
			<cfif attributes.source eq 'ec'>
				<cfset passMode = attributes.mode>
				<cfset passSource = 'ec'>
				<cfelse>
				<cfset passMode = attributes.mode>
				<cfset passSource = ''>
			</cfif>
			<cf_handleScreeningAnswerfield action="get" code="city_id" element="val" var="city_id">
			<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="#passMode#" source="#passSource#" city_id="#city_id#" zipcode="#attributes.zip#" limit="#attributes.eplimit#" var="outstr" append="true" suppressOfficesLink="#attributes.suppressOfficesLink#">
		</cfif>
		
		<cfif attributes.requisites>
			<cf_displayProgramDetailRequisites program_id="#attributes.program_id#" mode="#attributes.mode#" var="outstr" append="true">
		</cfif>
		
		<cfif attributes.source neq 'frame' and attributes.mode neq 'print' >
		  <cfif attributes.getWebResources eq true>
			<cfif webResources.recordcount is 0 
				AND programWebsite.recordcount is 0 
				AND appformcheck.recordcount is 0 
				and eformcheck.recordcount is 0>
				<cfset outstr = outstr & "</div><div style='clear:both;'></div><div id='resources_and_forms'>">
			<cfelse>
				<cfset outstr = outstr & "</div><div style='clear:both;'></div><div id='resources_and_forms'>">
			</cfif>
			
			<cfif (webResources.recordcount GT 0 AND attributes.getWebResources) 
				OR (programWebsite.recordcount GT 0 AND attributes.getWebResources)>
				<cfoutput>
					<cfsavecontent variable="webresources">
							<div id="web_resources">
								<h3>Web Resources</h3>
								<ul class="striping" style="list-style: none outside none; margin-left: 0px; margin-top: 0px; margin-bottom: 0px;">
									<cfloop query="webResources">
										<li class="questionBar">
											<div style="float:left;"><a href="#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" target="#form_id#"><cf_displayImage code="img_apply_gif" hspace="0" vspace="0"></a></div><div style="padding-left:25px;"><span class="tag_name" style="vertical-align:top;"><a href="#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" target="#form_id#">#tag_name#</a></span></div>
										</li>
									</cfloop>
									
							
									<cfif trim(programWebsite.url) IS NOT "">
										<li class="questionBar"">
											<div style="float:left;"><a href="#programWebsite.url#" target="#programWebsite.url#"><cf_displayImage code="img_link_go_gif" hspace="0" vspace="0" padding-bottom="0px"></a></div><div style="padding-left:25px;"><span class="tag_name"><a href="#programWebsite.url#" target="#programWebsite.url#">Program Website</a></span></div>
										</li>			
									</cfif>
							
									<!--- MH: Bug 5400 and 5571--->
									<cfif snapProgram.RecordCount GT 0>
										<li class="questionBar">
											<div style="float:left;"><a href="http://www.snapretailerlocator.com" target="http://www.snapretailerlocator.com" class="snapLink"><cf_displayImage code="img_house_snap_gif" hspace="0" vspace="0"></a></div><div style="padding-left:25px;"><span class="tag_name" style="vertical-align:top;"><a href="http://www.snapretailerlocator.com" target="http://www.snapretailerlocator.com" class="snapLink">Find Stores to Use Debit Card in English and Spanish</a></span></div>
										</li>
									</cfif>
								</ul>
							</div>
						<cfset moreprograms_url = "before_you_start.cfm?partner_id=#session.partner_id#">
						<cfset sub_id = 3>
						<cfset prtner_id = session.partner_id>
					</cfsavecontent>
				</cfoutput>
				<cfset outstr = outstr & webresources >
			</cfif><!--- END <cfif webResources.recordcount GT 0 OR programWebsite.recordcount GT 0> --->
			
			<cfif attributes.supressforms neq "true">
				<cf_displayProgramDetailForms_quickcheck program_id="#attributes.program_id#" formtype_id="0" var="outstr" append="true">
				<cf_displayProgramDetailForms_quickcheck program_id="#attributes.program_id#" eform="true" var="outstr" append="true">
			</cfif>
			
			<cfset outstr = outstr & "</div>">
			
		  </cfif>
		</cfif><!--- END <cfif attributes.source neq 'frame' and attributes.mode neq 'print' > --->
			
	</cfif>
	<cfset outstr = outstr & '</div>'>
	</cfsilent>
	<cfif attributes.var eq ''>
		<cfsilent>
		</cfsilent>
		<cfoutput>#outstr#</cfoutput>
		<cfsilent>
		</cfsilent>
		<cfelseif attributes.append>
		<cfsilent>
		<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
		</cfsilent>
		<cfelse>
		<cfsilent>
		<cfset "caller.#attributes.var#" = outstr>
		</cfsilent>
	</cfif>
