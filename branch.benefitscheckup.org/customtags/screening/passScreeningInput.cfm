<!--- Created by BShunn 2005/09/28 --->
<cfparam name="attributes.varname" type="string" default="">
<cfparam name="attributes.aflist" type="string" default="">
<cfparam name="attributes.pgcode" type="string" default="">
<cfparam name="attributes.pgno" type="string" default="">
<cfif attributes.varname neq ''>
	<cfset psiList = Evaluate("caller.#attributes.varname#")>
<cfelseif attributes.aflist neq ''>
	<cfset psiList = attributes.aflist>
<cfelse>
	<cfset psiList = ''>
</cfif>
<cfif attributes.pgno neq ''>
	<cfset session.screening.pgno = attributes.pgno>
<cfelseif attributes.pgcode neq ''>
	<cfif Not IsDefined('session.screening.pg')>
		<cfset session.screening.pg = StructNew()>
	</cfif>
	<cfif StructKeyExists(session.screening.pg, attributes.pgcode)>
		<cfset session.screening.pgno = StructFind(session.screening.pg, attributes.pgcode)>
	<cfelse>
		<cfset StructInsert(session.screening.pg, attributes.pgcode, session.screening.pgno)>
	</cfif>
	<cfif Not IsDefined('session.screening.qpg')>
		<cfset session.screening.qpg = StructNew()>
	</cfif>
	<cfif StructKeyExists(session.screening.qpg, attributes.pgcode)>
		<cfset session.screening.qno = StructFind(session.screening.qpg, attributes.pgcode)>
	<cfelse>
		<cfset StructInsert(session.screening.qpg, attributes.pgcode, session.screening.qno)>
	</cfif>
</cfif>
<cfoutput><input type="hidden" name="pgno" value="#session.screening.pgno#">
<cfif IsDefined("session.screening.qno") and session.screening.qno gt 0>
<input type="hidden" name="qno" value="#session.screening.qno#">
<cfelse>
<input type="hidden" name="qno" value="#session.screening.qnum#">
<input type="hidden" name="qnum" value="1">
</cfif>
<input type="hidden" name="aflist" value="#psiList#"></cfoutput>