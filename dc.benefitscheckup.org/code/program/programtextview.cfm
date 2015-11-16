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

<cf_buildPage title="Recommendations Administration" section="program">

<cf_buildView table="programtext" code="programtext" key="#id#" action="#action#" saving="#saving#" title="Recommendations Data">
	<cf_buildViewProperty column="rec" input="textarea" rows="10" cols="70">
	<cf_buildViewProperty column="summary" input="textarea" rows="4" cols="70">
	<cf_buildViewProperty column="program_id" input="select" references="program" link="programview.cfm?id=[[id]]">
	<cf_buildViewProperty column="type" limit="50">
	<cf_buildViewProperty column="benefits" size="10">
	<cf_buildViewProperty column="actions" visible="false">
	<cf_buildViewProperty column="Active" input="flag" default="yes">
	<cf_buildViewProperty column="alt_rec" visible="false">
	<cf_buildViewProperty column="alt_summary" visible="false">
</cf_buildView>

</cf_buildPage>