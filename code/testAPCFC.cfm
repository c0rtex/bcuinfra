<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>


<cfoutput>
<cfdump var="#application.AnswerfieldPool#" expand="no">
<cfoutput>
	getAnswerfield('ch_parent')<cfdump var="#application.AnswerfieldPool.getAnswerfield('ch_parent')#" expand="no" label="ch_parent"><br />
    getAnswerfield('be_clnt_fnm')<cfdump var="#application.AnswerfieldPool.getAnswerfield('be_clnt_fnm')#" expand="no" label="be_clnt_fnm">
	<!--- <cfdump var="#application.AnswerfieldPool.getAnswerfields()#" expand="no"> --->
</cfoutput>

</cfoutput>
</body>
</html>