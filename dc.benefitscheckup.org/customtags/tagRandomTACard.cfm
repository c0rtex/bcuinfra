<cfparam name="attributes.reset" type="string">
<cfif isdefined('attributes.reset') >
	<cfset reset = attributes.reset > 
<cfelse>
	<cfset reset = "Yes" > 
</cfif>
<cfif isdefined('session.structMedApproved') >
	<cfset result = StructClear(session.structMedApproved)>
</cfif>

<cfif isdefined('session.structMedApprovedNames') >
	<cfset result = StructClear(session.structMedApprovedNames)>
</cfif>

<cfif isdefined('session.structMedApprovedDNumber') >
	<cfset result = StructClear(session.structMedApprovedDNumber)>
</cfif>



<cfif isdefined('session.structMedApprovedDNumber') >
	<cfset result = StructClear(session.structMedApprovedDNumber)>
</cfif>

<cfif isdefined('session.structMedApprovedLocatorEnable') >
	<cfset result = StructClear(session.structMedApprovedLocatorEnable)>
</cfif>

<cfquery name="qryMedApproved" datasource="#application.dbSrc#"  >
	SELECT     tbl_prg_all.prg_id, prg_nm,DNumber, LocatorEnable, CMSEnable
	FROM         tbl_prg_all INNER JOIN
                      tbl_RX_PrgDetail ON tbl_prg_all.prg_id = tbl_RX_PrgDetail.PRG_ID
	WHERE     cat_id = 333  
	and tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id
	and prg_desc not like '%INACTIVE%'
	and (StateList like '%FD%'
	or StateList like '%#session.st#%')
</cfquery>



<cfset session.structRandomPrg = structNew()>
<cfset loopCount = 0 >

<cfloop query="qryMedApproved"> 
	<cfset loopCount = loopCount + 1 >
	<cfset result = #StructInsert(session.structRandomPrg,loopCount,qryMedApproved.prg_ID)# >
	<cfset result = #StructInsert(session.structMedApprovedNames, qryMedApproved.prg_id, qryMedApproved.prg_nm)# >
	<cfset result = #StructInsert(session.structMedApprovedDNumber, qryMedApproved.prg_id, qryMedApproved.DNumber)# >
	<cfset result = #StructInsert(session.structMedApprovedCMSEnable, qryMedApproved.prg_id, qryMedApproved.CMSEnable)# >
	<cfset result = #StructInsert(session.structMedApprovedLocatorEnable, qryMedApproved.prg_id, qryMedApproved.LocatorEnable)# >
</cfloop>

<cfif reset eq "Yes">
	<cfset session.PRG = ArrayNew(1)>
	<cfset num1 = #RandRange(1,7)#>
	<cfset unseenVal = 'Null'>
	<cfset session.PRG[1] = #StructFind(session.structRandomPrg, num1)# >
	<cfset num2 = #RandRange(8,14)#>
	<cfset session.PRG[2] = #StructFind(session.structRandomPrg, num2)# >
	<cfset num3 = #RandRange(15,qryMedApproved.recordCount)#>
	<cfset session.PRG[3] = #StructFind(session.structRandomPrg, num3)# >
	<cfset caller.PRG = session.PRG >
</cfif>



	<CFQUERY NAME="qryRandomTA" DATASOURCE="#application.dbSrc#">
	   select prg_id from tbl_user_prgid
	   where clientnum = '#session.clientnum#' and prg_id like '129-333%'
	</CFQUERY>

	<cfif qryRandomTA.recordcount eq 0>
	<CFQUERY NAME="insertRandomTA" DATASOURCE="#application.dbSrc#">
	   INSERT INTO tbl_user_prgid
	   (prg_id, clientnum, unseen)
	   VALUES('#session.PRG[1]#', #session.clientnum#, #unseenVal#)
	</CFQUERY>

	<CFQUERY NAME="insertRandomTA" DATASOURCE="#application.dbSrc#">
	   INSERT INTO tbl_user_prgid
	   (prg_id, clientnum, unseen)
	   VALUES('#session.PRG[2]#', #session.clientnum#, #unseenVal#)
	</CFQUERY>
	
	<CFQUERY NAME="insertRandomTA" DATASOURCE="#application.dbSrc#">
	   INSERT INTO tbl_user_prgid
	   (prg_id, clientnum, unseen)
	   VALUES('#session.PRG[3]#', #session.clientnum#, #unseenVal#)
	</CFQUERY>
	</cfif>