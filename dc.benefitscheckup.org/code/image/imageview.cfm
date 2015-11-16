<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Image Administration" section="image"><cfoutput>

<cf_buildView table="image" code="image" key="#id#" action="#action#" saving="#saving#" title="Image Data">
	<cf_buildViewProperty column="code" limit="64" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="filename" limit="255" input="image">
	<cf_buildViewProperty column="width" size="6">
	<cf_buildViewProperty column="height" size="6">
	<cf_buildViewProperty column="alt_display_id" input="display" group="imgalt" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>