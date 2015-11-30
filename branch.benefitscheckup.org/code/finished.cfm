<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Finished!</title>
</head>

<body>

< cfif  FileExists('/data/servers/benefitscheckup_governmentguide_com/pages/pdf/#session.CFToken#-#session.cfid#.pdf')>
<cfoutput>
<p><font size=4 face="Arial">Your report has been created.  Click below to access your report in Adobe's Acrobat Reader.</font> </p>
<center><a href="pdf/#session.CFToken#-#session.cfid#.pdf" target=_top>View & Print Report </a></center>
</cfoutput>

<cfelse >
<font face="Arial" size="4">
<center>Regrettably, we are unable to process your report at this time.  There seem to be too many people currently using <cf_tagBCU>.  You have two options:</center>
<ul>Option 1:  To try to generate your report again by clicking on the link below.</ul>

<center><a href="frmframebottomfirst.cfm" target=_top>Try to Generate the Report Again</a></center>
<ul>Option 2: To go back and review your Results without printing.</ul>

<center><a href="frmeligibility.cfm" target=_top>Go Back and Review Results</a></center><br>

<center><cf_tagClose></center>
</font>
</cfif >
</body>
</html>
