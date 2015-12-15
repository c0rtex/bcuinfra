<cfparam name="attributes.column" type="string">
<cfparam name="attributes.visible" type="string" default="true">
<cfparam name="attributes.references" type="string" default="">
<cfparam name="attributes.display" type="string" default="">
<cfparam name="attributes.displaygroup_id" type="numeric" default="0">

<cfif ListFindNoCase(GetBaseTagList(), 'cf_buildList')>
	<cfassociate basetag="cf_buildList">
</cfif>