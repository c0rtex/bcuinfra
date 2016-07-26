<cfparam name="attributes.name" type="string" default="bcuOrganizationPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.org_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuOrganization">

<cfif attributes.org_id eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset ohash = 'org' & attributes.org_id>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.o" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.o.#ohash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.o.#ohash#" = StructNew()>
	<cfset "application.#attributes.name#.o.#ohash#.lastRefresh" = Now()>
	<cfquery name="ovars" datasource="#application.dbSrcOE#">
		select o.site_name, o.slogan, o.site_bg_color, o.logo_path, o.url, p.site_name parent, a.line_1, a.line_2,
			a.city, a.state, a.zip, op.number, tp.number tdd, r.intro, r.contact_name, r.cover_comments
		from ORGANIZATION o left outer join ORGANIZATION p
				on o.parent_org_id = p.id
					and p.org_name != 'NCOA'
			left outer join ADDRESS a
		    	on a.org_id=o.id
			left outer join PHONE op
		    	on op.org_id=o.id
					and op.phonetype_id=1
			left outer join PHONE tp
				on tp.org_id=o.id
					and tp.phonetype_id=6
			left outer join REPORT r
		    	on r.org_id=o.id
		where o.id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.org_id#" maxlength="4">
	</cfquery>
	<cfloop query="ovars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'name', site_name)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'slogan', slogan)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'bg', site_bg_color)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'logo', logo_path)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'url', url)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'parent', parent)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'address1', line_1)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'address2', line_2)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'city', city)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'state', state)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'zip', zip)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'phone', number)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'tdd', tdd)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'intro', intro)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'contact', contact_name)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.o.#ohash#"), 'comment', cover_comments)>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="18" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>name</strong></td>
				<td><strong>slogan</strong></td>
				<td><strong>bg</strong></td>
				<td><strong>logo</strong></td>
				<td><strong>url</strong></td>
				<td><strong>parent</strong></td>
				<td><strong>address1</strong></td>
				<td><strong>address2</strong></td>
				<td><strong>city</strong></td>
				<td><strong>state</strong></td>
				<td><strong>zip</strong></td>
				<td><strong>phone</strong></td>
				<td><strong>tdd</strong></td>
				<td><strong>intro</strong></td>
				<td><strong>contact</strong></td>
				<td><strong>comment</strong></td>
				<td><strong>refresh</strong></td>
			</tr>

			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.o")), 'text')#" index="x">
				<cfif doAll or x eq ohash>
					<cfset oid = Right(x, Len(x) - 3)>
					<tr>
						<td align="right" valign="top">#oid#</td>
						<cfif IsDefined("application.#attributes.name#.o.#x#")>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.name")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.slogan")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.bg")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.logo")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.url")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.parent")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.address1")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.address2")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.city")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.state")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.zip")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.phone")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.tdd")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.intro")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.contact")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.comment")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.o.#x#.lastRefresh")#</td>
						</cfif>
					</tr>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif doAll>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.o.#ohash#"))>
		</cfif>
	</cfcase>
</cfswitch>