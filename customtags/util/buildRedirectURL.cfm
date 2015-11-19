<cfsilent>
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.id" type="string" default="">
<cfparam name="attributes.target" type="string" default="">
<cfparam name="attributes.onClick" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
</cfsilent><cfif not ThisTag.HasEndTag or ThisTag.ExecutionMode eq 'end'><cfsilent>
	<cfif IsDefined('session.partner_id')>
		<cfquery name="alt" datasource="#application.dbSrc#">
			select uu.url_code
			from url u, alt_url_partner aup, url uu
			where u.url_code='#attributes.code#'
				and u.url_id=aup.url_id
				and aup.partner_id=#session.partner_id#
				and aup.alt_url_id=uu.url_id
		</cfquery>
		<cfif alt.RecordCount>
			<cfset attributes.code = alt.url_code>
		</cfif>
	</cfif>
	<cfquery name="urlinfo" datasource="#application.dbSrc#">
		SELECT u.url_id, p.protocol, u.url, u.link_text, u.target_flag, u.active_flag
		FROM url u LEFT OUTER JOIN protocol p
			ON u.protocol_id=p.protocol_id
		WHERE u.url_code='#attributes.code#'
	</cfquery>
	<cfif urlinfo.RecordCount eq 0>
		<cfset outstr = "<span style=""color: red; font-weight: bold;"">[error: URL code ""#attributes.code#"" not found]</span>">
	<cfelse>
		<cfif ThisTag.ExecutionMode eq 'end' and ThisTag.GeneratedContent neq ''>
			<cfset bruText = ThisTag.GeneratedContent>
			<cfset ThisTag.GeneratedContent = ''>
		<cfelseif attributes.text neq ''>
			<cfset bruText = attributes.text>
		<cfelseif urlinfo.link_text neq ''>
			<cfset bruText = urlinfo.link_text>
		<cfelse>
			<cfif urlinfo.protocol eq ''>
				<cfset bruText = ''>
			<cfelse>
				<cfset bruText = urlinfo.protocol & '://'>
			</cfif>
			<cfset bruText = bruText & urlinfo.url>
		</cfif>
		<cfif attributes.class neq ''>
			<cfset bruClass = attributes.class>
		<cfelse>
			<cfset bruClass = ''>
		</cfif>
		<cfif attributes.id neq ''>
			<cfset bruID = attributes.id>
		<cfelse>
			<cfset bruID = ''>
		</cfif>
		<cfif attributes.target neq ''>
			<cfset bruTargetFlag = attributes.target>
		<cfelse>
			<cfset bruTargetFlag = urlinfo.target_flag>
		</cfif>
		<cfif bruTargetFlag eq 1>
			<cfset bruTarget = '_blank'>
		<cfelse>
			<cfset bruTarget = ''>
			<cfset bruTargetFlag eq 0>
		</cfif>
		<cfif urlinfo.active_flag eq 1>
        	<cfset extra = "">
        	<cfif isdefined('session.partner_id') ><cfset extra = ",partner_id=#session.partner_id#"></cfif>
			<cf_sessionPassVars href="/cf/redirect.cfm" extralist="id=#urlinfo.url_id#,tgt=#bruTargetFlag##extra#" class="#bruClass#" id="#bruID#" target="#bruTarget#" onClick="#attributes.onClick#" var="outstr"><cfoutput>#bruText#</cfoutput></cf_sessionPassVars>
		<cfelse>
			<cfset outstr = "<u><strike>#bruText#</strike></u>">
		</cfif>
	</cfif>
	</cfsilent><cfif attributes.var eq ''><cfoutput>#outstr#</cfoutput><cfelse><cfset "caller.#attributes.var#" = outstr></cfif><cfsilent>
</cfsilent></cfif>