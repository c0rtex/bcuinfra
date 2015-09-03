<cfsetting enablecfoutputonly="Yes">
<cfparam name="attributes.action" type="string" default="increment">

<cf_loadApplicationVars hashname="quotevars">

<cfif attributes.action eq 'random'>
	<cfset pos = RandRange(1, ArrayLen(application.quotevars.arr))>
<cfelse>
	<cfset pos = application.quotevars.pos + 1>
	<cfif pos gt ArrayLen(application.quotevars.arr)>
		<cfset pos = 1>
	</cfif>
	<cfset application.quotevars.pos = pos>
</cfif>
<cf_displayText group="quote" code="quote_#application.quotevars.arr[pos]#" var="output">
<cfoutput>&ldquo;#output#&rdquo;</cfoutput>
<cfsetting enablecfoutputonly="No">