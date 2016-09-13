<cfparam name="FORM.zip" default="" type="integer">
<cfif FORM.zip is "">
	<cfset FORM.zip = 0>
</cfif>
<cfquery name="qryGetCookCtyZips" datasource="#application.dbSrc#">
 SELECT DISTINCT Zip, PostalCity
 FROM tblCookCountyCities
 WHERE Zip =<cfqueryparam cfsqltype="cf_sql_integer" maxlength="5" value="#FORM.zip#">
</cfquery>

<cfif qryGetCookCtyZips.RecordCount EQ 1>
   <cfif qryGetCookCtyZips.PostalCity EQ "CHICAGO">
      <cfset session.City = "Chicago">
   <cfelse>
      <cfset session.City = "NotChi">
   </cfif>
<cfelseif qryGetCookCtyZips.RecordCount GT 1>
   <cfinclude template="tagPickCookCtyCity.cfm">
   <!--- 02/16/2002 REM  Need this next var on the main page to insert the hidden form 
   fields that will hold the City values, so they can be inserted as Session vars. --->
   <cfset boolGetCity="TRUE">
</cfif>
