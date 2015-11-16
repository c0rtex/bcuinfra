<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Individual Form Tag" section="form">

<cf_buildView title="Individual Form Tag" table="formtag" code="formtag" key="#id#" action="#action#" saving="#saving#" extraurllist="formtagdelete.cfm?id=#id#" extranamelist="delete">
	<cf_buildViewProperty column="formclass_id" input="select" references="formclass">
	<cf_buildViewProperty column="tag_name" input="textarea" rows="2" limit="255">
</cf_buildView>

<cfif action eq 'view' or hasSaved>
	
	<br />
	<cf_buildList title="Forms Using This Form Tag" table="form" code="form" condition="f.formtag_id=#id#" editlink="formedit.cfm?id=[[id]]" orderlinks="false">
		<cf_buildListProperty column="formtag_id" visible="false">
		<cf_buildListProperty column="description" visible="false">
		<cf_buildListProperty column="state_id" references="state">
	</cf_buildList>

</cfif>

</cf_buildPage>