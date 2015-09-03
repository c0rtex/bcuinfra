<HTML>
<HEAD>
	<TITLE></TITLE>
	<script language="javascript" src="ValidationFunctions.js"></script>
</HEAD>

	<cfset code = ListGetAt(session.codelist, session.codenum)>
	<cfset codeWord = ListGetAt(code, 1, '-')>
	<cfif codeWord eq 'form'>
		<cfset codeSort = ListGetAt(code, 7, '-')>
		<cfset codeClass = ListGetAt(code, 8, '-')>
		<cfset codeType = ListGetAt(code, 9, '-')>
	</cfif>
	<cfset codeProgram = ListGetAt(code, 2, '-') & '-' & ListGetAt(code, 3, '-') & '-' & ListGetAt(code, 4, '-') & '-' & ListGetAt(code, 5, '-') & '-' & ListGetAt(code, 6, '-')>


	<cfif session.partner_id eq 7>
		<body bgcolor="#999966">
	<cfelseif IsDefined('session.cobrand_bgcolor') and session.cobrand_bgcolor neq '' and session.cobrand_bgcolor neq 0>
		<body bgcolor="<cfoutput>#session.cobrand_bgcolor#</cfoutput>">
	<cfelse>
		<body bgcolor="#00594b">
	</cfif>
	<cfoutput>

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			
			<td valign="top" align="left">

	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top" align="center">
				<form>
				<input type="button" value="Print Fact Sheets" onClick="parent.lowerframe.print();"><br>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
			</form>
			</td>
			<td valign="top" align="right">
				<table border="0" bgcolor="white"><tr><td style="font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 9pt;">
					Your selected fact sheets appear below.
				</td></tr></table>
			</td>
			<td valign="top" align="left">
					<input type="button" name="facthelp" value="Help" onClick="help2('hlpPrintFactFrame.cfm')">
			</td>
		</tr>
	</table>
	
			</td>
			<td valign="top" align="right">

	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
			<form action="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="submit" value="Return to Application Guide">
			</form>
			</td>
		</tr>
	</table>
		
			</td>
			
		</tr>
	</table>

</cfoutput>

</body>
</html>