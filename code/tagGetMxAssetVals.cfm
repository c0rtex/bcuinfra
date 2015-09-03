<cfparam name="strTable" default="" type="string">
<cfquery name="getMxAssetVals" datasource="#application.dbSrc#">
SELECT single, couple
FROM tbl_mx_asset
WHERE st = '#session.st#'
AND tbl_nm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#strTable#" maxlength="50">
</cfquery>
