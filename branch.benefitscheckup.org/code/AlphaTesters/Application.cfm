<!--- Application (mini) created by Andrew Kopelman on 2/1/2 for the purposed of Alpha Testers of the CSO application feedback. --->

<CFAPPLICATION NAME="AlphaTesterz" SESSIONMANAGEMENT="Yes" SESSIONTIMEOUT="#CreateTimeSpan(0,2,0,0)#">

<!--- meta tag to allow english characters to prevent crosss-site scripting --->
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!--- setting to disable debugging output(commented out for testing in house) --->

<CFSETTING SHOWDEBUGOUTPUT="yes">

<CFSET Session.datasrc = "BCU">
<!--- Force creation of sessin tracking cookies which expire at browser
close --->
<CFCOOKIE NAME="CFID" VALUE="#Session.CFID#">
<CFCOOKIE NAME="CFTOKEN" VALUE="#Session.CFTOKEN#">

<cfparam name ="session.CSO_ID" default="">
<cfparam name ="session.SAT_OFF_ID" default="">