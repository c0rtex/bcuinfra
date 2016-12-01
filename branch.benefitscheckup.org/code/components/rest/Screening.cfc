<cfcomponent rest="true" restpath="/screening">

    <cffunction name="getDefaultSource">
        <cfset var source = entityload("source",1)>
        <cfif arraylen(source) neq 0>
            <cfreturn source[1]>
        </cfif>
    </cffunction>

    <cffunction name="savePrescreen" access="remote" restpath="/savePrescreen" returnType="String" httpMethod="POST">
        <cfargument name="body" type="String">

        <cfset prescreen = deserializeJSON(body)>

        <cftransaction>

            <cfset screening = entityNew("screening")>

            <cfset screening.setCfid(session.cfid)>
            <cfset screening.setCftoken(session.cftoken)>
            <cfset screening.setLanguage(createObject("component","bcu.orm.language").getCurrentLanguage())>
            <cfset screening.setStart_datetime(Now())>
            <cfset screening.setSource(this.getDefaultSource())>
            <cfset screening.setOrg_id(0)>
            <cfset screening.setPartner_id(0)>

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
                    <cfset this.saveScreeningAnswerfield(screening,answerField[1],0,prescreen[afCode],0)>
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
            <cftransaction>
                <cfset ormExecuteQuery("delete from screening_answerfield sa where sa.screening=? and sa.page_num=?",[screening,pgno])>
            </cftransaction>
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
                <cfset screening.setSource(this.getDefaultSource())>
                <cfset screening.setOrg_id(0)>
                <cfset screening.setPartner_id(0)>

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
                                <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,"y",0)>
                            </cfif>
                        </cfloop>
                    </cfcase>

                    <cfdefaultcase>
                        <cfset answerField = entityload("answer_field",{code="#afCode#"})>
                        <cfif arraylen(answerField) neq 0>
                            <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,answers.answers[afCode],0)>
                        </cfif>
                    </cfdefaultcase>

                </cfswitch>
            </cfloop>
        </cftransaction>

        <cfif structKeyExists(answers,"lastSet")>
            <cfset this.calcLastSet(screening,pgno)>
            <cfset screening.setEnd_datetime(Now())>
            <cfset entitySave(screening)>

            <cfset pc = createObject("component","bcu.rest.Programs")>

            <cfset pc.calcForScreening(screening.getId())>

            <cfreturn "{""screening"":#serializeJSON(screening)#,""found_programs"":#pc.calculatedForScreening(screening.getId())#}">
        <cfelse>
            <cfreturn serializeJSON(screening)>
        </cfif>

    </cffunction>

    <cffunction name="calcLastSet">
        <cfargument name="screening">
        <cfargument name="pgno">
        <cfset var sa = ormExecuteQuery("from screening_answerfield sa where sa.screening=?",[screening])>
        <cfset var saArray = structNew()>
        <cfloop array="#sa#" index="i">
            <cfif isNull(i.getOption())>
                <cfset saArray[i.getAnswer().getCode()]=i.getResponse()>
            <cfelse>
                <cfset saArray[i.getAnswer().getCode()]=i.getOption().getCode()>
            </cfif>
        </cfloop>


        <cfset var memCount=0>
        <cfif structKeyExists(saArray,"no_hh_members")>
            <cfif saArray["no_hh_members"] gt 0>
                <cfset memCount = saArray["no_hh_members"]>
            </cfif>
        </cfif>

        <cfif ((memCount eq 0)and(structKeyExists(saArray,"hh_depend")))>
            <cfset memCount = saArray["hh_depend"]>
        </cfif>

        <cfif memCount  eq 0 or memCount eq ''>
            <cfset memCount = 1>
        <cfelseif memCount gt 8>
            <cfset memCount   = 8>
        </cfif>

        <cfset getPoverty = ormExecuteQuery("select mem#memCount# from tbl_inc where proc_id = 484")>

        <cfset povertyIndex = saArray["hh_income_total_complete"]/getPoverty[1]>

        <cfset var answerField = entityload("answer_field",{code="poverty_index"})>

        <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,povertyIndex,1)>

        <cfset county = ormExecuteQuery("select id from county c where c.name=? and c.state.id=?",[saArray["county"],saArray["st"]])>
        <cfif arraylen(county) neq 0>
            <cfset var answerField = entityload("answer_field",{code="county_id"})>
            <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,county[1],1)>
        </cfif>

        <cfset var answerField = entityload("answer_field",{code="pri_resident"})>
        <cfset this.saveScreeningAnswerfield(screening,answerField[1],pgno,'y',1)>
    </cffunction>

    <cffunction name="saveScreeningAnswerfield">
        <cfargument name="screening">
        <cfargument name="answerField">
        <cfargument name="pgno">
        <cfargument name="value">
        <cfargument name="derivedFlag" default="0">

        <cfset sa = entityNew("screening_answerfield")>
        <cfset sa.setScreening(screening)>
        <cfset sa.setAnswer(answerField)>
        <cfset sa.setResponse_type(1)>
        <cfset sa.setPage_num(pgno)>
        <cfset sa.setSubmit_datetime(Now())>
        <cfset sa.setDerived_flag(derivedFlag)>

        <cfswitch expression="#answerField.getAnswer_field_type().getId()#">
            <cfcase value="18">
                <cfset option = entityload("option",{code="y"})>
                <cfset sa.setOption(option[1])>
            </cfcase>

            <cfcase value="5,6,13,23,25,27,29,30,32,33">
                <cfset option = entityload("option",{code="#value#"})>
                <cfif arraylen(option) neq 0>
                    <cfset sa.setOption(option[1])>
                </cfif>
            </cfcase>

            <cfcase value="14">
                <cfset var relDrug = ormExecuteQuery("select afr.left_answerfield from answer_field_relationship afr where afr.right_answerfield=?",[sa.getAnswer()])>
                <cfif arraylen(relDrug) neq 0>
                    <cfset sa.setAnswer(relDrug[1])>
                </cfif>
                <cfset option = entityload("option",{code="#value#"})>
                <cfif arraylen(option) neq 0>
                    <cfset sa.setOption(option[1])>
                </cfif>
            </cfcase>

            <cfcase value="8">
                <cfset option = entityload("option",{code="#value.code#"})>
                <cfif arraylen(option) neq 0>
                    <cfset sa.setOption(option[1])>
                </cfif>
            </cfcase>

            <cfcase value="21">
                <cfset sa.setResponse(value.id)>;
            </cfcase>

            <cfdefaultcase>
                <cfset sa.setResponse(value)>
            </cfdefaultcase>

        </cfswitch>
        <cfset entitySave(sa)>
    </cffunction>

</cfcomponent>