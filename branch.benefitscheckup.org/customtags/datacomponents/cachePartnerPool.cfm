<cfparam name="attributes.name" type="string" default="bcuPartnerPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuPartner">

<cfif attributes.partner_id eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset phash = 'partner' & attributes.partner_id>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.id" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>
	<cfset "application.#attributes.name#.p" = StructNew()>
	<cfquery name="pvars" datasource="#application.dbSrc#">
		SELECT partner_id, partner_code
		FROM tbl_partner
		ORDER BY partner_code
	</cfquery>
	<cfset pCount = 0>
	<cfloop query="pvars">
		<cfset pCount = pCount + 1>
		<cfset StructInsert(Evaluate("application.#attributes.name#.id"), partner_id, partner_code)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), pCount, partner_code)>
	</cfloop>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.p.#phash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.p.#phash#" = StructNew()>
	<cfset "application.#attributes.name#.p.#phash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.p.#phash#.sort" = StructNew()>
	<cfquery name="pvars" datasource="#application.dbSrc#">
		select p.partner_id, p.partner_code, p.partner_name, p.partner_url, p.alt_name, d.display_code bcu,
			p.partner_wrapper, p.partner_header, p.partner_footer, p.partner_css, p.partner_titlebar,
			p.cms_doc_no, p.learn_flag, p.race_flag, p.hispanic_flag, p.links_flag, p.pdf_logo_flag, w.wrapper_code
		from tbl_partner p left outer join display d
				on p.bcu_display_id=d.display_id
			left outer join wrapper w
				on p.wrapper_id=w.wrapper_id
		where p.partner_id=#attributes.partner_id#
	</cfquery>
	<cfloop query="pvars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'id', partner_id)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'name', partner_name)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'url', partner_url)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'alt', alt_name)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'bcu', bcu)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'wrapper', partner_wrapper)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'header', partner_header)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'footer', partner_footer)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'css', partner_css)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'titlebar', partner_titlebar)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'cms', cms_doc_no)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'learn', learn_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'race', race_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'hispanic', hispanic_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'links', links_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'pdf', pdf_logo_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#phash#"), 'wcode', wrapper_code)>
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
				<td><strong>partner</strong></td>
				<td><strong>name</strong></td>
				<td><strong>url</strong></td>
				<td><strong>alt</strong></td>
				<td><strong>wrapper</strong></td>
				<td><strong>header</strong></td>
				<td><strong>footer</strong></td>
				<td><strong>css</strong></td>
				<td><strong>titlebar</strong></td>
				<td><strong>cms</strong></td>
				<td><strong>learn</strong></td>
				<td><strong>race</strong></td>
				<td><strong>hispanic</strong></td>
				<td><strong>links</strong></td>
				<td><strong>pdf</strong></td>
				<td><strong>wcode</strong></td>
				<td><strong>refresh</strong></td>
			</tr>

			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.id")), 'numeric')#" index="p">
				<cfset x = "partner#p#">
				<cfif doAll or x eq phash>
					<cfset pid = Right(x, Len(x) - 7)>
					<tr>
						<td align="right" valign="top">#p#</td>
						<td valign="top">#StructFind(Evaluate("application.#attributes.name#.id"), pid)#</td>
						<cfif IsDefined("application.#attributes.name#.p.#x#")>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.name")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.url")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.alt")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.wrapper")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.header")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.footer")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.css")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.titlebar")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.cms")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.learn")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.race")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.hispanic")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.links")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.pdf")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.wcode")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.p.#x#.lastRefresh")#</td>
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
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.p.#phash#"))>
		</cfif>
	</cfcase>
</cfswitch>