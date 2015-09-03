
<cfhttp url="https://www.benefitscheckup.org/screening_user_fromdb.php" method="GET" resolveurl="Yes" throwOnError="Yes"/>
<cfoutput>#cfhttp.fileContent#</cfoutput>