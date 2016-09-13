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

<cf_buildPage title="MSP Assets Administration" section="lookup">

<cf_buildView title="MSP Assets Data" table="tbl_mx_asset" code="msp" key="#id#" actionurl="mxassetview.cfm" action="#action#" saving="#saving#" viewurl="mxassetview.cfm?id=#id#" editurl="mxassetview.cfm?id=#id#&action=edit">
	<cf_buildViewProperty column="tbl_id" visible="disableonedit">
	<cf_buildViewProperty column="tbl_nm" input="select" references="self">
	<cf_buildViewProperty column="st" input="select" references="state" condition="statetype_id=1 or state_id = 'VI'">
</cf_buildView>

</cf_buildpage>