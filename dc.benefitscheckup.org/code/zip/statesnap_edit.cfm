<cfparam name="state" type="string" default=""> <!--- state --->
<cfparam name="state_snap_id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0"> 
<cfparam name="name" type="string" default="">
<cfparam name="action" type="string" default="new">

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



<cf_buildPage title="Edit State Carriers">


<cf_buildView title="State SNAP Seniors" name="#name#" table="state_snap" code="state_snap" key="#state_snap_id#" action="#action#" viewlevel="0" saving="#saving#" actionurl="statesnap_edit.cfm?state=#state#&state_snap_id=#state_snap_id#" redirect="statesnapview.cfm?id=#state####name#">
	<cf_buildViewProperty column="state_id" input="select" references="state">
	<cf_buildViewProperty column="state_snap_id" increment="1" skipon="new">
	<cf_buildViewProperty column="required_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="exclude_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="options_flag" visible="false" valueonadd="0">
</cf_buildView>



</cf_buildPage>
