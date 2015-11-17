<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Program Value Administration" section="tote">

<cf_buildView table="programvalue" code="programvalue" key="#id#" action="#action#" saving="#saving#" title="Program Value Data">
	<cf_buildViewProperty column="program_id" input="select" references="program" link="../program/programview.cfm?id=[[id]]">
	<cf_buildViewProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
	<cf_buildViewProperty column="dollarvalue" input="dollar">
	<cf_buildViewProperty column="start_date" input="date">
	<cf_buildViewProperty column="end_date" input="date">
	<cf_buildViewProperty column="rule_text" visible="false">
</cf_buildView>

</cf_buildPage>