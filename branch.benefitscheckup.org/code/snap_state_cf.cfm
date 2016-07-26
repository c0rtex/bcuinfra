<cfif IsDefined('URL.partner_id')>
	<cfset SESSION.partner_id = URL.partner_id>
</cfif>
<!--- Bug 6096 - AARP Snap Map - Web Resources should wrap to next line --->

<cfoutput> 
	<script language="Javascript1.2">
	var message = "Print this Page";

	function printpage() {
		window.print();  
		return false;
	}

</script> 
<cfif IsDefined('URL.sc_partner_id') AND URL.sc_partner_id NEQ ''>
    <cfset SESSION.sc_partner_id = URL.sc_partner_id>
<cfelseif IsDefined ('SESSION.sc_partner_id')>
<!--- do nothing --->
<cfelse>
        <cfset SESSION.sc_partner_id = 0>
</cfif>

	
	<!--- 

Choose Language = Escoja el Idioma
English = Ingl�s
Espanol    = Espa�ol


--->
	
	<cfif listFindNoCase("PR", qState.state_id) GT 0 AND language_id EQ "ES">
		<cfset web_resources = "Recursos en el Internet">
		<cfset program_website = "P&##225;gina del PAN en el Internet">
		<cfset web_url = snap_state.url>
		<cfset find_stores = "D&##243;nde Usar la Tarjeta en Ingl&eacute;s y Espa&ntilde;ol">
		<cfset find_stores_url = "http://www.snapretailerlocator.com">
		<cfset find_stores_alt = "Encuentre Tiendas">
		<cfset find_out = "Averig�e si Usted Califica">
		<cfset application_forms = "Solicitud">
		<cfset definitions = "Definiciones">
		<cfset multi_form = "Solicitudes para M&##250;ltiples Programas:">
		<cfset apply_more = "Le permiten aplicar para beneficios de m&##225;s de un programa simult&##225;neamente.">
		<cfset food_only = "Solicitudes para Alimentos Solamente:">
		<cfset apply_only = "Le permiten aplicar para beneficios del programa de Cupones para Alimentos solamente.">
		<cfset choose_language = "Escoja el Idioma">
		<cfset no_application = "Solicitud no est&##225; Disponible">
		<cfset call_your_state = "Llame a la l&##78;nea de ayuda de su estado para averiguar a d&##84;nde usted debe enviar su solicitud.">
		<cfset fillable_forms = "Este s&##78;mbolo es para solicitudes que pueden llenarse electr&##84;nicamente.">
		<cfset find_out_link = 0>
		<cfset call_state = 0>
		<cfset img_back_button_gif = "img_back_button_sp_gif">
		<cfset img_print_this_page_gif = "img_print_this_page_sp_gif">
		<cfset img_pdf_gif = "img_pdf_sp_gif">
		<cfset img_word_doc_gif = "img_word_doc_sp_gif">
		<cfset img_apply_gif = "img_apply_sp_gif">
		<cfset img_link_go_gif = "img_link_go_sp_gif">
		<cfset img_find_gif = "img_find_sp_gif">
		<cfset img_pencil_gif = "img_pencil_sp_gif">
		<cfset img_find_stores_gif = "img_house_snap_sp_gif">
		<cfset doBreakOverride = 1>
		<cfelse>
		<cfset web_resources = "Web Resources">
		<cfset program_website = "Program Website">
		<cfset web_url = snap_state.url>
		<cfset find_stores = "Find Stores to Use Debit Card in English and Spanish">
		<cfset find_stores_url = "http://www.snapretailerlocator.com">
		<cfset find_out = "Find Out If You're Eligible">
		<cfset application_forms = "Application Forms">
		<cfset definitions = "Definition(s)">
		<cfset multi_form = "Multi-Program Forms:">
		<cfset apply_more = "This is to apply for more than one program at the same time.">
		<cfset food_only = "Food Only Forms:">
		<cfset apply_only = "This is to apply for the SNAP/Food Stamp program only.">
		<cfset choose_language = "Choose Language">
		<cfset no_application = "No Application Form Available">
		<cfset call_your_state = "Call your State Hotline to find out where to send the application.">
		<cfset fillable_forms = "This is for fillable forms.">
		<!---MH: 5/7/10 Bug 5265 Do not show find_out and call_state for GU --->
		<cfif listFindNoCase("GU", qState.state_id) GT 0>
			<cfset find_out_link = 0>
			<cfset call_state = 0>
			<cfelse>
			<cfset find_out_link = 1>
			<cfset call_state = 1>
		</cfif>
		<cfset img_back_button_gif = "img_back_button_gif">
		<cfset img_print_this_page_gif = "img_print_this_page_gif">
		<cfset img_pdf_gif = "img_pdf_gif">
		<cfset img_word_doc_gif = "img_word_doc_gif">
		<cfset img_apply_gif = "img_apply_gif">
		<cfset img_link_go_gif = "img_link_go_gif">
		<cfset img_find_gif = "img_find_gif">
		<cfset img_pencil_gif = "img_pencil_gif">
		<cfset img_find_stores_gif = "img_house_snap_gif">
		<cfset doBreakOverride = 0>
	</cfif>
	<!---MH: 6/28/10 Bug 5400 Do not show 'Find stores to use SNAP' for VI and GU--->
	<cfif listFindNoCase("GU", qState.state_id) GT 0>
		<cfset showSNAPStoreLink = 0>
		<cfelse>
		<cfset showSNAPStoreLink = 1>
	</cfif>
	<script type="text/javascript">
		var partnerID = "<cfoutput>#SESSION.partner_id#</cfoutput>";
		console.log(partnerID);
	</script>
	<table cellpadding="0" cellspacing="0" border="0" class="snapTable">
		<tr class="noprint">
			<td colspan="4" style="padding-bottom:8px;">
				<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<cfif SESSION.partner_id eq 0>
