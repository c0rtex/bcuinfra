<!---
	Template Name: DisplayEntity
	Component Purpose: Component mapped to database table display via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: display

--->

<cfcomponent persistent="true" entityname="display" table="display" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="display_id">
	<cfproperty name="code" column="display_code">
	<cfproperty name="display_text" persistent="false" getter="true">

<!---
	Method returns display text at language set in session
--->

	<cffunction name="getDisplay_text">
        <cfset displ=ORMExecuteQuery("from display_language where display_id=:display_id and language_id=:language_id", {display_id=this.getId(), language_id=session.language.getId()})>
		<cfreturn displ[1].getDisplay_text()>
	</cffunction>

	<cffunction name="expandTextCodes">
		<cfargument name="outstr" default="">
		<cfset hasCode = false>
		<cfset getCodeOpen = Find('[[', outstr)>
		<cfif getCodeOpen>
			<cfset getCodeClose = Find(']]', outstr, getCodeOpen + 2)>
			<cfif getCodeClose>
				<cfset hasCode = true>
				<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
			</cfif>
		</cfif>
		<cfloop condition="hasCode">
			<cfset commandParams = ListLen(getCode, '|')>
			<cfset commandCode = ListGetAt(getCode, 1, '|')>
			<cfswitch expression="#commandCode#">
				<cfcase value="bcu">
					<cfset expandedText = 'BenefitsCheckUp'>
					<cfif IsDefined('session.partner_id')>
						<cf_cachePartnerPool action="get" partner_id="#session.partner_id#" var="pobj">
						<cfif IsDefined('pobj.bcu') and pobj.bcu neq ''>
							<cf_displayText group="partnersite" code="#pobj.bcu#" alt="(zyx987NULL789xyz)" var="bcuSiteName">
							<cfif bcuSiteName neq '(zyx987NULL789xyz)' and bcuSiteName neq ''>
								<cfset expandedText = bcuSiteName>
							</cfif>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="count">
					<cfif commandParams gt 1>
						<cfset cmdType = ListGetAt(getCode, 2, '|')>
					<cfelse>
						<cfset cmdType = 'program'>
					</cfif>
					<cfif cmdType eq 'program'>
						<cfset cmdSpec = 'active'>
						<cfset cmdRoundDownTo = ''>
						<cfset cmdSubsetID = ''>
						<cfif commandParams gt 2>
							<cfset cmdSpec = ListGetAt(getCode, 3, '|')>
							<cfif commandParams gt 3>
								<cfset cmdRoundDownTo = ListGetAt(getCode, 4, '|')>
								<cfif cmdRoundDownTo eq 0>
									<cfset cmdRoundDownTo = ''>
								</cfif>
								<cfif commandParams gt 4>
									<cfset cmdSubsetID = ListGetAt(getCode, 5, '|')>
								</cfif>
							</cfif>
						</cfif>
						<cfif cmdSubsetID neq '' and IsNumeric(cmdSubsetID)>
							<cf_populateTableFromView table="subset_program_base" subset_id="#cmdSubsetID#">
							<cfquery name="prgcount" datasource="#application.dbSrc#">
						select count(*) as c
						from subset_program_base sp, tbl_prg_all p
						where sp.subset_id=#cmdSubsetID#
							and sp.program_id=p.RecID
							and <cfif cmdSpec eq 'active'>(p.inactive_flag is null or p.inactive_flag=0)<cfelseif cmdSpec eq 'inactive'>p.inactive_flag=1</cfif>
							</cfquery>
							<cfset outVal = prgcount.c>
						<cfelse>
							<cfquery name="prgcount" datasource="#application.dbSrc#">
						select count(*) as c
						from tbl_prg_all
						<cfif cmdSpec eq 'active'>where inactive_flag is null or inactive_flag=0<cfelseif cmdSpec eq 'inactive'>where inactive_flag=1</cfif>
							</cfquery>
							<cfset outVal = prgcount.c>
						</cfif>
						<cfif cmdRoundDownTo neq ''>
							<cf_integerRoundOver num="#outVal#" scale="#cmdRoundDownTo#" var="outVal">
						</cfif>
						<cf_integerSeparate num="#outVal#" var="expandedText">
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (count): count type ""#cmdType#"" is not known]</span>">
					</cfif>
				</cfcase>
				<cfcase value="def">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): no term was specified]</span>">
					<cfelse>
						<cfif commandParams gt 2>
							<cfset defText = ListGetAt(getCode, 3, '|')>
						<cfelse>
							<cfset defText = ''>
						</cfif>
						<cfset defKeyword = ListGetAt(getCode, 2, '|')>
						<cf_buildPopupLink keyword="#defKeyword#" text="#defText#" var="expandedText" error_var="defError">
