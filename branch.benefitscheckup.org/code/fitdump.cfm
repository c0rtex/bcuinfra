<cfset session.language_id = 'EN'>
<cfparam name="url.screening" default="">
<cfif url.screening NEQ "">
	<cfset screeningId = url.screening>
<cfelse>
	<cfset screeningId = 1789087>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Fit DB dump Page</title>
</head>

<body>
<cfset handledObj = createObject("component","com.bcu.fitHandler").init(screeningId, true)>
<cfset qAnswerfields = handledObj.getAnswerfieldsAsQuery()>
<cfdump label="Answerfields : #screeningId#" var="#qAnswerfields#" expand="yes">
</body>
</html>