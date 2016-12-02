<cfcomponent rest="true" restpath="/questionnaire">
    <cffunction name="prescreen" access="remote" restpath="/prescreen" returnType="String" httpMethod="GET">
        <!---SELECT
        subset_question.subset_id,
        question.question_id,
        question.question_code,
        subset_question.sort,
        subset_question.page_id,
        subset_question.options_flag,
        subset_question.exclude_flag,
        subset_question.required_flag,
        subset_questioncategory.questioncategory_id,
        questioncategory.questioncategory_code,
        questioncategory.questioncategory_desc
        FROM
        question
        INNER JOIN subset_question ON subset_question.question_id = question.question_id
        INNER JOIN subset_questioncategory ON subset_questioncategory.subset_id = subset_question.subset_id
        INNER JOIN questioncategory ON questioncategory.questioncategory_id = subset_questioncategory.questioncategory_id
        where subset_question.subset_id = 0
        order by subset_question.sort--->
        <cfset questions = ormExecuteQuery("select sq.question from subset_question sq where sq.subset.id=100 order by sq.sort")>

        <cfset retVal = arrayNew(1)>

        <cfloop array="#questions#" index="i">
            <cfset arrayAppend(retVal,i.toStructure())>
        </cfloop>

        <cfreturn serializeJSON(retVal)>

    </cffunction>

    <cffunction name="screening" access="remote" restpath="/{superCategoryCode}/{prevScreeningId}/{stateId}" returnType="String" httpMethod="GET">
        <cfargument name="superCategoryCode" required="true" restargsource="Path" type="string"/>
        <cfargument name="prevScreeningId" required="false" restargsource="Path" type="numeric" default="-1">
        <cfargument name="stateId" required="true" restargsource="Path" type="string"/>

        <cfset sqs = "">
        <cfset ps = ormExecuteQuery("from program_supercategory ps where ps.answerfieldcode in (select sa.answer.code from screening_answerfield sa where sa.screening.id=?)",[prevScreeningId])>
        <cfif arraylen(ps) neq 0>
            <cfset sqs = "0">
        </cfif>
        <cfloop array="#ps#" index="psi">
            <cfset sqs = "#sqs#,#psi.getId()#">
        </cfloop>
        <cfif arraylen(ps) neq 0>
            <cfset sqs = "and (sqp.supercategory_id in (#sqs#) or sqp.supercategory_id is null)">
        </cfif>

        <!---SELECT
        subset_question_tmp.subset_id,
        question.question_id,
        question.question_code,
        subset_question_tmp.sort,
        subset_question_tmp.page_id,
        subset_question_tmp.options_flag,
        subset_question_tmp.exclude_flag,
        subset_question_tmp.required_flag,
        question_supercategory.supercategory_id,
        question_supercategory.supercategory_code,
        questioncategory.questioncategory_code
        FROM
        question
        INNER JOIN subset_question_tmp ON subset_question_tmp.question_id = question.question_id
        INNER JOIN questioncategory ON questioncategory.questioncategory_id = question.questioncategory_id
        INNER JOIN question_supercategory ON question_supercategory.supercategory_id = questioncategory.supercategory_id
        where subset_question_tmp.subset_id = 101
        and question_supercategory.supercategory_code in ('finances')

        and subset_question_tmp.state_id = 'MN'
        order by subset_question_tmp.sort--->

       <cfset state = entityLoadByPK("state",stateId)>


        <cfset questions = ormexecutequery("select
                                              distinct q
                                            from
                                              subset_question_tmp sqt join
                                              sqt.question q join
                                              q.question_category qc join
                                              qc.super_category sc
                                              left join q.subset_question_programcategory sqp
                                            where
                                              sqt.subset.id=101
                                              and sqt.state=?
                                              and sc.code=?
                                              #sqs#
                                            order by sqt.sort",[state,superCategoryCode])>


        <cfset retVal = arrayNew(1)>
        <cfset display = createObject("component","bcu.orm.display")>

        <cfloop array="#questions#" index="i">
            <cfset strct = i.toStructure()>
            <cfset strct["display"] = display.expandTextCodes(strct["display"])>

             <cfswitch expression="#i.getCode()#">

                <cfcase value="drugs">
                    <cfset strct["answer_fields"] = this.getDrugList()>
                </cfcase>

                <cfcase value="incomegrid">
                    <cfset strct["answer_fields"] = this.getIncomeAnswerfields()>
                </cfcase>

                <cfcase value="assetgrid">
                    <cfset strct["answer_fields"] = this.getAssetAnswerfields()>
                </cfcase>

                <cfdefaultcase>
                    <cfset strct["answer_fields"] = this.getAnswersFilteredByState(i,state)>
                </cfdefaultcase>

            </cfswitch>

            <cfset arrayAppend(retVal,strct)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

    <cffunction name="getAssetAnswerfields">
        <cfset assets = ormExecuteQuery("from xassettype where exclude_flag=0 order by sort")>
        <cfset var retArray = arrayNew(1)>
        <cfloop array="#assets#" index="a">
            <cfset var retStrct = structNew()>
            <cfset retStrct["code"] = a.getVarname()>
            <cfset retStrct["display"] = a.getName()>
            <cfset retStrct["required"] = "0">
            <cfset retStrct["sort"] = a.getSort()>
            <cfset retStrct["id"] = a.getId()>
            <cfset retStrct["type"] = "grid">
            <cfset retStrct["earned"] = a.getEarned_flag()>
            <cfset var helps = ormExecuteQuery("from help where keyword=?",[a.getDefinition()])>
            <cfif arraylen(helps) gt 0>
                <cfset retStrct["description"] = helps[1].getDisplay().getDisplay_text()>
            <cfelse>
                <cfset retStrct["description"] = "">
            </cfif>
            <cfset arrayAppend(retArray,retStrct)>
        </cfloop>
        <cfreturn retArray>
    </cffunction>

    <cffunction name="getIncomeAnswerfields">
        <cfset incomes = ormExecuteQuery("from xincometype where exclude_flag=0 order by sort")>
        <cfset var retArray = arrayNew(1)>
        <cfloop array="#incomes#" index="a">
            <cfset var retStrct = structNew()>
            <cfset retStrct["code"] = a.getVarname()>
            <cfset retStrct["display"] = a.getName()>
            <cfset retStrct["required"] = "0">
            <cfset retStrct["sort"] = a.getSort()>
            <cfset retStrct["id"] = a.getId()>
            <cfset retStrct["type"] = "grid">
            <cfset retStrct["earned"] = a.getEarned_flag()>
            <cfset var helps = ormExecuteQuery("from help where keyword=?",[a.getDefinition()])>
            <cfif arraylen(helps) gt 0>
                <cfset retStrct["description"] = helps[1].getDisplay().getDisplay_text()>
            <cfelse>
                <cfset retStrct["description"] = "">
            </cfif>
            <cfset arrayAppend(retArray,retStrct)>
        </cfloop>
        <cfreturn retArray>
    </cffunction>

    <cffunction name="getDrugList">
        <cfset drg = ormExecuteQuery("select distinct af from program_answer_field paf right join paf.answer_field af join paf.program p where af.answer_field_type.id=13 and paf.answer_field is not null and p.active_flag=1")>
        <cfset var retArray = arrayNew(1)>
        <cfset var tmpStrct = structNew()>
        <cfset var i=1>
        <cfloop array="#drg#" index="d">
            <cfset var option = structNew()>
            <cfset option["code"]=d.getCode()>
            <cfset option["display"]=d.getDisplay().getDisplay_text()>
            <cfset tmpStrct[i] = option>
            <cfset i = i+1>
        </cfloop>
        <cfset drg = ormExecuteQuery("select distinct afr.right_answerfield from answer_field_relationship afr where afr.right_answerfield.answer_field_type.id=14 and afr.left_answerfield in (select paf.answer_field from program_answer_field paf where paf.answer_field.answer_field_type.id=13 and paf.program.active_flag=1)")>
        <cfloop array="#drg#" index="d">
            <cfset var option = structNew()>
            <cfset option["code"]=d.getCode()>
            <cfset option["display"]=d.getDisplay().getDisplay_text()>
            <cfset tmpStrct[i] = option>
            <cfset i = i+1>
        </cfloop>
        <cfset keys = structsort(tmpStrct,"textnocase","ASC","display")>
        <cfloop from="1" to="#arrayLen(keys)#" index="i">
            <cfset arrayAppend(retArray,tmpStrct[keys[i]])>
        </cfloop>
        <cfset var retVal = structNew()>
        <cfset retVal["type"]="druglist">
        <cfset retVal["options"] = retArray>
        <cfset retVal["count"] = arraylen(retArray)>
        <cfset var retArray = arrayNew(1)>
        <cfset arrayAppend(retArray,retVal)>
        <cfreturn retArray>
    </cffunction>

    <cffunction name="getAnswersFilteredByState">
        <cfargument name="question">
        <cfargument name="state" default="">
        <cfif ((question.getCode() eq 'receive')OR(question.getCode() eq 'interests'))>
            <cfset answers = ormExecuteQuery("select distinct a from question_answer_field qaf join qaf.answer a join a.programs p where qaf.question=? and (p.state is null or p.state=?) and (a.state is null or a.state=?) and p.active_flag=1 order by qaf.sort",[question,state,state])>
        <cfelse>
            <cfset answers = ormExecuteQuery("select distinct a from question_answer_field qaf join qaf.answer a where qaf.question=? and (a.state is null or a.state=?) order by qaf.sort",[question,state])>
        </cfif>
        <cfset var retArray = arrayNew(1)>
        <cfloop array="#answers#" index="i">
            <cfset var afStrct = i.toStructure()>
            <cfif !isNull(i.getDefault_value())>
                <cfset defOpt = ormexecutequery("from option where id=?",[i.getDefault_value()])>
                <cfif arraylen(defOpt) neq 0>
                    <cfset afStrct['default'] = defOpt[1].toStructure()>
                <cfelse>
                    <cfif (afStrct["type"] eq 'yn')>
                        <cfif i.getDefault_value() eq 1>
                            <cfset afStrct['default'] = 'y'>
                        <cfelse>
                            <cfset afStrct['default'] = 'n'>
                        </cfif>
                    <cfelse>
                        <cfset afStrct['default'] = i.getDefault_value()>
                    </cfif>
                </cfif>
            </cfif>
            <cfset arrayAppend(retArray,afStrct)>
        </cfloop>
        <cfreturn retArray>
    </cffunction>

</cfcomponent>