<!-- Start List of Wrap Around PRGS to be passed to eforms -->

<!--- do not show paps as primary option if mfr cards available with $600 credit --->
<cfinclude template="qryPAP.cfm">


<cfset PAPList = "">

 <cfset firstOutput = 0 > 
<cfloop query="qryPAP" >
	<cfif listcontains(#prg_list#, #qryPAP.prg_id#) >
		<cf_tagGetPrgDrugs prg_id="#qryPAP.prg_id#" type="CheckCount">
		
		<cfif session.subset_id eq 19>
			<cfset session.AvailableDrugCount = 1>
		</cfif>
		
			<cfif 	session.AvailableDrugCount gt 0 >
				<cfset firstOutput = firstOutput + 1 >
				<cfset tempProgName = qryPAP.prg_nm >
				<cfset PAPList = #ListAppend(PAPList, qryPAP.prg_id, ",")# >
				<cfinclude template="../dspOtherOptions.cfm">
					<cfif firstOutput eq 1 >
						<cfif mode neq "Summary">    
							<li>
								<p>
									Apply for the following patient assistance program(s)
									<cfif #listcontains(prg_list, "129-311-2526-FD-FD",",")# 
										or #listcontains(prg_list, "129-311-2523-FD-FD",",")# > 
									for any of <cfif session.StrClient IS "self">your<cfelse>your 
									<cfoutput>#session.StrClient#'s</cfoutput></cfif> prescriptions 
									that are not covered by a Medicare-approved drug discount card.
									<cfelse>.</cfif> 
									These are company-sponsored programs that provide medicine usually at a very low cost: 
								</p>
							</li>
						<cfelse>
							<li>
								Apply for the patient assistance programs listed below. 
							</li>
						</cfif>
					</cfif>
			</cfif>
	</cfif>
</cfloop>


<cfif mode neq "Summary">
<ul >
<cfloop query="qryPAP" >
	<cfif listcontains(#prg_list#, #qryPAP.prg_id#) >
	<cf_tagGetPrgDrugs prg_id="#qryPAP.prg_id#" type="CheckCount">
	<cfif session.subset_id eq 19><cfset session.AvailableDrugCount = 1></cfif>
	<cfif 	session.AvailableDrugCount gt 0 > 
		<cfset firstOutput = firstOutput + 1 >
		<cfset tempProgName = qryPAP.prg_nm >
		<cfoutput><li>#tempProgName# can provide substantial extra savings on: </li></cfoutput>
		<cfoutput><ul><li><cf_tagGetPrgDrugs prg_id="#qryPAP.prg_id#" type="PAP"></li></ul></cfoutput>
		<br>
		<cfset prg_id = qryPAP.prg_id>
		<cfinclude template="../dspLinks.cfm">
	</cfif> 
	</cfif>
</cfloop>
</ul>

<cfif firstOutput gt 0 >
	<br>
</cfif>


<!-- add to RX Prg list   --->
<cfif Len(PAPList) gt 0>
	<!--- <cfif len(PAPList) gt 20>
		<cfset PAPList = "(" &  #PAPList# & ")">
	</cfif> --->
	<cfset RxPrgList = #ListAppend(RxPrgList, PAPList, ",")# >
</cfif>

</cfif>


