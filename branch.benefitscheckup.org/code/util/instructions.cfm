<cfoutput>

<cfquery name="title_id" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS title_id FROM display
</cfquery>

<cfquery name="display_body" datasource="#application.dbSrc#">
 	INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (13
           ,'site_questionnaire_instructions_body'
           ,'General Site Text: questionnaire_instructions_body'
           ,NULL
           ,1)
</cfquery>
<cfquery name="body_id" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS body_id FROM display
</cfquery>
<cfquery name="dl_body" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#body_id.body_id#
           ,'EN'
           ,'You will receive the most complete results if you answer all questions. Click the <img border=''0'' src=''/wp-content/uploads/2011/11/help_button.png'' /> link if you need help answering a question. Please do not click your &quot;Back&quot; button while you are answering the questions, as your answers may not be saved.'
           ,0)
</cfquery>
<cfquery name="siteText_body" datasource="#application.dbSrc#">
	INSERT INTO sitetext
           (sitetext_code
           ,display_id
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           ('questionnaire_instructions_body'
           ,#body_id.body_id#
           ,4
           ,'2012-06-15 17:44:27'
           ,4
           ,'2012-06-15 17:44:27')
</cfquery>
</cfoutput>