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

<cf_buildPage title="Individual Program Group" section="program">

<cf_buildView table="programgroup" code="programgroup" key="#id#" action="#action#" saving="#saving#" title="Individual Program Group">
	<cf_buildViewProperty column="code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="prggroup" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="blurb_display_id" input="display" rows="5" group="prggrpblurb" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

</cf_buildPage>