<cfcomponent rest="true" restpath="/screening">
    <cffunction name="getExisting" access="remote" restpath="/byId/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>

        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset screening_answers = ormexecutequery("from screening_answerfield sa where sa.screening=?",[screening])>

        <cfreturn serializeJSON(screening_answers)>
    </cffunction>

    <cffunction name="savePrescreen" access="remote" restpath="/start" returnType="String" httpMethod="POST">
        <cfargument name="body" type="String">

        <cfset prescreen = deserializeJSON(body)>

        <cftransaction>

        <cfset screening = entityNew("screening")>

        <cfset screening.setCfid(session.cfid)>
        <cfset screening.setCftoken(session.cftoken)>
        <cfset screening.setLanguage(createObject("component","bcu.orm.language").getCurrentLanguage())>
        <cfset screening.setStart_datetime(Now())>

        <cfset state = entityload("state",prescreen.state_id)>
        <cfif arraylen(state) neq 0>
            <cfset screening.setPreset_state(state[1])>
        </cfif>

        <cfset entitySave(screening)>

        <cfloop collection="#prescreen#" item="question">
            <cfif isStruct(prescreen[question])>
                <cfloop collection="#prescreen[question]#" item="afCode">
                    <cfset answerField = entityload("answer_field",{code="#afCode#"})>
                    <cfif arraylen(answerField) neq 0>
                        <cfset this.saveScreeningAnswerfield(screening,answerField[1],0,prescreen[question][afCode])>
                    </cfif>
                </cfloop>
            </cfif>
        </cfloop>

        </cftransaction>

        <cfreturn "{""screening"":#serializeJSON(screening)#,""found_programs"":#createObject("component","bcu.rest.Programs").getExisting(screening.getId())#}">
    </cffunction>

    <cffunction name="saveScreeningAnswerfield">
        <cfargument name="screening">
        <cfargument name="answerField">
        <cfargument name="pgno">
        <cfargument name="value">

        <cfset sa = entityNew("screening_answerfield")>
        <cfset sa.setScreening(screening)>
        <cfset sa.setAnswer(answerField)>
        <cfset sa.setResponse_type(1)>
        <cfset sa.setPage_num(pgno)>
        <cfset sa.setSubmit_datetime(Now())>

        <cfswitch expression="#answerField.getAnswer_field_type().getId()#">
            <cfcase value="5,8,18">
                <cfset option = entityload("option",{code="#value#"})>
                <cfif arraylen(option) neq 0>
                    <cfset sa.setOption(option[1])>
                </cfif>
            </cfcase>
            <cfdefaultcase>
                <cfset sa.setResponse(value)>
            </cfdefaultcase>
        </cfswitch>
        <cfset entitySave(sa)>
    </cffunction>

</cfcomponent>