<cfquery name="qryMedApproved" datasource="#application.dbSrc#"  >
	SELECT     tbl_prg_all.prg_id, prg_nm,DNumber, LocatorEnable, CMSEnable
	FROM        tbl_prg_all,tbl_RX_PrgDetail
	WHERE     cat_id =<cfqueryparam 
                        value="#cat_id#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="4">  
	and  tbl_prg_all.prg_id in (#preservesinglequotes(prg_list)#)
	and tbl_prg_all.prg_id = tbl_RX_PrgDetail.prg_id
	ORDER BY DNumber ASC
</cfquery>
<cfset session.structMedApproved = structNew()>
<cfset session.structMedApprovedNames = structNew()>
<cfset session.structMedApprovedDNumber = structNew()>
<cfset session.structMedApprovedLocatorEnable = structNew()>
<cfset session.structMedApprovedCMSEnable = structNew()>
<cfloop query="qryMedApproved"> 
	<cfset result = #StructInsert(session.structMedApproved, qryMedApproved.prg_id, "0")# >
	<cfset result = #StructInsert(session.structMedApprovedNames, qryMedApproved.prg_id, qryMedApproved.prg_nm)# >
	<cfset result = #StructInsert(session.structMedApprovedDNumber, qryMedApproved.prg_id, qryMedApproved.DNumber)# >
    <cfset result = #StructInsert(session.structMedApprovedLocatorEnable, qryMedApproved.prg_id, qryMedApproved.LocatorEnable)# >
	 <cfset result = #StructInsert(session.structMedApprovedCMSEnable , qryMedApproved.prg_id, qryMedApproved.CMSEnable)# >
</cfloop>