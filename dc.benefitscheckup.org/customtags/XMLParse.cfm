<cfsetting enablecfoutputonly="yes">
<cfparam name="attributes.xml" type="string">
<cfparam name="attributes.name" type="string">
<cfparam name="attributes.columnlist" type="string" default="client_id,cso_id,name">
<cfset xml = attributes.xml>
<cfset queryvar = QueryNew('tag,content,query,#attributes.columnlist#')>

<cfset xmlpos = 1>
<cfset xmlfind = Find('<', xml, xmlpos)>
	
<cfloop condition="xmlfind gt 0">

	<cfif xmlfind gt 0>
	
		<cfset tempvar = QueryAddRow(queryvar)>
	
		<cfset xmlpos = xmlfind + 1>
		<cfset xmltagend = 0>
		<cfset xmlspace = Find(' ', xml, xmlpos)>
		<cfset xmlclose = Find('>', xml, xmlpos)>
		<cfif xmlspace gt 0>
			<cfif xmlclose gt 0>
				<cfif xmlspace gt xmlclose>
					<cfset xmlnext = xmlclose>
					<cfset xmltagend = 1>
				<cfelse>
					<cfset xmlnext = xmlspace>
				</cfif>
			<cfelse>
				<cfset xmlnext = xmlspace>
			</cfif>
		<cfelse>
			<cfif xmlclose gt 0>
				<cfset xmlnext = xmlclose>
				<cfset xmltagend = 1>
			<cfelse>
				<cfset xmlnext = 0>
			</cfif>
		</cfif>
		
		<cfset xmltag = Mid(xml, xmlpos, xmlnext - xmlpos)>
		
		<cfloop condition="xmltagend eq 0">

			<cfset xmlpos = xmlspace + 1>
			<cfset xmlequals = Find('=', xml, xmlpos)>

			<cfif xmlequals eq 0 or xmlequals gte xmlclose>
				<cfset xmltagend = 1>
			<cfelse>
				<cfset xmlattrib = Trim(Mid(xml, xmlpos, xmlequals - xmlpos))>
				
				<cfset xmlpos = xmlequals + 2>
				
				<cfset xmlquote = Find('"', xml, xmlpos)>
				<cfset xmlvalue = Mid(xml, xmlpos, xmlquote - xmlpos)>
				
				<cfset tempvar = QuerySetCell(queryvar, xmlattrib, xmlvalue)>
				<cfset xmlspace = xmlquote + 1>

			</cfif>

		</cfloop>
		
		<cfset xmlpos = xmlclose + 1>
		<cfset xmlcontain = Find('</#xmltag#>', xml, xmlpos)>
		<cfset xmlcontent = Trim(Mid(xml, xmlpos, xmlcontain - xmlpos))>

		<!cfif Left(xmlcontent, 1) eq '<'>
			<!cf_XMLParse xml="#xmlcontent#" name="menudo" columnlist="question">
			<!cfset tempvar = QuerySetCell(queryvar, 'query', menudo)>
		<!cfelse>
			<cfset tempvar = QuerySetCell(queryvar, 'content', xmlcontent)>
		<!/cfif>
		
		
		<cfset xmlpos = xmlcontain + Len('</#xmltag#>')>
		<cfset xmlfind = Find('<', xml, xmlpos)>

	
	</cfif>
	
</cfloop>

<cfset "caller.#attributes.name#" = queryvar>
