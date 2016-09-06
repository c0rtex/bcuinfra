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
        <cfset questions = ormExecuteQuery("select sq.question from subset_question sq where sq.subset.id=0 order by sq.sort")>

        <cfset retVal = arrayNew(1)>

        <cfloop array="#questions#" index="i">
            <cfset arrayAppend(retVal,i.toStructure())>
        </cfloop>

        <cfreturn serializeJSON(retVal)>

    </cffunction>

    <cffunction name="screening" access="remote" restpath="/screening/{superCategoryCode}/{stateId}" returnType="String" httpMethod="GET">
        <cfargument name="superCategoryCode" required="true" restargsource="Path" type="string"/>
        <cfargument name="stateId" required="true" restargsource="Path" type="string"/>

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
                                              q
                                            from
                                              subset_question_tmp sqt join
                                              sqt.question q join
                                              q.question_category qc join
                                              qc.super_category sc
                                            where
                                              sqt.subset.id=101
                                              and sqt.state=?
                                              and sc.code=?
                                            order by sqt.sort",[state,superCategoryCode])>


        <cfset retVal = arrayNew(1)>

        <cfloop array="#questions#" index="i">
            <cfset arrayAppend(retVal,i.toStructure())>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>
</cfcomponent>