<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="Validation Administration" section="answerfield"><cfoutput>

<cf_buildView table="validation" code="validation" key="#id#" action="#action#" saving="#saving#" editlevel="2" title="Validation Data">
	<!--- MH : Bug 5147 Allow User Level 2 to edit only Error and Description on Individual Validation Page --->
	<cfif IsDefined('session.level') and session.level gte 2>
    	<cf_buildViewProperty column="validation_code" limit="32" visible="disableonedit">
        <cf_buildViewProperty column="formula" input="textarea" visible="disableonedit">
    <cfelse>
    	<cf_buildViewProperty column="validation_code" limit="32">
        <cf_buildViewProperty column="formula" input="textarea">
    </cfif>
    <cf_buildViewProperty column="display_id" input="display" rows="4" group="valid" namefrom="validation_code" codefrom="validation_code">
	<cf_buildViewProperty column="validation_desc" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>