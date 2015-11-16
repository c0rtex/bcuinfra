<cfparam name="attributes.subset" type="string" default="bcu">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.rxscale" type="numeric" default="10">
<cfparam name="attributes.bcuscale" type="numeric" default="50">
<cfif FindNoCase('governmentguide', application.serverPath) gt 0>
	<cf_updateTally>
	<cfif attributes.subset eq 'rx'>
		<cfquery name="prgcount" datasource="#application.dbSrc#">
			SELECT rx c
		    FROM tbl_tally
		</cfquery>
		<cfset scale=attributes.rxscale>
	<cfelse>
		<cfquery name="prgcount" datasource="#application.dbSrc#">
			SELECT bcu c
		    FROM tbl_tally
		</cfquery>
		<cfset scale=attributes.bcuscale>
	</cfif>
<cfelse>
	<cfif attributes.subset eq 'pap'>
		<cf_populateTableFromView table="subset_program_base" subset_id="19">
		<cfquery name="prgcount" datasource="#application.dbSrc#">
			SELECT count(*) AS c
		    FROM subset_program_base
			WHERE subset_id=19
		</cfquery>
		<cfset scale=attributes.rxscale>
	<cfelseif attributes.subset eq 'rx'>
		<cfquery name="prgcount" datasource="#application.dbSrc#">
			SELECT rx c
		    FROM view_tally
		</cfquery>
		<cfset scale=attributes.rxscale>
	<cfelse>
		<cfquery name="prgcount" datasource="#application.dbSrc#">
			SELECT bcu c
		    FROM view_tally
		</cfquery>
		<cfset scale=attributes.bcuscale>
	</cfif>
</cfif>
<cf_integerRoundOver num="#prgcount.c#" scale="#scale#" var="outstr">
<cf_integerSeparate num="#outstr#" var="outstr">
<cfif attributes.var eq "">
	<cfoutput>#outstr#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outstr>
</cfif>