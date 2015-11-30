<cfquery name="qryPAP" datasource="#application.dbSrc#"  >
SELECT     prg_id, prg_nm
FROM         tbl_prg_all
WHERE     (Cat_ID = 331)
</cfquery>