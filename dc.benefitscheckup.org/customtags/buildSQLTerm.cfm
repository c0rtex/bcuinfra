<cfparam name="attributes.var" type="string" default="term">
<cfparam name="attributes.value" type="string" default="">
<cfparam name="attributes.type" type="string" default="s">
<cfparam name="attributes.required" type="numeric" default="0">
<cfparam name="attributes.comparison" type="boolean" default="false">
<cfparam name="attributes.negate" type="boolean" default="false">

<cfif attributes.type eq 'd'>
	<cfif attributes.value eq ''>
		<cfif attributes.required eq 1>
			<cfset outstr = 'now()'>
		<cfelse>
			<cfset outstr = 'NULL'>
		</cfif>
	<cfelse>
		<cfset outstr = "'" & Replace(attributes.value, "'", "''", 'ALL') & "'">
	</cfif>
<cfelseif attributes.type eq 'n'>
	<cfif attributes.value eq ''>
		<cfif attributes.required eq 1>
			<cfset outstr = 0>
		<cfelse>
			<cfset outstr = 'NULL'>
		</cfif>
	<cfelse>
		<cfset outstr = attributes.value>
	</cfif>
<cfelse>
	<cfif attributes.value eq ''>
		<cfif attributes.required eq 1>
			<cfset outstr = "''">
		<cfelse>
			<cfset outstr = 'NULL'>
		</cfif>
	<cfelse>
		<cfset outstr = "'" & Replace(attributes.value, "'", "''", 'ALL') & "'">
	</cfif>
</cfif>
<cfif attributes.comparison>
	<cfif outstr eq 'NULL'>
		<cfif attributes.negate>
			<cfset outstr = ' IS NOT NULL'>
		<cfelse>
			<cfset outstr = ' IS NULL'>
		</cfif>
	<cfelse>
		<cfif attributes.negate>
			<cfset outstr = " <> #outstr#">
		<cfelse>
			<cfset outstr = "=#outstr#">
		</cfif>
	</cfif>
</cfif>
<cfset "caller.#attributes.var#" = outstr>
