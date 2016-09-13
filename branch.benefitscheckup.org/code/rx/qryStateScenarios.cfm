<cfquery name="qryStateScenarios" datasource="#application.dbSrc#">
SELECT     Template_name, Display_level
FROM         tbl_RX_Scenarios
WHERE     (State = <cfqueryparam 
                        value="#ST#"  
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="2">) and Scenario = <cfqueryparam 
                        value="#Scenario#"  
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="30">
order by Display_level,SortOrder
</cfquery>