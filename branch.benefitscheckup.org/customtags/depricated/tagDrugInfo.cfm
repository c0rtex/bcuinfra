<cfparam name="attributes.catlist" type="string">

<cfset session.drugCount = 0 >
<cfif IsDefined('session.selectedDrugs')>
<cfif isdefined('session.structDrugPrgID') >
	<cfset result = StructClear(session.structDrugPrgID)>
</cfif>
<cfif isdefined('session.structDrugOptionName') >
	<cfset result = StructClear(session.structDrugOptionName)>
</cfif>
<cfif isdefined('session.structDrugOptID') >
	<cfset result = StructClear(session.structDrugOptID)>
</cfif>

<cfset session.structDrugPrgID =  structNew()>
<cfset session.structDrugOptionName =  structNew()>
<cfset session.structDrugOptID =  structNew()>

<CFIF ISDEFINED('ATTRIBUTES.CATLIST')>
	<cfset catlist = "#ATTRIBUTES.CATLIST#">
<CFELSE>
	<cfSET CATLIST = "" >
</CFIF>
<cfquery name="matchingdrugs" datasource="#application.dbSrc#">
	SELECT a.answerfield, substring(dl.display_text, 1, 255) option_nm, p.prg_id, a.answerfield_id opt_id
	FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
	WHERE p.prg_id in (#preservesinglequotes(session.prg_list)#)
		AND p.cat_id in (#preservesinglequotes(catlist)#)
		AND p.RecID=pa.program_id
		AND pa.answerfield_id=a.answerfield_id
		AND a.display_id=dl.display_id
		AND dl.language_id='#session.language_id#'
	GROUP BY a.answerfield, substring(dl.display_text, 1, 255), p.prg_id, a.answerfield_id
	ORDER BY option_nm
</cfquery>

<cfset session.drugsArray = arraynew(1)>
	   <cfset strCount = 0>
	<cfloop query="matchingdrugs" >
		 <cfset strCount = strCount + 1>
	 	<cfset #session.drugsArray[strCount]# = "#answerfield#">
	</cfloop>
	   <cfset strCount = 0>
	<cfloop query="matchingdrugs" >
		 <cfset strCount = strCount + 1>
		<cfif ListFindNoCase(session.selectedDrugs, answerfield) gt 0>
					<cfset result = #StructInsert(session.structDrugPrgID,  strcount,prg_id)# >
					<cfset result = #StructInsert(session.structDrugOptionName, strcount, option_nm)# >
					<cfset result = #StructInsert(session.structDrugOptID, strcount, Opt_ID)# >
		</cfif>
	</cfloop>

	<cfset genericList = "">
	<cfloop list="#session.selectedDrugs#" index="thisdrug">
        <cfset afobj = application.AnswerfieldPool.getAnswerfield(thisdrug)>
		<cfif afobj.type eq 'generic'>
			<cfset genericList = ListAppend(genericList, afobj.id)>
		</cfif>
	</cfloop>
	<cfif genericList neq ''>
		<cfquery name="genericMatch" datasource="#application.dbSrc#" >
			select a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (#genericList#)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id='#session.language_id#'
			order by option_nm
		</cfquery>
	
	<cfloop query="matchingdrugs">
		<cfset strCount = strCount + 1>
		<cfif ListFindNoCase(ValueList(genericMatch.answerfield), answerfield) gt 0>
			<cfset result = StructInsert(session.structDrugPrgID,  strcount,prg_id)>
			<cfset result = StructInsert(session.structDrugOptionName, strcount, option_nm)>
			<cfset result = StructInsert(session.structDrugOptID, strcount, Opt_ID)>
		</cfif>
	</cfloop>
	</cfif>
</cfif>