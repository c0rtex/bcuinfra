<cfparam name="attributes.level" type="string" default="1">
<cfif not IsDefined('session.user') or session.user eq '' or (application.maintenanceFlag and session.level gt 1)>
	<cfset q = cgi.query_string>
	<cfset popFound = false>
	<cfset searchDetected = false>
	<cfloop list="#ListSort(StructKeyList(form), 'textnocase')#" index="element">
		<cfif element neq 'fieldnames'>
			<cfif element eq 'dcsrchpop'>
				<cfset form.dcsrchpop = form.dcsrchpop + 1>
				<cfset popFound = true>
			</cfif>
			<cfset q = ListAppend(q, "#LCase(element)#=#URLEncodedFormat(Evaluate("form.#element#"))#", '&')>
			<cfif Left(element, 6) eq 'dcsrch'>
				<cfset searchDetected = true>
			</cfif>
		</cfif>
	</cfloop>
	<cfif not popFound and searchDetected>
		<cfset q = ListAppend(q, "dcsrchpop=2", '&')>
	</cfif>
	<cflocation url="#session.serverpath#/login.cfm?p=#URLEncodedFormat(cgi.script_name)#&q=#URLEncodedFormat(q)#" addtoken="no">
	<cfabort>
<cfelseif session.level gt attributes.level>
	<cflocation url="#session.serverpath#/restricted.cfm">
	<cfabort>
</cfif>