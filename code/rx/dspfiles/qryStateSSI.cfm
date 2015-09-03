<cfquery name="qryStateSSI" datasource="#application.dbSrc#">
SELECT sp.program_id, p.prg_id, p.prg_nm
	FROM xsubset_program AS sp, tbl_prg_all AS p
	WHERE sp.subset_id=20
		AND (sp.exclude_flag <> 1 OR sp.exclude_flag IS NULL)
	    AND sp.program_id=p.recid
		AND p.st =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2">
					ORDER BY p.prg_nm, p.prg_id
</cfquery>
