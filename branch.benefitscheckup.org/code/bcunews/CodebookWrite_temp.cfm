<!--- Remember to escape double quotes with "" and # with ## --->
<cfset mytext = "#HTMLEditFormat('CCP - Coordinated Care Plans, MSA - Medicare Medical Savings Accounts, PFFS - Private Fee-For-Service Plans, RFB - Religious Fraternal Benefit plans, PACE - Program for All Inclusive Care for the Elderly, HCPP - Health Care Pre-payment Plans')#">
<!---
<cfquery name="insertNews" datasource="#application.dbSrc#">

INSERT INTO [BCU].[dbo].[bcu_news]
           ([date_added]
           ,[archived]
           ,[news]
           ,[title]
           ,[date_updated]
           ,[active])
     VALUES
           (now()
           ,0
           ,'#mytext#'
           ,'National Council on Aging and AGIS Network, Inc. partner to streamline senior eligibility screening and program enrollment'
           ,now()
           ,0)

</cfquery>--->

<cfquery name="updateNews" datasource="#application.dbSrc#">

	Update mp_codebook
	Set acronyms2 = '#mytext#'
	where codebook_id = 10
</cfquery>

