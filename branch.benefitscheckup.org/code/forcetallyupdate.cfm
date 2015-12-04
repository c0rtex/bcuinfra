<cfset localSource="nybcu">
<cfset localTable="tbl_answerfield_list">
<cfset columnList="answerfield, RecID">

<html>
<head>
	<title>Force Tally Update</title>
</head>

<body>

<cfoutput>
Run at:  #DateFormat(Now(), "YYYY-MM-DD")# #TimeFormat(Now(), "HH:MM:SS")#<br><br>
</cfoutput>
<cfquery name="gettally" datasource="#application.dbSrc#">
	SELECT bcu, rx, brand, generic, drug
	FROM view_tally
</cfquery>
<cfquery name="updatetally" datasource="#application.dbSrc#">
	UPDATE tbl_tally
	SET bcu=#gettally.bcu#, rx=#gettally.rx#, brand=#gettally.brand#, generic=#gettally.generic#, drug=#gettally.drug#, updated=now()
</cfquery>

Tallies updated.<br><br>

<CFQUERY NAME="qryDrugnm" DATASOURCE="#application.dbSrc#">
SELECT * FROM tbl_tally
</CFQUERY>
<table border="1">
	<tr>
		<td align="center"><b>bcu</b></td>
		<td align="center"><b>rx</b></td>
		<td align="center"><b>brand</b></td>
		<td align="center"><b>generic</b></td>
		<td align="center"><b>drug</b></td>
		<td align="center"><b>updated</b></td>
	</tr>
<cfoutput query="qryDrugnm">
	<tr>
		<td align="right">#bcu#</td>
		<td align="right">#rx#</td>
		<td align="right">#brand#</td>
		<td align="right">#generic#</td>
		<td align="right">#drug#</td>
		<td align="center">#updated#</td>
	</tr>
</cfoutput>
</table><br>
	
If this worked, there should be no errors on this page.

</body> 
</html>