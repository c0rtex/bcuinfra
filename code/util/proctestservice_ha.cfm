<cfoutput><h2>Testing Results</h2></cfoutput>
<cfparam name="form.xml_answers" default="">
<cfparam name="form.partner_id" default="0">
<cfparam name="form.org_id" default="0">

<cfif form.partner_id eq 47 and (1 eq 0)>
	<cfinvoke method="doScreening" 
	returnvariable="responseFromService" 
	webservice="https://#CGI.server_name#/util/remotescreening_staging_humanarc.cfc?wsdl" >
		<cfset number = int(rand() * 1000)>
		<cfinvokeargument name="partner_id" value="#form.partner_id#">
		<cfinvokeargument name="partner_screening_id" value="10#number#">
		<cfinvokeargument name="org_id" value="#form.org_id#">
		<cfinvokeargument name="password" value="pass">
		<cfinvokeargument name="client_id" value="#number#">
		<cfinvokeargument name="response_list" value="#ltrim(rtrim(form.XML_answers))#">
	</cfinvoke>
<cfelse>
	<cfinvoke method="doScreening" 
	returnvariable="responseFromService" 
	webservice="https://www.benefitscheckup.org/util/remotescreening_2_1.cfc?wsdl" >
		<cfset number = int(rand() * 1000)>
		<cfinvokeargument name="partner_id" value="#form.partner_id#">
		<cfinvokeargument name="partner_screening_id" value="ABC#number#">
		<cfinvokeargument name="org_id" value="#form.org_id#">
		<cfinvokeargument name="password" value="pass">
		<cfinvokeargument name="client_id" value="#number#">
		<cfinvokeargument name="response_list" value="#trim(rtrim(form.XML_answers))#">
	</cfinvoke>
</cfif>

<b>Response from server:</b><br/>
<h2>ClientID <cfoutput>#number#</cfoutput></h2>
<cfdump var="#responseFromService#">
