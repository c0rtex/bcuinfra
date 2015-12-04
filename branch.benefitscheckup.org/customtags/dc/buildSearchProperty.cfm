<cfparam name="attributes.column" type="string">
<cfparam name="attributes.input" type="string" default="">
<cfparam name="attributes.size" type="numeric" default="0">
<cfparam name="attributes.maxlength" type="numeric" default="0">
<cfparam name="attributes.references" type="string" default="">
<cfparam name="attributes.visible" type="string" default="true">
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.default" type="any" default="">

<cfif ListFindNoCase(GetBaseTagList(), 'cf_buildSearch')>
	<cfassociate basetag="cf_buildSearch">
</cfif>