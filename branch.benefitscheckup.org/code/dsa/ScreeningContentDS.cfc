<cfcomponent extends="AbstractDS">
   <cffunction name="getQuery">
       <cfargument name="reqParams">
       <cfquery name="build_array" datasource="#application.dbSrc#">
           SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.subset_id,
subset_content.sort_order,
subset_content.section_code,
screening.preset_state_id as state_id,
1 as programcategory_id,
'' as program_id,
'' as programgroup_id,
0 as bcu_link_flag
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
INNER JOIN screening ON screening.screening_id = screening_content.screening_id
where
screening.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#reqParams.screening_id#">
and subset_content.subset_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#reqParams.subset_id#">
order by section_code, sort_order

       </cfquery>
        <cfreturn build_array>
   </cffunction>
</cfcomponent>
