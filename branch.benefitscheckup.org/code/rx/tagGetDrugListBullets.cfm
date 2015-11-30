<!--display list of drugs in a bulleted list format-->
<cfset selectedDrugs = #attributes.selectedDrugs# >
<cfset strClient = #attributes.strClient# >
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
<cfoutput><li><cfif #StrClient# IS "self">You are<cfelse>Your #StrClient# is</cfif> taking the following medications<cfif IsDefined('session.drugnumber')> <em>(<a href="frmDrugList.cfm?shownumber=#session.drugnumber#&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a> to make any corrections)</em></cfif>:</li></cfoutput>
<cfset hasOutputted=true>
<ul>
</cfif>
<cfif Left(chosendrug, 1) eq 'g'>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
			select answerfield_id as generic_id, a.answerfield, substring(dl.display_text, 1, 255) as option_nm
			from answerfield a left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
			where a.answerfieldtype_id=14 and a.answerfield = <cfqueryparam 
                        value="#LCase(chosendrug)#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="50"> 
	</CFQUERY>
<cfelse>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="getName">
	select a.answerfield,substring(dl.display_text, 1, 255) as option_nm
	from answerfield a left outer join display_language dl
	on a.display_id=dl.display_id and dl.language_id='EN'
	where a.answerfieldtype_id=13 and lower(a.answerfield) =<cfqueryparam 
                        value="#LCase(chosendrug)#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="50"> 
	</CFQUERY>
</cfif>
<CFOUTPUT query="getName">
<li>#option_nm#</li>
</CFOUTPUT>
</cfloop>
</cfif>
</ul>