<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Question Format Administration" section="question"><cfoutput>

<cf_buildView table="format" code="format" key="#id#" action="#action#" saving="#saving#" editlevel="1" title="Question Format Data">
	<cf_buildViewProperty column="format_code" limit="32" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="format_name" limit="64">
	<cf_buildViewProperty column="format_desc" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>