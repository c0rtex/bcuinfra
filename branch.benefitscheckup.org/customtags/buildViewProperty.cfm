<cfparam name="attributes.column" type="string">
<cfparam name="attributes.group" type="string" default="">
<cfparam name="attributes.namefrom" type="string" default="">
<cfparam name="attributes.codefrom" type="string" default="">
<cfparam name="attributes.increment" type="numeric" default="0">
<cfparam name="attributes.input" type="string" default="text">
<cfparam name="attributes.bindto" type="string" default="">
<cfparam name="attributes.bindoptionskey" type="string" default="">
<cfparam name="attributes.bindid" type="string" default="">
<cfparam name="attributes.yes" type="string" default="Yes">
<cfparam name="attributes.no" type="string" default="No">
<cfparam name="attributes.default" type="string" default="">
<cfparam name="attributes.size" type="numeric" default="50">
<cfparam name="attributes.limit" type="numeric" default="0">
<cfparam name="attributes.restriction" type="string" default="">
<cfparam name="attributes.case" type="string" default="">
<cfparam name="attributes.cols" type="numeric" default="50">
<cfparam name="attributes.rows" type="numeric" default="5">
<cfparam name="attributes.prefix" type="string" default="">
<cfparam name="attributes.references" type="string" default="">
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.selectrequiredwhen" type="string" default="">
<cfparam name="attributes.order" type="string" default="">
<cfparam name="attributes.visible" type="string" default="true">
<cfparam name="attributes.value" type="string" default="">
<cfparam name="attributes.skipon" type="string" default="">
<cfparam name="attributes.valueonadd" type="string" default="">
<cfparam name="attributes.nullvalue" type="any" default="">
<cfparam name="attributes.link" type="string" default="">
<cfparam name="attributes.addlink" type="string" default="">
<cfparam name="attributes.addlevel" type="numeric" default="3">
<cfparam name="attributes.user" type="string" default="">
<cfparam name="attributes.message" type="string" default="">
<cfparam name="attributes.valuetovar" type="string" default="">
<cfparam name="attributes.validateagainst" type="string" default="">

<cfif ListFindNoCase(GetBaseTagList(), 'cf_buildView')>
	<cfassociate basetag="cf_buildView">
</cfif>