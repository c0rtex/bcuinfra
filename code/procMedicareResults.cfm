<cfif isdefined('url.confirmationNumber')>
	<cfset ConfirmationNumber = url.ConfirmationNumber >
<CFELSE>
	<cfset ConfirmationNumber = "" >
</cfif>

<cfif isdefined('url.SubmitDate')>
	<cfset SubmitDate = url.SubmitDate >
<CFELSE>
	<cfset SubmitDate = "" >
</cfif>
<cfif isdefined('url.FirstName')>
	<cfset FirstName = url.FirstName >
<CFELSE>
	<cfset FirstName = "" >
</cfif>

<cfif isdefined('url.LastName')>
	<cfset LastName = url.LastName >
<CFELSE>
	<cfset LastName = "" >
</cfif>

<cfif isdefined('url.DOB')>
	<cfset DOB = url.DOB >
<CFELSE>
	<cfset DOB = "" >
</cfif>

<cfif isdefined('url.Zip')>
	<cfset Zip = url.Zip >
<CFELSE>
	<cfset Zip = "" >
</cfif>


<cfif isdefined('url.SponsorID')>
	<cfset SponsorID = url.SponsorID >
<CFELSE>
	<cfset SponsorID = "" >
</cfif>

<cfif isdefined('url.SourceID')>
	<cfset SourceID = url.SourceID >
<CFELSE>
	<cfset SourceID = "" >
</cfif>

<cfif isdefined('url.ReferringID')>
	<cfset ReferringID = url.ReferringID >
<CFELSE>
	<cfset ReferringID = "" >
</cfif>
<cfif isdefined('url.TransID')>
	<cfset TransID = url.TransID >
<CFELSE>
	<cfset TransID = "" >
</cfif>
<cfquery name="GetSession" datasource="#application.dbSrc#">
select urltoken
from tbl_user_trans
where trans_id = '#TransID#'
</cfquery>
<cfif GetSession.recordcount gt 0>
<cfset session.urltoken = #GetSession.URLToken#>
</cfif>
<cfif isdefined('session.clientnum')>
<cfquery name="GetPrgs" datasource="#application.dbSrc#">
Insert into 
tbl_user_ta
(clientnum, ConfirmationNumber, SubmitDate, FirstName, LastName, DOB, Zip, SponsorID, SourceID, ReferringID, TransID)
Values
('#session.clientnum#','#ConfirmationNumber#','#SubmitDate#','#FirstName#','#LastName#','#DOB#','#Zip#','#SponsorID#','#SourceID#','#ReferringID#','#TransID#')
</cfquery>
</cfif>
<cflocation url="dspEnrollComplete.cfm" addtoken="yes">
