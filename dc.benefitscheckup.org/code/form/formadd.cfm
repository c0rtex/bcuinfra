<cfparam name="name" type="string" default="">
<cfparam name="tagnew" type="numeric" default="0">
<cfparam name="tag_id" type="numeric" default="0">
<cfparam name="tagline" type="string" default="">
<cfparam name="class_id" type="numeric" default="0">
<cfparam name="state_id" type="string" default="NULL">
<cfparam name="description" type="string" default="">

<cfif trim(name) eq '' Or (tagnew eq 1 And trim(tagline) eq '')>
	<cflocation url="formnew.cfm">
<cfelse>
	<cfif trim(description) eq ''>
		<cfset description = 'NULL'>
	<cfelse>
		<cfset description = "'" & Replace(description, "'", "''", 'ALL') & "'">
	</cfif>
	<cfif tagnew eq 1>
		<cfset tagline = trim(tagline)>
		<cfinclude template="taginsert.cfm">
	</cfif>
	<cfinclude template="forminsert.cfm">
	<cflocation url="formview.cfm?id=#id#">
</cfif>