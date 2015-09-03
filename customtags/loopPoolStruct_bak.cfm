
<cfparam name="attributes.scope" type="string" default="caller">
<cfparam name="attributes.struct" type="string">
<cfparam name="attributes.index" type="string">
<cfparam name="attributes.sortBy" type="string" default="sort">

<cfif ThisTag.ExecutionMode eq 'start' and ThisTag.HasEndTag>
	<cfset loopControlList = ''>
	<cfset listPos = 1>
		
	<cfset keys = StructKeyList(Evaluate("#attributes.scope#.#attributes.struct#.#attributes.sortBy#"))>
	<cfif ListLen(keys) gt 0 and IsNumeric(ListGetAt(keys, 1))>
		<cfset order = 'numeric'>
	<cfelse>
		<cfset order = 'textnocase'>
	</cfif>
	<cfloop list="#ListSort(StructKeyList(Evaluate("#attributes.scope#.#attributes.struct#.#attributes.sortBy#")), order)#" index="x">
		<cfif order eq 'textnocase'>
			<cfset loopControlList = ListAppend(loopControlList, x)>
		<cfelse>
			<cfset loopControlList = ListAppend(loopControlList, StructFind(Evaluate("#attributes.scope#.#attributes.struct#.#attributes.sortBy#"), x))>
		</cfif>
	</cfloop>
	<cfif ListLen(loopControlList) gt 0>
		<cfset "caller.#attributes.index#" = ListGetAt(loopControlList, listPos)>
	<cfelse>
		<cfexit method="exitTag">
	</cfif>
<cfelseif ThisTag.ExecutionMode eq 'end'>
	<cfif ListLen(loopControlList) eq 0>
		<cfset ThisTag.GeneratedContent = ''>
	<cfelse>
		<cfset listPos = listPos + 1>
		<cfif listPos lte ListLen(loopControlList)>
			<cfset "caller.#attributes.index#" = ListGetAt(loopControlList, listPos)>
			<cfexit method="loop">
		</cfif>
	</cfif>
</cfif>

