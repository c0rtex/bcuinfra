<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="View Help Type" section="help"><cfoutput>

<cf_buildView table="helptype" code="helptype" editlevel="1" key="#id#" action="#action#" saving="#saving#" title="Display Help Type">
	<cf_buildViewProperty column="code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="name" limit="64">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>