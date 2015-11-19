<cfparam name="attributes.prg_num" type="numeric" default="1">
<cfparam name="attributes.prg_id" type="string">
<cfparam name="attributes.outvar" type="string" default="strpprout">
<cfparam name="attributes.pgbreaks" type="boolean" default="true">
<cfparam name="attributes.prgdesc" type="boolean" default="true">
<cfparam name="attributes.prgeps" type="boolean" default="true">
<cfparam name="attributes.prgepnum" type="numeric" default="3">
<cfparam name="attributes.prgreqmat" type="boolean" default="true">

<cfif attributes.prgepnum lt 1>
	<cfset attributes.prgeps = false>
</cfif>

<cfset rdOut = "">
<cfset intCellPad="0">
<cfset intFontSize="3">

<cfset rdOut = rdOut & "<table width=100% border=0 align=center cellpadding=#intCellPad# cellspacing=2>">
<cfset rdOut = rdOut & "<tr>">
<cfset rdOut = rdOut & "<td bgcolor=##ffffff colspan=2>">
<cfset rdOut = rdOut & "<font face=arial size=#intFontSize# color=##000000>">

<cfif IsDefined('session.county') and session.county neq '0'>
	<cfset passCounty = session.county>
<cfelse>
	<cfset passCounty = ''>
</cfif>
<cfif IsDefined('session.st')>
	<cfset passState = session.st>
<cfelseif IsDefined('session.state_id')>
	<cfset passState = session.state_id>
<cfelse>
	<cfset passState = ''>
</cfif>
<cfif IsDefined('session.zip') and session.zip neq '0' and session.zip neq '00000'>
	<cfset passZip = session.zip>
<cfelse>
	<cfset passZip = ''>
</cfif>
<cf_displayProgramDetail prg_id="#attributes.prg_id#" mode="print" number="#attributes.prg_num#" county="#passCounty#" state_id="#passState#" zip="#passZip#" description="#attributes.prgdesc#" entrypoints="#attributes.prgeps#" eplimit="#attributes.prgepnum#" requisites="#attributes.prgreqmat#" var="rdOut" append="true">

<cfset rdOut = rdOut & "</FONT></TD></TR></TABLE>

">

<cfif attributes.pgbreaks>
	<cfset rdOut = rdOut & "<!-- NEW PAGE -->

">
<cfelse>
	<cfset rdOut = rdOut & "<br><br><br>

">
</cfif>

<cfset "caller.#attributes.outvar#" = rdOut>