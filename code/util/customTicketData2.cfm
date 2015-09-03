<cfoutput>
<cfquery name="F" datasource="#application.dbSrc#">
      SELECT a.answerfield, asp.subset_id, asp.partner_id, asp.default_value
            FROM answerfield_subset_partner asp, answerfield a
            WHERE asp.background_flag=0
                AND asp.answerfield_id=a.answerfield_id
            ORDER BY asp.answerfield_id, asp.subset_id, asp.partner_id
 </cfquery>
 <cfdump var="#F#">
 <cfabort>
<!--- Start F --->
<cfquery name="F" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'Navigating through the maze of public benefit programs can be difficult and confusing. Many people don''t know what assistance is available — or how to gain access to it.  AARP offers online tools that take the guesswork out of the process for every state in the U.S., the District of Columbia, the U.S. Virgin Islands, Puerto Rico and Guam.  <i>It''s fast, private, and secure!</i>'
 	where display_id = 80739
</cfquery>
<!--- END F --->

<!--- Start G --->
<cfquery name="G_q" datasource="#application.dbSrc#">
	UPDATE question
   	SET dep_question_id = NULL
      ,question_code = 'lis_undeemed'
      ,questioncategory_id = 16
      ,questionheader_id = NULL
      ,questiontype_id = 6
      ,display_id = 3354
      ,short_display_id = 3355
      ,spq_display_id = 7656
      ,print_display_id = 7657
      ,format_id = NULL
      ,rule_id = 1254
      ,include_flag = 0
      ,exclude_flag = 0
      ,suppress_qno_flag = 0
      ,spq_exclude_flag = 0
      ,sort = 32
      ,modify_user_id = 4
      ,modify_date = '2011-10-06 12:02:36'
 	WHERE question_id = 625
</cfquery>
<cfquery name="G_dl_u" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'Have you received a letter from Medicare saying that you will no longer automatically qualify for the def|extrahelp|Extra Help available through the Medicare Prescription Drug Coverage in 2012?'
      ,update_flag = 0
	 WHERE display_id = 3354 and language_id = 'EN'
</cfquery>
<cfquery name="G_dl_v" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'No longer automatically qualify for LIS in 2012?'
      ,update_flag = 0
	 WHERE display_id = 3355 and language_id = 'EN'
</cfquery>
<cfquery name="G_dl_w" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = ''
      ,update_flag = 0
	 WHERE display_id = 7656 and language_id = 'EN'
</cfquery>
<cfquery name="G_dl_x" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = ''
      ,update_flag = 0
	 WHERE display_id = 7657 and language_id = 'EN'
</cfquery>
<cfquery name="G_squ" datasource="#application.dbSrc#">
	DELETE FROM subset_question
      WHERE question_id = 625 and subset_id = 27
</cfquery>
<cfquery name="G_sqv" datasource="#application.dbSrc#">
	DELETE FROM subset_question
      WHERE question_id = 625 and subset_id = 39
</cfquery>
<!--- End G --->

<!--- Start H --->
<cfquery name="G_sqv" datasource="#application.dbSrc#">
	UPDATE display_language
   	SET display_text = 'Help for the Unemployed'
 	where display_id = 80738
</cfquery>
<!--- End H --->

<!--- Start L--->
<!--- I s_income_unemployment --->
<cfquery name="I_du" datasource="#application.dbSrc#">
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
<cfquery name="I_newIDu" datasource="#application.dbSrc#">
	SELECT (display_id) AS newIDu FROM display
</cfquery>
<cfquery name="I_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#I_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="I_dv" datasource="#application.dbSrc#">
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
<cfquery name="I_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="I_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#I_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="I_dw" datasource="#application.dbSrc#">
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
<cfquery name="I_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="I_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#I_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="I_dx" datasource="#application.dbSrc#">
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
<cfquery name="I_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="I_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#I_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="I" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#I_newIDu.newIDu#
           ,#I_newIDv.newIDv#
           ,#I_newIDw.newIDw#
           ,#I_newIDx.newIDx#
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

