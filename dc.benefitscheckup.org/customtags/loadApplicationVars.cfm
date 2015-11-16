<!--- Created by BShunn 2005/09/28 --->
<!--- Loads variables into application scope, if not already done --->
<cfparam name="attributes.hashname" type="string" default="">
<cfparam name="attributes.varname" type="string" default="">
<cfparam name="attributes.resetApplication" type="boolean" default="false">
<cfparam name="attributes.refresh" type="boolean" default="false">
<cfparam name="attributes.flush" type="string" default="">

<cfif attributes.resetApplication>
	<!--- clear application vars --->
	<cfset StructDelete(application, 'debug')>
	<cfset StructDelete(application, 'subsetsUseViews')>
	<cfset StructDelete(application, 'templateType')>
	<cfset StructDelete(application, 'templateTypeCanonical')>
	<cfset StructDelete(application, 'serverPath')>
	<cfset StructDelete(application, 'serverPathCanonical')>
	<cfset StructDelete(application, 'serverPathOE')>
	<cfset StructDelete(application, 'serverPathES')>
	<cfset StructDelete(application, 'serverPathESAARP')>
	<cfset StructDelete(application, 'dbSrc')>
	<cfset StructDelete(application, 'dbSrcOE')>
	<cfset StructDelete(application, 'dbSrcWarehouse')>
	<cfset StructDelete(application, 'remotesurvey')>
	<!--- don't do anything else in this tag --->
	<cfset attributes.hashname = 'doNothing'>
    <cfset session.resetApp = true>
</cfif>
<cfif attributes.refresh or attributes.flush eq 'template'>
	<!--- clear cached pages --->
	<cfcache action="flush">
</cfif>
<cfif attributes.refresh or attributes.flush eq 'query'>
	<!--- clear cached queries --->
	<cfobjectcache action="clear">
</cfif>
<cfif attributes.refresh>
	<!--- clear data cache --->
	<cfset application.lastRefresh = Now()>
	<!--- <cfset StructDelete(application, 'bcuAnswerfieldPool')> --->
	<cfset StructDelete(application, 'bcuAnswerfieldSubsetPartnerPool')>
	<cfset StructDelete(application, 'bcuDisplayPool')>
	<cfset StructDelete(application, 'bcuGridcolumnPool')>
	<cfset StructDelete(application, 'bcuGridrowPool')>
	<cfset StructDelete(application, 'bcuGridrowGridcolumnPool')>
	<cfset StructDelete(application, 'bcuHelpPool')>
	<cfset StructDelete(application, 'bcuImagePool')>
	<cfset StructDelete(application, 'bcuLanguagePool')>
	<cfset StructDelete(application, 'bcuOptionPool')>
	<cfset StructDelete(application, 'bcuOrganizationPool')>
	<cfset StructDelete(application, 'bcuPartnerPool')>
	<cfset StructDelete(application, 'bcuProgramPool')>
	<cfset StructDelete(application, 'bcuQuestionPool')>
	<cfset StructDelete(application, 'bcuRequisitePool')>
	<cfset StructDelete(application, 'bcuRulePool')>
	<cfset StructDelete(application, 'bcuStatePool')>
	<cfset StructDelete(application, 'bcuSubsetPool')>
	<cfset StructDelete(application, 'bcuSubsetAnswerfieldPool')>
	<cfset StructDelete(application, 'bcuSubsetProgramPool')>
	<cfset StructDelete(application, 'bcuSubsetQuestionPool')>
	<cfset StructDelete(application, 'bcuSubsetQuestionAnswerfieldPool')>
	<cfset StructDelete(application, 'bcuSubsetQuestionGridrowPool')>
	<cfset StructDelete(application, 'bcuTemplatePool')>
	<cfset StructDelete(application, 'bcuValidationPool')>
	<!--- QUICK-AND-DIRTY QUERY CACHES:  Should be replaced with genuine cache pool calls eventually --->
	<cfset StructDelete(application, 'bcuPartnerQuery')>
	<cfset StructDelete(application, 'bcuWrapperQuery')>
    <cfset session.resetApp = true>
    <cf_cacheQuestionPool action="refresh" >
    <!--- <cf_cacheAnswerfieldPool action="refresh" > --->
    <cf_cacheOptionPool action="refresh" >
    <cf_cacheValidationPool action="refresh" >
    
	<!--- HOUSECLEANING:  Delete deprecated application structures from application.
	          This is necessary or else deprecated vars will stick around in application
	          memory even on refresh, dying only at the next server restart.
	          (Remove this section when housecleaning in this template is complete) --->
	<!--- End HOUSECLEANING section --->
