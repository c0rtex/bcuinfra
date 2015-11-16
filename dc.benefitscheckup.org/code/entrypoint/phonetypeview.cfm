<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="4">
</cfif>

<cf_buildPage title="Individual Phone Type" section="entrypoint"><cfoutput>

<cf_buildView title="Individual Phone Type" table="phonetype" code="phonetype" key="#id#" action="#action#" saving="#saving#" editlevel="4">
	<cf_buildViewProperty column="code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="phonetype" namefrom="code" codefrom="code">
</cf_buildView>

</cfoutput></cf_buildPage>