<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Question Type Group" section="question">

<cf_buildView table="questiontype" code="questiontype" key="#id#" action="#action#" saving="#saving#" title="Question Type Data" editlevel="1">
	<cf_buildViewProperty column="code" limit="32" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="name" limit="64">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

</cf_buildPage>