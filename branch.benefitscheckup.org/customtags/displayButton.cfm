<!---
Template Name: displayButton.cfm 
Component Purpose: Generate button sytel and display features
Data Tables: NA	
--->
<cfsilent>
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.method" type="string" default="post">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.target" type="string" default="_top">
<cfparam name="attributes.return_oe" type="boolean" default="false">

</cfsilent><cfif attributes.return_oe and (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26><cfsilent>
	<cfif IsDefined('session.oe_server_id') and session.oe_server_id neq ''>
		<cfset domainPath = "#session.oe_server_id#.benefitscheckup.org/oe">
	<cfelse>
		<cfset domainPath = "#application.serverPathOE#">
	</cfif>
	<cfif attributes.name neq ''>
		<cfset attributes.name = " name=""#attributes.name#""">
	</cfif>
	<cfif attributes.method neq ''>
		<cfset attributes.method = " method=""#attributes.method#""">
	</cfif>
	<cfif attributes.style neq ''>
		<cfset attributes.style = " style=""#attributes.style#""">
	</cfif>
	<cfif attributes.target neq ''>
		<cfset attributes.target = " target=""#attributes.target#""">
	</cfif>
	</cfsilent><cfoutput><div class="noprint"><form action="#application.transferType#://#domainPath#/menu.do"#attributes.name##attributes.method##attributes.style##attributes.target#>
		<input type="submit" value="Return to OE Home" >
	</form></div></cfoutput><cfsilent>
</cfsilent></cfif>