<cfparam name="attributes.root" type="string" default="#application.rootPathBCU#">
<cfparam name="attributes.path" type="string" default="">
<cfparam name="attributes.var" type="string" default="imageList">

<cfif not IsDefined("caller.#attributes.var#")>
	<cfset "caller.#attributes.var#" = ''>
</cfif>
<cfdirectory directory="#attributes.root#" name="dtquery">

<cfoutput>

<cfloop query="dtquery">
	<cfif type eq 'Dir'>
		<cf_directoryTree root="#attributes.root##application.rootSlash##name#" path="#attributes.path##application.rootSlash##name#" var="caller.#attributes.var#">
	<cfelseif Right(name, 4) eq '.jpg' or Right(name, 5) eq '.jpeg' or Right(name, 4) eq '.gif' or Right(name, 4) eq '.png' or Right(name, 5) eq '.bmp'>
		<cfset filename = "#attributes.path##application.rootSlash##name#">
		<cfif Left(filename, 1) eq application.rootSlash>
			<cfset filename = Right(filename, Len(filename) - 1)>
		</cfif>
		<cfset "caller.#attributes.var#" = ListAppend(Evaluate("caller.#attributes.var#"), filename)>
	</cfif>
</cfloop>

</cfoutput>