<!--- FAILOVER TEST:  if nothing comes up for keyword, try it as a code --->
						<cfif expandedText eq '' and defError eq 2>
							<cf_buildPopupLink code="#defKeyword#" text="#defText#" var="expandedText" error_var="defError">
						</cfif>
						<cfswitch expression="#defError#">
							<cfcase value="2">
								<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): definition for ""#defKeyword#"" not found]</span>">
							</cfcase>
							<cfcase value="3">
								<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): no link text could be determined]</span>">
							</cfcase>
						</cfswitch>
					</cfif>
				</cfcase>
				<cfcase value="eval">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (eval): no variable name was specified]</span>">
					<cfelse>
						<cfset expandedText = Evaluate("#Trim(ListGetAt(getCode, 2, '|'))#")>
					</cfif>
				</cfcase>
				<cfcase value="if">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (if): no ""then"" element was specified]</span>">
					<cfelse>
						<cfset conditionBoolean = Evaluate("#ListGetAt(getCode, 2, '|')#")>
						<cfif Not IsBoolean(conditionBoolean)>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (if): conditional parameter does not evaluate to a boolean value]</span>">
							<cfelseif conditionBoolean>
							<cfset expandedText = ListGetAt(getCode, 3, '|')>
							<cfelseif commandParams gt 3>
							<cfset expandedText = ListGetAt(getCode, 4, '|')>
						<cfelse>
							<cfset expandedText = ''>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="number">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (number): no variable name was specified]</span>">
					<cfelse>
						<cfset expandNumber = Evaluate("#Trim(ListGetAt(getCode, 2, '|'))#")>
						<cfif not IsNumeric(expandNumber)>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (number): '#expandNumber#' is not a numeric value]</span>">
						<cfelse>
							<cf_displayText group="number" code="number_#expandNumber#" alt="#expandNumber#" var="expandedText">
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="pass">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (pass): no URL was specified]</span>">
						<cfelseif commandParams eq 2>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (pass): no link text was specified]</span>">
					<cfelse>
						<cfset commandProbe = 4>
						<cfif IsDefined('session.partner_id')>
							<cfset command_partner_id = session.partner_id>
						<cfelse>
							<cfset command_partner_id = 0>
						</cfif>
						<cfif IsDefined('session.subset_id')>
							<cfset command_subset_id = session.subset_id>
						<cfelse>
							<cfset command_subset_id = 0>
						</cfif>
						<cfif IsDefined('session.org_id')>
							<cfset command_org_id = session.org_id>
						<cfelse>
							<cfset command_org_id = 0>
						</cfif>
						<cfif IsDefined('session.source_id')>
							<cfset command_source_id = session.source_id>
						<cfelse>
							<cfset command_source_id = 0>
						</cfif>
						<cfset command_extralist = ''>
						<cfloop condition="commandParams gt commandProbe">
							<cfset "command_#ListGetAt(getCode, commandProbe, '|')#" = Evaluate(DE(ListGetAt(getCode, commandProbe + 1, '|')))>
							<cfset commandProbe = commandProbe + 2>
						</cfloop>
						<cf_sessionPassVars href="#Trim(ListGetAt(getCode, 2, '|'))#" partner_id="#command_partner_id#" subset_id="#command_subset_id#" org_id="#command_org_id#" source_id="#command_source_id#" extralist="#command_extralist#" var="expandedText"><cfoutput>#Trim(ListGetAt(getCode, 3, '|'))#</cfoutput></cf_sessionPassVars>
					</cfif>
				</cfcase>
                <!--		SE - Added this case statement to temporarily address bug 3624	-->
				<cfcase value="home">
					<cfset commandProbe = 4>
					<cfif IsDefined('session.partner_id')>
						<cfset command_partner_id = session.partner_id>
					<cfelse>
						<cfset command_partner_id = 0>
					</cfif>
					<cfif IsDefined('session.subset_id')>
						<cfset command_subset_id = session.subset_id>
					<cfelse>
						<cfset command_subset_id = 0>
					</cfif>
					<cfif IsDefined('session.org_id')>
						<cfset command_org_id = session.org_id>
					<cfelse>
						<cfset command_org_id = 0>
					</cfif>
					<cfif IsDefined('session.source_id')>
						<cfset command_source_id = session.source_id>
					<cfelse>
						<cfset command_source_id = 0>
					</cfif>
					<cfset command_extralist = ''>
					<cfloop condition="commandParams gt commandProbe">
						<cfset "command_#ListGetAt(getCode, commandProbe, '|')#" = Evaluate(DE(ListGetAt(getCode, commandProbe + 1, '|')))>
						<cfset commandProbe = commandProbe + 2>
					</cfloop>
					<cfswitch expression="#application.serverPath#">
						<cfcase value="ssl1.benefitscheckup.org,ssl2.benefitscheckup.org,ssl3.benefitscheckup.org,ssl4.benefitscheckup.org">
							<cfset printedServer = 'www.benefitscheckup.org'>
						</cfcase>
						<cfdefaultcase>
							<cfset printedServer = application.serverPath>
						</cfdefaultcase>
					</cfswitch>
					<cfset expandedText = "<a href='#application.transfertype#://#printedServer#/index.cfm?partner_id=#command_partner_id#'>here</a>">
				</cfcase>
				<cfcase value="plural">
					<cfif param1 eq ''>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): no number was specified]</span>">
						<cfelseif not IsNumeric(param1)>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): '#param1#' is not a number]</span>">
						<cfelseif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (plural): no noun was specified]</span>">
					<cfelse>
						<cfif commandParams gt 2>
							<cfset pluralPluralNoun = Trim(ListGetAt(getCode, 3, '|'))>
						<cfelse>
							<cfset pluralPluralNoun = ''>
						</cfif>
						<cfset pluralSingularNoun = Trim(ListGetAt(getCode, 2, '|'))>
						<cf_displayText group="number" code="number_#param1#" alt="#param1#" var="pluralNumber">
						<cfif param1 neq 1>
							<cfif pluralPluralNoun neq ''>
								<cfset expandedText = "#pluralNumber# #pluralPluralNoun#">
							<cfelse>
								<cfset expandedText = "#pluralNumber# #pluralSingularNoun#s">
							</cfif>
						<cfelse>
							<cfset expandedText = "#pluralNumber# #pluralSingularNoun#">
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="printed">
					<cfif commandParams gt 1 and ListGetAt(getCode, 2, '|') eq 'url'>
						<cfif IsDefined('session.partner_id')>
							<cfset command_partner_id = session.partner_id>
						<cfelse>
							<cfset command_partner_id = 0>
						</cfif>
						<cfif IsDefined('session.subset_id')>
							<cfset command_subset_id = session.subset_id>
						<cfelse>
							<cfset command_subset_id = 0>
						</cfif>
						<cfswitch expression="#application.serverPath#">
							<cfcase value="ssl1.benefitscheckup.org,ssl2.benefitscheckup.org,ssl3.benefitscheckup.org,ssl4.benefitscheckup.org">
								<cfset printedServer = 'www.benefitscheckup.org'>
							</cfcase>
							<cfdefaultcase>
								<cfset printedServer = application.serverPath>
							</cfdefaultcase>
						</cfswitch>
						<cfset expandedText = "http://#printedServer#/link/#command_partner_id#/#command_subset_id#">
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (printed): no mode was specified]</span>">
					</cfif>
				</cfcase>
				<cfcase value="state">
					<cfset expandedText = ''>
					<cfset stateID = ''>
					<cfif commandParams gt 1>
						<cfif commandParams gt 2>
							<cfset stateID = Evaluate(DE(ListGetAt(getCode, 3, '|')))>
						</cfif>
						<cfif stateID eq '' and IsDefined('session.state_id')>
							<cfset stateID = session.state_id>
						</cfif>
						<cfif stateID neq ''>
							<cfif (ListGetAt(getCode, 2, '|') eq 'abbrev' or ListGetAt(getCode, 2, '|') eq 'id')>
								<cfset expandedText = stateID>
								<cfelseif ListGetAt(getCode, 2, '|') eq 'name'>
								<cf_cacheStatePool action="get" state_id="#stateID#" var="stobj">
								<cfset expandedText = stobj.name>
							</cfif>
						</cfif>
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): no mode was specified]</span>">
					</cfif>
					<cfif expandedText eq ''>
						<cfif stateID eq ''>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): state_id is blank]</span>">
						<cfelse>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): unknown state_id '#stateID#']</span>">
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="subset">
					<cfif commandParams gt 1 and ListGetAt(getCode, 2, '|') eq 'name'>
						<cfif IsDefined('session.subset_id') and session.subset_id neq ''>
							<cfquery name="expandSubset" datasource="#application.dbSrc#">
						select subset_name, qaire_name
						from xsubset
						where subset_id=#session.subset_id#
							</cfquery>
							<cfif expandSubset.RecordCount eq 0>
								<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (subset): no subset data was found]</span>">
							<cfelse>
								<cfif expandSubset.qaire_name eq ''>
									<cfset expandedText = expandSubset.subset_name>
								<cfelse>
									<cfset expandedText = expandSubset.qaire_name>
								</cfif>
							</cfif>
						<cfelse>
							<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (subset): no subset_id is set]</span>">
						</cfif>
					<cfelse>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (state): no mode was specified]</span>">
					</cfif>
				</cfcase>
				<cfcase value="track">
					<cfif commandParams eq 1>
						<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (track): no URL code was specified]</span>">
					<cfelse>
						<cfif commandParams gt 4>
							<cfset trackOnClick = Trim(ListGetAt(getCode, 5, '|'))>
						<cfelse>
							<cfset trackOnClick = ''>
						</cfif>
						<cfif commandParams gt 3>
							<cfset trackTarget = Trim(ListGetAt(getCode, 4, '|'))>
						<cfelse>
							<cfset trackTarget = ''>
						</cfif>
						<cfif commandParams gt 2>
							<cfset trackText = Trim(ListGetAt(getCode, 3, '|'))>
						<cfelse>
							<cfset trackText = ''>
						</cfif>
						<cfset trackCode = ListGetAt(getCode, 2, '|')>
						<cf_buildRedirectURL code="#trackCode#" text="#trackText#" target="#trackTarget#" onClick="#trackOnClick#" var="expandedText">
					</cfif>
				</cfcase>
				<cfcase value="year">
					<cfset expandedText = Year(Now())>
					<cfif commandParams gt 1>
						<cfset yearParam = ListGetAt(getCode, 2, '|')>
						<cfset incYear = 1>
						<cfif commandParams gt 2>
							<cfset incParam = ListGetAt(getCode, 3, '|')>
							<cfif IsNumeric(incParam)>
								<cfset incYear = incParam>
							</cfif>
						</cfif>
						<cfif yearParam eq 'next'>
							<cfset expandedText = expandedText + incYear>
							<cfelseif yearParam eq 'prev'>
							<cfset expandedText = expandedText - incYear>
						</cfif>
					</cfif>
				</cfcase>
				<cfdefaultcase>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error: command ""#commandCode#"" not known]</span>">
				</cfdefaultcase>
			</cfswitch>
			<cfset outstr = Replace(outstr, "[[#getCode#]]", expandedText, 'ONE')>
			<cfset hasCode = false>
			<cfset getCodeOpen = Find('[[', outstr)>
			<cfif getCodeOpen>
				<cfset getCodeClose = Find(']]', outstr, getCodeOpen + 2)>
				<cfif getCodeClose>
					<cfset hasCode = true>
					<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn outstr>
	</cffunction>

</cfcomponent>