
<cfset subset_id = 0>
<cfset new_subset_id = 101>
<cfquery name="statequery" datasource="dbSrc  ">
select state_id from state where statetype_id = 1
</cfquery>
<cfquery name="questiondetails" datasource="dbSrc  ">
select question_id, sort, exclude_flag from question where question_id = 67
</cfquery>


<cfloop query="#statequery#" >
<hr>
<cfquery name="insertquestions" datasource="dbSrc  ">
INSERT INTO subset_question_tmp (question_id, subset_id, state_id, required_flag, exclude_flag,options_flag, sort )
VALUES (#questiondetails.question_id#,101, '#statequery.state_id#',0,#questiondetails.exclude_flag#,0,#questiondetails.sort#);
</cfquery>

<cfoutput><h1>#questiondetails.question_id# questions inserted for state: #statequery.state_id#</h1><hr></cfoutput>
<cfflush>
</cfloop>
<cfoutput><h1>DONE</h1></cfoutput>