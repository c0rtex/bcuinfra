<cfparam name="state" type="string" default=""> <!--- state --->
<cfparam name="statecarrier_id" type="numeric" default="0">
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


<cf_buildView title="State Carrier" name="#name#" table="statecarrier" code="subset_content" key="#statecarrier_id#" action="#action#" viewlevel="0" saving="#saving#" actionurl="statecarrier_edit.cfm?state=#state#&statecarrier_id=#statecarrier_id#" redirect="statecarrierview.cfm?id=#state####name#">
	<cf_buildViewProperty column="state_id" input="select" references="state">
	<cf_buildViewProperty column="statecarrier_id" increment="1" skipon="new">
</cf_buildView>



</cf_buildPage>
