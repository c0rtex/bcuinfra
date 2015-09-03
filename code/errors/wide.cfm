<HTML>

<body link="#00594b" vlink="#00594b" alink="#00594b" >
<CENTER>
<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>

				<td align="center" valign="top" colspan="3"></td>
			</tr>
			<tr>
				<td rowspan="2" align="right"><img src="images/ncoaLogoNew.gif" width="137" height="60" border="0" alt="NCOA - National Council on Aging"></td>
				<td align="left" valign="top"><img src="images/head-bcu.gif"  border="0" alt="BenefitsCheckUp"></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>

</table>




<br><br><br><br>
<font face="Arial" size=3>




<cfif isDefined('session.subset_id')>
	<cfif session.subset_id is "41">
		We are not able to complete your Extra Help Application at this time.<br> Please send an email to <a href="mailto:admin@benefitscheckup.org">admin@benefitscheckup.org</a> and provide any information about what action was taken before you received this message. <br> Or, feel free to check back again later.
		<br><br>
<table border="0" width="80%">
        <tr>
                <td colspan=2 align="center">    <b>It is important to note that:<br></b> </td>
        </tr>
        <tr>
                <td> </td>
        </tr>
        <tr>
                <td>
                        <UL><LI>You may have exceeded the maximum time limit (120 minutes) to complete each page of the questionnaire. </LI></UL>
                </td>
        </tr>
        <tr><td align="center"> Or</td></tr>
        <tr>
                <td>
                        <UL><LI>You may have clicked on the Back Browser button while completing the Medicare Rx Extra Help Online Application. (We do not recommend using the back browser button while completing the Medicare Rx Extra Help Online Application as it may interfere with the processing of your application.)</LI>
                        </UL>
                </td>
        </tr>
</table>

                <br><br><b>To start over, please go to <a href="https://www.benefitscheckup.org/">www.benefitscheckup.org</a>.</b><br>

		<br><br>We apologize for the inconvenience.<br>
	<cfelse>
		We are not able to complete your BenefitsCheckUp screening at this time.<br> 
		Please send an email to <a href="mailto:admin@benefitscheckup.org">admin@benefitscheckup.org</a> and provide any information about what action was taken before you received this message. <br><br>
		<b>Note: You may have exceeded the maximum time limit (120 minutes) to complete each page of the questionnaire. <br> To start over, please go to <a href="http://www.benefitscheckup.org">www.benefitscheckup.org</a></b>
		<br><br>We apologize for the inconvenience.<br>
	</cfif>

<cfelse>
		We are not able to complete your BenefitsCheckUp screening at this time.<br> 
		Please send an email to <a href="mailto:admin@benefitscheckup.org">admin@benefitscheckup.org</a> and provide any information about what action was taken before you received this message. <br><br>
		<b>Note: You may have exceeded the maximum time limit (120 minutes) to complete each page of the questionnaire. <br> To start over, please go to <a href="http://www.benefitscheckup.org">www.benefitscheckup.org</a></b>
		<br><br>We apologize for the inconvenience.<br>

</cfif>




<br><br>
Thank you,
<br><br>
BenefitsCheckUp Team
</font>

<TABLE cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
	<tr>
		<td valign="top" bgcolor="white" colspan="2" align="center"><font face="Arial" color="#00594b" size="2"><i>Powered by National Council on Aging</i></font></td>
	</tr>
    <tr>
		<td bgcolor="white" colspan="2" align="center"><font face="Arial" color="#00594b" size="1">Copyright &copy; 2010 National Council on Aging 
            | <a href="javascript:help2('privacy.cfm')" style="color: #00594b;">Privacy Policy</a>
			| <a href="javascript:help2('termsofuse.cfm')" style="color: #00594b;">Terms of Use</a>
			| <a href="mailto:comments@benefitscheckup.org" style="color: #00594b;">Feedback</a>
			</font></td>
	</tr>
</table>



</td>

</tr>

</table>



</CENTER>
</BODY>
<cfmail
	from="report@benefitscheckup.org"
	to="kiryl@benefitscheckup.org"
	subject="Wide error on #cgi.HTTP_HOST#">
	You see this message because you are part of the mail list.
	User Agent: #cgi.HTTP_USER_AGENT#  
	Remote Address: #cgi.REMOTE_ADDR#  
	Script Name: #cgi.SCRIPT_NAME#  
	Path Translated: #cgi.PATH_TRANSLATED#
	HTTP Referer: #cgi.HTTP_REFERER#
	CFID and CFTOKEN: #cgi.HTTP_COOKIE#
	<cfif isDefined("error.message")>Error Message: #error.message#	</cfif>
	<cfif isDefined("error.rootCause")>Root Cause: #error.rootCause#	</cfif>
	<cfif isDefined("error.type")>Error Type: #error.type#	</cfif>
	<cfif isDefined("error.diagnostics")>Error Diagnostics: #error.diagnostics#	</cfif>
	<cfif isDefined("error.browser")>Error Browser: #error.browser#	</cfif>
	<cfif isDefined("error.dateTime")>Error DateTime: #error.dateTime#	</cfif>
	<cfif isDefined("error.invalidFields")>Error Invalid Fields: #error.invalidFields#	</cfif>
</cfmail>

</HTML>
