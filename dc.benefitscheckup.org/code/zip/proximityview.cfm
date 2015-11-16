<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Individual Proximity Method" section="zip"><cfoutput>

<cf_buildView title="Individual Proximity Method" table="proximity" code="proximity" key="#id#" action="#action#" saving="#saving#">
	<cf_buildViewProperty column="code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="description" input="textarea" rows="4" limit="255">
</cf_buildView>

</cfoutput></cf_buildPage>