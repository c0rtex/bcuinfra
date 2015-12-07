<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	


<!---
checkzip.cfm
Created JEngstrom
--->
<!--- BShunn 7/9/2007 Do zipcode lookup to determine input validity --->
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>
<cfquery name="postalcode" datasource="#application.dbSrc#">
	select z.zipcode, z.state_id
	from zip z, state s
	where z.zipcode='#Left(form.zip, 5)#'
		and z.valid=1
		and z.state_id=s.state_id
		and (s.statetype_id=1
       or s.state_id = 'VI')
</cfquery>
<cfif postalcode.RecordCount eq 0>
	<cflocation url="printed.cfm?partner_id=#session.partner_id#&subset_id=#subset_id#&#error#=1&zip=#zip#">
<cfelseif IsDefined('error') and error eq 'error2'>
    <cf_sessionPassVars var="redirectURL" href="full.cfm" partner_id="#session.partner_id#" subset_id="#subset_id#" state_id="#postalcode.state_id#" extralist="zip=#postalcode.zipcode#">
	<cflocation url="#redirectURL#" AddToken="No">
	<cflocation url="#redirectURL#" AddToken="No">
<cfelse>
    <cf_sessionPassVars var="redirectURL" href="fullprint.cfm" partner_id="#session.partner_id#" subset_id="#subset_id#" state_id="#postalcode.state_id#" extralist="zip=#postalcode.zipcode#">
	<cflocation url="#redirectURL#" AddToken="No">
</cfif>