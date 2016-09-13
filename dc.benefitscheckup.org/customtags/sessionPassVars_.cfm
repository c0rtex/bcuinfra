<cfprocessingdirective suppresswhitespace="Yes">
<!--- used to load resulting URL into given variable --->
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.blocklist" type="string" default="">
<cfparam name="attributes.extralist" type="string" default="">
<!--- used as <a> tag --->
<cfparam name="attributes.href" type="string" default="">
<cfparam name="attributes.onClick" type="string" default="">
<cfparam name="attributes.confirm" type="string" default="">
<!--- used as <form> tag --->
<cfparam name="attributes.action" type="string" default="">
<cfparam name="attributes.method" type="string" default="post">
<!--- used as <a> or <form> tag --->
<cfparam name="attributes.target" type="string" default="">
<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.id" type="string" default="">
<cfparam name="attributes.style" type="string" default="">
<!--- parameters to pass along --->
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
<!--- whether or not cfid and cftoken will be passed on URL --->
<cfparam name="attributes.addtoken" type="boolean" default="false">
<!--- for server-choice handling --->
<cfparam name="attributes.canonical" type="string" default="">

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>
	<!--- if bed state_id is passed in, just act like no state_id was passed --->
	<cfif attributes.state_id neq ''>
		<cf_cacheStatePool action="get" state_id="#attributes.state_id#" var="stobj">
		<cfif not stobj.exists>
			<cfset attributes.state_id = ''>
		</cfif>
	</cfif>
	<!--- if prev_id supplied and state_id not specified, get the state from the screening --->
	<cfif attributes.prev_id neq '' and IsNumeric(attributes.prev_id) and attributes.prev_id gt 0 and attributes.state_id eq ''>
		<cf_getScreeningState screening_id="#attributes.prev_id#" var="attributes.state_id">
	</cfif>
	<cfset varAccum=''>
	<cfset fieldAccum=''>
	<cfloop index="itemID" list="cfid,cftoken,source_id,prev_id,org_id,partner_id,subset_id,language_id,access_id,client_id,user_id,state_id,test_id">
		<cfif Not ListFind(attributes.blocklist, itemID)>
			<cfset itemVal = ''>
			<cfif itemID eq 'cfid' or itemID eq 'cftoken'>
				<cfif attributes.addtoken or (ThisTag.ExecutionMode eq 'End' and attributes.action neq '')>
					<cfset itemVal = StructFind(session, itemID)>
				<cfelse>
					<cfset itemVal = ''>
				</cfif>
			<cfelseif StructFind(attributes, itemID) neq ''>
				<cfset itemVal = StructFind(attributes, itemID)>
			<cfelseif StructKeyExists(session, itemID) and StructFind(session, itemID) neq ''>
				<cfset itemVal = StructFind(session, itemID)>
			</cfif>	
			<cfif itemVal neq ''>
				<cfif ThisTag.ExecutionMode eq 'Start' or attributes.action eq ''>
					<cfset varAccum = ListAppend(varAccum, "#itemID#=#itemVal#", '&')>
				<cfelse>
					<cfset fieldAccum = fieldAccum & "
		<input type=""hidden"" name=""#itemID#"" value=""#itemVal#"">">
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
	<cfloop index="extraID" list="#attributes.extralist#" delimiters="&,">
		<cfif ThisTag.ExecutionMode eq 'Start' or attributes.action eq ''>
			<cfset varAccum = ListAppend(varAccum, extraID, '&')>
		<cfelse>
			<cfset fieldAccum = fieldAccum & "
		<input type=""hidden"" name=""#ListGetAt(extraID, 1, '=')#"" value=""#ListGetAt(extraID, 2, '=')#"">">
		</cfif>
	</cfloop>
