<cfparam name="attributes.id" type="numeric">
<cfparam name="attributes.action" type="string" default="view">
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.key" type="string">
<cfparam name="attributes.column" type="string">
<cfparam name="attributes.deflectValueList" type="string">
<cfparam name="attributes.deflectURLList" type="string">

<cfquery name="getVal" datasource="#application.dbSrc#">
	select #attributes.column# as deflect
	from #attributes.table#
	where #attributes.key#=#attributes.id#
</cfquery>

<cfif getVal.RecordCount>
	<cfset deflectIndex = ListFind(attributes.deflectValueList, getVal.deflect)>
	<cfif deflectIndex>
		<cfset deflectURL = ListGetAt(attributes.deflectURLList, deflectIndex)>
		<cfset deflectURL = Replace(deflectURL, '[[id]]', attributes.id, 'ALL')>
		<cfset deflectURL = Replace(deflectURL, '[[action]]', attributes.action, 'ALL')>
		<cflocation url="#deflectURL#" addtoken="no">
	</cfif>
</cfif>