<!--display list of drugs user has selected -->
<cfset selectedDrugs = #attributes.selectedDrugs# >
<cfif IsDefined('selectedDrugs')>
<cfset position = ListFindNoCase(selectedDrugs, "null", ",")>
<cfif position gt 0>
	<cfset selectedDrugs = ListDeleteAt(selectedDrugs, position ,  "," )>
</cfif>
<cfset TotalDrugs = #ListLen(selectedDrugs, ",")#  >
<cfset hasOutputted=false>
<cfset tempCount = 0 >
<cfloop list="#selectedDrugs#" index="chosendrug">
<cfset tempCount = tempCount + 1 >
<cfif #hasOutputted# EQ false>
<!-- Output this sentence one time -->
<cfoutput><li>Taking the following medications:<br></li></cfoutput>
<cfset hasOutputted=true>
<ul>
</cfif>
<cfif Left(chosendrug, 1) eq 'g'>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
			select answerfield_id as generic_id, a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield a left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
			where a.answerfieldtype_id=14 and a.answerfield =<cfqueryparam 
                        value="#LCase(chosendrug)#"  
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="50"> 
	</CFQUERY>
<cfelse>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
	select a.answerfield,substring(dl.display_text, 1, 255) as option_nm
	from answerfield a left outer join display_language dl
	on a.display_id=dl.display_id and dl.language_id='EN'
	where a.answerfieldtype_id=13 and lower(a.answerfield) = <cfqueryparam 
                        value="#LCase(chosendrug)#"  
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="50"> 
	</CFQUERY>
</cfif>
<CFOUTPUT query="getName">
#option_nm#
</CFOUTPUT>
<cfif tempCount eq (#TotalDrugs# - 1)>
and
<cfelseif tempCount lt #TotalDrugs# >
,
</cfif>
</cfloop>
</cfif>
</ul>