<div class="yellowBox feedbackSurvey">
<a class="feedbackSurvey" href="https://www.surveymonkey.com/r/BenefitsCheckUpFeedback" target="_blank">Please give us feedback on BenefitsCheckUp. Click here to complete a short satisfaction survey.</a>
</div>
</cfif>

</tr>
						<tr>
							<td><span>
								<cf_sessionPassVars href="snap.cfm?partner_id=#session.partner_id#&sc_partner_id=#SESSION.sc_partner_id#" prev_id="#session.partner_id#" partner_id="#session.partner_id#" org_id="#session.org_id#" class="snapLink">
									<cf_displayImage code="#img_back_button_gif#" hspace="0" vspace="0" border="0">
								</cf_sessionPassVars>
								</span></td>
							<cfif session.partner_id neq 22><td align="right"><div><a href="##" onClick="printpage();" class="snapLink">
								<cf_displayImage code="#img_print_this_page_gif#" hspace="0" vspace="0" border="0">
								</a></div></td></cfif>
						</tr>
					</table>
			</td>
		</tr>
		<tr>
			<td class="text1 snapLeftCol" valign="top" rowspan="2" colspan="4"><div id="snap_left_col">
            		<h1 class="snapH1" style="margin-top:0px;">#snap_title#</h1>
					<div id="snap_right_col">
						
						<cfif listFindNoCase("PR", qState.state_id) GT 0>
							<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
                            	<div style="padding:6px 12px 8px; background-color: ##d7d7d7; width: 284px; margin-bottom:16px; margin-top:4px; float: left; clear:both" class="noprint">              
                            <cfelse>
                            	<div style="background: none repeat scroll 0 0 ##FEF4DC; border-radius: 10px 10px 10px 10px; display: block; margin-bottom: 10px; padding: 10px 0 10px 10px;">
                     		</cfif>
								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td colspan="2" class="text1" style="height: 30px;"><h2>#choose_language#</h2></td>
									</tr>
									<tr>
										<td class="text1" valign="top"><form id="testLang" action="#CGI.ALL_HTTP#" method="post" style="margin:0;">
												<input  <cfif language_id IS "EN">checked</cfif> type="radio" name="lang" value="EN" onclick="javascript:document.forms.testLang.submit();" />
												<cfif language_id IS "EN">
													English
													<cfelse>
													Ingl&eacute;s
												</cfif>
												&nbsp;&nbsp;
												<input <cfif language_id IS "ES">checked</cfif> type="radio" name="lang" value="ES" onclick="javascript:document.forms.testLang.submit();" />
												<cfif language_id IS "EN">
													Spanish
													<cfelse>
													Espa&ntilde;ol
												</cfif>
												<br />
												<cfif isDefined("form.fieldnames")>
													<cfloop list="#form.fieldnames#" delimiters="," index="i">
														<cfif i NEQ 'lang'>
															<input type="hidden" name="#i#" value="#Evaluate('form.#i#')#" />
														</cfif>
													</cfloop>
												</cfif>
											</form></td>
									</tr>
								</table>
							</div>
							<div style="clear:both"></div>
						</cfif>
						<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
							<div style="padding:6px 12px 8px; background-color: ##d7d7d7;  margin-bottom:16px; margin-top:4px;" class="noprint">
                        <cfelse>
        					<div id="web_resources">                
                        </cfif>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td colspan="2" class="text1" style="height: 30px;"><h2>#web_resources#</h2></td>
								</tr>
								<cfloop query="forms_online">
									<tr>
                                    	<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="text1" valign="top">
                                        <cfelse>
                                        <td class="text1fact" valign="top">
                                        </cfif>
											<div id="img_apply_gif">
                                    			<a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" class="img_apply_gif" target="#tag_name#">
													<cf_displayImage code="img_apply_gif" hspace="0" vspace="0">
												</a>
											</div>		
										</td>
                                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="snapLegend" valign="top">
                                        <cfelse>
                                        <td class="text1fact" valign="top">
                                        </cfif>
                                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
											<div class="online_app">
                                        <cfelse>
                                        	<div>
                                        </cfif>
												<a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=#string#" target="#qstate.state_name#_info" class="snapLink">#tag_name#</a>
											</div>
										</td>
									</tr>
								</cfloop>
								<cfif trim(snap_state.url) IS NOT "">
									<!---cfif listFindNoCase("PR", qState.state_id) GT 0 and language_id EQ "EN">
										<cfset web_url = "http://www.fns.usda.gov/FSP/faqs.htm">
									</cfif--->
									<tr>
                                    	<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="text1" valign="top">
                                        <cfelse>
                                        <td class="text1fact" valign="top">
                                        </cfif>
											<div id="img_apply_gif">
												<a href="#web_url#" target="#web_url#" class="img_apply_gif">
													<cf_displayImage code="#img_link_go_gif#" hspace="0" vspace="0">
												</a>
											</div>
										</td>
                                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="snapLegend" valign="middle"><a href="#web_url#" target="#web_url#" class="snapLink">#program_website#</a></td>
                                        <cfelse>
                                        <td class="text1fact" valign="top"><a href="#web_url#" target="#web_url#" class="snapLink">#program_website#</a></td>
                                        </cfif>
									</tr>
								</cfif>
								<!--- MH Bug 5400 --->
								<cfif showSNAPStoreLink eq 1>
									<tr>
                                    	<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="text1" valign="top">
                                        <cfelse>
                                        <td class="text1fact" valign="top">
                                        </cfif>
											<div id="img_apply_gif">
												<a href="#find_stores_url#" target="#find_stores_url#" class="img_apply_gif">
													<cf_displayImage code="#img_find_stores_gif#" hspace="0" vspace="0">
												</a>
											</div>
										</td>
                                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
										<td class="snapLegend" valign="top"><a href="#find_stores_url#" target="#find_stores_url#" class="snapLink">#find_stores#</a></td>
                                        <cfelse>
                                        <td class="text1fact" valign="top"><a href="#find_stores_url#" target="#find_stores_url#" class="snapLink">#find_stores#</a></td>
                                        </cfif>
									</tr>
								</cfif>
								<cfset moreprograms_url = "frmwelcome2.cfm?partner_id=#session.partner_id#&subset_id=62&sc_partner_id=#session.sc_partner_id#">
								<!--- MH: Bug 5477 Redirected SNAP subset to point to 62 instead of 3--->
								<cfset sub_id = 62>
								<cfset prtner_id = session.partner_id>
                                <cfif find_out_link EQ 1 AND NOT listFindNoCase("PR", qState.state_id) GT 0>
									<tr>
										<cfif session.org_id eq '' or session.org_id lt 1 >
                                        	<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
											<td class="text1" valign="top">
											<cfelse>
                                            <td class="text1fact" valign="top">
											</cfif>	
                                                <div id="img_apply_gif">
													<cf_sessionPassVars href="#moreprograms_url#" partner_id="#prtner_id#" org_id="#session.org_id#" subset_id="#sub_id#" prev_id="0" class="img_apply_gif">
														<cf_displayImage code="#img_find_gif#" hspace="0" vspace="0">
													</cf_sessionPassVars>
												</div>
											</td>
                                            <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
											<td class="snapLegend" valign="top"><cf_sessionPassVars href="#moreprograms_url#" partner_id="#prtner_id#" org_id="#session.org_id#" subset_id="#sub_id#" prev_id="0" class="snapLink">#find_out#</cf_sessionPassVars></td>
                                            <cfelse>
                                            <td class="text1fact" valign="top"><cf_sessionPassVars href="#moreprograms_url#" partner_id="#prtner_id#" org_id="#session.org_id#" subset_id="#sub_id#" prev_id="0" class="snapLink">#find_out#</cf_sessionPassVars></td>
                                            </cfif>
										</cfif>
									</tr>
								</cfif>
							</table>
						</div>
                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
						<div class="snapRightCol noprint">
                         <cfelse>
        					<div id="application_forms">                
                        </cfif>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td colspan="2" class="text1" style="height: 30px;"><h2>#application_forms#</h2></td>
								</tr>
								<cfif forms.recordcount IS 0>
									<tr>
										<td colspan="2" class="text1">#no_application#</td>
									</tr>
									<cfelse>
									<cfset setBreak = 0>
									<cfset doBreak = 0>
									<cfloop query="forms">
										<cfif findnocase('Food Only', tag_name) GT 0 OR findnocase('Muestra de la Solicitud', tag_name) GT 0>
											<cfset foodStampLegend = 1>
										</cfif>
										<cfif findnocase('Multi-Program', tag_name) GT 0>
											<cfset multiProgramLegend = 1>
										</cfif>
										<cfif formtype_id IS 4>
											<cfset fillableLegend = 1>
										</cfif>
										<cfif findnocase('English', tag_name) EQ 0 AND findnocase('Spanish', tag_name) EQ 0 AND doBreak EQ 0 and doBreakOverride EQ 0>
											<cfset doBreak = 1>
											<tr>
												<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
                                                <td colspan="2" class="text1"><hr size="1" noshade="noshade" /></td>
                                                <cfelse>
                                                <td colspan="2" class="text1fact"><hr size="1" noshade="noshade" /></td>
                                                </cfif>
											</tr>
										</cfif>
										<tr>
											<cfset name = replacenocase(tag_name, 'Application', '')>
                                            <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
											<td class="text1" valign="top" width="24"><a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=/forms/#string#" class="img_apply_gif" target="#tag_name#">
                                            <cfelse>
                                            <td class="text1fact" valign="top" width="24"><div class="pdf_img"><a class="snapLink" href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=/forms/#string#" class="img_apply_gif" target="#tag_name#">
                                            </cfif>
												<cfif right(trim(string),4) IS ".pdf">
													<cf_displayImage code="#img_pdf_gif#" hspace="0" vspace="0">
													<cfelseif right(trim(string),4) IS ".doc">
													<cf_displayImage code="#img_word_doc_gif#" hspace="0" vspace="0">
													<cfelse>
													<cf_displayImage code="#img_apply_gif#" hspace="0" vspace="0" class="snap_icon">
												</cfif>
												</a></div></td>
											<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77><td class="snapLegend" valign="top"><cfelse><td class="text1fact" valign="top"></cfif><a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgtorg_id=#session.org_id#&tgt=/forms/#string#" class="snapLink" target="#tag_name#">#name#</a>
												<cfif formtype_id IS 4>
													<cf_displayImage code="img_pencil_gif" hspace="0" vspace="0">
												</cfif></td>
											<cfif findnocase('English', tag_name) IS 0 OR findnocase('Spanish', tag_name) IS 0 AND setBreak IS 0>
												<cfset setBreak = 1>
											</cfif>
										</tr>
									</cfloop>
								</cfif>
							</table>
						</div>
						<cfparam name="multiProgramLegend" default="0">
						<cfparam name="foodStampLegend" default="0">
						<cfparam name="fillableLegend" default="0">
						<cfif forms.recordcount IS NOT 0 and 1 eq 1 AND call_state IS 1 AND NOT listFindNoCase("PR", qState.state_id) GT 0>
                        	<cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
							<div style="padding:0px 12px; background-color: ##d7d7d7; width: 284px;" class="noprint"> <strong>#call_your_state#</strong> </div>
                            <cfelse>
                            <div class="appforms noprint" style="padding-bottom:10px;"><strong>#call_your_state#</strong></div> 
                            </cfif>
						</cfif>
                        <cfif session.partner_id neq 0 AND SESSION.partner_id NEQ 77>
						<div style="padding:12px; background-color: ##d7d7d7; width: 284px;" class="noprint">
                        <cfelse>
                        <div class="appforms noprint" style="margin-bottom:15px;padding-bottom:10px;"> 
                        </cfif>
							<cfif multiProgramLegend IS 1 OR foodStampLegend IS 1>
								<h2 class="snapH2" style="margin-bottom:4px;">#definitions#</h2>
								<cfif multiProgramLegend IS 1>
									<p style="margin-top:0px;" class="snapLegend2"><strong>#multi_form#</strong><br />
										<em>#apply_more#</em> </p>
								</cfif>
								<cfif foodStampLegend IS 1>
									<p style="margin-top:0px;" class="snapLegend2"><strong>#food_only#</strong><br />
										<em>#apply_only#</em> </p>
								</cfif>
								<cfif fillableLegend IS 1>
									<p style="margin-top:0px;" class="snapLegend2">
										<cf_displayImage code="img_pencil_gif" hspace="0" vspace="0">
										<em>#fillable_forms#</em> </p>
								</cfif>
							</cfif>
						</div>
					</div>
					<!-- END snap_right_col --> 
					
					#snap_state.description#<!---</td>---> 
					
					<!---<td class="text1" valign="top" style="white-space:300px;">--->


				</div>
				<!-- END snap_left_col --></td>

		</tr>
		<tr>
			<td class="text1" valign="bottom"></td>
		</tr>
	</table>
	</td>
	</tr>
	</table>
</cfoutput> 
