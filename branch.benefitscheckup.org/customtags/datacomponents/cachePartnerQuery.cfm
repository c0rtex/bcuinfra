<!---
Please note that this is a quick-and-dirty alternative to the partner cache pool and is not
intended as a long-term solution to the partner caching issue.  This is designed specifically
to be as unintrusive as possible, and to allow the output of this tag to be accessed using
the exact same syntax that is being used to access the individual queries.  This tag should
also continue to work without editing as more (God forbid!) columns are added to the partner
and wrapper tables.  However, this tag is a stopgap alternative to the queries that are being
re-run on almost every page of the site, and should eventually be deleted and replaced by
the more sophisticed cachePartnerPool (which will likely need updating as more columns are
added to these tables, as they surely will be).
--->
<cfparam name="attributes.name" type="string" default="bcuPartnerQuery">
<cfparam name="attributes.partner_id" type="numeric">
<cfparam name="attributes.query" type="string" default="bcuPartner">

<cfset phash = "p#attributes.partner_id#">
<!--- If var doesn't exist, initialize structure --->
<cfif not IsDefined("application.#attributes.name#")>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.RecordCount" = 0>
	<cfquery name="pvars" datasource="#application.dbSrc#">
		select *
		from tbl_partner p left join wrapper w
			on p.wrapper_id=w.wrapper_id
		order by p.partner_id
	</cfquery>
	<cfloop query="pvars">
		<cfset localhash = "p#partner_id#">
		<cfif not StructKeyExists(Evaluate("application.#attributes.name#"), localhash)>
			<cfset "application.#attributes.name#.#localhash#" = StructNew()>
			<cfset StructInsert(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount', 1)>
			<cfloop list="#pvars.ColumnList#" index="x">
				<cfif not StructKeyExists(Evaluate("application.#attributes.name#.#localhash#"), LCase(x))>
					<cfset StructInsert(Evaluate("application.#attributes.name#.#localhash#"), LCase(x), Evaluate("pvars.#x#"))>
				</cfif>
			</cfloop>
		<cfelse>
			<cfset StructUpdate(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount', StructFind(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount') + 1)>
		</cfif>
	</cfloop>
	<cfloop list="#pvars.ColumnList#" index="x">
		<cfif not StructKeyExists(Evaluate("application.#attributes.name#.null"), LCase(x))>
			<cfset StructInsert(Evaluate("application.#attributes.name#.null"), LCase(x), '')>
		</cfif>
	</cfloop>
</cfif>

<cfif StructKeyExists(Evaluate("application.#attributes.name#"), phash)>
	<cfset "caller.#attributes.query#" = StructCopy(Evaluate("application.#attributes.name#.#phash#"))>
<cfelse>
	<cfset "caller.#attributes.query#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
</cfif>