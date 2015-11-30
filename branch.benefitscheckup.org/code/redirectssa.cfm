<cfset url="">
<cfparam name="session.partner_id" default="0">
<cfif session.partner_id neq 89 and session.partner_id neq 90>
<cflocation url="/lisapp/">
<cfelse>
<cfset URL = "https://secure.ssa.gov/i1020/start">
			
			<!--- Open Main Table --->
			<TABLE cellSpacing="0" cellPadding="10" width="100%" align="center" border="0">
				<TR>
					<TD bgColor="#ffffff" align="center"><font size="4" face="Arial,Helvetica,Verdana"><b>
						In a moment, you will be redirected away from<br>
						<cfif session.partner_id eq 22>AARP Benefits QuickLINK<cfelse>BenefitsCheckUp.org</cfif> to a different Web site.<br><br>
						<font size="3">If the new page does not begin loading within 5 seconds,<br>
						please <cfoutput><a href="https://secure.ssa.gov/i1020/start">click here</a></cfoutput> to continue.</font>
					</b></font></td>
				</tr>
			</table>
<meta http-equiv="refresh" content="5;url=https://secure.ssa.gov/i1020/start" />
			
</cfif>
