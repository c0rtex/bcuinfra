<cfparam name="attributes.name" type="string" default="bcuValidationPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuValidation">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.v" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null rule obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.id" = ''>
	<cfset "application.#attributes.name#.null.formula" = ''>
	<cfset "application.#attributes.name#.null.msg" = ''>

	<cfquery name="vvars" datasource="#application.dbSrc#">
		select v.validation_id, v.validation_code, v.formula, d.display_code
		from validation v, display d
		where v.display_id=d.display_id
		order by validation_code
	</cfquery>
	<cfset vCount = 0>
	<cfloop query="vvars">
		<cfset vCount = vCount + 1>
		<cfif Not IsDefined("application.#attributes.name#.v.#validation_code#")>
			<cfset "application.#attributes.name#.v.#validation_code#" = StructNew()>
			<cfset "application.#attributes.name#.v.#validation_code#.exists" = true>
			<cfset "application.#attributes.name#.v.#validation_code#.id" = validation_id>
			<cfset "application.#attributes.name#.v.#validation_code#.formula" = formula>
			<cfset "application.#attributes.name#.v.#validation_code#.msg" = display_code>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), vCount, validation_code)>
		</cfif>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="4" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>formula</strong></td>
				<td><strong>message</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cf_cacheValidationPool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#Evaluate("#attributes.var#.id")#</td>
					<td valign="top">#x#</td>
					<td valign="top">#Evaluate("#attributes.var#.formula")#</td>
					<td valign="top">#Evaluate("#attributes.var#.msg")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<!--- copy structures by reference to save memory --->
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.v"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.v.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
</cfswitch>