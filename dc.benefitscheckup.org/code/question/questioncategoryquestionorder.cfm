<cfparam name="id" type="numeric">
<cfparam name="minimum" type="numeric" default="1">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cfif not saving>
	<!--- If not saving the reordered values, then this particular application
	      needs to pre-reorder the questions to group the question before doing
		  the internal category reorder --->
	<cfquery name="preorder" datasource="#application.dbSrc#">
		select q.question_id
		from question q, questioncategory qc
		where q.questioncategory_id=qc.questioncategory_id
		order by qc.sort, q.sort
	</cfquery>
	<cfset itemplace = 1>
	<cfloop query="preorder">
		<cfquery name="reorder" datasource="#application.dbSrc#">
			update question
			set sort=#itemplace#
			where question_id=#question_id#
		</cfquery>
		<cfset itemplace = itemplace + 1>
	</cfloop>
</cfif>

<cf_buildPage title="Question Order in Category" section="question" js="order"><cfoutput>

<cf_buildOrder title="Question Order in Category" table="question" code="questioncategory" selflink="true" startatminimum="true" minimum="#minimum#" condition="questioncategory_id=#id#" redirect="questioncategoryview.cfm?id=#id#" saving="#saving#">

</cfoutput></cf_buildPage>