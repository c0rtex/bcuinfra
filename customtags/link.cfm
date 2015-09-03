<cfsilent>
<cfparam name="attributes.href" type="string">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.id" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.target" type="string" default="">
<cfparam name="attributes.onClick" type="string" default="">
<!--- if any of these standard parameters exist and are required for the given template, add to query string --->
<cfparam name="attributes.source_id" type="any" default="">
<cfparam name="attributes.prev_id" type="any" default="">
<cfparam name="attributes.org_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.language_id" type="any" default="">
<cfparam name="attributes.access_id" type="any" default="">
<cfparam name="attributes.client_id" type="any" default="">
<cfparam name="attributes.user_id" type="any" default="">
<cfparam name="attributes.state_id" type="any" default="">
<cfparam name="attributes.test_id" type="any" default="">
<!--- extra query string variables to be passed on URL (or in form fields) --->
<cfparam name="attributes.extralist" type="string" default="">
<!--- whether or not query string should be added --->
<cfparam name="attributes.isFormAction" type="boolean" default="false">
<!--- whether or not cfid and cftoken will be passed on URL --->
<cfparam name="attributes.addtoken" type="boolean" default="false">
<!--- for server-choice handling --->
<cfparam name="attributes.canonical" type="string" default="">
<!--- for returning output in a variable --->
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.canonicalVar" type="string" default="">

<cfif attributes.source_id eq ''>
	<cfif IsDefined('session.source_id')>
		<cfset attributes.source_id = session.source_id>
	<cfelse>
		<cfset attributes.source_id = 1>
	</cfif>
</cfif>
<cfif attributes.prev_id eq ''>
	<cfif IsDefined('session.prev_id')>
		<cfset attributes.prev_id = session.prev_id>
	<cfelse>
		<cfset attributes.prev_id = 0>
	</cfif>
</cfif>
<cfif attributes.org_id eq ''>
	<cfif IsDefined('session.org_id')>
		<cfset attributes.org_id = session.org_id>
	<cfelse>
		<cfset attributes.org_id = 0>
	</cfif>
</cfif>
<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.partner_id')>
		<cfset attributes.partner_id = session.partner_id>
	<cfelse>
		<cfset attributes.partner_id = 0>
	</cfif>
</cfif>
<cfif attributes.subset_id eq ''>
	<cfif IsDefined('session.subset_id')>
		<cfset attributes.subset_id = session.subset_id>
	<cfelse>
		<cfset attributes.subset_id = 0>
	</cfif>
</cfif>
<cfif attributes.language_id eq ''>
	<cfif IsDefined('session.language_id')>
		<cfset attributes.language_id = session.language_id>
	<cfelse>
		<cfset attributes.language_id = 'EN'>
	</cfif>
</cfif>
<cfif attributes.access_id eq ''>
	<cfif IsDefined('session.access_id')>
		<cfset attributes.access_id = session.access_id>
	<cfelse>
		<cfset attributes.access_id = 0>
	</cfif>
</cfif>
<cfif attributes.client_id eq ''>
	<cfif IsDefined('session.client_id')>
		<cfset attributes.client_id = session.client_id>
	<cfelse>
		<cfset attributes.client_id = 'NULL'>
	</cfif>
</cfif>
<cfif attributes.user_id eq ''>
	<cfif IsDefined('session.user_id')>
		<cfset attributes.user_id = session.user_id>
	<cfelse>
		<cfset attributes.user_id = 'NULL'>
	</cfif>
</cfif>
<cfif attributes.state_id eq ''>
	<cfif IsDefined('session.state_id')>
		<cfset attributes.state_id = session.state_id>
	<cfelse>
		<cfset attributes.state_id = 'IL'>
	</cfif>
</cfif>
<cfif attributes.test_id eq ''>
	<cfif IsDefined('session.test_id')>
		<cfset attributes.test_id = session.test_id>
	<cfelse>
		<cfset attributes.test_id = 0>
	</cfif>
</cfif>

