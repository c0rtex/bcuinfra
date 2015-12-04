<cfparam name="strTable" default="" type="string">
<cfquery name="getMxIncVals" datasource="#application.dbSrc#">
SELECT single_max, single_min, couple_max, couple_min
FROM tbl_mx_income
WHERE st = '#session.st#'
AND tbl_nm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#strTable#" maxlength="50">
</cfquery>
