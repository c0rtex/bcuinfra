<cfparam name="attributes.struct" type="string">
<cfparam name="attributes.form" type="boolean" default="false">
<cfparam name="attributes.level" type="numeric" default="0">
<cfparam name="attributes.inputStruct" type="string" default="form">

<cfif not IsDefined(attributes.struct)>
	<cfoutput><i>no variable <b>#attributes.struct#</b> defined</i></cfoutput>
<cfelseif not IsStruct(Evaluate("#attributes.struct#"))>
	<cfoutput><i>variable <b>#attributes.struct#</b> not a structure</i></cfoutput>
<cfelse>
	<cfset field = Replace(attributes.struct, '.', '_', 'ALL')>
	<cfset nextlevel = attributes.level + 1>
	<cfset input = "caller.#attributes.inputStruct#">
	<cfif attributes.level eq 0>
		<cfset display = 'block'>
	<cfelseif IsDefined("#input#.#field#")>
		<cfset display = Evaluate("#input#.#field#")>
	<cfelse>
		<cfset display = 'none'>
	</cfif>
	
	<cfset keys = StructKeyList(Evaluate(attributes.struct))>
	<cfif ListLen(keys) gt 0 and IsNumeric(ListGetAt(keys, 1))>
		<cfset order = 'numeric'>
	<cfelse>
		<cfset order = 'textnocase'>
	</cfif>
	<cfoutput>
	<cfif attributes.level eq 0>
	<script language="javascript">
	<!--
	function toggleOL(id, ele) {
		var code = 'block';
		if (document.getElementById(id).style.display == 'block')
			code = 'none';
		document.getElementById(id).style.display = code;
		document.getElementById(ele).value = code;
	}
	// -->
	</script>
	<cfif attributes.form>
		<form method="post" name="#field#">
			<input type="submit" value="refresh" /><br />
	</cfif>
	</cfif>
	<input id="#field#" type="hidden" name="#field#" value="#display#" />
	<ul id="#attributes.struct#" style="display: #display#;">
	<cfif ListLen(keys) eq 0>
		<li><i>empty structure</i></li>
	<cfelse>
		<cfloop index="element" list="#ListSort(StructKeyList(Evaluate(attributes.struct)), order)#">
			<li><b>#element#</b>
			<cfif IsArray(StructFind(Evaluate(attributes.struct), element))>[array]<cfelseif IsStruct(StructFind(Evaluate(attributes.struct), element))>[<a href="javascript:toggleOL('#attributes.struct#.#LCase(element)#', '#field#_#LCase(element)#')">expand</a>]<cf_inspectStruct struct="#attributes.struct#.#LCase(element)#" form="#attributes.form#" level="#nextlevel#" inputStruct="#input#"><cfelse> => <i>#StructFind(Evaluate(attributes.struct), element)#</i></cfif></li>
	</cfloop>
	</cfif>
	</ul>
	<cfif attributes.form and attributes.level eq 0>
		</form>
	</cfif>
	</cfoutput>
</cfif>