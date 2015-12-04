<cfsetting showdebugoutput="no" enablecfoutputonly="yes">
<cfparam name="program_id" default="0">
<cfparam name="suppressOfficesLink" default="false">
<cfparam name="zipcode" default="">
<cfparam name="mode" default="screen">
<cfparam name="source" default="">
<cfparam name="city_id" default="">
<cfparam name="county" default="">
<cfparam name="state" default="">
<cfparam name="outStr" default="">
<cfparam name="proximityOverride" default="">
<cfparam name="radius" default="100">
<cfparam name="limit" default="3">
<cfparam name="append" default="false">
<cfparam name="suppressText" default="false">
<cfparam name="google" default="false">
<cfparam name="wrapUrl" default="true">
<cfif session.mZip NEQ "">
	<cfset zipcode = session.mZip>
</cfif>
<cfif session.mState NEQ "">
	<cfset state = session.mState>
</cfif>
<cfif session.mCounty NEQ "">
	<cfset county_id = session.mCounty>
</cfif>

<cfif zipcode IS "" AND session.mProgram NEQ 1933>
	<cfset outStr = outStr & "To find your State Health Insurance Program office, please enter a zip below.">
</cfif>
<cf_proximityLocal entrypointgroup_id="83" zipcode="#zipcode#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#suppressOfficesLink#">
<cfoutput>
    #outStr#
</cfoutput>