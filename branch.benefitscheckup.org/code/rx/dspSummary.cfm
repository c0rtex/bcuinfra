<!--- Get State Scenarios to output from DB --->
<cfinclude template="procGenScenarios.cfm">

<cfif session.subset_id eq 27 or session.subset_id eq 28 or session.subset_id eq 36>
  			<p>
  				We recommend that you take the following actions to save money on prescription drugs and other health care costs:
  			</p>
  		
  <cfelseif session.subset_id neq 39 and session.subset_id neq 40> 	
  			<p>
  				Based on the information that you provided
  					<cfif session.subset_id eq 18 or session.subset_id eq 0 >
  						, we recommend that you take the following actions to save money on prescription drugs and other health care costs:
  					<cfelse>
  						:
  					</cfif>
  			</p>
  		
</cfif>

<cfif session.subset_id neq 18 and session.subset_id neq 0 and session.subset_id neq 39 and session.subset_id neq 40>
	<UL>
	<cfif userMedications neq "null" >
		<cf_tagGetDrugListBullets strClient="#strClient#" selectedDrugs="#UserMedications#" > 
	<cfelse>
		<li>
			<cfoutput>Not taking any medications. <cfif IsDefined('session.drugnumber')> <i>(<a href="frmDrugList.cfm?shownumber=#session.drugnumber#&cfid=#session.cfid#&cftoken=#session.cftoken#">click here</a> to make corrections)</i></cfif></cfoutput>
		</li>
	</cfif>
	</UL>
</cfif>

<!---<cfif session.subset_id neq 27 and session.subset_id neq 28 and session.subset_id neq 36 and session.subset_id neq 0>
	<h3>We Recommend:</h3>
</cfif>--->

<cfif session.subset_id neq 27 and session.subset_id neq 28 and session.subset_id neq 36>
  <cfif  session.subset_id neq 0 >
  	
  			<p>
  				Based on the 
		  		<cfif session.subset_id neq 39 and session.subset_id neq 40>
		  			medicines that you use and other 
		  		</cfif>facts that you provided, We recommend that you take 
		  		the following actions to save money on prescription drugs and other health care costs:
  			</p>
  		
  </cfif>
  
</cfif>
<cfset mode="Summary">
<cfset display_level = "1">
<cfinclude template="procScenarios.cfm">