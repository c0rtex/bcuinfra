<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelseif action eq 'new'>
	<cf_checkAccess level="1">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="MSP Income Administration" section="lookup">

<cf_buildView title="MSP Income Data" table="tbl_mx_income" code="msp" key="#id#" actionurl="mxincomeview.cfm" action="#action#" saving="#saving#" viewurl="mxincomeview.cfm?id=#id#" editurl="mxincomeview.cfm?id=#id#&action=edit">
	<cf_buildViewProperty column="tbl_id" visible="disableonedit">
	<cf_buildViewProperty column="tbl_nm" input="select" references="self">
	<cf_buildViewProperty column="st" input="select" references="state" condition="statetype_id=1  or state_id = 'VI'">
</cf_buildView>

</cf_buildpage>