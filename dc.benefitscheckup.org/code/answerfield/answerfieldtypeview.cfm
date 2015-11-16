<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Answerfield Type Administration" section="answerfield"><cfoutput>

<cf_buildView table="answerfieldtype" code="answerfieldtype" key="#id#" action="#action#" saving="#saving#" editlevel="1" title="Answerfield Type Data">
	<cf_buildViewProperty column="code" limit="16">
	<cf_buildViewProperty column="name" limit="64">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>