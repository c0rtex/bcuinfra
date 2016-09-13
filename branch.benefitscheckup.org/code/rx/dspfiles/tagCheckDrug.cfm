<cfset prg_id = "#attributes.prg_id#">
<cfset Session.AvailableDrugCount = 0 >
<cfif IsDefined('session.selectedDrugs')>
	<cfquery name="matchingdrugs" datasource="#application.dbSrc#">
		SELECT a.answerfield, substring(dl.display_text, 1, 255) option_nm
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
		WHERE p.prg_id = <cfqueryparam 
                        value="#prg_id#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
			AND p.recid=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			AND a.answerfieldtype_id in (13, 14)
			AND a.display_id=dl.display_id
			and dl.language_id=<cfqueryparam 
                        value="#session.language_id#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="2">
		ORDER BY option_nm
	</cfquery>
	<cfset strCount = 0>
	<cfoutput query="matchingdrugs">
		<cfif ListFindNoCase(session.selectedDrugs, answerfield) gt 0>
			<cfif ListFindNoCase(Session.WrapAroundDrugList, option_nm) eq 0>	
				<cfset Session.AvailableDrugCount = Session.AvailableDrugCount + 1 >
			</cfif>
		</cfif>
	</cfoutput>
	<cfset genericList = "">
	<cfloop list="#session.selectedDrugs#" index="thisdrug">
    	<!---
		#5452
		<cf_cacheAnswerfieldPool action="get" code="#thisdrug#" var="afobj">
        --->
        <cfset afobj = application.AnswerfieldPool.getAnswerfield('#thisdrug#')>
		<cfif afobj.type eq 'generic'>
			<cfset genericList = ListAppend(genericList, afobj.id)>
		</cfif>
	</cfloop>
	<cfif genericList eq ''>
		<cfquery name="genericMatch" datasource="#application.dbSrc#">
			select answerfield, answerfield option_nm
			from answerfield
			where answerfield_id is null
		</cfquery>
	<cfelse>
		<cfquery name="genericMatch" datasource="#application.dbSrc#" >
			select a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield_relationship ar, answerfield a, display_language dl
			where ar.right_answerfield_id in (<cfqueryparam 
                        value="#genericList#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="250">)
				and ar.relationship_id=1
				and ar.left_answerfield_id=a.answerfield_id
				and a.answerfieldtype_id=13
				and a.display_id=dl.display_id
				and dl.language_id=<cfqueryparam 
                        value="#session.language_id#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="2">
			order by option_nm
		</cfquery>
	</cfif>
	<cfoutput query="matchingdrugs">
		<cfif ListFindNoCase(ValueList(genericMatch.answerfield), answerfield) gt 0>
			<cfif ListFindNoCase(Session.WrapAroundDrugList, option_nm) eq 0>
				<cfset Session.AvailableDrugCount = Session.AvailableDrugCount + 1>
			</cfif>
		</cfif>
	</cfoutput>
</cfif>