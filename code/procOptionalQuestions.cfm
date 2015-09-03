<cf_tagHeader>

<cfquery name="rob" datasource="#application.dbSrc#">
	SELECT ifnull(RACE, 'NULL') BRACE, count(*) CRACE
	FROM tbl_user_ans
	group by RACE
	order by RACE
</cfquery>

<table border="1" cellpadding="3" cellspacing="0">
<tr>
	<td><b>val</b></td>
	<td><b>num</b></td>
</tr>
<cfoutput query="rob">
	<tr>
		<td>#BRACE#</td>
		<td>#CRACE#</td>
	</tr>
</cfoutput>
</table>
<br>

<cfquery name="molchon" datasource="#application.dbSrc#">
	SELECT ifnull(LEARN, 'NULL') BLEARN, count(*) CLEARN
	FROM tbl_user_ans
	group by LEARN
	ORDER BY LEARN
</cfquery>

<table border="1" cellpadding="3" cellspacing="0">
<tr>
	<td><b>val</b></td>
	<td><b>num</b></td>
</tr>
<cfoutput query="molchon">
	<tr>
		<td>#BLEARN#</td>
		<td>#CLEARN#</td>
	</tr>
</cfoutput>
</table>
<br>


<cfquery name="tmolchon" datasource="#application.dbSrc#">
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE RACE IS NOT NULL AND RACE <> ''
</cfquery>

<cfoutput query="tmolchon">
	#mindate#, #maxdate#<br>
</cfoutput>
<br>

<cfquery name="bmolchon" datasource="#application.dbSrc#">
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN IS NOT NULL AND LEARN <> ''
</cfquery>

<cfoutput query="bmolchon">
	#mindate#, #maxdate#<br>
</cfoutput>
<br>


<cfquery name="rmolchon" datasource="#application.dbSrc#">
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN IS NULL AND RACE IS NULL
</cfquery>

<cfoutput query="rmolchon">
	NULL: #mindate#, #maxdate#<br>
</cfoutput>
<br>


<cfquery name="amolchon" datasource="#application.dbSrc#">
SELECT MIN(END_TIME) mindate, MAX(END_TIME) maxdate
FROM tbl_user_ans
WHERE LEARN = '' AND RACE = ''
</cfquery>

<cfoutput query="amolchon">
	EMPTY: #mindate#, #maxdate#<br>
</cfoutput>
<br>


<cfquery name="survey" datasource="#application.dbSrc#">
SELECT CLIENTNUM, COUNTY, ST, ZIP, DOB, CITIZEN, WORK_STATUS, END_TIME, RACE, LEARN, POVERTYINDEX, IDNUMBER
FROM tbl_user_ans
WHERE CLIENTNUM + 51 > (select max(CLIENTNUM) from tbl_user_ans)
	or (CLIENTNUM > 19670000 AND CLIENTNUM < 19680000)
ORDER BY CLIENTNUM DESC
</cfquery>

<table border="1" cellpadding="3" cellspacing="0">
<tr>
	<td><b>id</b></td>
	<td><b>county</b></td>
	<td><b>st</b></td>
	<td><b>zip</b></td>
	<td><b>dob</b></td>
	<td><b>citizen</b></td>
	<td><b>work</b></td>
	<td><b>end_time</b></td>
	<td><b>race</b></td>
	<td><b>learn</b></td>
	<td><b>poverty</b></td>
	<td><b>pid</b></td>
</tr>
<cfoutput query="survey">
	<tr>
		<td>#CLIENTNUM#</td>
		<td>#COUNTY#</td>
		<td>#ST#</td>
		<td>#ZIP#</td>
		<td>#DOB#</td>
		<td>#CITIZEN#</td>
		<td>#WORK_STATUS#</td>
		<td>#END_TIME#</td>
		<td>#RACE#</td>
		<td>#LEARN#</td>
		<td>#POVERTYINDEX#</td>
		<td>#IDNUMBER#</td>
	</tr>
</cfoutput>
</table><br>

<cf_tagFooter>