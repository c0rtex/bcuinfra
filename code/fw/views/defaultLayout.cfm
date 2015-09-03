<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfset css = getProperty("css")>
<cfset js = getProperty("js")>
<cfoutput>
    <link href="#css#" rel="stylesheet" type="text/css" />
    <script src="#js#" type="text/javascript"></script>
</cfoutput>
<title>Untitled Document</title>
</head>

<body>
<cfoutput>
	<div>
		#event.getArg("nav")#
    </div>
    <div class="clear"></div>
    #event.getArg("errorMsg")#
    #event.getArg("content")#
</cfoutput>
</body>
</html>