<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.language_id" type="string" default="">
<cfparam name="attributes.spacebefore" type="boolean" default="false">
<cfparam name="attributes.spaceafter" type="boolean" default="false">
<cfparam name="attributes.suppress" type="boolean" default="false">
<cfparam name="attributes.stripTags" type="boolean" default="false">
<cfparam name="attributes.jsEscape" type="boolean" default="false">
<cfparam name="attributes.param1" type="string" default="">
<cfparam name="attributes.param2" type="string" default="">
<cfparam name="attributes.param3" type="string" default="">
<cfparam name="attributes.var" type="string" default="">

<cfset nullStr = '!!9876??NULL??6789!!'>
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>

<cfset outVal = ''>
<cfif attributes.mode eq 'print'>
	<cfset attributes.stripTags = true>
	<cf_displayText var="outVal" group="afprint" code="afprint_#attributes.code#" alt="#nullStr#" language_id="#attributes.language_id#" spacebefore="#attributes.spacebefore#" spaceafter="#attributes.spaceafter#" suppress="#attributes.suppress#" stripTags="true" jsEscape="#attributes.jsEscape#" param1="#attributes.param1#" param2="#attributes.param2#" param3="#attributes.param3#">
</cfif>
<cfif (outVal eq '' or outVal eq nullStr) and (attributes.mode eq 'full' or attributes.mode eq 'print')>
	<cf_displayText var="outVal" group="afspq" code="afspq_#attributes.code#" alt="#nullStr#" language_id="#attributes.language_id#" spacebefore="#attributes.spacebefore#" spaceafter="#attributes.spaceafter#" suppress="#attributes.suppress#" stripTags="#attributes.stripTags#" jsEscape="#attributes.jsEscape#" param1="#attributes.param1#" param2="#attributes.param2#" param3="#attributes.param3#">
</cfif>
<cfif outVal eq '' or outVal eq nullStr>
	<cf_displayText var="outVal" group="answerfield" code="answerfield_#attributes.code#" alt="#nullStr#" language_id="#attributes.language_id#" spacebefore="#attributes.spacebefore#" spaceafter="#attributes.spaceafter#" suppress="#attributes.suppress#" stripTags="#attributes.stripTags#" jsEscape="#attributes.jsEscape#" param1="#attributes.param1#" param2="#attributes.param2#" param3="#attributes.param3#">
</cfif>
<cfif outVal eq nullStr>
	<cfset outVal = ''>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfoutput>#outVal#</cfoutput><cfelse><cfset "caller.#attributes.var#" = outVal></cfif>