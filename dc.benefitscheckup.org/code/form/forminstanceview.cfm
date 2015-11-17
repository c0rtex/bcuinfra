<cfparam name="form_id" type="numeric" default="0">
<cfparam name="formtype_id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="0"><!--- prevent form_formtype from ever being edited through this interface --->
</cfif>

<cf_buildPage title="Individual Form Instance" section="form">

<cf_buildView title="Individual Form Instance" table="form_formtype" code="forminstance" key="#form_id#,#formtype_id#" action="#action#" saving="#saving#" editurl="typeedit.cfm?form_id=[[form_id]]&type_id=[[formtype_id]]">
	<cf_buildViewProperty column="form_id" input="select" references="form">
	<cf_buildViewProperty column="formtype_id" input="select" references="formtype">
	<cf_buildViewProperty column="active" input="flag">
	<cf_buildViewProperty column="form_date" input="date">
	<cf_buildViewProperty column="form_day_ignore_flag" visible="false">
	<cf_buildViewProperty column="entry_date" input="date">
	<cf_buildViewProperty column="entry_day_ignore_flag" visible="false">
</cf_buildView>

</cf_buildPage>