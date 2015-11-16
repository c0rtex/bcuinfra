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

<cf_buildPage title="MSP Income Search" section="lookup">

<cf_buildSearch title="MSP Income Search" table="tbl_mx_income" code="msp" actionurl="mxincomelist.cfm">
	<cf_buildSearchProperty column="tbl_nm" input="select" references="self">
	<cf_buildSearchProperty column="st" input="select" references="state" condition="statetype_id=1  or state_id = 'VI'">
</cf_buildSearch>

</cf_buildpage>