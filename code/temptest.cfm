<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>2 Millionth Results</title>
</head>

<body>

<cfquery name="ins_survey" datasource="#session.datasrc#">
	select survey_id, screening_id, first_name, last_name, city, state_id, phone, email, learn
	from survey
	order by survey_id
</cfquery>

<table border="1">
<tr style="font-weight: bold;">
<td>survey_id</td>
<td>screening_id</td>
<td>first_name</td>
<td>last_name</td>
<td>city</td>
<td>st</td>
<td>phone</td>
<td>email</td>
<td>learn</td>
</tr>
<cfloop query="ins_survey"><cfoutput>
<tr>
<td>#survey_id#</td>
<td>#screening_id#</td>
<td>#first_name#</td>
<td>#last_name#</td>
<td>#city#</td>
<td>#state_id#</td>
<td>#phone#</td>
<td>#email#</td>
<td>#learn#</td>
</tr>
</cfoutput></cfloop>
</table>

</body>
</html>
