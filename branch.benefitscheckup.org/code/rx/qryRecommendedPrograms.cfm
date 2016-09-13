 <!--- Update user program table and flag any programs recommended --->
 <cfloop list="#session.prg_list#" index="temp_prg_id">
 <cfif not #listcontains(RxPrgList,temp_prg_id,"','")# >
 <cfoutput>#temp_prg_id#</cfoutput>
 <cfquery datasource="#application.dbSrc#" name="qryUpdateUserPrg">
  Update tbl_user_prgid
  SET Unseen = 1
  where clientnum = <cfqueryparam 
                        value="#session.clientnum#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="10">
  and prg_id =  <cfqueryparam 
                        value="#temp_prg_id#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
 </cfquery>
 </cfif>
 </cfloop>
 