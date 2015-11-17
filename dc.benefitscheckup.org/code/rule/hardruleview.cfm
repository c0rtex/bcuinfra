<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linkname" type="string" default="">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="1">
</cfif>

<cf_buildPage title="Hardcoded Rule" section="rule">

<cf_buildView table="hardrule" code="hardrule" editlevel="1" key="#id#" action="#action#" saving="#saving#" title="Hardcoded Rule">
	<cf_buildViewProperty column="code" limit="64" case="lower" restriction="alphanumeric">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<cf_buildList name="answerfieldAssociate" table="answerfield" code="answerfield" title="Associated Answerfields" crossaddlevel="1" crossdeletelevel="1" key="#id#" crosstable="hardrule_answerfield" crosscolumn="hardrule_id" crossvalue="#id#" crossorder="a.answerfield" linkname="#linkname#" linksection="answerfield" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkhassort="false" linkid="#linkid#" linkaction="#linkaction#">
		<cf_buildListProperty column="answerfieldtype_id" references="answerfieldtype">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="short_display_id" visible="false">
		<cf_buildListProperty column="spq_display_id" visible="false">
		<cf_buildListProperty column="print_display_id" visible="false">
		<cf_buildListProperty column="max_length" visible="false">
		<cf_buildListProperty column="default_value" visible="false">
		<cf_buildListProperty column="spq_default_value" visible="false">
		<cf_buildListProperty column="oe_default_value" visible="false">
		<cf_buildListProperty column="required_flag" visible="false">
		<cf_buildListProperty column="rx_required_flag" visible="false">
		<cf_buildListProperty column="rule_id" visible="false">
		<cf_buildListProperty column="validation_id" visible="false">
		<cf_buildListProperty column="answerfield_desc" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

</cfif>

</cf_buildPage>