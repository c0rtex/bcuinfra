<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Grid Row" section="question"><cfoutput>

<cf_buildView table="gridrow" code="gridrow" editlevel="1" key="#id#" action="#action#" saving="#saving#" title="Grid Row Data">
	<cf_buildViewProperty column="code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="gridrow" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="help_id" input="select" references="help">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
	<cf_buildViewProperty column="exclude_flag" input="flag" default="no">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

</cfoutput></cf_buildPage>