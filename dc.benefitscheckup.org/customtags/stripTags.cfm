<cfsilent>
<cfparam name="attributes.text" type="string">
<cfparam name="attributes.all" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="">
<!--- always strip paired <script> tags and full inner content --->
<cfset attributes.text = REReplaceNoCase(attributes.text, '<script(\s[^>]*)?>.*</script>', '', 'ALL')>
<cfif attributes.all>
	<!--- for ALL, strip paired <sub> and <sup> tags with inner content, then strip out all other tags leaving content in place --->
	<cfset attributes.text = REReplaceNoCase(attributes.text, '<sub(\s[^>]*)?>.*</sub>', '', 'ALL')>
	<cfset attributes.text = REReplaceNoCase(attributes.text, '<sup(\s[^>]*)?>.*</sup>', '', 'ALL')>
	<cfset attributes.text = REReplaceNoCase(attributes.text, '</?[^>]*>', '', 'ALL')>
<cfelse> 
	<!--- for NOT ALL, strip out only <a> tags leaving content in place --->
	<cfset attributes.text = REReplaceNoCase(attributes.text, '</?a(\s[^>]*)?>', '', 'ALL')>
</cfif>
</cfsilent>
<cfif attributes.var eq ''>
<cfoutput>#attributes.text#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = attributes.text>
</cfif>
