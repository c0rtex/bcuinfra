<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Question Header" section="question">

<cf_buildView table="questionheader" code="questionheader" key="#id#" action="#action#" saving="#saving#" title="Question Header Data" editlevel="1">
	<cf_buildViewProperty column="code" limit="64" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="display_id" input="display" rows="6" group="queshead" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

</cf_buildPage>