</cfif>
<cfif ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag>
	<cfif attributes.href eq ''>
		<cfset hrefInput="#attributes.action#">
	<cfelse>
		<cfset hrefInput="#attributes.href#">
	</cfif>
	<cf_link href="#hrefInput#" canonical="#attributes.canonical#" extralist="#attributes.extralist#" source_id="#attributes.source_id#" prev_id="#attributes.prev_id#" org_id="#attributes.org_id#" partner_id="#attributes.partner_id#" subset_id="#attributes.subset_id#" language_id="#attributes.language_id#" access_id="#attributes.access_id#" client_id="#attributes.client_id#" user_id="#attributes.user_id#" state_id="#attributes.state_id#" test_id="#attributes.test_id#" var="finalURL" canonicalVar="isCanonical">
	<cf_rebuildQueryString string="#varAccum#" extralist="bcu_url=#URLEncodedFormat(finalURL)#" var="varAccum">
	<cf_link href="/dispatch.cfm#varAccum#" addtoken="true" canonical="#isCanonical#" var="dispatchURL">
	<cfif attributes.var eq ''>
		<cfoutput>#dispatchURL#</cfoutput>
	<cfelse>
		<cfset "caller.#attributes.var#" = dispatchURL>
	</cfif>
<cfelseif ThisTag.ExecutionMode eq 'End'>
	<!--- Builds <a> or <form> tag with appropriate fields --->
	<cfset ThisTag.GeneratedContent = ">" & ThisTag.GeneratedContent>
	<cfif attributes.target neq ''>
		<cfset ThisTag.GeneratedContent = " target=""#attributes.target#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.style neq ''>
		<cfset ThisTag.GeneratedContent = " style=""#attributes.style#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.id neq ''>
		<cfset ThisTag.GeneratedContent = " id=""#attributes.id#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.class neq ''>
		<cfset ThisTag.GeneratedContent = " class=""#attributes.class#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.name neq ''>
		<cfset ThisTag.GeneratedContent = " name=""#attributes.name#""" & ThisTag.GeneratedContent>
	</cfif>
	<cfif attributes.action eq ''>
		<cf_link href="#attributes.href#" canonical="#attributes.canonical#" extralist="#attributes.extralist#" source_id="#attributes.source_id#" prev_id="#attributes.prev_id#" org_id="#attributes.org_id#" partner_id="#attributes.partner_id#" subset_id="#attributes.subset_id#" language_id="#attributes.language_id#" access_id="#attributes.access_id#" client_id="#attributes.client_id#" user_id="#attributes.user_id#" state_id="#attributes.state_id#" test_id="#attributes.test_id#" var="finalURL" canonicalVar="isCanonical">
		<cf_rebuildQueryString string="#varAccum#" extralist="bcu_url=#URLEncodedFormat(finalURL)#" var="varAccum">
		<cf_link href="/dispatch.cfm#varAccum#" addtoken="true" canonical="#isCanonical#" var="dispatchURL">
		<cfif attributes.confirm neq ''>
			<cf_jsEscapeString text="#attributes.confirm#" var="attributes.confirm">
			<cfset onMouseOver = " onMouseOver=""this.href='#finalURL#'""">
			<cfif attributes.onClick neq ''>
				<cfset attributes.onClick = "if (confirm(#attributes.confirm#)) {#attributes.onClick#; this.href='#dispatchURL#';} else this.href='javascript:void(0)';">
			<cfelse>
				<cfset attributes.onClick = "if (confirm(#attributes.confirm#)) this.href='#dispatchURL#'; else this.href='javascript:void(0)';">
			</cfif>
		<cfelse>
			<cfset onMouseOver = ''>
			<cfif attributes.onClick neq ''>
				<cfset attributes.onClick = "#attributes.onClick#; this.href='#dispatchURL#';">
			<cfelse>
				<cfset attributes.onClick = "this.href='#dispatchURL#';">
			</cfif>
		</cfif>
		<cfset ThisTag.GeneratedContent = "<a href=""#finalURL#""#onMouseOver# onClick=""#attributes.onClick#""" & ThisTag.GeneratedContent>
		<cfset ThisTag.GeneratedContent = ThisTag.GeneratedContent & "</a>">
	<cfelse>
		<cf_link href="#attributes.action#" canonical="#attributes.canonical#" isFormAction="true" var="finalURL">
		<cfset ThisTag.GeneratedContent = "<form action=""#finalURL#"" method=""#attributes.method#""" & ThisTag.GeneratedContent>
		<cfset ThisTag.GeneratedContent = ThisTag.GeneratedContent & "#fieldAccum#
</form>">
	</cfif>
	<cfif attributes.var neq ''>
		<cfset "caller.#attributes.var#" = ThisTag.GeneratedContent>
		<cfset ThisTag.GeneratedContent = ''>
	</cfif>
</cfif>
</cfprocessingdirective>