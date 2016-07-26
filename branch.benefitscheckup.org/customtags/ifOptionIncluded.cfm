<cfsilent>
<cfparam name="attributes.scope" type="string" default="caller">
<cfparam name="attributes.struct" type="string">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">

<cfif ThisTag.ExecutionMode eq 'start' and ThisTag.HasEndTag>
	<cfif attributes.subset_id eq '' and IsDefined('session.subset_id')>
		<cfset attributes.subset_id = session.subset_id>
	</cfif>
	<cfif attributes.partner_id eq '' and IsDefined('session.partner_id') and session.partner_id gt 0>
		<cfset attributes.partner_id = session.partner_id>
	</cfif>
	<cfset inc = Evaluate("#attributes.scope#.#attributes.struct#.inc")>
	<cfset sp = Evaluate("#attributes.scope#.#attributes.struct#.sp")>
	<cfif StructKeyExists(sp, "s#attributes.subset_id#p#attributes.partner_id#")>
		<cfset inc = StructFind(sp, "s#attributes.subset_id#p#attributes.partner_id#")>
	<cfelseif StructKeyExists(sp, "s#attributes.subset_id#p")>
		<cfset inc = StructFind(sp, "s#attributes.subset_id#p")>
	<cfelseif StructKeyExists(sp, "sp#attributes.partner_id#")>
		<cfset inc = StructFind(sp, "sp#attributes.partner_id#")>
	<cfelseif StructKeyExists(sp, "sp")>
		<cfset inc = StructFind(sp, "sp")>
	</cfif>
	<cfif inc eq 0>
		<cfexit>
	</cfif>
</cfif>
</cfsilent>