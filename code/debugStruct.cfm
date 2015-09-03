<cfparam name="struct" type="string">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Debug Structure</TITLE>
</HEAD>

<BODY>
<cfoutput>

<h3>Structure "#struct#" Contents</h3>

<cfif not IsDefined("#struct#")>

	The variable "#struct#" does not exist.

<cfelseif not IsStruct(Evaluate(struct))>

	The variable "#struct#" is not a structure.

<cfelse>

	<table border="1">
		<tr>
			<td><b>Variable</b></td>
			<td><b>Value</b></td>
		</tr>
	<cfset keys = StructKeyList(Evaluate(struct))>
	<cfif ListLen(keys) gt 0 and IsNumeric(ListGetAt(keys, 1))>
		<cfset order = 'numeric'>
	<cfelse>
		<cfset order = 'textnocase'>
	</cfif>
	<cfloop index="element" list="#ListSort(StructKeyList(Evaluate(struct)), order)#">
		<tr>
			<td>#element#</td>
			<td><cfif IsArray(StructFind(Evaluate(struct), element))><i>array</i><cfelseif IsStruct(StructFind(Evaluate(struct), element))><a href="debugStruct.cfm?struct=#struct#.#LCase(element)#"><i>structure</i></a><cfelse>#StructFind(Evaluate(struct), element)#</cfif></td>
		</tr>
	</cfloop>
	</table>

</cfif>

</cfoutput>
</BODY>
</HTML>