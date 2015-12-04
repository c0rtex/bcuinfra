<cfif not isdefined('request.dontapply')>
	<cfset request.dontapply = "No">
</cfif>

<cfset source="recommendations">

<table>
	<tr>
		<td width="180" valign=center>
			<cfoutput>
				<a href="../frmDetails.cfm?prg_id=#prg_id#&ReportType=#url.reporttype#" >
					<img alt="View Fact Sheet" src="images/button_fact-sheet.gif" border=0>
				</a>
			</cfoutput>
		</td>
		<td  valign=center>
			Read more about this program
		</td>
	</tr>
</table>