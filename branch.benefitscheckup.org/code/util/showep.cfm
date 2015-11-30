<cftry>
	<!--- pass arguments --->
	<cfparam name="url.program_id" type="numeric" default="0" >
	<cfparam  name="partner_id" type="numeric" default="0" >
	<cfparam  name="url.county" type="string" default="">
	<cfparam  name="url.city" type="string" default="">
	<cfparam  name="url.state_id" type="string" default="">
	<cfparam  name="url.limit" type="numeric"  default="3" >
	<cfparam  name="url.radius" type="numeric"  default="100" >
	<cfparam  name="url.zip" type="numeric" default="0" >
    <cfparam  name="session.partner_id" type="numeric" default="0" >    
    <cfif isdefined('debug')><cfoutput>displayprogramdetail program_id = "#url.program_id#" state_id="#url.state_id#" county="#url.county#" zip="#zip#" source="ec" supressforms="true" suppressOfficesLink="true" eplimit="#limit#" requisites="false" description="false"  entrypoints="true"  title="false" getWebResources="false"  var="resultstring" </cfoutput></cfif>
    <cf_displayprogramdetailWP program_id = "#url.program_id#" state_id="#url.state_id#" county="#url.county#" zip="#zip#" source="ec" supressforms="true" suppressOfficesLink="false" eplimit="#url.limit#" requisites="false" description="false"  entrypoints="true"  title="false" getWebResources="false"  var="resultstring"  >
    <cfset resultstring = replacenocase(resultstring,"<br />","")>
    <cfset resultstring = replacenocase(resultstring,"<br>","","all")>
    <cfset resultstring = replacenocase(resultstring,"</div></div></div>","")>
    <cfset resultstring = replacenocase(resultstring,'<div style="clear:left;">',"")>
    <cfset resultstring = replacenocase(resultstring,'<strong class="factSheetH2">For further information about this program:</strong>','')>
    <cfset resultstring = replacenocase(resultstring,'This is the regional office that serves the zip code you entered','')>
    <cfset resultstring = replacenocase(resultstring,'.  All program inquiries should be made through this office.','')>
    <cfset resultstring = replacenocase(resultstring,'<span class="epName"><strong>',"")>
    <cfset resultstring = replacenocase(resultstring,'</strong></span>',"")>
    <cfset resultstring = replacenocase(resultstring,"</span>","")>
   <cfset resultstring = replacenocase(resultstring,'onclick','doNothing')>
     <cfset resultstring = replacenocase(resultstring,"offices.cfm?","offices.cfm?state_id=#url.state_id#&")>
<cfset resultstring = replacenocase(resultstring,'The office that administers this program does not provide address information.  Please call the phone number(s) listed below.','')>
	<cfoutput>#resultstring#</cfoutput>
<cfcatch>
<div class="alert alert-information"><p>Office data is unavailable.</div></p></div>
</cfcatch>    
</cftry>
	