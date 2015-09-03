
<!---cfset xmlfile = '<Programs> <Program Id = "1271" CatId ="11">Hawaii Rx Plus</Program> <Program Id = "128" CatId ="9">Medicare</Program> <Program Id = "1643" CatId ="9">Seniors EyeCare</Program> <Program Id = "214" CatId ="9">Adult &amp; Community Care Services</Program> <Program Id = "213" CatId ="9">Adult Day Care</Program> <Program Id = "157" CatId ="5">Tax Credit for the Elderly and Disabled</Program> <Program Id = "147" CatId ="15">HUD Public Housing Program</Program> <Program Id = "146" CatId ="15">Section 8 Housing Assistance Program</Program> <Program Id = "129" CatId ="39">Elderly Nutrition Program - Congregate or Group Meals</Program> <Program Id = "135" CatId ="39">Elderly Nutrition Program - Home Delivered Meals</Program> <Program Id = "151" CatId ="27">Weatherization Assistance Program</Program> <Program Id = "1547" CatId ="27">Lifeline and Link Up</Program> <Program Id = "1420" CatId ="27">Lifeline/Linkup Service</Program> <Program Id = "216" CatId ="28">Transportation and Escort Program</Program> <Program Id = "1421" CatId ="31">Hawaii Information and Referral Service</Program> <Program Id = "153" CatId ="19">America the Beautiful - Senior Pass (formerly Golden Age Passport for persons age 62 and older)</Program> <Program Id = "211" CatId ="25">Continuing Education</Program> </Programs> '>
<cfset results = #xmlparse(xmlfile)#>
<cfdump var="#results#"---->
<cfquery name="results" datasource="#application.dbSrc#">

SELECT * from click order by click_id desc limit 0, 50

</cfquery>
<cfdump var="#results#"> 
<!---cfquery name="results2" datasource="#application.dbSrc#">

		SELECT    top  1 *  
		FROM          program p, programcategory pc
        where pc.programcategory_id = p.programcategory_id
        and pc.programcategory_id = 23
        and p.state_id = 'NY'
        

</cfquery>
<cfif results2.recordcount gt 0>
	<cf_displaytext group="program" code="program_#results2.program_code#" var="programName">
	<cfset programNameText = programName>
<cfelse>             
	<cfset programNameText = "the Super Neato Program">
</cfif>
<cfoutput>#programNameText#</cfoutput>
<cfdump var="#results2#"> 
<cfabort--->
<cfquery name="CountTADistinct1" datasource="#application.dbSrc#">

SELECT  distinct ConfirmationNumber, FirstName, LastName

FROM         tbl_user_ta

where createDate > '20041220' and createDate < '20050101'

</cfquery>



<cfquery name="CountTADistinct2" datasource="#application.dbSrc#">

SELECT  distinct ConfirmationNumber, FirstName, LastName

FROM         tbl_user_ta

where createDate > '20050101'

</cfquery>



<cfquery name="CountTACMSExport1" datasource="#application.dbSrc#">

SELECT  distinct ConfirmationNumber

FROM         medEnrollment

WHERE     (submitdate < '20050101')

</cfquery>

<cfquery name="CountTACMSExport2" datasource="#application.dbSrc#">

SELECT  distinct ConfirmationNumber

FROM         medEnrollment

WHERE     (submitdate > '20050101')

</cfquery>

<cfset amount1 = 2000>

<cfset countdistinct1 = CountTADistinct1.RecordCount>

<cfset value1 = amount1 * countdistinct1>



<cfset amount2 = 2000>

<cfset countdistinct2 = CountTADistinct2.RecordCount>

<cfset value2 = amount2 * countdistinct2>



<cfset value = value1 + value2>

<cfset countdistinct = countdistinct1 + countdistinct2>





<cfset CountTACMSExport1 = CountTACMSExport1.RecordCount>

<cfset value3 = 2000 * CountTACMSExport1>



<cfset CountTACMSExport2 = CountTACMSExport2.RecordCount>

<cfset value4 = 2000 * CountTACMSExport2>

<cfset valueCMS = value3 + value4>

<cfset countdistinctCMS = CountTACMSExport1 + CountTACMSExport2>







<cfoutput>



<br><br>

<strong>Users Tracked in BCURx Database (Live Data)</strong>

<br><br>

Total number of users enrolling online for Medicare-approved drug discount cards through BenefitsCheckUpRx:<!---<br>--->

<b> <!--- #CountTA.total# (distinct confnum)<br> --->

#countdistinct# 

<!--- (distinct confnum and name)<br>

#CountTA.totalall# (total)---></b>

<br><br>



Total value of benefits  - <b>$ #NumberFormat(value,'____,___.__')# </b>



</cfoutput>



<cfoutput>

<br><br><br><br>

<strong>Enrollments Confirmed by CMS as of 4/15/2005 (Updated Weekly)</strong>

<br><br>

Total number of users enrolling online for Medicare-approved drug discount cards through BenefitsCheckUpRx:<!---<br>--->

<b> <!--- #CountTA.total# (distinct confnum)<br> --->

#NumberFormat(countdistinctCMS,'____,___,___')#

<!--- (distinct confnum and name)<br>

#CountTA.totalall# (total)---></b>

<br><br>

Total value of benefits  - <b>$ #NumberFormat(valueCMS,'____,___,___.__')# </b>

</cfoutput>

