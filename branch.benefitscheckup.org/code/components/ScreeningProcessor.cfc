<cfcomponent>
    <cffunction name="doScreening" access="remote" returnFormat="plain">
        <cfargument name="state_id" type="string" required="no" default="">
        <cfargument name="subset_id" type="numeric" required="yes" default="0">
        <cfargument name="partner_id" type="numeric" required="yes" default="0">
        <cfargument name="prev_id" type="numeric" required="no" default="-1">
        <cfargument name="response" type="any" required="yes" default="">
        <cfargument name="pgno" type="numeric" required="no" default="1">
        <cfset resp = deserializeJSON(response)>
        <cfset scArr = entityload("screening",{cfid=session.cfid, cftoken="#session.cftoken#"})>
        <cfif arraylen(scArr) eq 0>
            <cfset screening = entityNew("screening")>

            <cfif state_id neq "">
                <cfset state = entityload("state",state_id)>
                <cfif arraylen(state) neq 0>
                    <cfset screening.setPreset_state(state[1])>
                </cfif>
            </cfif>

            <cfif prev_id neq -1>
                <cfset prev = entityLoad("screening",prev_id)>
                <cfif arraylen(prev) neq 0>
                    <cfset screening.setPrev_screening(prev[1])>
                </cfif>
            </cfif>

            <cfset screening.setLanguage(createObject("component","cf.components.orm.language").getCurrentLanguage())>

            <cfset screening.setCfid(session.cfid)>

            <cfset screening.setCftoken(session.cftoken)>

            <cfset screening.setStart_datetime(Now())>

            <cfset partner = entityload("partner",partner_id)>
            <cfif arraylen(partner) neq 0>
                <cfset screening.setPartner(partner[1])>
            </cfif>

            <cfset subset = entityload("subset",subset_id)>
            <cfif arraylen(subset) neq 0>
                <cfset screening.setSubset(subset[1])>
            </cfif>

            <cfset entitySave(screening)>
            <cfset entityMerge(screening)>
        <cfelse>
            <cfset screening=scArr[1]>
        </cfif>


       <cfloop collection="#resp#" item="answerCode">
           <cfset answerField = entityload("answer_field",{code="#answerCode#"})[1]>
           <cfset sa = entityNew("screening_answerfield")>
           <cfset sa.setScreening(screening)>
           <cfset sa.setAnswer(answerField)>
           <cfset sa.setResponse_type(1)>
           <cfset sa.setPage_num(pgno)>
           <cfset sa.setSubmit_datetime(Now())>
           <cfswitch expression="#answerField.getAnswer_field_type().getId()#">
               <cfcase value="5">
                   <cfset option = entityload("option",resp[answerCode])[1]>
                   <cfset sa.setOption(option)>
               </cfcase>
               <cfcase value="8">
                   <cfset option = entityload("option",resp[answerCode]["id"])[1]>
                   <cfset sa.setOption(option)>
               </cfcase>
               <cfcase value="21,22">
                   <cfset sa.setResponse(resp[answerCode]["id"])>;
               </cfcase>
               <cfdefaultcase>
                   <cfif StructKeyExists(resp,answerCode)>
                       <cfset sa.setResponse(resp[answerCode])>
                   </cfif>
               </cfdefaultcase>
           </cfswitch>
           <cfset entitySave(sa)>
       </cfloop>
        <cfif structKeyExists(arguments, "callback")>
            <cfreturn arguments.callback & "({ok:1});">
            <cfelseif structKeyExists(arguments, "jsonp")>
            <cfreturn "jsonp({ok:1});">
        </cfif>
    </cffunction>

</cfcomponent>

