<cfinvoke method="getProgramForms" 
returnvariable="responseFromService" 
webservice="http://bcuqa.benefitscheckup.org/util/remotescreening_staging.cfc?wsdl" >

<cfinvokeargument name="program_id" value="#url.program_id#">
<cfinvokeargument name="state_id" value="#url.state_id#">
<cfinvokeargument name="format" value="#url.format#">
</cfinvoke >
<cfset session.st = url.state_id >
<!---cf_displayprogramdetailforms program_id = "#program_id#" state_id="#state_id#"  var="resultstring" formtype_id=0 source="details"--->



<cfoutput><h2>Test Output for Program ID: #program_id# State: #state_id# Format #format#</h2>
#responsefromservice#


</cfoutput>

<cfif url.format eq "xml" and #isxml(responsefromservice)#>
<cfset tryme = #xmlparse(responsefromservice)#>
<cfdump var="#tryme#">
</cfif>






