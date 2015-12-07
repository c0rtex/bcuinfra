<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="url.pdf" default="false">
<cfif 1 eq 1>
	<cfif session.screening.id gt 0>
		<!--- UPDATE screening.end_datetime in database --->
		<cfquery name="logScreeningEnd" datasource="#application.dbSrc#">
			UPDATE screening 
			SET end_datetime=#CreateODBCDateTime(Now())#
			WHERE screening_id=#session.screening.id#
		</cfquery>
	</cfif>
<cfinclude template="esi_debugging.cfm">
</cfif>
<cfset session.screening.prepopulate = 1>
