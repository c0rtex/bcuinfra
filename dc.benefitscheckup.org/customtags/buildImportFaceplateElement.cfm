<cfparam name="attributes.goto" type="string">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.section" type="string" default="">
<cfif ListFindNoCase(GetBaseTagList(), 'cf_buildImportFaceplate')>
<cfassociate basetag="cf_buildImportFaceplate"></cfif>