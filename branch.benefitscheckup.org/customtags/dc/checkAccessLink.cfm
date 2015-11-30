<cfsilent>
<cfparam name="attributes.level" type="numeric" default="1">
<cfparam name="attributes.href" type="string" default="">
<cfparam name="attributes.target" type="string" default="">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.onClick" type="string" default="">
<cfif ThisTag.ExecutionMode eq 'End' and session.level lte attributes.level>
	<!--- Builds <a> tag with appropriate fields --->
	<cfset ThisTag.GeneratedContent = ">" & ThisTag.GeneratedContent>
	<cfif attributes.onClick neq ''>
		<cfset ThisTag.GeneratedContent = " onClick=""#attributes.onClick#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.target neq ''>
		<cfset ThisTag.GeneratedContent = " target=""#attributes.target#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.style neq ''>
		<cfset ThisTag.GeneratedContent = " style=""#attributes.style#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.class neq ''>
		<cfset ThisTag.GeneratedContent = " class=""#attributes.class#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.name neq ''>
		<cfset ThisTag.GeneratedContent = " name=""#attributes.name#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfset ThisTag.GeneratedContent = "<a href=""#attributes.href#""" & ThisTag.GeneratedContent>
	<cfset ThisTag.GeneratedContent = ThisTag.GeneratedContent & "</a>">
<cfelseif ThisTag.ExecutionMode eq 'End'>
	<!--- Builds <span> tag with appropriate styling --->
	<cfset ThisTag.GeneratedContent = ">" & ThisTag.GeneratedContent>
	<cfif attributes.style neq ''>
		<cfset ThisTag.GeneratedContent = " style=""#attributes.style#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.class neq ''>
		<cfset ThisTag.GeneratedContent = " class=""#attributes.class#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfset ThisTag.GeneratedContent = "<span" & ThisTag.GeneratedContent>
	<cfset ThisTag.GeneratedContent = ThisTag.GeneratedContent & "</span>">
</cfif>
</cfsilent>