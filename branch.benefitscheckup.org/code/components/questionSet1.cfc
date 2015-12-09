<!---
	Template Name: QuestionSet1
	Component Purpose: Implementation of abstract root component for web services, that returns questionnaires question sets in json format

	Data Tables: component doesn't use database tables directly

--->

<cfcomponent extends="customQuestionSet">

  <cffunction name="getQuestionsId">
    <cfargument name="state_id" type="string" required="no" default="">
    <cfargument name="subset_id" type="numeric" required="no" default="0">
    <cfargument name="partner_id" type="numeric" required="no" default="0">
    <cfargument name="org_id" type="numeric" required="no" default="0">

    <cfreturn "433,431,13">

  </cffunction>

</cfcomponent>
