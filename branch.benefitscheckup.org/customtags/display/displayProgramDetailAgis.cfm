<cfsilent>
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
<cfparam name="session.partner_id" type="numeric" default="0">
<cfparam name="session.org_id" type="numeric" default="0">
<cfset outstr = ''>
<cfset validInput = true>
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
		<cfset outstr = outstr & "<h2><b>">
		<cfif attributes.number gt 0>
			<cfset outstr = outstr & "#attributes.number#. ">
		</cfif>
		<cfset outstr = outstr & "#programName# (#categoryName#)</b></h2>">
		<cfelse>
		<span style="float:left;">
		<cfif attributes.source EQ 'elig' OR attributes.source EQ 'ec' OR (attributes.source NEQ 'ec' AND attributes.source NEQ 'eforms' AND attributes.report_type NEQ '')>
			<cfset outstr = outstr & '<h1 class="screeningh1">Fact Sheet</h1>'>
		</cfif>
		<div class="screeningClear"></div>
		<cfset outstr = outstr & '<div class="screeninghr"></div>'>
		<cfset outstr = outstr & '<h2 class="screeningh2">#programName#</h2>'>
		</span>
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
			<!---
				Bug 5215 - Show "Application Forms" box even though there is no "Web Resource" information to pull::
					AND ft.formtype_id =<cfqueryparam cfsqltype="cf_sql_integer" value="1" maxlength="2">
			 --->
			AND ft.formtype_id IN (1,4)
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
	<cfset outstr = outstr & '<div class="screeningText">'>
	<cfif attributes.source neq 'frame' and attributes.mode neq 'print' >
		<cfif webResources.recordcount is 0 AND programWebsite.recordcount is 0 AND appformcheck.recordcount is 0 and eformcheck.recordcount is 0>
			<cfset outstr = outstr & '<div class="appformsOuter noprint" style="display:none;">'>
			<cfelse>
			<cfset outstr = outstr & '<div class="appformsOuter noprint">'>
		</cfif>
		
		<!---<cfdump var="#webResources#" expand="no" label="webResources">
<cfdump var="#programWebsite#" expand="no" label="programWebsite">--->
		
		<cfif webResources.recordcount GT 0 OR programWebsite.recordcount GT 0>
			<cfoutput>
				<cfsavecontent variable="webresources">
				<div class="appforms noprint" style="margin-bottom:15px; padding-bottom:10px; display:">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td colspan="2" class="text1" style="height: 30px;"><div class="factSheetH2">Web Resources</div></td>
					</tr>
					<cfloop query="webResources">
						<tr>
							<td class="text1fact" valign="top" width="24">
								<cfif SESSION.partner_id NEQ 80>
									<a href="#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" target="#form_id#">
										Apply Now
									</a>
								</cfif>
							</td>
							<td class="text1fact" valign="top">
								<cfif SESSION.partner_id EQ 80>
									<div class="program_link_padding">
								</cfif>
								<a href="#application.transfertype#://#application.serverPath#/cf/form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" target="#form_id#">
									<cfif SESSION.partner_id EQ 80>
										<div class="application_image" <cfif Len(tag_name) GTE 30>style="height:35px;"</cfif>>
											Apply Now
										</div>
									</cfif>
									#tag_name#
								</a>
								<cfif SESSION.partner_id EQ 80>
									</div>
								</cfif>
							</td>
						</tr>
					</cfloop>
					<cfif trim(programWebsite.url) IS NOT "">
						<tr>
							<td class="text1fact" valign="top" width="24">
								<cfif SESSION.partner_id NEQ 80>
									<a href="#programWebsite.url#" target="#programWebsite.url#">
										Go
									</a>
								</cfif>
							</td>
							<td class="text1fact" valign="middle">
								<cfif SESSION.partner_id EQ 80>
									<div class="program_link_padding">
								</cfif>
								<a href="#programWebsite.url#" target="#programWebsite.url#">
									<cfif SESSION.partner_id EQ 80>
										<div class="application_image">
											Go
										</div>
									</cfif>
											Program Website	
								</a>
								<cfif SESSION.partner_id EQ 80>
									</div>
								</cfif>
							</td>
						</tr>
					</cfif>
					
					<!--- MH: Bug 5400 and 5571--->
					<cfif snapProgram.RecordCount GT 0>
						<tr>
							<td class="text1fact" valign="top" width="24">
								<cfif SESSION.partner_id NEQ 80>
									<a href="http://snap-load-balancer-244858692.us-east-1.elb.amazonaws.com/index.html" 
										target="http://snap-load-balancer-244858692.us-east-1.elb.amazonaws.com/index.html" class="snapLink">
										<cf_displayImage code="img_house_snap_gif" hspace="0" vspace="0">
									</a>
								</cfif>
							</td>
							<td class="text1fact" valign="top">
								<cfif SESSION.partner_id EQ 80>
									<div class="program_link_padding">
								</cfif>
								<a href="http://snap-load-balancer-244858692.us-east-1.elb.amazonaws.com/index.html" 
									target="http://snap-load-balancer-244858692.us-east-1.elb.amazonaws.com/index.html">
									<cfif SESSION.partner_id EQ 80>
										<div class="application_image">
											<cf_displayImage code="img_house_snap_gif" hspace="0" vspace="0">
										</div>
									</cfif>
										Find Stores to Use Debit Card in English and Spanish
								</a>
								<cfif SESSION.partner_id EQ 80>
									</div>
								</cfif>
							</td>
						</tr>
					</cfif>
					<!--- END MH --->
					
					<cfset moreprograms_url = "/before_you_start.cfm?partner_id=#session.partner_id#">
					<cfset sub_id = 3>
					<cfset prtner_id = session.partner_id>
				</table>
				</div>
				</cfsavecontent>
			</cfoutput>
			<cfset outstr = outstr & webresources >
		</cfif>
		<cfif attributes.supressforms neq "true">
			<cf_displayProgramDetailForms program_id="#attributes.program_id#" formtype_id="0" var="outstr" append="true">
			<cf_displayProgramDetailForms program_id="#attributes.program_id#" eform="true" var="outstr" append="true">
		</cfif>
		<cfset outstr = outstr & "</div>">
	</cfif>
	<cfif attributes.description>
		<cfset outstr = outstr & "#programDescription#<br />">
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
