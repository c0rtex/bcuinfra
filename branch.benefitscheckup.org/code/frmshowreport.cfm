<cfparam name="cover" type="boolean" default="false">

<HTML>

<HEAD>

	<TITLE>Your <cfif session.subset_id eq 70>Benefits<cfelse>BenefitsCheckUp</cfif> Report</TITLE>

</HEAD>



<BODY>

<cfoutput>

<table border="0" cellspacing="0" cellpadding="5">

		<tr>

			<td valign="middle">

			<form>

				<input type="button" value="Print Your Report" onClick="print();">

			</form>

			</td>

			<cfif not (IsDefined('session.regeneratedReport') and session.regeneratedReport eq 1)>
			<cfif session.partner_id neq 55>
			<td valign="middle">

			<form action="frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_top">

				<input type="submit" value="Return to Results">

			</form>

			</td>
			</cfif>
			</cfif>

			<cfif session.partner_id eq 5>

			<td valign="middle">

			<cf_sessionPassVars action="startover.cfm" prev_id="0" subset_id="2" target="_top">

				<input type="submit" value="Start a New Screening">

			</cf_sessionPassVars>

			</td>

			<td valign="middle">

			<form action="#application.transferType#://#session.ltccservername#/index.cfm?bcupath=#URLEncodedFormat("http://#application.serverPathCanonical#/pdf/#session.cftoken#-#session.cfid##session.randomname#.cfm")#" method="post" target="_top">

				<input type="submit" value="Return to LTCC Home">

			</form>

			</td>

			<cfelseif session.client_id neq 'null' and session.partner_id neq 61 and session.partner_id neq 81>

			<td valign="middle">

			<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">

				<input type="submit" value="Return to Client Detail">

			</form>

			</td>

			<td valign="middle">

			<cf_displayButton return_oe="true">

			</td>

			<cfelseif session.source_id eq 2 or session.source_id eq 3>
			<cfif session.subset_id neq 40 and session.subset_id neq 55 and session.partner_id neq 55>
			<td valign="middle">

			<cf_sessionPassVars action="startover.cfm" prev_id="0" target="_top">

				<input type="submit" value="Start a New Screening">

			</cf_sessionPassVars>

			</td>
			</cfif>
			<td valign="middle">

			<cf_displayButton return_oe="true">

			</td>

			<cfelse>

			<cfif session.subset_id neq 40 and session.subset_id neq 55 and session.partner_id neq 55>

			<td valign="middle">

			<cf_sessionPassVars action="startover.cfm" prev_id="0" target="_top">

				<input type="submit" value="Start a New Screening">

			</cf_sessionPassVars>

			</td>

			</cfif>

			<cfif session.source_id eq 2 or session.source_id eq 3>

			<td valign="middle">

			<cf_displayButton return_oe="true">

			</td>

			</cfif>

			</cfif>

		</tr>

		<tr>

		</table>

</cfoutput>

<cfif cover and FileExists("/pdf/#session.CFToken#-#session.cfid##session.randomname#.html")>

	<cfinclude template="/pdf/#session.CFToken#-#session.cfid##session.randomname#.html">

</cfif>

<br><hr size="6"><br>



<cfinclude template="/pdf/#session.CFToken#-#session.cfid##session.randomname#.cfm">



</BODY>

</HTML>