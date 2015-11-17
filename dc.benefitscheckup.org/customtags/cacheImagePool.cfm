<cfparam name="attributes.name" type="string" default="bcuImagePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuImage">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.i" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<cfquery name="ivars" datasource="#application.dbSrc#">
		select image_id, code, filename, width, height
		from image
		order by filename
	</cfquery>
	<cfset iCount = 0>
	<cfloop query="ivars">
		<cfset iCount = iCount + 1>
		<cfif Not IsDefined("application.#attributes.name#.i.#code#")>
			<cfset "application.#attributes.name#.i.#code#" = StructNew()>
			<cfset "application.#attributes.name#.i.#code#.id" = image_id>
			<cfset "application.#attributes.name#.i.#code#.file" = filename>
			<cfset "application.#attributes.name#.i.#code#.w" = width>
			<cfset "application.#attributes.name#.i.#code#.h" = height>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), iCount, code)>
		</cfif>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="6" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>file</strong></td>
				<td><strong>w</strong></td>
				<td><strong>h</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cf_cacheImagePool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#bcuImage.id#</td>
					<td valign="top">#x#</td>
					<td valign="top">#bcuImage.file#</td>
					<td align="right" valign="top">#bcuImage.w#</td>
					<td align="right" valign="top">#bcuImage.h#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.i"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.i.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = false>
		</cfif>
	</cfcase>
</cfswitch>