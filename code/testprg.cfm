<cfset programCodeList = "">	
<!--- Pull in eligible programs from session.prg_list--->
	<cfquery name="prgConvert" datasource="#application.dbSrc#">
		select p.program_code, pa.prg_id
		from tbl_prg_all pa inner join program p
				on pa.RecID=p.program_id
			left outer join programgroup pg
				on p.programgroup_id=pg.programgroup_id
		where pa.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
		order by pg.sort, p.sort
	</cfquery>
	<cfloop query="prgConvert">
		<cfoutput>#program_code#________#prg_id#<br/></cfoutput>
		<cfset programCodeList = ListAppend(programCodeList, program_code)>
		<cf_cacheProgramPool action="get" code="#program_code#" var="pobj">
	</cfloop>
	


<cfoutput>#programCodeList#</cfoutput>

<cfquery name="qryPAP" datasource="#application.dbSrc#"  >
SELECT     *
FROM         tbl_prg_all
WHERE     (Cat_ID = 331) order by RecID
</cfquery>
<ul >
<cfset firstOutput = 0>
<cfloop query="qryPAP" >
	<cfif listcontains(#session.prg_list#, #qryPAP.prg_id#) >MATCH FOUND <cfoutput>#qryPAP.prg_id#</cfoutput><br>
	<cf_tagGetPrgDrugs prg_id="#qryPAP.prg_id#" type="CheckCount">
	<cfif session.subset_id eq 19><cfset session.AvailableDrugCount = 1></cfif>
	<cfif 	session.AvailableDrugCount gt 0 > 
		<cfset firstOutput = firstOutput + 1 >
		<cfset tempProgName = qryPAP.prg_nm >
		<cfoutput><li>#tempProgName# can provide substantial extra savings on: </li></cfoutput>
		<cfoutput><ul><li><cf_tagGetPrgDrugs prg_id="#qryPAP.prg_id#" type="PAP"></li></ul></cfoutput>
		<br>
		<cfset prg_id = qryPAP.prg_id>
		
	</cfif>
	<cfelse>MATCH NOT FOUND <cfoutput>#qryPAP.prg_id#</cfoutput><br>
	</cfif>
</cfloop>
</ul>
