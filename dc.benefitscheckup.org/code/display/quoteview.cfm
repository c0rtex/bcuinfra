<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="Home Page Quote Administration" section="display">

<cf_buildView title="Home Page Quote" table="quote" code="quote" editlevel="2" key="#id#" action="#action#" saving="#saving#">
	<cf_buildViewProperty column="quote_code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="display_id" input="display" rows="6" group="quote" namefrom="quote_code" codefrom="quote_code">
	<cf_buildViewProperty column="active" input="checkbox">
</cf_buildView>

</cf_buildPage>