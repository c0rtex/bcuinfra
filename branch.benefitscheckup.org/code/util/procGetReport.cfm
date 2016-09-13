<cfparam name = "url.clientnum" default="00" type="numeric" >
<cfparam name = "WhereToDisplay" default="inBCU" type="string">
<cfparam name = "url.s" default="1" type="numeric">
<cfset session.screening = StructNew()>
<cfset session.prg_list = ''>
<cfset session.buff_list = ''>
<cfset session.zipradius = 100>
<cfset session.strclient = 'self'>

<!-- Get OE Server Name -->
<cf_tagIdentifyServer>
<cfif isdefined('url.source') and url.source eq "webservice">
	<cflocation url="../pdf/23549484-179126-43001399.pdf" AddToken="No">
</cfif>

 
<cfset clientnum = url.clientnum>
<cfif isdefined('url.client_id')>
	<cfset session.client_id = url.client_id>
<cfelse>
	<cfset session.client_id = 'null'>
</cfif>

<cfif isdefined('url.unique_id')>
	<cfset session.unique_id = url.unique_id>
</cfif>
<cfif IsDefined('url.subset_id')>
	<cfset session.subset_id = url.subset_id>
</cfif>


<cfif url.s eq 0>
	<cfquery name="GetUserPrgs" datasource="#application.dbSrc#">
	SELECT prg_id
	FROM tbl_user_prgid
	WHERE clientnum = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
<cfelseif url.s eq 1>
	<cfquery name="GetUserPrgs" datasource="#application.dbSrc#">
	SELECT     program.legacy_prg_id as prg_id
	FROM         screening_program INNER JOIN
	program ON screening_program.program_id = program.program_id 
	and screening_id = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
</cfif>

<cfif GetUserPrgs.recordCount is "0">
	<cfoutput><h3>Sorry, there is no report available for this client id.</h3></cfoutput>
	<cfabort>
</cfif>
<cfset session.regeneratedReport = 1 >
<cfif not isdefined('session.client_id') or session.client_id eq 'null'>
<cfif url.s eq 0>
	<cfquery name="GetClientID" datasource="#application.dbSrc#">
	SELECT client_id
	FROM tbl_user_info
	WHERE clientnum = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
<cfelseif url.s eq 1>
	<cfquery name="GetClientID" datasource="#application.dbSrc#">
	SELECT client_id
	FROM screening
	WHERE screening_id  = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
</cfif>
	<cfset session.client_id = #GetClientID.client_id# >
</cfif>


<cfif url.s eq 0>
	<cfquery name="GetUserData" datasource="#application.dbSrc#">
	SELECT wantChips, County, ST, ZIP, City, cso_id, idnumber
	FROM tbl_user_ans
	WHERE clientnum = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
	<cfif GetUserData.RecordCount>
		<cfquery name="GetOrgData" datasource="#application.dbSrcOE#">
		SELECT id
		FROM ORGANIZATION
		WHERE cso_id=#GetUserData.cso_id#
		</cfquery>
		<cfif GetOrgData.RecordCount>
			<cfset oldStyleCSOID = GetOrgData.id>
		<cfelse>
			<cfset oldStyleCSOID = 0>
		</cfif>
	<cfelse>
		<cfset oldStyleCSOID = 0>
	</cfif>
	<cfset localPartnerID = GetUserData.idnumber>
	<cfif localPartnerID eq ''>
		<cfset localPartnerID = 0>
	</cfif>
<cfelseif url.s eq 1>
	<cfquery name="GetUserData" datasource="#application.dbSrc#">
	select org_id, partner_id, screening_id from screening
	WHERE screening_id = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">)
	</cfquery>
</cfif>
<cfif GetUserData.recordCount is "0">
	<cfoutput>Sorry, there is no report available for this client id.</cfoutput>
	<cfabort>
</cfif>

<!--- Put GetUserPrgs in a list --->
<cfset session.prg_list = QuotedValueList(GetUserPrgs.prg_id, ',')>

<!--- BShunn 02/25/05  Remove Generic Drugs from the program list and display separately --->
<cfset genericnum=ListContains(session.prg_list, "XXX-311-2387-FD-FD")>
<cfif genericnum gt 0>
	<cfset session.prg_list=ListDeleteAt(session.prg_list, genericnum)>
	<cfset session.genericdrugs = "y">
<cfelse>
	<cfset session.genericdrugs = "n">
</cfif>

<cfif url.s eq 0 >
	<!-- Get User Data for old  Schema -->
	<cfset session.wantchips = "#GetUserData.wantChips#">
	<cfset session.county = "#GetUserData.County#">
	<cfset session.city = "#GetUserData.City#">
	<cfset session.zip = "#GetUserData.ZIP#">
	<cfset session.ST = "#GetUserData.ST#">
	<cf_sessionPassVars var="redirectURL" href="#application.transferType#://#application.serverPath#/frmreportoptions.cfm" partner_id="#localPartnerID#" org_id="#oldStyleCSOID#" extralist="report_only=1">
<cfelseif url.s eq 1 >
	<!-- Get User Data for New Schema -->
	<cfset session.wantchips = "N">
	<cfquery name="GetVars" datasource="#application.dbSrc#">
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = ( <cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">) and answerfield_id = (4341) 
	</cfquery>
	<cfif GetVars.RecordCount gt 0>
		<cfset session.wantchips = GetVars.response>
	</cfif>
	<cfset session.county = 0>
	<cfquery name="GetVars" datasource="#application.dbSrc#">
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = ( <cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">) and answerfield_id = (47) 
	</cfquery>
	<cfif GetVars.RecordCount gt 0>
		<cfset session.county = GetVars.response>
	</cfif>
	<cfset session.city = 0>
	<cfquery name="GetVars" datasource="#application.dbSrc#">
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">) and answerfield_id = (542) 
	</cfquery>
	<cfif GetVars.RecordCount gt 0>
		<cfset session.city = GetVars.response>
	</cfif>
	<cfset session.st = 0>
	<cfquery name="GetVars" datasource="#application.dbSrc#">
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">) and answerfield_id = (177) 
	</cfquery>
	<cfif GetVars.RecordCount gt 0>
		<cfset session.st = GetVars.response>
	</cfif>
	<cfset session.zip = 0>
	<cfquery name="GetVars" datasource="#application.dbSrc#">
		SELECT     response
		FROM         screening_answerfield INNER JOIN
        tbl_answerfield_list ON screening_answerfield.answerfield_id = tbl_answerfield_list.RecID
		WHERE     screening_answerfield.screening_id = (<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">) and answerfield_id = (543) 
	</cfquery>
	<cfif GetVars.RecordCount gt 0>
		<cfset session.zip = GetVars.response>
	</cfif>
	<cf_sessionPassVars var="redirectURL" href="#application.transferType#://#application.serverPath#/cf/frmreportoptions.cfm" partner_id="#GetUserData.partner_id#" org_id="#GetUserData.org_id#" extralist="report_only=1">
</cfif>

<!-- Relocate to report options page  -->
<cflocation url="#redirectURL#" AddToken="No">