<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.default" type="any" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="gadValue">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.subset_id eq '' and IsDefined('session.subset_id')>
	<cfset attributes.subset_id = session.subset_id>
</cfif>
<cfif attributes.partner_id eq '' and IsDefined('session.partner_id') and session.partner_id gt 0>
	<cfset attributes.partner_id = session.partner_id>
</cfif>
<cfset output = attributes.default>
<cfset afobj = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>
<cfif StructKeyExists(afobj.sp, "s#attributes.subset_id#p#attributes.partner_id#")>
	<cfset output = StructFind(afobj.sp, "s#attributes.subset_id#p#attributes.partner_id#")>
<cfelseif StructKeyExists(afobj.sp, "s#attributes.subset_id#p")>
	<cfset output = StructFind(afobj.sp, "s#attributes.subset_id#p")>
<cfelseif StructKeyExists(afobj.sp, "sp#attributes.partner_id#")>
	<cfset output = StructFind(afobj.sp, "sp#attributes.partner_id#")>
<cfelseif StructKeyExists(afobj.sp, "sp")>
	<cfset output = StructFind(afobj.sp, "sp")>
<cfelseif attributes.mode eq 'full' and session.org_id gt 0 and afobj.oedef neq ''>
	<cfset output = afobj.oedef>
<cfelseif attributes.mode eq 'full' and session.org_id eq 0 and afobj.spqdef neq ''>
	<cfset output = afobj.spqdef>
<cfelseif attributes.mode neq 'full' and attributes.mode neq 'print' and afobj.def neq ''>
	<cfset output = afobj.def>
</cfif>
<cfset "caller.#attributes.var#" = output>
</cfsilent>