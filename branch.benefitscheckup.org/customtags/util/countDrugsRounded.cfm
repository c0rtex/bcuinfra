<cfparam name="attributes.type" type="string" default="all">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.brandscale" type="numeric" default="10">
<cfparam name="attributes.genericscale" type="numeric" default="50">
<cfparam name="attributes.drugscale" type="numeric" default="50">
<cfif FindNoCase('governmentguide', application.serverPath) gt 0>
	<cf_updateTally>
	<cfif attributes.type eq 'brandname'>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT brand
			FROM tbl_tally
		</cfquery>
		<cfset tally=drugcount.brand>
		<cfset scale=attributes.brandscale>
	<cfelseif attributes.type eq 'generic'>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT generic
			FROM tbl_tally
		</cfquery>
		<cfset tally=drugcount.generic>
		<cfset scale=attributes.genericscale>
	<cfelse>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT drug
			FROM tbl_tally
		</cfquery>
		<cfset tally=drugcount.drug>
		<cfset scale=attributes.drugscale>
	</cfif>
<cfelse>
	<cfif attributes.type eq 'brandname'>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT brand
			FROM view_tally
		</cfquery>
		<cfset tally=drugcount.brand>
		<cfset scale=attributes.brandscale>
	<cfelseif attributes.type eq 'generic'>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT generic
			FROM view_tally
		</cfquery>
		<cfset tally=drugcount.generic>
		<cfset scale=attributes.genericscale>
	<cfelse>
		<cfquery name="drugcount" datasource="#application.dbSrc#">
			SELECT drug
			FROM view_tally
		</cfquery>
		<cfset tally=drugcount.drug>
		<cfset scale=attributes.drugscale>
	</cfif>
</cfif>
<cf_integerRoundOver num="#tally#" scale="#scale#" var="outstr">
<cf_integerSeparate num="#outstr#" var="outstr">
<cfif attributes.var eq "">
	<cfoutput>#outstr#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outstr>
</cfif>