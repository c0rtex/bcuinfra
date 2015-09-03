
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>redirect</title>
</head>

<body>
<cfif session.partner_id neq 89 and session.partner_id neq 90>
<cflocation url="http://www.benefitscheckup.org/lisapp/">
<cfelse>
<cflocation url="https://secure.ssa.gov/i1020/start">
</cfif>
</body>
</html>