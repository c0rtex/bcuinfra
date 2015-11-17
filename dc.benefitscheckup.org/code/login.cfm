<cfparam name="wrong" type="string" default="no">
<cfparam name="p" type="string" default="">
<cfparam name="q" type="string" default="">

<cf_buildPage title="Please Log In" bounce="false">

<cfif application.maintenanceFlag>

	<div align="center"><font size="+1" color="#990000"><b>The Data Collector is down for a couple of hours for maintenance updates.  Please be patient.</b></font></div><br>

<cfelse>

	<cfif wrong eq 'yes'>
	<div align="center"><FONT COLOR="#990000"><b>invalid login&#151;please try again</b></FONT></div><br>
	</cfif>
	<div align="center">
	<table border="0">
	<form action="index.cfm" method="post">
		<tr>
			<td><font face=arial size=2><b>username:&nbsp;</b></font> <input type="text" name="user" size="10"></td>
			<td>&nbsp;&nbsp;</td>
			<td><font face=arial size=2><b>password:&nbsp;</b></font> <input type="password" name="psswrd" size="10"></td>
			<td>&nbsp;&nbsp;</td>
			<td><input type="submit" value="log in"></td>
		</tr>
		<cfoutput>
		<input type="hidden" name="p" value="#HTMLEditFormat(p)#" />
		<input type="hidden" name="q" value="#HTMLEditFormat(q)#" />
		</cfoutput>
	</form>
	</table>

</cfif>

<div align="center"><img src="dc2.jpg" border="0" width="768" height="393" alt="BenefitsCheckUp Data Collector"></div>

</cf_buildPage>