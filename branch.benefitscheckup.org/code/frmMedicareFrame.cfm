<html>
<head>
<cfif isdefined('session.startpace') and session.startpace eq 'Y' >
<title>PACE Online Enrollment</title>
<cfelse>
<title>Medicare-Approved Drug Discount Card Online Enrollment</title>
</cfif>
<script language="JavaScript" src="ValidationFunctions.js"></script>
</head>


		<body bgcolor="#FFFFFF">

	<cfoutput>
	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
	
			<td valign="middle">
			<!--- <form action="frmRecommend.cfm?#session.URLToken#" method="post" target="_top">
				<input type="submit" value="Return to ABC Recommendations">
			</form> --->
		<cfif isdefined('session.startpace') and session.startpace eq 'Y' >
		<form method="post" action="frmRecommend.cfm?sr=1&#session.URLToken#" target="_top">
		<input type="submit" name="prev" value="Back to BenefitsCheckUp" style="font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 8pt;">
		</form>
		<cfelse>
		   <A HREF="javascript:help3('dspEnrollHelp.cfm')">For Help Completing This Page Click Here</A>
		</cfif>
			</td>
		</tr>


	</table>
	</cfoutput>

</body>
</html>