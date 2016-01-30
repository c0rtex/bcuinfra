<!---
	Template Name: DisplayEntity
	Component Purpose: Component mapped to database table display via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: display

--->

<cfcomponent persistent="true" entityname="display" table="display" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="display_id">
	<cfproperty name="code" column="display_code">
	<cfproperty name="display_text" persistent="false" getter="true">

<!---
	Method returns display text at language set in session
--->

	<cffunction name="getDisplay_text">
        <cfset displ=ORMExecuteQuery("from display_language where display_id=:display_id and language_id=:language_id", {display_id=this.getId(), language_id=session.language.getId()})>
		<cfreturn expandTextCodes(displ[1].getDisplay_text())>
	</cffunction>

	<cffunction name="expandTextCodes">
		<cfargument name="outstr" default="">
		<cfset hasCode = false>
		<cfset getCodeOpen = Find('[[', outstr)>
		<cfif getCodeOpen>
			<cfset getCodeClose = Find(']]', outstr, getCodeOpen + 2)>
			<cfif getCodeClose>
				<cfset hasCode = true>
				<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
			</cfif>
		</cfif>
		<cfloop condition="hasCode">
			<cfset commandParams = ListLen(getCode, '|')>
			<cfset commandCode = ListGetAt(getCode, 1, '|')>
			<cfset expandedText = "">
			<cfset defText = "">
			<cfif commandCode eq "def">
				<cfif commandParams eq 1>
					<cfset expandedText = "<span style=""color: red; font-weight: bold;"">[error (def): no term was specified]</span>">
				<cfelse>
					<cfif commandParams gt 2>
						<cfset defText = ListGetAt(getCode, 3, '|')>
					<cfelse>
						<cfset defText = ''>
					</cfif>
					<cfset defKeyword = ListGetAt(getCode, 2, '|')>
					<cfset h=ormExecuteQuery("from help as h where h.keyword='#defKeyword#'")>
					<cfif arraylen(h) neq 0>
						<cfset expandedText = h[1].getDisplay().getDisplay_text()>
					</cfif>
					<cfset expandedText = "<a href onClick=""return showHideHelpDef(true,'#defKeyword#');"">#defText#</a><div id=""#defKeyword#"" style=""display:none;"" >#expandedText#<a href onClick=""return showHideHelpDef(false,'#defKeyword#');"">hide</a></div>">
				</cfif>
				<cfset outstr = Replace(outstr, "[[#getCode#]]", expandedText, 'ONE')>
			</cfif>
			<cfset hasCode = false>
			<cfset getCodeOpen = Find('[[', outstr)>
			<cfif getCodeOpen>
				<cfset getCodeClose = Find(']]', defText, getCodeOpen + 2)>
				<cfif getCodeClose>
					<cfset hasCode = true>
					<cfset getCode = Mid(outstr, getCodeOpen + 2, getCodeClose - getCodeOpen - 2)>
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn outstr>
	</cffunction>

</cfcomponent>