</cfif>
<cfif attributes.hashname eq ''>
	<cf_populateTableFromView table="xsubset" full="true">
	<cf_populateTableFromView table="xsubset_xincometype" full="true">
	<cf_populateTableFromView table="xsubset_xincass" full="true">
	<!--- MH: 5/12/10 Removed reference to xsubset_category since it is being archived on BCUQA 
    <cf_populateTableFromView table="xsubset_category" full="true">--->
    <cf_populateTableFromView table="xsubset_program" full="true">
    <cf_populateTableFromView table="xsubset_xassettype" full="true">
	<cf_populateTableFromView table="tbl_major_cat_list" full="true">
	<cf_populateTableFromView table="tbl_prg_all" full="true">
	<cf_populateTableFromView table="tbl_questions_new" full="true">
	<cf_populateTableFromView table="tbl_rules" full="true">
    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_req_mat, tbl_req_mat_list which are being archived
    <cf_populateTableFromView table="tbl_req_mat_list" full="true">
	<cf_populateTableFromView table="tbl_req_mat" full="true">--->
	<cf_populateTableFromView table="program_answerfield" full="true">
	<cf_populateTableFromView table="program_parent" full="true">
	<cf_populateTableFromView table="subset_program_base" full="true">
	<cf_populateTableFromView table="subset_program_sum" full="true">
</cfif>
<cfif attributes.hashname eq 'prgvars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.prgvars') Or attributes.refresh>
		<cfset application.prgvars = StructNew()>
		<cfquery name="prgvars" datasource="#application.dbSrc#">
			SELECT prg_id, RecID, childrens_flag
			FROM tbl_prg_all 
			ORDER BY RecID
		</cfquery>
		<cfloop query="prgvars">
			<cfif Not StructKeyExists(application.prgvars, prg_id)>
				<cfset StructInsert(application.prgvars, prg_id, RecID)>
			</cfif>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'recapvars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.recapvars') Or attributes.refresh>
		<cfset application.recapvars = StructNew()>
		<cfquery name="recapvars" datasource="#application.dbSrc#">
			SELECT recap_code, formula
			FROM recap 
			ORDER BY recap_id
		</cfquery>
		<cfloop query="recapvars">
			<cfif Not StructKeyExists(application.recapvars, recap_code)>
				<cfset StructInsert(application.recapvars, recap_code, formula)>
			</cfif>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'pgvars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.pgvars') Or attributes.refresh>
		<cfset application.pgvars = StructNew()>
		<cfset application.pgrecap = StructNew()>
		<cfquery name="pgvars" datasource="#application.dbSrc#">
			SELECT page_id, page_code, postrecap
			FROM page 
			ORDER BY page_id
		</cfquery>
		<cfloop query="pgvars">
			<cfif Not StructKeyExists(application.pgvars, "pg#page_id#")>
				<cfset StructInsert(application.pgvars, "pg#page_id#", page_code)>
			</cfif>
			<cfif Not StructKeyExists(application.pgrecap, "pg#page_id#")>
				<cfset StructInsert(application.pgrecap, "pg#page_id#", postrecap)>
			</cfif>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'optionvars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.optionvars') Or attributes.refresh>
		<cfset application.optionvars = StructNew()>
		<cfquery name="optionvars" datasource="#application.dbSrc#">
			SELECT option_id, option_code
			FROM `option`
			ORDER BY option_id
		</cfquery>
		<cfloop query="optionvars">
			<cfif Not StructKeyExists(application.optionvars, "o#option_id#")>
				<cfset StructInsert(application.optionvars, "o#option_id#", option_code)>
			</cfif>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'partnervars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.partnervars') Or attributes.refresh>
		<cfset application.partnervars = StructNew()>
		<cfquery name="partnervars" datasource="#application.dbSrc#">
			SELECT partner_id, partner_code
			FROM tbl_partner
			ORDER BY partner_id
		</cfquery>
		<cfloop query="partnervars">
			<cfif Not StructKeyExists(application.partnervars, "p#partner_id#")>
				<cfset StructInsert(application.partnervars, "p#partner_id#", partner_code)>
			</cfif>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'quotevars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.quotevars') Or attributes.refresh>
		<cfset application.quotevars = StructNew()>
		<cfquery name="quotevars" datasource="#application.dbSrc#">
			SELECT quote_id, quote_code
			FROM quote
			WHERE active=1
			ORDER BY quote_id
		</cfquery>
		<cfset application.quotevars.arr = ArrayNew(1)>
		<cfset application.quotevars.pos = 0>
		<cfloop query="quotevars">
			<cfset ArrayAppend(application.quotevars.arr, quote_code)>
		</cfloop>
	</cfif>
