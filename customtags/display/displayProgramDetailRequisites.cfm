<cfsilent>
<cfparam name="attributes.program_id" type="numeric">
<cfparam name="attributes.mode" type="string" default="screen">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">

<cfset outstr = ''>
<cf_cacheProgramPool action="get" id="#attributes.program_id#" var="pobj">

<cfset outstr = outstr & "<BR><B>Please be prepared to have the following materials available:</b><br>">
<cfset outstr = outstr & "
<script language=""javascript"">
		function lookup(i) {
    var d =open(i, 'Glossary', 
    ""width=400,height=300,status=no,toolbar=no,menubar=no"");
}
</script>
">
<cfif not StructCount(pobj.req)>
	<cfset outstr = outstr & "There are no materials needed for this program.">
<cfelse>
	<cfif attributes.mode neq 'print'>
		<cfset outstr = outstr & "(Click on the links below to view examples.)">
	</cfif>
	<cfif SESSION.partner_id EQ 80 AND attributes.mode NEQ 'print'><cfset outstr = outstr & "<ul class='materials_list'>"><cfelse><cfset outstr = outstr & "<ul style='list-style:none;margin-top:0px;margin-left:2px;'>"></cfif>
	<cf_loopPoolStruct struct="pobj" sortBy="req" index="reqCode">
		<cf_cacheRequisitePool action="get" code="#reqCode#" var="reqObj">
		<cf_displayText group="requisite" code="#reqObj.name#" var="reqName">
			
		<cfif attributes.mode eq 'print' or reqObj.def eq ''>
			<cfset outstr = outstr & "<li>#reqName#</li>">
		<cfelse>
			<cfset outstr = outstr & "<li><a href=""javascript:lookup('popText.cfm?titlegroup=requisite&titlecode=#reqObj.name#&group=reqdef&code=#reqObj.def#')"">#reqName#</a></li>">
			
		</cfif>	
	</cf_loopPoolStruct>
	<cfif SESSION.partner_id EQ 80 AND attributes.mode NEQ 'print'><cfset outstr = outstr & "</ul>"><cfelse><cfset outstr = outstr & "</ul>"></cfif>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>