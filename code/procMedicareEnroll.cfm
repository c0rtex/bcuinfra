<cfoutput>
<!--- SourceID Assigned by CMS/TogetherRx --->
<cfset SourceID = 10014 >
<!--- ReturnURL --->
<cfset ReturnURL = "http://#application.serverPath#/procMedicareResults.cfm" >
<!--- SponsorID --->
<cfset SponsorID = form.SponsorID >
<!--- TALevel --->
<cfset TALevel = form.TALevel >
<!--- MaritalStatus --->
<cfif LCase(Left(form.MaritalStatus, 1)) eq 'y'>
	<cfset MaritalStatus = 'Y'>
<cfelse>
	<cfset MaritalStatus = 'N'>
</cfif>
<!--- Zip --->
<cfset Zip = form.Zip >
<!--- Recently --->
<cfset Recently = form.Recently>
<cfif LCase(Left(form.Recently, 1)) eq 'y'>
	<cfset Recently = 'Y'>
<cfelseif LCase(Left(form.Recently, 1)) eq 'n'>
	<cfset Recently = 'N'>
<cfelse>
	<cfset Recently = ''>
</cfif>
<!--- StatePay --->
<cfif LCase(Left(form.StatePay, 1)) eq 'y'>
	<cfset StatePay = 'Y'>
<cfelseif LCase(Left(form.StatePay, 1)) eq 'n'>
	<cfset StatePay = 'N'>
<cfelse>
	<cfset StatePay = ''>
</cfif>
<!--- Referring ID --->
<cfif session.partner_id neq "0">
<cfset ReferringID = session.partner_id >
<cfelse>
<cfset ReferringID = session.org_id >
</cfif>
<cfquery name="GetShip_Code" datasource="#application.dbSrcOE#">
Select ship_code from ORGANIZATION where id = '#session.org_id#'
</cfquery>

<cfif GetShip_Code.recordcount gt 0>
	<cfset ReferringID = ReferringID & "|" & "#GetShip_Code.ship_code#">
</cfif>

<cftransaction>
<!--- create Transaction Record that user's data is being submitted --->
<cfquery name="LogTrans" datasource="#application.dbSrc#">
Insert into 
tbl_user_trans
(clientnum, DNumber)
Values
('#session.clientnum#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#SponsorID#" maxlength="25">)
</cfquery>
<cfquery name="GetTrans" datasource="#application.dbSrc#">
Select Max(trans_id) as TransNum from tbl_user_trans
</cfquery>
<!--- Trans ID --->
<cfset TransID = GetTrans.TransNum >
</cftransaction>
<cfset session.MedicareEnrollmentURL="#session.cmsserverURL#?SourceID=#SourceID#&ReturnURL=#ReturnURL#&SponsorID=#SponsorID#&TALevel=#TALevel#&MaritalStatus=#MaritalStatus#&Zip=#Zip#&Recently=#Recently#&StatePay=#StatePay#&ReferringID=#ReferringID#&TransID=#TransID#">

<cflocation url="frmMedicareFrameSet.cfm?#session.URLToken#" >
</cfoutput>