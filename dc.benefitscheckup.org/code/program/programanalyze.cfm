<cfparam name="id" type="numeric" default="0">

<cf_checkAccess level="5">

<cfset parray = StructNew()>
<cfquery name="paview" datasource="#application.dbSrc#">
	select pa.answerfield_id, a.answerfield
	from view_program_answerfield pa, answerfield a
	where pa.program_id=#id#
		and pa.answerfield_id=a.answerfield_id
	order by a.answerfield
</cfquery>
<cfquery name="paorig" datasource="#application.dbSrc#">
	select pa.answerfield_id, a.answerfield
	from program_answerfield_original pa, answerfield a
	where pa.program_id=#id#
		and pa.answerfield_id=a.answerfield_id
	order by a.answerfield
</cfquery>
<cfloop query="paview">
	<cfset "parray.#answerfield#" = StructNew()>
	<cfset "parray.#answerfield#.id" = answerfield_id>
	<cfset "parray.#answerfield#.status" = 1>
</cfloop>
<cfloop query="paorig">
	<cfif IsDefined("parray.#answerfield#")>
		<cfset "parray.#answerfield#.status" = 3>
	<cfelse>
		<cfset "parray.#answerfield#" = StructNew()>
		<cfset "parray.#answerfield#.id" = answerfield_id>
		<cfset "parray.#answerfield#.status" = 2>
	</cfif>
</cfloop>

<cf_buildPage title="Individual Program" section="program">

<cf_buildView title="Abbreviated Program Data" table="program" code="program" key="#id#" action="view" extraurllist="programsubsets.cfm?id=#id#,null" extranamelist="subsets,analyze" linkallactions="true">
	<cf_buildViewProperty column="programcategory_id" visible="false">
	<cf_buildViewProperty column="programgroup_id" visible="false">
	<cf_buildViewProperty column="state_id" input="select" references="state">
	<cf_buildViewProperty column="name_display_id" input="display">
	<cf_buildViewProperty column="desc_display_id" visible="false">
	<cf_buildViewProperty column="url" visible="false">
	<cf_buildViewProperty column="exclude_flag" visible="false">
	<cf_buildViewProperty column="significant_flag" visible="false">
	<cf_buildViewProperty column="active_flag" visible="false">
	<cf_buildViewProperty column="funder_id" visible="false">
	<cf_buildViewProperty column="reference_id" visible="false">
	<cf_buildViewProperty column="last_update" visible="false">
	<cf_buildViewProperty column="notes" visible="false">
	<cf_buildViewProperty column="supersort" visible="false">
	<cf_buildViewProperty column="sort" visible="false">
	<cf_buildViewProperty column="legacy_prg_id" visible="false">
	<cf_buildViewProperty column="legacy_pri_sec" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false">
	<cf_buildViewProperty column="create_date" visible="false">
	<cf_buildViewProperty column="modify_user_id" visible="false">
	<cf_buildViewProperty column="modify_date" visible="false">
</cf_buildView>

<cf_buildList title="Eligibility Rules" table="rule" code="rule" key="#id#" crosstable="program_rule" crosscolumn="program_id" crossvalue="#id#" crossorder="sort" crossadd="false" crossdelete="false" linksection="rule">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="legacy_pri_sec" visible="false">
</cf_buildList><br />

<cfoutput>
<table cellpadding="3" cellspacing="3" border="0">
	<tr bgcolor="#application.color.answerfield.dark#">
		<td colspan="4" style="font-size: 18pt; font-weight: bold;">Answerfield Association Analysis</td>
	</tr>
	<tr bgcolor="#application.color.answerfield.med#">
		<td colspan="2"><strong style="font-size: 12pt;">Associations from New Data</strong><br /><i style="font-size: 8pt;">as of #DateFormat(Now(), 'd mmmm yyyy')#</i></td>
		<td colspan="2"><strong style="font-size: 12pt;">Associations from Old Data</strong><br /><i style="font-size: 8pt;">as of 31 January 2008</i></td>
	</tr>
<cfloop list="#ListSort(StructKeyList(parray), 'text')#" index="x">
	<cfset xid = StructFind(Evaluate("parray.#x#"), 'id')>
	<cfset status = StructFind(Evaluate("parray.#x#"), 'status')>
	<tr bgcolor="#application.color.answerfield.light#">
		<td align="right"><i style="font-size: 10pt;">#xid#</i></td>
		<td><cfif status neq 2>#x#<cfelse>&nbsp;</cfif></td>
		<td><cfif status gt 1>#x#<cfelse>&nbsp;</cfif></td>
		<td>&nbsp;<a href="../answerfield/answerfieldview.cfm?id=#xid#">view</a>&nbsp;</td>
	</tr>
</cfloop>
</table>
</cfoutput>

</cf_buildPage>