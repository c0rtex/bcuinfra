
<cfquery name="CountTA" datasource="#application.dbSrc#">
SELECT count(distinct(ConfirmationNumber)) as total
FROM tbl_user_ta
WHERE CreateDate > '12/20/2004'
</cfquery>

<cfoutput query="CountTA">
Total number of users enrolling online through BenefitsCheckUpRx: #CountTA.total#
</cfoutput>

