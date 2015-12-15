<html>
<head>
    <title>Use Get Method</title>
</head>
<body>
<cfhttp 
    method="Get"
    url="https://www.benefitscheckup.org"
    resolveurl="Yes"
    port=443>

<cfoutput>
    #cfhttp.FileContent# <br>
</cfoutput>

</body>
</html>
