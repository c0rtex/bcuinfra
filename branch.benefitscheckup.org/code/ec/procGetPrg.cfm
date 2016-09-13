<cfparam name="FORM.SELECTEDDRUGNM" default="">
<cfparam name="menu_tab" default="drug">
<cfset session.ecprglist = "">
<cfset genericList = "">
<cfset session.selectedAFCDrugs = "">
<cfset session.selectedAFCDrugs = FORM.SELECTEDDRUGNM >

<cfloop list="#session.selectedAFCDrugs#" index="drug">
	<CFQUERY NAME="qryPrgs" DATASOURCE="#application.dbSrc#">
		SELECT p.prg_id
		FROM answerfield a, program_answerfield pa, tbl_prg_all p
		WHERE a.answerfield = <cfqueryparam cfsqltype="cf_sql_varchar" value="#drug#" maxlength="100">
			AND a.answerfield_id=pa.answerfield_id
			AND pa.program_id=p.RecID
		ORDER BY p.prg_id
	</cfquery>
	<cfoutput query="qryPrgs">
		<cfset prg_id2 = "'" & "#prg_id#" & "'">
		<cfset session.ecPrgList = ListAppend(session.ecPrgList,"#prg_id2#", ",")>
	</cfoutput>
	 <cf_cacheAnswerfieldPool action="get" code="#drug#" var="afobj">
    <!---<cfset afobj = application.answerfieldPool.getAnswerfield(drug)>--->
	<cfif afobj.type eq 'generic'>
		<cfset genericList = ListAppend(genericList, afobj.id)>
	</cfif>
</cfloop>
<cfif len(genericList) gt 0>
	<CFQUERY NAME="qryPrgs2" DATASOURCE="#application.dbSrc#">
		select p.prg_id
		from answerfield_relationship ar, program_answerfield pa, tbl_prg_all p
		where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=pa.answerfield_id
				and pa.program_id=p.RecID
		group by p.prg_id
		order by p.prg_id
	</cfquery>
	<cfoutput query="qryPrgs2">
		<cfset prg_id2 = "'" & "#prg_id#" & "'">
		<cfset session.ecPrgList = listappend(session.ecPrgList,"#prg_id2#", ",")>
	</cfoutput>
</cfif>
<cflocation url="dspForms.cfm?cat=DRUG&menu_tab=#menu_tab#">