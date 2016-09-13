<!--- <cf_sessioncheck> --->
<cfif isdefined('url.reportType')>
	<cfset reportType = url.reportType>
<cfelse>
	<cfset reportType = "pdf">
</cfif>
<cfset frameheight = 35>
<html>
<head>
<title>Your BenefitsCheckUp Report</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="frmreportframe.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="border" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
  <cfif reportType eq "htm">
	<frame src="frmshowreport.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="report" marginwidth="0" marginheight="0" scrolling="Yes" noresize frameborder="0" framespacing="0">
  <cfelse>
	<frame src="/pdf/#session.CFToken#-#session.cfid##session.randomname#.pdf" name="report" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
  </cfif>
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>

If you are seeing this message, then your benefits report did not print properly.<br><br>

Please go back to your computer and click the <b>Print Your Report</b> button, as shown in the diagram below.<br><br>

If your report still fails to print, try clicking the print icon below the <b>Print Your Report</b> button, as circled in the diagram below.</font><br><br>

<img src="images/bcu-print.gif" border="0" alt="Print button circled in red" width="287" height="282"><br><br>

Thank you for using <b>BenefitsCheckUp</b>.
</noframes>
</html>