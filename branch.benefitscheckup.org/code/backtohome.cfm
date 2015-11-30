<!--- Load passed variables without initializing unspecified session variables --->
<cf_sessionLoadVars initAll="false">
<cfparam name="prev_id" type="any" default="0">
<cf_handleScreening action="kill">
	<cf_sessionPassVars var="repeatURL" href="index.cfm" prev_id="0">
<cflocation url="#repeatURL#" addtoken="no">