<cfparam name="attributes.href" type="string">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.section" type="string" default="">

<cfif ListFindNoCase(GetBaseTagList(), 'cf_buildExportFaceplate')>
	<cfassociate basetag="cf_buildExportFaceplate">
</cfif>