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

<cf_buildPage title="Funder" section="misc">

<cf_buildView table="funder" code="funder" key="#id#" action="#action#" saving="#saving#" title="Funder">
	<cf_buildViewProperty column="name" limit="255" input="textarea">
	<cf_buildViewProperty column="legacy_code" visible="viewonly">
</cf_buildView>

</cf_buildPage>