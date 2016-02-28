<cfcomponent>
    <cffunction name="doScreening" access="remote">
        <cfset response = deserializeJSON((toString(getHttpRequestData().content)))>
        <cfset scArr = entityload("screening",{cfid=session.cfid, cftoken="#session.cftoken#"})>
        <cfif arraylen(scArr) eq 0>
            <cfset screening = entityNew("screening")>

            <cfif structKeyExists(response,"state_id")>
                <cfset state = entityload("state",response.state_id)>
                <cfif arraylen(state) neq 0>
                    <cfset screening.setPreset_state(state[1])>
                </cfif>
            </cfif>

            <cfif structKeyExists(response,"prev_id")>
                <cfset prev = entityLoad("screening",response.prev_id)>
                <cfif arraylen(prev) neq 0>
                    <cfset screening.setPrev_screening(prev[1])>
                </cfif>
            </cfif>

            <cfset screening.setLanguage(createObject("component","cf.component.orm.language").getCurrentLanguage())>

            <cfset screening.setCfid(session.cfid)>

            <cfset screening.setCftoken(session.cftoken)>

            <cfset screening.setStart_datetime(Now())>

            <cfset partner = entityload("partner",response.partner_id)>
            <cfif arraylen(partner) neq 0>
                <cfset screening.setPartner(partner[1])>
            </cfif>

            <cfset subset = entityload("subset",response.subset_id)>
            <cfif arraylen(subset) neq 0>
                <cfset screening.setSubset(subset[1])>
            </cfif>

            <cfset entitySave(screening)>
            <cfset entityMerge(screening)>
        <cfelse>
            <cfset screening=scArr[1]>
        </cfif>


       <cfloop collection="#response.response#" item="answerCode">
           <cfset answerField = entityload("answer_field",{code="#answerCode#"})[1]>
           <cfset sa = entityNew("screening_answerfield")>
           <cfset sa.setScreening(screening)>
           <cfset sa.setAnswer(answerField)>
           <cfset sa.setResponse_type(1)>
           <cfset sa.setPage_num(1)>
           <cfset sa.setSubmit_datetime(Now())>
           <cfswitch expression="#answerField.getAnswer_field_type().getId()#">
               <cfcase value="5">
                   <cfset option = entityload("option",response.response[answerCode])[1]>
                   <cfset sa.setOption(option)>
               </cfcase>
               <cfcase value="8">
                   <cfset option = entityload("option",response.response[answerCode]["id"])[1]>
                   <cfset sa.setOption(option)>
               </cfcase>
               <cfcase value="21,22">
                   <cfset sa.setResponse(response.response[answerCode]["id"])>;
               </cfcase>
               <cfdefaultcase>
                   <cfif StructKeyExists(response.response,answerCode)>
                       <cfset sa.setResponse(response.response[answerCode])>
                   </cfif>
               </cfdefaultcase>
           </cfswitch>
           <cfset entitySave(sa)>
       </cfloop>
       <cfreturn 1>
    </cffunction>

</cfcomponent>