</cfif>
<cfif attributes.hashname eq 'cookvars' Or attributes.hashname eq ''>
	<cfif Not IsDefined('application.cookvars') Or attributes.refresh>
		<cfset application.cookvars = StructNew()>
		<cfset application.cookcityvars = StructNew()>
		<cfset application.chicagovars = StructNew()>
		<cfquery name="cookvars" datasource="#application.dbSrc#">
			select z.zipcode, c.city_name, c.city_id
			from (
				select z.zipcode, count(*) c
				from (
					select cz.zipcode
					from view_city_zip_preferred cz
					where cz.city_id='W12401'
				) z, view_city_zip_preferred cz
				where z.zipcode=cz.zipcode
				group by z.zipcode
			) z, view_city_zip_preferred cz, city c
			where z.c > 1
				and z.zipcode=cz.zipcode
				and cz.city_id != 'W12401'
				and cz.city_id=c.city_id
			order by z.zipcode
		</cfquery>
		<cfquery name="chicagoland" datasource="#application.dbSrc#">
			select z.zipcode
			from (
				select z.zipcode, count(*) c
				from (
					select cz.zipcode
					from view_city_zip_preferred cz
					where cz.city_id='W12401'
				) z, view_city_zip_preferred cz
				where z.zipcode=cz.zipcode
				group by z.zipcode
			) z
			where z.c = 1
			order by z.zipcode
		</cfquery>
		<cfloop query="cookvars">
			<cfif StructKeyExists(application.cookvars, zipcode)>
				<cfset StructUpdate(application.cookvars, zipcode, ListAppend(StructFind(application.cookvars, zipcode), city_name))>
			<cfelse>
				<cfset StructInsert(application.cookvars, zipcode, city_name)>
			</cfif>
			<cfif Not StructKeyExists(application.cookcityvars, city_name)>
				<cfset StructInsert(application.cookcityvars, city_name, city_id)>
			</cfif>
		</cfloop>
		<cfif Not StructKeyExists(application.cookcityvars, 'CHICAGO')>
			<cfset StructInsert(application.cookcityvars, 'CHICAGO', 'W12401')>
		</cfif>
		<cfloop query="chicagoland">
			<cfset StructInsert(application.chicagovars, zipcode, 'W12401')>
		</cfloop>
	</cfif>
</cfif>