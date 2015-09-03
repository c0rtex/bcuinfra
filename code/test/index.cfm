<cfparam name="test_id" type="numeric" default="1">
<cf_sessionPassVars var="redirectURL" href="index.cfm" test_id="#test_id#">
<cflocation url="#redirectURL#" AddToken="No">