<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">				 
update rule set rule_text = '(1 eq 0)' where rule_id = 2428
</cfquery>
<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">				 
select * from rule where rule_id = 2428
</cfquery>
<cfdump var="#results10#">

<cfquery name="results10"  datasource="wp_benefitscheckup">
update  wp_posts_v3_1 set 
post_content = 'The Health Insurance Marketplace Open Enrollment Period - your opportunity to shop, compare, and change your health insurance plans online, through the Health Insurance Marketplace - begins on November 1, 2015 and ends January 31, 2016. You can use the Marketplace to shop for a quality health insurance plan, whether you are interested in a private plan (a plan that is not funded by the government), Medicaid, or the Children\'s Health Insurance Program (CHIP). Even if you already have a Marketplace health insurance plan, the Marketplace can help you to shop for a new plan. <a href="https://www.healthcare.gov/">Visit the Health Insurance Marketplace</a>.'
where id = 15221
</cfquery>

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
	and
	end_datetime > '2010-01-01' and s.partner_id = 76   and sa.answerfield_id = 6271 
	group by agency_id
	


		
                                            
</cfquery><cfdump var="#results9#"><cfabort>
<table border=1><tr><td>clientid</td><td>screeningid</td><td>date</td></tr>
<cfloop query="results9">
<cfoutput><tr><td>#client_id#</td><td>#screening_id#</td><td>#end_datetime#</td><td>http://www.benefitscheckup.org/util/procGetReport.cfm?clientnum=#screening_id#</td></tr></cfoutput>
</cfloop>
</table>
<cfabort>