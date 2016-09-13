<cfoutput>
<!--- 6950 AARP: Research and Add Child Care Assistance Program--->




<cfquery name="6595_dl_2" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'No longer automatically qualify for LIS in 2012?'
      ,update_flag = 0
	 WHERE display_id = 3355 and language_id = 'EN'
</cfquery>
<cfquery name="6595_dl_3" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = ''
      ,update_flag = 0
	 WHERE display_id = 7656 and language_id = 'EN'
</cfquery>
<cfquery name="6595_dl_4" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = ''
      ,update_flag = 0
	 WHERE display_id = 7657 and language_id = 'EN'
</cfquery>
<cfquery name="6595_sq1" datasource="#application.dbSrc#">
	DELETE FROM subset_question
      WHERE question_id = 625 and subset_id = 27
</cfquery>
<cfquery name="6595_sq2" datasource="#application.dbSrc#">
	DELETE FROM subset_question
      WHERE question_id = 625 and subset_id = 39
</cfquery>
<!--- End 6595 --->

<!--- Start 6979 --->
<cfquery name="6595_sq2" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'Help for the Unemployed'
 	WHERE where display_id = 80738
</cfquery>
<!--- End 6979 --->

<!--- Start 6945--->
<!--- 6827 s_income_unemployment --->
<cfquery name="x27_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_s_income_unemployment'
           ,'Answerfield Text: s_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="x27_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="x27_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_s_income_unemployment'
           ,'Short Answerfield Text: s_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x27_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="x_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x27_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_s_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: s_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x27_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="x_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x27_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_s_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: s_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="x_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x27" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'s_income_unemployment'
           ,#x_newID1.newID1#
           ,#x_newID2.newID2#
           ,#x_newID3.newID3#
           ,#x_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:30:51'
           ,4
           ,'2012-03-19 12:30:51')
</cfquery>

<!--- 6828 sp_income_unemployment --->
<cfquery name="x28_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_sp_income_unemployment'
           ,'Answerfield Text: sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x28_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="x_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="x28_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_sp_income_unemployment'
           ,'Short Answerfield Text: sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="x_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_sp_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="x_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6828_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_sp_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="x_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'sp_income_unemployment'
           ,#x_newID1.newID1#
           ,#x_newID2.newID2#
           ,#x_newID3.newID3#
           ,#x_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:31:19'
           ,4
           ,'2012-03-19 12:31:19')
</cfquery>

<!--- 6829 s_sp_income_unemployment --->
<cfquery name="x_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_s_sp_income_unemployment'
           ,'Answerfield Text: s_sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="x_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="6829_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_s_sp_income_unemployment'
           ,'Short Answerfield Text: s_sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="6829_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_s_sp_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: s_sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="6829_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_s_sp_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: s_sp_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="6829_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'s_sp_income_unemployment'
           ,#x29_newID1.newID1#
           ,#x29_newID2.newID2#
           ,#x29_newID3.newID3#
           ,#x29_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:31:38'
           ,4
           ,'2012-03-19 12:31:38')
</cfquery>

<!--- 6830 hh_income_unemployment --->
<cfquery name="6829_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_hh_income_unemployment'
           ,'Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="6829_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="6829_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_hh_income_unemployment'
           ,'Short Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="6829_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_hh_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="6829_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_hh_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="6829_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'hh_income_unemployment'
           ,#x29_newID1.newID1#
           ,#x29_newID2.newID2#
           ,#x29_newID3.newID3#
           ,#x29_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:31:57'
           ,4
           ,'2012-03-19 12:31:57')
</cfquery>

<!--- 6831 s_sp_income_unemployment_simple --->
<cfquery name="6829_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_hh_income_unemployment'
           ,'Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="6829_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="6829_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_hh_income_unemployment'
           ,'Short Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="6829_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_hh_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="6829_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_hh_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="6829_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="6829" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'hh_income_unemployment'
           ,#x29_newID1.newID1#
           ,#x29_newID2.newID2#
           ,#x29_newID3.newID3#
           ,#x29_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:33:25'
           ,4
           ,'2012-03-19 12:33:25')
</cfquery>

<!--- 6831 hh_income_unemployment_simple --->
<cfquery name="6829_d1" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (5
           ,'answerfield_hh_income_unemployment'
           ,'Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID1" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID1 FROM display
</cfquery>
<cfquery name="6829_dl1_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID1.newID1#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="6829_d2" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (14
           ,'afshort_hh_income_unemployment'
           ,'Short Answerfield Text: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID2" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID2 FROM display
</cfquery>
<cfquery name="x29_dl2_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID2.newID2#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x29_d3" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (37
           ,'afspq_hh_income_unemployment'
           ,'Alternate Answerfield Text for Single-Page Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID3" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID3 FROM display
</cfquery>
<cfquery name="x29_dl3_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID3.newID3#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x29_d4" datasource="#application.dbSrc#">
    INSERT INTO display
           (displaygroup_id
           ,display_code
           ,display_name
           ,display_desc
           ,active_flag)
     VALUES
           (38
           ,'afprint_hh_income_unemployment'
           ,'Alternate Answerfield Text for Printed Questionnaire: hh_income_unemployment'
           ,NULL
           ,1)
</cfquery>
<cfquery name="x29_newID4" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newID4 FROM display
</cfquery>
<cfquery name="x29_dl4_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#x29_newID4.newID4#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="x29" datasource="#application.dbSrc#">
	INSERT INTO BCU.dbo.answerfield
           (answerfieldtype_id
           ,answerfield
           ,display_id
           ,short_display_id
           ,spq_display_id
           ,print_display_id
           ,max_length
           ,default_value
           ,spq_default_value
           ,oe_default_value
           ,required_flag
           ,rule_id
           ,validation_id
           ,state_id
           ,answerfield_desc
           ,create_user_id
           ,create_date
           ,modify_user_id
           ,modify_date)
     VALUES
           (16
           ,'hh_income_unemployment'
           ,#x29_newID1.newID1#
           ,#x29_newID2.newID2#
           ,#x29_newID3.newID3#
           ,#x29_newID4.newID4#
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,4
           ,'2012-03-19 12:33:45'
           ,4
           ,'2012-03-19 12:33:45')
</cfquery>

<!--- End 6945 --->
</cfoutput>