<!--- J sp_income_unemployment --->
<cfquery name="J_du" datasource="#application.dbSrc#">
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
<cfquery name="J_newIDu" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDu FROM display
</cfquery>
<cfquery name="J_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#J_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="J_dv" datasource="#application.dbSrc#">
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
<cfquery name="J_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="J_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#J_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="J_dw" datasource="#application.dbSrc#">
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
<cfquery name="J_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="J_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#J_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="J_dx" datasource="#application.dbSrc#">
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
<cfquery name="J_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="J_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#J_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="J" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#J_newIDu.newIDu#
           ,#J_newIDv.newIDv#
           ,#J_newIDw.newIDw#
           ,#J_newIDx.newIDx#
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

<!--- K s_sp_income_unemployment --->
<cfquery name="K_du" datasource="#application.dbSrc#">
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
<cfquery name="K_newIDu" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDu FROM display
</cfquery>
<cfquery name="K_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#K_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="K_dv" datasource="#application.dbSrc#">
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
<cfquery name="K_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="K_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#K_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="K_dw" datasource="#application.dbSrc#">
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
<cfquery name="K_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="K_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#K_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="K_dx" datasource="#application.dbSrc#">
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
<cfquery name="K_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="K_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#K_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="K" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#K_newIDu.newIDu#
           ,#K_newIDv.newIDv#
           ,#K_newIDw.newIDw#
           ,#K_newIDx.newIDx#
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
<cfquery name="M_du" datasource="#application.dbSrc#">
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
<cfquery name="M_newIDu" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDu FROM display
</cfquery>
<cfquery name="M_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#M_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="M_dv" datasource="#application.dbSrc#">
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
<cfquery name="M_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="M_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#M_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="M_dw" datasource="#application.dbSrc#">
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
<cfquery name="M_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="M_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#M_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="M_dx" datasource="#application.dbSrc#">
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
<cfquery name="M_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="M_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#M_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="M" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#M_newIDu.newIDu#
           ,#M_newIDv.newIDv#
           ,#M_newIDw.newIDw#
           ,#M_newIDx.newIDx#
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
<cfquery name="N_du" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDu" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDu FROM display
</cfquery>
<cfquery name="N_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="N_dv" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="N_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="N_dw" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="N_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="N_dx" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="N_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="N" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#N_newIDu.newIDu#
           ,#N_newIDv.newIDv#
           ,#N_newIDw.newIDw#
           ,#N_newIDx.newIDx#
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
<cfquery name="N_du" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDu" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDu FROM display
</cfquery>
<cfquery name="N_dlu_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDu.newIDu#
           ,'EN'
           ,'Unemployment Insurance'
           ,0)
</cfquery>
<cfquery name="N_dv" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDv" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDv FROM display
</cfquery>
<cfquery name="N_dlv_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDv.newIDv#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="N_dw" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDw" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDw FROM display
</cfquery>
<cfquery name="N_dlw_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDw.newIDw#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="N_dx" datasource="#application.dbSrc#">
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
<cfquery name="N_newIDx" datasource="#application.dbSrc#">
	SELECT MAX(display_id) AS newIDx FROM display
</cfquery>
<cfquery name="N_dlx_en" datasource="#application.dbSrc#">
    INSERT INTO display_language
           (display_id
           ,language_id
           ,display_text
           ,update_flag)
     VALUES
           (#N_newIDx.newIDx#
           ,'EN'
           ,''
           ,0)
</cfquery>

<cfquery name="K" datasource="#application.dbSrc#">
	INSERT INTO answerfield
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
           ,#N_newIDu.newIDu#
           ,#N_newIDv.newIDv#
           ,#N_newIDw.newIDw#
           ,#N_newIDx.newIDx#
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