<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Debug</TITLE>
</HEAD>

<BODY>
<cfoutput>

<h3>Application Values</h3>

<table border="1">
	<tr>
		<td><b>Variable</b></td>
		<td><b>Value</b></td>
	</tr>
<cfloop index="element" list="#ListSort(StructKeyList(application), 'Textnocase')#">
	<tr>
		<td>#element#</td>
		<td><cfif IsArray(StructFind(application, element))><i>array</i><cfelseif IsStruct(StructFind(application, element))><a href="debugStruct.cfm?struct=application.#element#"><i>structure</i></a><cfelse>#StructFind(application, element)#</cfif></td>
	</tr>
</cfloop>
</table>

<h3>Session Values</h3>

<table border="1">
	<tr>
		<td><b>Variable</b></td>
		<td><b>Value</b></td>
	</tr>
<cfloop index="element" list="#ListSort(StructKeyList(session), 'Textnocase')#">
	<tr>
		<td>#element#</td>
		<td><cfif IsArray(StructFind(session, element))><i>array</i><cfelseif IsStruct(StructFind(session, element))><a href="debugStruct.cfm?struct=session.#element#"><i>structure</i></a><cfelse>#StructFind(session, element)#</cfif></td>
	</tr>
</cfloop>
</table>

</cfoutput>
</BODY>
</HTML>