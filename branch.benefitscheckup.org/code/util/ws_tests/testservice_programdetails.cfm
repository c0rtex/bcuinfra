<cfparam name="url.showdescription" type="boolean" default="true">
<cfparam name="url.showentrypoints" type="boolean" default="true">
<cfparam name="url.eplimit" type="numeric" default="3">
<cfparam name="url.showrequisites" type="boolean" default="true">
<cfparam name="url.county" type="string" default="">
<cfparam name="url.state_id" type="string" default="">
<cfparam name="url.zip" type="string" default="">
<cfparam name="url.program_id" type="numeric" default="0">

<cfinvoke method="getProgramDetails" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_6.cfc?wsdl" >

<cfinvokeargument name="program_id" value="#url.program_id#">
<cfinvokeargument name="state_id" value="#url.state_id#">
<cfinvokeargument name="county" value="#url.county#">
<cfinvokeargument name="zip" value="#url.zip#">
<cfinvokeargument name="showdescription" value="#url.showdescription#">
<cfinvokeargument name="showentrypoints" value="#url.showentrypoints#">
<cfinvokeargument name="eplimit" value="#url.eplimit#">
<cfinvokeargument name="showrequisites" value="#url.showrequisites#">
</cfinvoke >

<!--- cfset questiondata = #xmlparse(responsefromservice)# --->

<cf_displayprogramdetail program_id = "#program_id#" state_id="#state_id#" county="#url.county#" zip="#url.zip#" source="ec" var="responsefromservice2" >



<cfoutput>#responsefromservice#</cfoutput>





