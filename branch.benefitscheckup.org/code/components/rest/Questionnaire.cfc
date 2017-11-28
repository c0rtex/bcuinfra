<cfcomponent rest="true" restpath="/questionnaire">

    <cffunction name="drugListRestService" access="remote" restpath="/drugList/{drugCode:(\S)*}" returntype="String" httpMethod="GET">
        <cfargument name="drugCode" required="false" restargsource="Path" type="string"/>
        <cfset drugCodeArr = listToArray(drugCode,',',false,true)>
        <cfreturn serializeJSON(this.getDrugList(drugCode))>
    </cffunction>

    <cffunction name="get" access="remote" restpath="/get/{subsetId:(\d)*}" returntype="String" httpMethod="GET">
        <cfargument name="subsetId" required="false" restargsource="Path" type="string"/>
        <cfargument name="superCategoryCode" required="false" restargsource="Query" type="string" default="BASICS"/>
        <cfargument name="prevScreeningId" required="false" restargsource="Query" type="numeric" default="-1">
        <cfargument name="stateId" required="false" restargsource="Query" type="string" default="NY"/>

        <cfset var subset = entityLoadByPK("subset",subsetId)>

        <cfswitch expression="#subset.getresult_page().getCode()#">
            <cfcase value="prescreen">
                <cfreturn '{"type":"prescreen","screening":#serializeJSON(subset.toStructure())#,"questions":#this.prescreen(subsetId)#}'>
            </cfcase>

            <cfcase value="newresults">
                <cfreturn '{"type":"screening","screening":#serializeJSON(subset.toStructure())#,"questions":#this.screening(superCategoryCode,prevScreeningId,stateId,subsetId)#}'>
            </cfcase>

            <cfdefaultcase>
                <cfreturn '{"type":"screening","screening":#serializeJSON(subset.toStructure())#,"questions":#this.screening(superCategoryCode,prevScreeningId,stateId,subsetId)#}'>
            </cfdefaultcase>
        </cfswitch>
    </cffunction>

    <cffunction name="prescreen" access="remote" restpath="/prescreen" returnType="String" httpMethod="GET">
        <cfargument name="subsetId" required="false" restargsource="Query" type="numeric" default="100">
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
        <cfset questions = ormExecuteQuery("select sq.question from subset_question sq where sq.subset.id=? order by sq.sort",[subsetId])>

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
        <cfargument name="subset_id" required="false" restargsource="Query" type="numeric" default="101"/>

        <cfset sqs = "">
        <cfset ps = ormExecuteQuery("from program_supercategory ps where ps.answerfieldcode in (select sa.answer.code from screening_answerfield sa where sa.screening.id=?)",[prevScreeningId])>
        <cfif arraylen(ps) neq 0>
            <cfset sqs = "0">
        </cfif>
        <cfloop array="#ps#" index="psi">
            <cfset sqs = "#sqs#,#psi.getId()#">
        </cfloop>
        <cfif arraylen(ps) neq 0>
            <cfset sqs = "and (psc.id in (#sqs#) or psc.id is null)">
        </cfif>

       <cfset state = entityLoadByPK("state",stateId)>

        <cfset questions = ormexecutequery("select
                                      distinct q
                                    from
                                      subset_question_tmp sqt join
                                      sqt.question q join
                                      q.question_category qc join
                                      qc.super_category qsc left join
                                      q.answer_fields qa left join
                                      qa.answer a left join
                                      a.programs p left join
                                      p.program_category pc left join
                                      pc.super_category psc
                                    where
                                      sqt.subset.id=?
                                      and sqt.state=?
                                      and qsc.code=?
                                      and (p.state=? or p.state is null)
                                      and ((p.active_flag=1 and p.exclude_flag=0) or (p.id is null))
                                      #sqs#
                                    order by sqt.sort",[subset_id,state,superCategoryCode,state])>

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
                    <cfset strct["answer_fields"] = this.getAnswersFilteredByState(i,state,subset_id,prevScreeningId)>
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
        <cfargument name="drugCode" required="false" type="string" default=""/>
        <cfset drugCodeArr = listToArray(drugCode,',',false,true)>

        <cfset drqText = "select distinct af from program_answer_field paf right join paf.answer_field af join paf.program p where af.answer_field_type.id=13 and paf.answer_field is not null and p.active_flag=1">

        <cfif arraylen(drugCodeArr) neq 0>
            <cfset drqText = "#drqText# and af.code in (''">
            <cfloop array="#drugCodeArr#" index="dri">
                <cfset drqText = "#drqText#,'#dri#'">
            </cfloop>
            <cfset drqText = "#drqText#)">
        </cfif>

        <cfset drg = ormExecuteQuery(drqText)>
        <cfset var retArray = arrayNew(1)>
        <cfset var tmpStrct = structNew()>
        <cfset var i=1>
        <cfloop array="#drg#" index="d">
            <cfset var option = structNew()>
            <cfset option["code"]=d.getCode()>
            <cfset option["display"]=d.getDisplay().getDisplay_text()>
            <cfset option["type"] = "brand">
            <cfset option["programs"]=arrayNew(1)>
            <cfloop array="#d.getPrograms()#" index="p">
                <cfif (p.getActive_flag() eq 1)and(p.getExclude_flag() eq 0)>
                    <cfif arraylen(drugCodeArr) neq 0>
                        <cfset var prgFull = structNew()>
                        <cfset prgFull["prg_nm"]=p.getName_display().getDisplay_text()>
                        <cfset prgFull["prg_desc"]=p.getShort_desc()>
                        <cfset prgFull["code"]=p.getCode()>
                            <cfinvoke  component="Programs"
                                    method = "getProgramForms"
                                    programId = "#p.getId()#"
                                    returnVariable = "forms">
                        <cfset prgFull["id"]=p.getId()>
                        <cfset prgFull["forms"] = forms>
                        <cfset arrayAppend(option["programs"],prgFull)>
                    <cfelse>
                        <cfset arrayAppend(option["programs"],p.getCode())>
                    </cfif>
                </cfif>
            </cfloop>
            <cfset tmpStrct[i] = option>
            <cfset i = i+1>
        </cfloop>

        <cfset drqText = "select distinct afr from answer_field_relationship afr where afr.right_answerfield.answer_field_type.id=14 and afr.left_answerfield in (select paf.answer_field from program_answer_field paf where paf.answer_field.answer_field_type.id=13 and paf.program.active_flag=1)">

        <cfif arraylen(drugCodeArr) neq 0>
            <cfset drqText = "#drqText# and afr.right_answerfield.code in (''">
            <cfloop array="#drugCodeArr#" index="dri">
                <cfset drqText = "#drqText#,'#dri#'">
            </cfloop>
            <cfset drqText = "#drqText#)">
        </cfif>

        <cfset drqText ="#drqText# order by afr.right_answerfield.code">

        <cfset drg = ormExecuteQuery(drqText)>
        <cfset var option = structNew()>
        <cfset option["code"] = "">
        <cfloop array="#drg#" index="d">
            <cfif option["code"] neq d.getRight_answerfield().getCode() >
                <cfset var option = structNew()>
                <cfset option["code"]=d.getRight_answerfield().getCode()>
                <cfset option["display"]=d.getRight_answerfield().getDisplay().getDisplay_text()>
                <cfset option["programs"]=arrayNew(1)>
                <cfset option["type"]="generic">
                <cfset tmpStrct[i] = option>
                <cfset i = i+1>
            </cfif>
            <cfloop array="#d.getLeft_answerfield().getPrograms()#" index="p">
                <cfif (p.getActive_flag() eq 1)and(p.getExclude_flag() eq 0)>
                    <cfset var pbD = structNew()>
                    <cfset pbD["program"] = p.getCode()>
                    <cfif arraylen(drugCodeArr) neq 0>
                        <cfset pbD["prg_nm"]=p.getName_display().getDisplay_text()>
                        <cfset pbD["prg_desc"]=p.getShort_desc()>
                        <cfset pbD["code"]=p.getCode()>
                        <cfinvoke  component="Programs"
                                    method = "getProgramForms"
                                    programId = "#p.getId()#"
                                    returnVariable = "forms">
                        <cfset pbD["forms"] = forms>
                    <cfelse>
                        <cfset pbD["program"] = p.getCode()>
                    </cfif>
                    <cfset pbD["brand_code"] = d.getLeft_answerfield().getCode()>
                    <cfset pbD["brand_name"] = d.getLeft_answerfield().getDisplay().getDisplay_text()>
                    <cfset arrayAppend(option["programs"],pbD)>
                </cfif>
            </cfloop>
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
        <cfargument name="subsetId">
        <cfargument name="screening">

        <cfset answers = ormExecuteQuery("select distinct a from question_answer_field qa join qa.answer a left join a.programs p left join p.subsets s where qa.question=? and (a.state is null or a.state=?) and ((a.answer_field_type.id=18 and (p.state=? or p.state is null) and p.active_flag=1 and p.exclude_flag=0 and s.id=?) or (a.answer_field_type.id<>18 and (p.state=? or p.state is null) and ((p.active_flag=1 and p.exclude_flag=0 and s.id=?) or (p.id is null and s.id is null)))) order by qa.sort",[question,state,state,subsetId,state,subsetId])>
        <cfset var retArray = arrayNew(1)>
        <cfloop array="#answers#" index="i">
            <cfset var afStrct = i.toStructure()>
            <cfif !isNull(i.getDefault_value())>
                <cfset defOpt = ormexecutequery("from option where id=?",[i.getDefault_value()])>
                <cfif arraylen(defOpt) neq 0>
                    <cfset afStrct['default'] = defOpt[1].toStructure()>
                <cfelse>
                    <cfif (afStrct["type"] eq 'yn')>
                        <cfif i.getAnswer().getDefault_value() eq 1>
                            <cfset afStrct['default'] = 'y'>
                        <cfelse>
                            <cfset afStrct['default'] = 'n'>
                        </cfif>
                    <cfelse>
                        <cfset afStrct['default'] = i.getDefault_value()>
                    </cfif>
                </cfif>
            <cfelse>
                <cfif afStrct["code"] eq "no_hh_members">
                    <cfset afStrct['default'] = this.fillHhMembers(screening)>
                </cfif>
            </cfif>
            <cfset arrayAppend(retArray,afStrct)>
        </cfloop>
        <cfreturn retArray>
    </cffunction>

    <cffunction name="fillHhMembers">
        <cfargument name="screening">
        <cfset var sa = ormExecuteQuery("select sa.option.code from screening_answerfield sa where sa.screening.id=? and sa.answer.code='marital_stat'",[screening])>
        <cfif arraylen(sa) gt 0>
            <cfif sa[1] eq "married">
                <cfreturn 2>
            <cfelse>
                <cfreturn 1>
            </cfif>
        <cfelse>
            <cfreturn 0>
        </cfif>
    </cffunction>

</cfcomponent>