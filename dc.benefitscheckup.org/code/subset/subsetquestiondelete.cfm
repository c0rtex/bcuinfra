<cfparam name="subset_id" type="numeric">
<cfparam name="question_id" type="numeric">

<cfquery name="sqdel" datasource="#application.dbSrc#">
	delete from subset_question
	where subset_id=#subset_id#
		and question_id=#question_id#
		and page_id is not null
		and required_flag=0
		and exclude_flag=0
		and options_flag=0
</cfquery>

<cflocation addtoken="no" url="subsetquestions.cfm?id=#subset_id###questionAssociate">