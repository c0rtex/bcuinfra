<cfcomponent rest="true" restpath="/screening">

    <cffunction name="savePrescreen" access="remote" restpath="/savePrescreen" returnType="String" httpMethod="POST">
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

            <cfset subset = entityload("subset",100)>
            <cfif arraylen(subset) neq 0>
                <cfset screening.setSubset(subset[1])>
            </cfif>

            <cfset entitySave(screening)>

            <cfloop collection="#prescreen#" item="afCode">
                <cfset answerField = entityload("answer_field",{code="#afCode#"})>
                <cfif arraylen(answerField) neq 0>
                    <cfset this.saveScreeningAnswerfield(screening,answerField[1],0,prescreen[afCode])>
                </cfif>
            </cfloop>

        </cftransaction>

        <cfset pc = createObject("component","bcu.rest.Programs")>

        <cfset pc.calcForPrescreen(screening.getId())>

        <cfset screening.setEnd_datetime(Now())>
        <cfset entitySave(screening)>

        <cfreturn "{""screening"":#serializeJSON(screening)#,""found_programs"":#pc.calculatedForScreening(screening.getId())#}">
    </cffunction>

    <cffunction name="saveScreening" access="remote" restpath="/saveScreening" returnType="String" httpMethod="POST">
        <cfargument name="body" type="String">

        <cfset answers = deserializeJSON(body)>

        <cfif structKeyExists(answers,"pgno")>
            <cfset pgno = answers.pgno>
        <cfelse>
            <cfset pgno = 1>
        </cfif>

        <cfif structKeyExists(answers,"screening")>
            <cfset screening = entityLoadByPK("screening",answers.screening.id)>
        <cfelse>
            <cftransaction>
                <cfset prescreen = entityLoadByPK("screening", answers.prescreen.id)>

                <cfset screening = entityNew("screening")>

                <cfset screening.setCfid(session.cfid)>
                <cfset screening.setCftoken(session.cftoken)>
                <cfset screening.setLanguage(prescreen.getLanguage())>
                <cfset screening.setStart_datetime(Now())>

                <cfset screening.setPrev_screening(prescreen)>

                <cfset screening.setPreset_state(prescreen.getPreset_state())>

                <cfset subset = entityload("subset",101)>
                <cfif arraylen(subset) neq 0>
                    <cfset screening.setSubset(subset[1])>
                </cfif>

                <cfset entitySave(screening)>

                <cfset saArray = ormExecuteQuery("from screening_answerfield where screening=?",[prescreen])>

                <cfloop array="#saArray#" index="sa">
                    <cfset saNew = entityNew("screening_answerfield")>

                    <cfset saNew.setScreening(screening)>
                    <cfset saNew.setAnswer(sa.getAnswer())>
                    <cfset saNew.setResponse_type(sa.getResponse_type())>
                    <cfset saNew.setPage_num(sa.getPage_num())>
                    <cfset saNew.setSubmit_datetime(Now())>
                    <cfset saNew.setOption(sa.getOption())>
                    <cfset saNew.setResponse(sa.getResponse())>
                    <cfset entitySave(saNew)>
                </cfloop>
            </cftransaction>
        </cfif>

        <cftransaction>
            <cfloop collection="#answers.answers#" item="afCode">
                <cfswitch expression="#afCode#">
                    <cfcase value="drugs">
                        <cfloop array="#answers.answers.drugs#" index="drug">
                            <cfset answerField = entityload("answer_field",{code="#drug#"})>
                            <cfif arraylen(answerField) neq 0>
                                <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,"y")>
                            </cfif>
                        </cfloop>
                    </cfcase>

                    <cfdefaultcase>
                        <cfset answerField = entityload("answer_field",{code="#afCode#"})>
                        <cfif arraylen(answerField) neq 0>
                            <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,answers.answers[afCode])>
                        </cfif>
                    </cfdefaultcase>

                </cfswitch>
            </cfloop>
        </cftransaction>

        <cfif structKeyExists(answers,"lastSet")>
            <cfset screening.setEnd_datetime(Now())>
            <cfset entitySave(screening)>

            <cfset pc = createObject("component","bcu.rest.Programs")>

            <cfset pc.calcForScreening(screening.getId())>

            <cfreturn "{""screening"":#serializeJSON(screening)#,""found_programs"":#pc.calculatedForScreening(screening.getId())#}">
        <cfelse>
            <cfreturn serializeJSON(screening)>
        </cfif>

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
            <cfcase value="18">
                <cfset option = entityload("option",{code="y"})>
                <cfset sa.setOption(option[1])>
            </cfcase>

            <cfcase value="4,5,6,8,13,14,23,25,27,29,30,32,33">
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