



<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

SELECT * from tbl_questions_new q, 
		subset_question sq where q.question_id = sq.question_id 
		and sq.subset_id=93
		order by sq.sort
</cfquery><cfdump var="#results10#"><cfabort>

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

show tables
</cfquery><cfdump var="#results10#"><cfabort>

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

update subset_question set sort = 1  where subset_id = 93 and question_id = 13
</cfquery>
<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

update subset_question set sort = 2  where subset_id = 93 and question_id = 14
</cfquery>
<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

update subset_question set sort = 4  where subset_id = 93 and question_id = 888
</cfquery>


<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">
update subset_question set sort = 3  where subset_id = 93 and question_id = 891
</cfquery>

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

Select * from subset_question where subset_id = 93
</cfquery>
<cfdump var="#results10#"><cfabort>

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">

Select * from subset_program_sum sps, program p , display_language dl, programcategory pc
where subset_id = 93
and p.program_id = sps.program_id
and  p.programcategory_id = pc.programcategory_id
and p.name_display_id = dl.display_id
and dl.language_id = 'EN'
and active_flag = 1 
and (state_id = 'AK' or state_id is null)
order by p.sort
</cfquery>
<cfdump var="#results10#">

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">
Select * from subset_programcategory sp, programcategory pc, display_language dl
where sp.programcategory_id = pc.programcategory_id
and dl.display_id = pc.display_id
and sp.subset_id = 93 
and dl.language_id = 'EN'
order by sort
</cfquery>
<cfdump var="#results10#">
<cfabort>


<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">				 
select * from affinity_partner;
</cfquery>
<cfdump var="#results10#"><cfabort>
<cfquery name="results10"  datasource="wp_benefitscheckup">
select post_name, post_code, id, post_type, post_content, post_status from wp_posts 
where post_type = 'page'
</cfquery>
<cfdump var="#results10#">
<cfquery name="results10"  datasource="wp_benefitscheckup">
update  wp_posts_v3_1 set 
post_content = 'The Health Insurance Marketplace helps people without health coverage find and enroll in a plan. If you don\'t have coverage through a job, Medicare, Medicaid, the Children\'s Health Insurance Program (CHIP), or another source, the Marketplace can help you find and enroll in a plan that fits your budget and meets your needs. <a href="https://www.healthcare.gov/">Visit the Health Insurance Marketplace</a>. <strong>Note</strong>: You can enroll in a Marketplace plan during the <a href="https://www.healthcare.gov/marketplace-deadlines/">Health Insurance Marketplace Open Enrollment Period</a>.'
where id = 15344
</cfquery>
<cfquery name="results10"  datasource="wp_benefitscheckup">
update  wp_posts_v3_1 set 
post_content = 'The Health Insurance Marketplace Open Enrollment Period - your opportunity to shop, compare, and change your health insurance plans online, through the Health Insurance Marketplace - begins on November 1, 2015 and ends January 31, 2016. You can use the Marketplace to shop for a quality health insurance plan, whether you are interested in a private plan (a plan that is not funded by the government), Medicaid, or the Children\'s Health Insurance Program (CHIP). Even if you already have a Marketplace health insurance plan, the Marketplace can help you to shop for a new plan. <a href="https://www.healthcare.gov/">Visit the Health Insurance Marketplace</a>.'
where id = 15221
</cfquery>

<cfquery name="results10"  datasource="wp_benefitscheckup">
update  wp_posts_v3_1 set 
post_content = 'Based on what you told us, you should know that if you are currently enrolled in a Health Insurance Marketplace plan and you receive tax credits to help pay for your monthly premiums, you will lose your tax credits when you are eligible for Medicare even if you don\'t enroll in Medicare. The sole exception to losing tax credits applies to people who must pay a premium for Medicare Part A. For more information, go to the <a href="https://www.healthcare.gov/">Health Insurance Marketplace</a> or call: 1-800-318-2596 (TTY: 1-855-889-4325).'
where id = 15325
</cfquery>
<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">				 
select * from subset_content;
</cfquery>



<cfquery name="results10"  datasource="wp_benefitscheckup">	
			 
select * from wp_posts_v3_1
where id in (15325, 15221,15344)

</cfquery>

<cfdump var="#results10#"><cfabort>

<cfdump var="#results10#"><cfabort>
<cfquery name="results10"  datasource="#application.dbsrc#">				 
update answerfield set answerfieldtype_id = 6 where answerfield_id = 7324
</cfquery>
<cfquery name="results10"  datasource="#application.dbsrc#">				 
select * from answerfield where answerfield like '%hsa%'
</cfquery>
<cfdump var="#results10#"><cfabort>

<cfquery name="results9"  datasource="#APPLICATION.dbSrc#">

	select  sa.response as agency_id, s.client_id as vendor_id from screening s, screening_answerfield sa where 
	sa.screening_id = s.screening_id 
 d	and
	end_datetime > '2010-01-01' and s.partner_id = 76   and sa.answerfield_id = 6271 
	group by agency_id
	


		
                                            
</cfquery><cfdump var="#results9#"><cfabort>
<table border=1><tr><td>clientid</td><td>screeningid</td><td>date</td></tr>
<cfloop query="results9">
<cfoutput><tr><td>#client_id#</td><td>#screening_id#</td><td>#end_datetime#</td><td>http://www.benefitscheckup.org/util/procGetReport.cfm?clientnum=#screening_id#</td></tr></cfoutput>
</cfloop>
</table>
<cfabort>