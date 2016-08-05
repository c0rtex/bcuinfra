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
</cfcomponent>