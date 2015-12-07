<cfparam name="url.SHOWGOOGLEMAPLINK" default="true">
<cfparam name="url.radius" default="100">
<cfparam name="url.limit" default="3">
<cfparam name="url.zip" default="">
<cfparam name="url.county" default="">
<cfparam name="url.city" default="">
<cfinvoke method="getProgramEntryPoints" 
returnvariable="responseFromService" 
webservice="http://bcuqa.benefitscheckup.org/util/remotescreening_staging.cfc?wsdl" >

<cfinvokeargument name="program_id" value="#url.program_id#">
<cfinvokeargument name="partner_id" value="0">
<cfinvokeargument name="state_id" value="#url.state_id#">
<cfinvokeargument name="county" value="#url.county#">
<cfinvokeargument name="zip" value="#url.zip#">
<cfinvokeargument name="radius" value="#url.radius#">
<cfinvokeargument name="limit" value="#url.limit#" >
<cfinvokeargument name="city" value="#url.city#" >
</cfinvoke >


<cfoutput><h2>Test Output for Program ID: #program_id# State: #state_id# County #url.county# Zip #url.zip#</h2>
#responsefromservice#
</cfoutput>

