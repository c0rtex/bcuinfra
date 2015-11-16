
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.searchlevel" type="numeric" default="5">
<cfparam name="attributes.searchcondition" type="string" default="">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.actionurl" type="string" default="">

<cfif attributes.actionurl eq ''>
	<cfset attributes.actionurl = "#attributes.code#list.cfm">
</cfif>

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cf_tableLoad table="#attributes.table#">

<cfset colhash=StructNew()>
<cfset colhash.table=attributes.table>
<cfset colhash.tag=tag>
<cfset colhash.columns=StructNew()>
<cfset columnNameList=''>
<cfloop list="#columns#" index="column">
	<cfset colname = ListGetAt(column, 1, '|')>
	<cfset columnNameList = ListAppend(columnNameList, colname)>
	<cfset "colhash.columns.#colname#" = StructNew()>
	<cfset "colhash.columns.#colname#.name" = ListGetAt(column, 2, '|')>
	<cfset "colhash.columns.#colname#.type" = ListGetAt(column, 3, '|')>
	<cfset "colhash.columns.#colname#.req" = ListGetAt(column, 4, '|')>
	<cfset "colhash.columns.#colname#.input" = ''>
	<cfset "colhash.columns.#colname#.size" = 0>
	<cfset "colhash.columns.#colname#.maxlength" = 0>
	<cfset "colhash.columns.#colname#.references" = ''>
	<cfset "colhash.columns.#colname#.visible" = true>
	<cfset "colhash.columns.#colname#.condition" = ''>
	<cfset "colhash.columns.#colname#.default" = ''>
</cfloop>

<cfif IsDefined('ThisTag.AssocAttribs')>
	<cfloop index="x" from="1" to="#ArrayLen(ThisTag.AssocAttribs)#">
		<cfset temper = ThisTag.AssocAttribs[x].column>
		<cfif StructKeyExists(colhash.columns, temper)>
			<cfloop list="input,size,maxlength,references,visible,condition,default" index="attrib">
				<cfset "colhash.columns.#temper#.#attrib#" = Evaluate("ThisTag.AssocAttribs[x].#attrib#")>
			</cfloop>
		</cfif>
	</cfloop>
</cfif>

<cfset localTable=colhash.table>

<cfset tagColumnList = ''>
<cfloop list="#columnNameList#" index="column">
	<cfset tagColumnList = ListAppend(tagColumnList, "#colhash.tag#.#column#")>
</cfloop>



<cfoutput>

<table border="0" cellpadding="3" cellspacing="3" width="500">
<form action="#attributes.actionurl#" method="post">
<tr bgcolor="#localdark#">
	<td colspan="3" valign="bottom"><div style="float: left;"><font size="+2"><b><cfif attributes.title neq ''>#attributes.title#<cfelse>Search</cfif></b></font></div><div style="float: left;">&nbsp; &nbsp; <input type="button" value="help" onclick="var objrow = document.getElementById('helpinfo'); if (this.value == 'help') {this.value = 'hide'; objrow.style.display = '';} else {this.value = 'help'; objrow.style.display = 'none';}"></div><div style="float: right;"><input type="submit" value="search" /> &nbsp; <input type="reset" value="reset" /></div></td>
</tr>
<tr bgcolor="#localmed#" id="helpinfo" style="display:none;">
	<td colspan="3" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-style:italic; font-size:8pt;">To search on a given field, select a matching operator and enter a search term.  Fields left blank will be ignored.  Enter search terms in more than one field for a more constrictive search.  For select lists, hold down the Control key with the mouse if you want to select more than one term to match.  To perform a substring search on a text field, select "contains" or "does not contain" as the matching operator.  Please note that certain text fields can only be searched using "contains" or "does not contain."</td>
