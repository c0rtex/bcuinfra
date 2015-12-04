<cfcomponent>
	<cffunction name="init" access="public" returntype="sessionLoadVars">
		<cfargument name="redirect" type="boolean" default="true">
        <cfargument name="initAll" type="boolean" default="true">
        <cfargument name="checkSubset" type="boolean" default="true">
        <cfscript>
			setRedirect(arguments.redirect);
			setInitAll(arguments.initAll);
			setCheckSubset(arguments.checkSubset);
			
			setSkipLoad();
			doLoadVars();
		</cfscript>
        	
		<cfreturn this />
	</cffunction>
    
    <!--- UDF's --->
    <cffunction name="setSkipLoad" access="public" output="no">
    	<cfset skipLoad = false>
		<cfif IsDefined('session.skipLoad') and session.skipLoad neq ''>
            <cfif session.skipLoad eq "#session.cfid#|#session.cftoken#">
                <cfset skipLoad = true>
            </cfif>
            <cfset session.skipLoad = ''>
        </cfif>
    </cffunction>
    
    <cffunction name="doLoadVars" access="public" output="yes" returntype="any">
    	<cfif not IsDefined('application.lastRefresh')>
            <cf_loadApplicationVars refresh="true">
        </cfif>
        <cfif IsDefined('url.link') and (url.link eq 'aarpnc' or url.link eq 'aarpmt' or url.link eq 'grandfamilies')>
            <cflocation url="http://www.aarp.org/quicklink" AddToken="No">
            <cfabort>
        <cfelseif IsDefined('url.link') and REFind("^([0-9]+)\/([0-9]+)\/?$", url.link)>
            <cfset urlArr = REFind("^([0-9]+)\/([0-9]+)\/?$", url.link, 1, true)>
            <cf_sessionPassVars href="printed.cfm" partner_id="#Mid(url.link, urlArr.pos[2], urlArr.len[2])#" subset_id="#Mid(url.link, urlArr.pos[3], urlArr.len[3])#" var="redirectURL">
            <cflocation url="#redirectURL#" addtoken="no">
            <cfabort>
        <cfelse>
            <cfif not skipLoad>
                <cfif getInitAll()>
                    <!--- Remove session variables that haven't been passed in by url or form --->
                    <cfif not isDefined('url.sn') and not isDefined('form.sn')>
                        <cfif isDefined('session.oe_server_id')>
                            <cfset StructDelete(session, 'oe_server_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.source_id') and not isDefined('form.source_id')>
                        <cfif isDefined('session.source_id')>
                            <cfset StructDelete(session, 'source_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.prev_id') and not isDefined('form.prev_id')>
                        <cfif isDefined('session.prev_id')>
                            <cfset StructDelete(session, 'prev_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.org_id') and not isDefined('form.org_id') and not isDefined('url.link')>
                        <cfif isDefined('session.org_id')>
                            <cfset StructDelete(session, 'org_id')>
                            <cfset StructDelete(session, 'cobrand_org_id')>
                            <cfset StructDelete(session, 'cobrand_name')>
                            <cfset StructDelete(session, 'cobrand_slogan')>
                            <cfset StructDelete(session, 'cobrand_bgcolor')>
                            <cfset StructDelete(session, 'cobrand_logo')>
                            <cfset StructDelete(session, 'site_name_style')>
                            <cfset StructDelete(session, 'site_slogan_style')>
                            <cfset StructDelete(session, 'cobrand_parent_name')>
                            <cfset StructDelete(session, 'cobrand_parent_slogan')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.partner_id') and not isDefined('form.partner_id')>
                        <cfif isDefined('session.partner_id')>
                            <cfset StructDelete(session, 'partner_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.subset_id') and not isDefined('form.subset_id')>
                        <cfif isDefined('session.subset_id')>
                            <cfset StructDelete(session, 'subset_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.language_id') and not isDefined('form.language_id')>
                        <cfif isDefined('session.language_id')>
                            <cfset StructDelete(session, 'language_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.access_id') and not isDefined('form.access_id')>
                        <cfif isDefined('session.access_id')>
                            <cfset StructDelete(session, 'access_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.client_id') and not isDefined('form.client_id')>
                        <cfif isDefined('session.client_id')>
                            <cfset StructDelete(session, 'client_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.user_id') and not isDefined('form.user_id')>
                        <cfif isDefined('session.user_id')>
                            <cfset StructDelete(session, 'user_id')>
                        </cfif>
                    </cfif>
                    <cfif not isDefined('url.state_id') and not isDefined('form.state_id')>
                        <cfif isDefined('session.state_id')>
                            <cfset StructDelete(session, 'state_id')>
                        </cfif>
                    </cfif>
                    <!--- But don't destroy test_id value (we want that one to stick around from before) --->
                    
                    <!--- initialize various cobranding variables --->
                    <cfif IsDefined('url.org_id') or IsDefined('form.org_id') or IsDefined('url.link')>
                        <cfset header_org_id = 0>
                        <cfset session.cobrand_org_id = ''>
                    </cfif>
                    <cfif not IsDefined('session.site_name_style')>
                        <cfset session.site_name_style = ''>
                    </cfif>
                    <cfif not IsDefined('session.site_slogan_style')>
                        <cfset session.site_slogan_style = ''>
                    </cfif>
                    <cfif not IsDefined('session.cobrand_parent_name')>
                        <cfset session.cobrand_parent_name = ''>
                    </cfif>
                    <cfif not IsDefined('session.cobrand_parent_slogan')>
                        <cfset session.cobrand_parent_slogan = ''>
                    </cfif>
                </cfif>
                
                <cfif IsDefined('url.sn')>
                    <cfset session.oe_server_id = url.sn>
                <cfelseif IsDefined('form.sn')>
                    <cfset session.oe_server_id = form.sn>
                <cfelseif getInitAll()>
                    <cfset session.oe_server_id = ''>
                </cfif>
                <cfif IsDefined('url.link')>
                    <cfset session.source_id=4>  <!--- If we came from a direct link, explicitly set source_id to 4 ('link') --->
                <cfelseif IsDefined('url.source_id')>
                    <cfset session.source_id=url.source_id>
                <cfelseif IsDefined('form.source_id')>
                    <cfset session.source_id=form.source_id>
                <cfelseif getInitAll()>
                    <cfset session.source_id=1>
                </cfif>
                <cfif IsDefined('url.prev_id')>
                    <cfset session.prev_id=url.prev_id>
                <cfelseif IsDefined('form.prev_id')>
                    <cfset session.prev_id=form.prev_id>
                <cfelseif getInitAll()>
                    <cfset session.prev_id=0>
                </cfif>
                <!--- find values for cobranding variables --->
                <cfif (IsDefined('url.org_id') or IsDefined('form.org_id') or IsDefined('url.link')) And getInitAll()>
                    <cfif IsDefined('url.org_id') and IsNumeric(url.org_id)>
                        <cfset header_org_id = url.org_id>
                    <cfelseif IsDefined('form.org_id') and IsNumeric(form.org_id)>
                        <cfset header_org_id = form.org_id>
                    <cfelse>
                        <cfset header_org_id = 0>
                    </cfif>
                    <cfif IsDefined('url.link')>
                        <cfset urlLink = REReplace(url.link, '\/', '', 'ALL')>
                        <cfset urlLink = LCase(urlLink)>
                        <cfquery name="cobrandInfoFromWebLink" datasource="#application.dbSrcOE#">
                            select id
                            from ORGANIZATION
                            where web_link=<cfqueryparam cfsqltype="cf_sql_varchar" value="#urlLink#" maxlength="250">
                        </cfquery>
                        <cfif cobrandInfoFromWebLink.RecordCount gt 0>
                            <cfset header_org_id = cobrandInfoFromWebLink.id>
                        </cfif>
                    </cfif>
                    <cfif not IsDefined('session.cobrand_org_id')>
                        <cfset session.cobrand_org_id="">
                    </cfif>
                    <cfif header_org_id eq 0>
                        <cfset session.cobrand_name=''>
                        <cfset session.cobrand_slogan=''>
                        <cfset session.cobrand_bgcolor=0>
                        <cfset session.cobrand_logo=''>
                        <cfset session.cobrand_org_id=0>
                        <cfset session.site_name_style=''>
                        <cfset session.site_slogan_style=''>
                        <cfset session.organization_type_id=0>
                        <cfset session.cobrand_parent_name=''>
                        <cfset session.cobrand_parent_slogan=''>
                    <cfelseif session.cobrand_org_id neq header_org_id>
                        <cfquery name="cobrandInfo" datasource="#application.dbSrcOE#">
                            select o.site_name Pro_Name, o.slogan Pro_Slogon,
                                o.site_bg_color Pro_BkColor, o.logo_path Pro_LogoPath,
                                o.site_name_style, o.site_slogan_style,
                                o.organization_type_id,
                                p.site_name parent_org, p.slogan parent_slogan
                            from ORGANIZATION o LEFT OUTER JOIN ORGANIZATION p
                                ON o.parent_org_id = p.id
                                    AND p.id != 1
                            WHERE o.id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="5" value="#header_org_id#" >
                        </cfquery>
                        <cfset session.cobrand_name=cobrandInfo.Pro_Name>
                        <cfset session.cobrand_slogan=cobrandInfo.Pro_Slogon>
                        <cfset session.cobrand_bgcolor=cobrandInfo.Pro_BkColor>
                        <cfset session.cobrand_logo=cobrandInfo.Pro_LogoPath>
                        <cfset session.cobrand_org_id=header_org_id>
                        <cfset session.site_name_style=cobrandInfo.site_name_style>
                        <cfset session.site_slogan_style=cobrandInfo.site_slogan_style>
                        <cfset session.organization_type_id=cobrandInfo.organization_type_id>
                        <cfset session.cobrand_parent_name=cobrandInfo.parent_org>
                        <cfset session.cobrand_parent_slogan=cobrandInfo.parent_slogan>
                    </cfif>
                    <cfset session.org_id=session.cobrand_org_id>
                <cfelseif IsDefined('url.org_id')>
                    <cfset session.org_id=url.org_id>
                <cfelseif IsDefined('form.org_id')>
                    <cfset session.org_id=form.org_id>
                <cfelseif getInitAll()>
                    <cfset session.org_id=0>
                </cfif>
                <cfif IsDefined('partner_id') and partner_id eq 19>
                    <cfset session.partner_id = partner_id>
                <cfelseif IsDefined('session.organization_type_id') And session.organization_type_id eq 2>
                    <cfset session.partner_id = 7>
                <cfelseif IsDefined('session.organization_type_id') And session.organization_type_id eq 3>
                    <cfset session.partner_id = 12>
                <cfelseif IsDefined('session.organization_type_id') And session.organization_type_id eq 4>
                    <cfset session.partner_id = 13>
                <cfelseif IsDefined('session.organization_type_id') And session.organization_type_id eq 5>
                    <cfset session.partner_id = 14>
                <cfelseif IsDefined('session.organization_type_id') And session.organization_type_id eq 6>
                    <cfset session.partner_id = 16>
                <cfelseif IsDefined('url.partner_id')>
                    <cfset session.partner_id = url.partner_id>
                <cfelseif IsDefined('form.partner_id')>
                    <cfset session.partner_id = form.partner_id>
                <cfelseif getInitAll()>
                    <cfset session.partner_id = 0>
                </cfif>
                <cfif IsDefined('subset_id') and subset_id eq 41>
                    <cfset session.subset_id = subset_id>
                    <!--- BShunn 2007-09-24:  Stop changing the partner ID for LIS App because it fucks up OE org screenings.
                    <cfif session.partner_id neq 13 and session.partner_id neq 31>
                        <cfset session.partner_id = 19>
                    </cfif>
                    --->
                <cfelseif IsDefined('url.link') And IsDefined('session.organization_type_id') And session.organization_type_id eq 2>
                    <cfset session.subset_id=39>
                <cfelseif IsDefined('url.link') And IsDefined('session.organization_type_id') And session.organization_type_id eq 3>
                    <cfset session.subset_id=39>
                <cfelseif IsDefined('url.link') And IsDefined('session.organization_type_id') And session.organization_type_id eq 4>
                    <cfset session.subset_id=39>
                <cfelseif IsDefined('url.link') And IsDefined('session.organization_type_id') And session.organization_type_id eq 5>
                    <cfset session.subset_id=39>
                <cfelseif IsDefined('url.link') And IsDefined('session.organization_type_id') And session.organization_type_id eq 6>
                    <cfset session.subset_id=38>
                <cfelseif IsDefined('url.subset_id')>
                    <cfset session.subset_id=url.subset_id>
                <cfelseif IsDefined('form.subset_id')>
                    <cfset session.subset_id=form.subset_id>
                <cfelseif IsDefined('url.rxonly') and url.rxonly eq 'Y'>
                    <cfset session.subset_id=19>
                <cfelseif getInitAll()>
                    <cfset session.subset_id=0>
                </cfif>
                <cfif IsDefined('session.subset_id')>
                    <cfquery name="subsetInfo" datasource="#application.dbSrc#">
                        SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text, all_flag,
                            state_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
                        FROM xsubset
                        WHERE subset_id=#session.subset_id#
                    </cfquery>
                    <cfif subsetInfo.RecordCount>
                        <cfif getCheckSubset() And subsetInfo.subsettype_id eq 4>
                            <cflocation url="#application.transferType#://#application.serverPath#/" AddToken="No">
                            <cfabort>
                        </cfif>
                        <cfset session.subsetName = subsetInfo.subset_name>
                        <cfset session.subsetLongName = subsetInfo.subset_longname>
                        <cfset session.subsetDescription = subsetInfo.subset_description>
                        <cfset session.subsetText = subsetInfo.subset_text>
                        <cfset session.subsetAllFlag = subsetInfo.all_flag>
                        <cfset session.subsetStateFlag = subsetInfo.state_flag>
                        <cfset session.subsetGridFlag = subsetInfo.grid_flag>
                        <cfset session.subsetSCHIPFlag = subsetInfo.schip_flag>
                        <cfset session.subsetDrugFlag = subsetInfo.drug_flag>
                        <cfset session.subsetOptionalFlag = subsetInfo.optional_flag>
                        <cfset session.subsetRecFlag = subsetInfo.rec_flag>
                        <cfset session.subsetEFormFlag = subsetInfo.eform_flag>
                    <cfelse>
                        <cfset session.subsetName = ''>
                        <cfset session.subsetLongName = ''>
                        <cfset session.subsetDescription = ''>
                        <cfset session.subsetText = ''>
                        <cfset session.subsetAllFlag = 0>
                        <cfset session.subsetStateFlag = 0>
                        <cfset session.subsetGridFlag = 0>
                        <cfset session.subsetSCHIPFlag = 0>
                        <cfset session.subsetDrugFlag = 0>
                        <cfset session.subsetOptionalFlag = 0>
                        <cfset session.subsetRecFlag = 0>
                        <cfset session.subsetEFormFlag = 0>
                    </cfif>
                    <cfquery name="subsetPartnerInfo" datasource="#application.dbSrc#">
                        SELECT resultpage_id
                        FROM subset_partner
                        WHERE subset_id=#session.subset_id#
                            AND partner_id=#session.partner_id#
                            AND resultpage_id IS NOT NULL
                    </cfquery>
                    <cfif subsetPartnerInfo.RecordCount>
                        <cfset session.subsetRecFlag = subsetPartnerInfo.resultpage_id - 1>
                    </cfif>
                </cfif>
                <!--- START PARTNER-SPECIFIC OPTIONAL QUESTIONS CUSTOMIZATION --->
                <cfif session.partner_id gt 0>
                    <cfquery name="partnerInfo" datasource="#application.dbSrc#">
                        select learn_flag, race_flag, hispanic_flag, links_flag, pdf_logo_flag
                        from tbl_partner
                        where partner_id=#session.partner_id#
                    </cfquery>
                    <cfset session.partnerLearnFlag = partnerInfo.learn_flag>
                    <cfset session.partnerRaceFlag = partnerInfo.race_flag>
                    <cfset session.partnerHispanicFlag = partnerInfo.hispanic_flag>
                    <cfset session.partnerLinksFlag = partnerInfo.links_flag>
                    <cfset session.partnerPDFLogoFlag = partnerInfo.pdf_logo_flag>
                <cfelse>
                    <cfset session.partnerLearnFlag = 1>
                    <cfset session.partnerRaceFlag = 1>
                    <cfset session.partnerHispanicFlag = 0>
                    <cfset session.partnerLinksFlag = 1>
                    <cfset session.partnerPDFLogoFlag = 1>
                </cfif>
                <cfquery name="subsetQuestionInfo" datasource="#application.dbSrc#">
                    select x.question_code, max(x.include) as include
                    from (
                        select q.question_code, 1 as include
                        from question q
                        where q.question_code in ('learn', 'race', 'hispanic')
                            and (
                                q.include_flag=1
                                or (
                                    q.exclude_flag=0
                                    and q.question_id in (
                                        select question_id
                                        from subset_question
                                        where subset_id=#session.subset_id#
                                        and exclude_flag=0
                                    )
                                )
                            )
                        union
                        select q.question_code, 0 as include
                        from question q
                        where q.question_code in ('learn', 'race', 'hispanic')
                    ) x
                    group by x.question_code
                </cfquery>
                <cfloop query="subsetQuestionInfo">
                    <cfswitch expression="#question_code#">
                        <cfcase value="learn">
                        <cfif session.partner_id eq 22 and session.org_id gt 0>
                            <cfset session.partnerLearnFlag = 0>
                        </cfif>
                            <cfset session.partnerLearnFlag = session.partnerLearnFlag * include>
                        </cfcase>
                        <cfcase value="race">
                            <cfset session.partnerRaceFlag = session.partnerRaceFlag * include>
                        </cfcase>
                        <cfcase value="hispanic">
                            <cfset session.partnerHispanicFlag = session.partnerHispanicFlag * include>
                        </cfcase>
                    </cfswitch>
                </cfloop>
                <cfif session.subsetOptionalFlag eq 0 and session.partnerLearnFlag eq 0 and session.partnerRaceFlag eq 0 and session.partnerHispanicFlag eq 0>
                    <cfset session.subsetOptionalFlag = 1>
                </cfif>
                <!--- END PARTNER-SPECIFIC OPTIONAL QUESTIONS CUSTOMIZATION --->
                <cfif IsDefined('url.language_id')>
                    <cfset session.language_id=url.language_id>
                <cfelseif IsDefined('form.language_id')>
                    <cfset session.language_id=form.language_id>
                <cfelseif getInitAll()>
                    <cfset session.language_id='EN'>
                </cfif>
                <cfif IsDefined('url.access_id')>
                    <cfset session.access_id=url.access_id>
                <cfelseif IsDefined('form.access_id')>
                    <cfset session.access_id=form.access_id>
                <cfelseif getInitAll()>
                    <cfset session.access_id=0>
                </cfif>
                <cfif IsDefined('url.client_id')>
                    <cfset session.client_id=url.client_id>
                <cfelseif IsDefined('form.client_id')>
                    <cfset session.client_id=form.client_id>
                <cfelseif getInitAll()>
                    <cfset session.client_id='NULL'>
                </cfif>
                <cfif IsDefined('url.user_id')>
                    <cfset session.user_id=url.user_id>
                <cfelseif IsDefined('form.user_id')>
                    <cfset session.user_id=form.user_id>
                <cfelseif getInitAll()>
                    <cfset session.user_id='NULL'>
                </cfif>
                <cfif IsDefined('url.state_id')>
                    <cfset session.state_id=url.state_id>
                <cfelseif IsDefined('form.state_id')>
                    <cfset session.state_id=form.state_id>
                <cfelseif getInitAll()>
                    <cfset session.state_id=''>
                </cfif>
                <cfif session.state_id neq ''>
                    <cf_cacheStatePool action="get" state_id="#session.state_id#" var="stobj">
                    <cfif not stobj.exists>
                        <cfset session.state_id = ''>
                    </cfif>
                </cfif>
                <cfif session.partner_id eq 10>
                    <cfset session.test_id=1>
                <cfelseif IsDefined('url.test_id')>
                    <cfset session.test_id=url.test_id>
                <cfelseif IsDefined('form.test_id')>
                    <cfset session.test_id=form.test_id>
                <cfelseif getInitAll() and Not IsDefined('session.test_id')>
                    <cfset session.test_id=0>
                </cfif>
            </cfif>
            <cfif getRedirect()>
                <cfif (session.partner_id eq 6 Or session.partner_id eq 7 or session.partner_id eq 12 or session.partner_id eq 14 or session.partner_id eq 16) And GetFileFromPath(CGI.CF_TEMPLATE_PATH) eq 'index.cfm' And FindNoCase('/ec/', GetDirectoryFromPath(CGI.CF_TEMPLATE_PATH)) eq 0 And FindNoCase('\ec\', GetDirectoryFromPath(CGI.CF_TEMPLATE_PATH)) eq 0>
                    <cf_sessionPassVars href="before_you_start.cfm" var="redirectURL">
                    <cflocation url="#redirectURL#" addtoken="no">
                    <cfabort>
                <cfelseif session.partner_id eq 5 And (GetFileFromPath(CGI.CF_TEMPLATE_PATH) eq 'index.cfm' Or GetFileFromPath(CGI.CF_TEMPLATE_PATH) eq 'before_you_start.cfm')>
                    <cf_sessionPassVars href="frmwelcome2.cfm" var="redirectURL">
                    <cflocation url="#redirectURL#" addtoken="no">
                    <cfabort>
                <cfelseif session.subset_id eq 41 And (GetFileFromPath(CGI.CF_TEMPLATE_PATH) eq 'frmwelcome2.cfm' Or GetFileFromPath(CGI.CF_TEMPLATE_PATH) eq 'before_you_start.cfm')>
                    <cf_sessionPassVars href="start.cfm" var="redirectURL">
                    <cflocation url="#redirectURL#" addtoken="no">
                    <cfabort>
                </cfif>
            </cfif>
        </cfif>
    </cffunction>
    
    
    <!--- GETTERS AND SETTERS --->
    <cffunction name="setRedirect" access="public" output="no">
    	<cfargument name="redirect" type="boolean" required="true" />
		<cfset variables.redirect = arguments.redirect />
    </cffunction>
    <cffunction name="getRedirect" access="public" output="no">
		<cfreturn variables.redirect />
    </cffunction>
    
    <cffunction name="setInitAll" access="public" output="no">
    	<cfargument name="initAll" type="boolean" required="true" />
		<cfset variables.initAll = arguments.initAll />
    </cffunction>
    <cffunction name="getInitAll" access="public" output="no">
		<cfreturn variables.initAll />
    </cffunction>
    
    <cffunction name="setCheckSubset" access="public" output="no">
    	<cfargument name="checkSubset" type="boolean" required="true" />
		<cfset variables.checkSubset = arguments.checkSubset />
    </cffunction>
    <cffunction name="getCheckSubset" access="public" output="no">
		<cfreturn variables.checkSubset />
    </cffunction>
</cfcomponent>