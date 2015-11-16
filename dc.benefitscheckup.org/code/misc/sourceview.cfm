<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Source" section="misc">

<cf_buildView table="source" code="source" key="#id#" action="#action#" saving="#saving#" title="Source">
	<cf_buildViewProperty column="source_code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="source_name" limit="64" input="textarea" rows="2">
</cf_buildView>

</cf_buildPage>