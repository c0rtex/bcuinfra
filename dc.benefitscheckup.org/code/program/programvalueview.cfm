<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_program_id" type="string" default="">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Program Value Administration" section="program">

<cf_buildView name="#name#" table="programvalue" code="programvalue" key="#id#" action="#action#" saving="#saving#" title="Program Value Data">
	<cf_buildViewProperty column="program_id" input="select" references="program" skipon="edit" link="programview.cfm?id=[[id]]#anchorname#" valueonadd="#new_program_id#">
	<cf_buildViewProperty column="state_id" input="select" references="state" condition="statetype_id=1  or state_id = 'VI'">
	<cf_buildViewProperty column="dollarvalue" input="dollar">
	<cf_buildViewProperty column="start_date" input="date">
	<cf_buildViewProperty column="end_date" input="date">
	<cf_buildViewProperty column="rule_text" visible="disableonedit">
</cf_buildView>

</cf_buildPage>