</cfsilent><cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'><cfsilent>

	<cfset isCanonical = false>

	<cfset sp = Replace(application.serverPath, '.', '\.', 'ALL')>
	<cfset spc = Replace(application.serverPathCanonical, '.', '\.', 'ALL')>

	<cfset hrefTokens = REFindNoCase("^((https?)://(#sp#|#spc#|[^/]*)|(#sp#|#spc#))?(/?)((([^\?\/]*\/)*)?)([^\?]*)((\?)(.*))?", attributes.href, 1, true)>
	<cfset typeElement = 3>
	<cfset serverElement = 4>
	<cfset serverBareElement = 5>
	<cfset slashElement = 6>
	<cfset pathElement = 7>
	<cfset templateElement = 10>
	<cfset questionElement = 12>
	<cfset queryElement = 13>

	<cfif hrefTokens.pos[serverElement]>
		<cfset serverToken = Mid(attributes.href, hrefTokens.pos[serverElement], hrefTokens.len[serverElement])>
	<cfelse>
		<cfset serverToken = ''>
	</cfif>
	<cfif serverToken eq '' or serverToken eq application.serverPath or serverToken eq application.serverPathCanonical>
		<cfset isInternal = true>
	<cfelse>
		<cfset isInternal = false>
	</cfif>

	<cfif isInternal>
		<cfif hrefTokens.pos[typeElement]>
			<cfset typeToken = Mid(attributes.href, hrefTokens.pos[typeElement], hrefTokens.len[typeElement])>
		<cfelse>
			<cfset typeToken = ''>
		</cfif>
		<cfif hrefTokens.pos[serverBareElement]>
			<cfset serverBareToken = Mid(attributes.href, hrefTokens.pos[serverBareElement], hrefTokens.len[serverBareElement])>
		<cfelse>
			<cfset serverBareToken = ''>
		</cfif>
		<cfif hrefTokens.pos[slashElement]>
			<cfset slashToken = Mid(attributes.href, hrefTokens.pos[slashElement], hrefTokens.len[slashElement])>
		<cfelse>
			<cfset slashToken = ''>
		</cfif>
		<cfif hrefTokens.pos[pathElement]>
			<cfset pathToken = Mid(attributes.href, hrefTokens.pos[pathElement], hrefTokens.len[pathElement])>
		<cfelse>
			<cfset pathToken = ''>
		</cfif>
		<cfif hrefTokens.pos[templateElement]>
			<cfset templateToken = Mid(attributes.href, hrefTokens.pos[templateElement], hrefTokens.len[templateElement])>
		<cfelse>
			<cfset templateToken = ''>
		</cfif>
		<cfif hrefTokens.pos[questionElement]>
			<cfset questionToken = Mid(attributes.href, hrefTokens.pos[questionElement], hrefTokens.len[questionElement])>
		<cfelse>
			<cfset questionToken = ''>
		</cfif>
		<cfif hrefTokens.pos[queryElement]>
			<cfset queryToken = Mid(attributes.href, hrefTokens.pos[queryElement], hrefTokens.len[queryElement])>
		<cfelse>
			<cfset queryToken = ''>
		</cfif>
		<cfif serverToken eq '' and serverBareToken neq ''>
			<cfset serverToken = serverBareToken>
		</cfif>
		<cfif pathToken eq '' and (templateToken eq '.' or templateToken eq '..')>
			<cfset pathToken = "#templateToken#/">
			<cfset templateToken = ''>
		</cfif>
		<cfif not Find('.', templateToken)>
			<cfset pathToken = "#pathToken##templateToken#">
			<cfset templateToken = ''>
		</cfif>
	
		<cfif pathToken eq './'>
			<cfset pathToken = ''>
		</cfif>
		<cfset scriptList = cgi.script_name>
		<cfif slashToken eq ''>
			<cfif serverToken eq ''>
				<cfset tempServer = application.serverPath>
			<cfelse>
				<cfset tempServer = serverToken>
			</cfif>
			<cfset serverLen = ListLen(tempServer, '/')>
			<cfset scriptLen = ListLen(cgi.script_name, '/')>
			<cfif serverLen gt 1 and scriptLen gte serverLen>
				<cfset serverList = ListDeleteAt(tempServer, 1, '/')>
				<cfset scriptMatch = true>
				<cfset scriptPos = 1>
				<cfloop condition="scriptMatch and scriptPos lt serverLen">
					<cfif ListGetAt(serverList, scriptPos, '/') eq ListGetAt(scriptList, 1, '/')>
						<cfset scriptList = ListDeleteAt(scriptList, 1, '/')>
					<cfelse>
						<cfset scriptMatch = false>
					</cfif>
					<cfset scriptPos = scriptPos + 1>
				</cfloop>
			</cfif>
			<cfset newPath = ListDeleteAt(scriptList, ListLen(scriptList, '/'), '/')>
			<cfloop list="#pathToken#" delimiters="/" index="x">
				<cfif x eq '..'>
					<cfif ListLen(newPath, '/') gt 1>
						<cfset newPath = ListDeleteAt(newPath, ListLen(newPath, '/'), '/')>
					<cfelse>
						<cfset newPath = ''>
					</cfif>
				<cfelseif x neq '.'>
					<cfset newPath = ListAppend(newPath, x, '/')>
				</cfif>
			</cfloop>
			<cfset pathToken = newPath>
		</cfif>
		<cfif Left(pathToken, 1) eq '/'>
			<cfset pathToken = Right(pathToken, Len(pathToken) - 1)>
		</cfif>
		<cfif Right(pathToken, 1) eq '/'>
			<cfset pathToken = Left(pathToken, Len(pathToken) - 1)>
		</cfif>
		<cfif pathToken neq ''>
			<cfset pathToken = pathToken & '/'>
		</cfif>
		<cfset varPassList = ''>
		<cfif templateToken neq ''>
			<cf_cacheTemplatePool action="get" filename="#pathToken##templateToken#" var="tobj">
			<cfif tobj.exists>
				<cfif tobj.canonical>
					<cfset typeToken = application.transferTypeCanonical>
					<cfset serverToken = application.serverPathCanonical>
				</cfif>
				<cfif not attributes.isFormAction>
					<cfloop list="source,prev,org,partner,subset,language,access,client,user,state,test" index="x">
						<cfif Evaluate("tobj.#x#")>
							<cfset varPassList = ListAppend(varPassList, x)>
						</cfif>
					</cfloop>
				</cfif>
			</cfif>
		</cfif>
		<cfif attributes.canonical eq 'true'>
			<cfset urlType = application.transferTypeCanonical>
		<cfelseif attributes.canonical eq 'false' or typeToken eq ''>
			<cfset urlType = application.transferType>
		<cfelse>
			<cfset urlType = typeToken>
		</cfif>
		
		<cfif parameterExists(session.transferTypeCanonicalOverride)>
			<cfset urlType = session.transferTypeCanonicalOverride>
		</cfif>		
		
		<cfif attributes.canonical eq 'true'>
			<cfset urlServer = application.serverPathCanonical>
		<cfelseif attributes.canonical eq 'false' or serverToken eq ''>
			<cfset urlServer = application.serverPath>
		<cfelse>
			<cfset urlServer = serverToken>
		</cfif>
		<cfif urlServer eq application.serverPathCanonical>
			<cfset isCanonical = true>
		</cfif>
		<cfloop list="#varPassList#" index="x">
			<cfset attributes.extralist = ListAppend(attributes.extralist, "#x#_id=#Evaluate("attributes.#x#_id")#", '&')>
		</cfloop>
		<cf_rebuildQueryString string="#queryToken#" extralist="#attributes.extralist#" addtoken="#attributes.addtoken#" var="queryToken">
		<cfset urlFullyQualified = "#urlType#://#urlServer#/#pathToken##templateToken##queryToken#">
	<cfelse>
		<cfset urlFullyQualified = attributes.href>
	</cfif>

	<cfif ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag>
		<cfset outStr = urlFullyQualified>
	<cfelseif ThisTag.ExecutionMode eq 'End'>
		<cfset outStr = '>' & ThisTag.GeneratedContent & '</a>'>
		<cfif attributes.onClick neq ''>
			<cfset outStr = " onClick=""#attributes.onClick#""" & outStr>
		</cfif>
		<cfif attributes.target neq ''>
			<cfset outStr = " target=""#attributes.target#""" & outStr>
		</cfif>
		<cfif attributes.style neq ''>
			<cfset outStr = " style=""#attributes.style#""" & outStr>
		</cfif>
		<cfif attributes.class neq ''>
			<cfset outStr = " class=""#attributes.class#""" & outStr>
		</cfif>
		<cfif attributes.id neq ''>
			<cfset outStr = " id=""#attributes.id#""" & outStr>
		</cfif>
		<cfif attributes.name neq ''>
			<cfset outStr = " name=""#attributes.name#""" & outStr>
		</cfif>
		<cfset outStr = "<a href=""#urlFullyQualified#""" & outStr>
		<cfset ThisTag.GeneratedContent = ''>
	</cfif>
	
	<cfif attributes.canonicalVar neq ''>
		<cfset "caller.#attributes.canonicalVar#" = isCanonical>
	</cfif>

</cfsilent><cfif attributes.var eq ''><cfoutput>#outStr#</cfoutput><cfelse><cfset "caller.#attributes.var#" = outStr></cfif></cfif>