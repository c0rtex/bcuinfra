<!-- update edited question -->

<cfquery datasource="#application.dbSrc#" name="hints">
	SELECT keyword
	FROM tbl_hints
	WHERE keyword = '#question_id#'
</cfquery>

<cfif hints.RecordCount eq 0>
	<cfif Trim(hint) neq ''>
		<cfquery datasource="#application.dbSrc#">
			insert into tbl_hints
				(keyword, definition)
			values
				('#question_id#', '#Trim(hint)#')
		</cfquery>
	</cfif>
<cfelse>
	<cfif Trim(hint) eq ''>
		<cfquery datasource="#application.dbSrc#">
			delete from tbl_hints
			where keyword = '#question_id#'
		</cfquery>
	<cfelse>
		<cfquery datasource="#application.dbSrc#">
			update tbl_hints
			set definition = '#Trim(hint)#'
			where keyword = '#question_id#'
		</cfquery>
	</cfif>
</cfif>

<cfupdate datasource="#application.dbSrc#" tablename="tbl_questions_new" formfields="question,order_num,category,pri_sec,type,validation,textlength,dep_field,dep_criteria,dep_op,answerfield,question_id">

<cflocation url="questions.cfm">