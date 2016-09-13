<html>
<head>
<title>Your BenefitsCheckUp Report</title>
</head>

	<cfif IsDefined('session.cobrand_bgcolor') and session.cobrand_bgcolor neq '' and session.cobrand_bgcolor neq 0>
		<body bgcolor="<cfoutput>#session.cobrand_bgcolor#</cfoutput>">
	<cfelseif SESSION.partner_id EQ 80>
		<body bgcolor="#E1DAE7">
 	<cfelseif SESSION.partner_id EQ 0>
		<body bgcolor="#D0D9D6">
	<cfelseif SESSION.partner_id EQ 89>
		<body bgcolor="#b2d8e5">
	<cfelseif SESSION.partner_id EQ 90>
		<body bgcolor="#b2d8e5">
	<cfelse>
		<body bgcolor="#00594b">
	</cfif>
	<cf_jsPrintConfirm>
	<cfoutput>
	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
						<cfif not (IsDefined('session.regeneratedReport') and session.regeneratedReport eq 1)>
			<cfif session.partner_id neq 55 >
			<td valign="middle">
			<form action="frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_top">
				<input type="submit" value="Return to Results">
			</form>
			</td>
			</cfif>
			</cfif>
			<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
			<td valign="middle">
			<cf_sessionPassVars action="/startover.cfm" prev_id="0" subset_id="2" target="_top">
				<input type="submit" value="Start a New Screening">
			</cf_sessionPassVars>
			</td>
			<td valign="middle">
			<form action="#application.transferType#://#session.ltccservername#/index.cfm?bcupath=#URLEncodedFormat("http://#application.serverPath#/pdf/#session.cftoken#-#session.cfid##session.randomname#.cfm")#" method="post" target="_top">
				<input type="submit" value="Return to LTCC Home">
			</form>
			</td>
			<cfelseif IsDefined('session.client_id') and session.client_id neq 'null' and session.partner_id neq 61 and session.partner_id neq 81>
			<td valign="middle">
			<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">
				<input type="submit" value="Return to Client Detail">
			</form>
			</td>
			<td valign="middle">
			<cf_displayButton return_oe="true">
			</td>
			<cfelseif session.source_id eq 2 or session.source_id eq 3>
			<td valign="middle">
			<cf_sessionPassVars action="/startover.cfm" prev_id="0" target="_top">
				<input type="submit" value="Start a New Screening">
			</cf_sessionPassVars>
			</td>
			<td valign="middle">
			<cf_displayButton return_oe="true">
			</td>
			<cfelse>
			<cfif session.subset_id neq 40 and session.subset_id neq 55 and session.partner_id neq 55>
			<td valign="middle">
			<cf_sessionPassVars action="/startover.cfm" prev_id="0" target="_top">
				<input type="submit" value="Start a New Screening">
			</cf_sessionPassVars>
			</td>
			</cfif>
			<cfif isdefined('session.org_id') and session.org_id gt 0>
			<td valign="middle">
			<cf_displayButton return_oe="true">
			</td>
			</cfif>
			</cfif>
		</tr>
		<tr>
			<td colspan="3"><font face="arial,helvetica,verdana"><br><br><h3>We're sorry</h3>

If you are seeing this message, then your benefits report did not print properly.<br><br>

Please go back to your computer and click the <b>Print Your Report</b> button, as shown in the diagram below.<br><br>

If your report still fails to print, try clicking the print icon below the <b>Print Your Report</b> button, as circled in the diagram below.</font><br><br>

<img src="images/bcu-print.gif" border="0" alt="Print button circled in red" width="287" height="282"><br><br>

Thank you for using <b>BenefitsCheckUp</b>.</td>
		</tr>
	</table>
	</cfoutput>

</body>
</html>
