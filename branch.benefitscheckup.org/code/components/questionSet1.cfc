<!---
	Template Name: QuestionSet1
	Component Purpose: Implementation of abstract root component for web services, component returns first question set of questionnaire via web service.

	Data Tables: component doesn't use database tables directly

--->

<cfcomponent extends="customQuestionSet">

<!---
  Method returns list of questions id's comma separated. This method is used by method geQuestionSet, implemented in parent component
--->

  <cffunction name="getQuestionsId">
    <cfargument name="state_id" type="string" required="no" default="">
    <cfargument name="subset_id" type="numeric" required="no" default="0">
    <cfargument name="partner_id" type="numeric" required="no" default="0">
    <cfargument name="org_id" type="numeric" required="no" default="0">

    <cfreturn "433,431,13">
  </cffunction>

  <cffunction name="getNextService">
    <cfreturn "questionSet2">
  </cffunction>

</cfcomponent>