</tr>
<cfloop list="#columnNameList#" index="column">
	<cfif Evaluate("colhash.columns.#column#.visible")>
		<tr>
			<td bgcolor="#localmed#" valign="top"><font size="+1"><b>#Evaluate("colhash.columns.#column#.name")#</b></font></td>
			<td bgcolor="#locallight#" valign="top">
				<cfif false>
				<cfelse>
					<select name="dcsrchop_#column#">
					<cfif Evaluate("colhash.columns.#column#.input") neq 'text' and Evaluate("colhash.columns.#column#.input") neq 'display' and Evaluate("colhash.columns.#column#.input") neq 'select'>
						<option value="1">=</option>
						<cfif Evaluate("colhash.columns.#column#.input") neq 'flag'>
							<option value="2">&lt;&gt;</option>
							<option value="3">&lt;</option>
							<option value="4">&lt;=</option>
							<option value="5">&gt;</option>
							<option value="6">&gt;=</option>
						</cfif>
					</cfif>
					<cfif (Evaluate("colhash.columns.#column#.type") neq 'n' and Evaluate("colhash.columns.#column#.input") neq 'date' and Evaluate("colhash.columns.#column#.input") neq 'select') or Evaluate("colhash.columns.#column#.input") eq 'text' or Evaluate("colhash.columns.#column#.input") eq 'display'>
						<option value="7">contains</option>
						<option value="8">does not contain</option>
					</cfif>
					<cfif Evaluate("colhash.columns.#column#.input") eq 'select'>
						<option value="9">in</option>
						<option value="10">not in</option>
					</cfif>
					</select>
				</cfif>
			</td>
			<td bgcolor="#locallight#" valign="top">
				<cfif (Evaluate("colhash.columns.#column#.type") eq 's' and Evaluate("colhash.columns.#column#.input") eq '') or Evaluate("colhash.columns.#column#.input") eq 'text' or Evaluate("colhash.columns.#column#.input") eq 'display'>
					<input type="text" name="dcsrch_#column#" value="" size="<cfif Evaluate("colhash.columns.#column#.size") eq 0><cfif Evaluate("colhash.columns.#column#.maxlength") gt 0>#Evaluate("colhash.columns.#column#.maxlength")#<cfelse>50</cfif><cfelse>#Evaluate("colhash.columns.#column#.size")#</cfif>"<cfif Evaluate("colhash.columns.#column#.maxlength") gt 0> maxlength="#Evaluate("colhash.columns.#column#.maxlength")#"</cfif> />
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'select' and Evaluate("colhash.columns.#column#.references") eq 'self'>
					<cf_buildFormSelect table="#attributes.table#" name="dcsrch_#column#" self="#column#" required="true" multiple="true">
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'date'>
					<cf_buildDateSelect name="dcsrch_#column#" search="true">
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'select'>
					<cf_buildFormSelect table="#Evaluate("colhash.columns.#column#.references")#" name="dcsrch_#column#" required="#Evaluate("colhash.columns.#column#.req")#" condition="#Evaluate("colhash.columns.#column#.condition")#" multiple="true">
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'flag'>
					<select name="dcsrch_#column#">
						<option value=""></option>
						<option value="1"<cfif Evaluate("colhash.columns.#column#.default") eq 1> selected</cfif>>Yes</option>
						<option value="0"<cfif Evaluate("colhash.columns.#column#.default") eq 0> selected</cfif>>No</option>
					</select>
				<cfelseif Evaluate("colhash.columns.#column#.type") eq 'n'>
					<input type="text" name="dcsrch_#column#" value="" size="20" />
				<cfelse>
					type: #Evaluate("colhash.columns.#column#.type")#<br />
					input: #Evaluate("colhash.columns.#column#.input")#<br />
					references: #Evaluate("colhash.columns.#column#.references")#<br />
					condition: #Evaluate("colhash.columns.#column#.condition")#<br />
				</cfif>
			</td>
		</tr>
	</cfif>
</cfloop>
<tr bgcolor="#localdark#">
	<td colspan="3" valign="bottom"><div style="float: right;"><input type="submit" value="search" /> &nbsp; <input type="reset" value="reset" /></div></td>
</tr>
</form>
</table>

</cfoutput>

</cfif>
