<cfparam name="subset_id" type="numeric">
<cfparam name="post_code" type="string">
<cfparam name="section_code" type="string">
<cfparam name="saving" type="numeric" default="0"> 
<cfparam name="name" type="string" default="">
<cfparam name="action" type="string" default="delete">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>



<cfquery name="scdelete" datasource="#application.dbSrc#">
	delete from subset_content
	where subset_id=#subset_id#
		and post_code='#post_code#'
</cfquery>


<cflocation addtoken="no" url="subsetview.cfm?id=#subset_id###afAssociate">


