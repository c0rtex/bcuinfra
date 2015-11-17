<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Screening Page Administration" section="subset"><cfoutput>

<cf_buildView table="page" code="page" key="#id#" action="#action#" saving="#saving#" title="Screening Page Data">
	<cf_buildViewProperty column="subset_id" visible="false">
	<cf_buildViewProperty column="page_code" limit="32" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="title_display_id" input="display" rows="2" cols="60" group="pgtitle" namefrom="page_code" codefrom="page_code">
	<cf_buildViewProperty column="display_id" input="display" rows="8" cols="60" group="page" namefrom="page_code" codefrom="page_code">
	<cf_buildViewProperty column="page_desc" input="textarea" limit="255">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

</cfoutput></cf_buildPage>