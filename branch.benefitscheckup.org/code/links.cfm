<cfoutput>
<cfset structLinks = structNew()>
<cfset structLinkDesc = structNew()>
<cfif session.subset_id eq 14 >
		<cfset success = #structInsert(structLinks,19, "Patient Assistance Programs", "yes")# >
		<cfset success = #structInsert(structLinkDesc,"19", "Helps find prescription assistance offered by private pharmaceutical companies.", "yes")# >
<cfelseif session.subset_id eq 27 and session.partner_id neq 8 and session.partner_id neq 17  >
		
		<cfif session.partner_id neq 22 and session.partner_id neq 31>
			<cfset success = #structInsert(structLinks,39, "Rx Programs", "yes")# >
			<cfset success = #structInsert(structLinkDesc,"39", "Screens for a variety of programs that provide assistance for prescription drugs and health care costs including Medicare Prescription Drug Coverage and the Low Income Subsidy.", "yes")# >
		</cfif>
		
<cfelseif session.subset_id eq 19 and session.partner_id neq 17 >
	<cfif (   (session.marital_stat eq 'Single' and session.hh_income_total_complete lt 1633 and session.hh_asset_total_complete lt 6000  ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 and session.hh_asset_total_complete lt 6000  ) ) >
	<cfif session.partner_id IS 22>
		<cfelse>
			<cfif session.subset_id IS NOT 39 AND session.subset_id IS NOT 19>
				<cfset success = #structInsert(structLinks,35, "Food Stamps, Housing and Energy Assistance Programs", "yes")# >
			</cfif>
			<cfset success = #structInsert(structLinkDesc,"35", "Helps determine whether you should apply for food stamps, housing and/or energy assistance programs.", "yes")# >
		</cfif>
	</cfif>
<cfelseif session.subset_id eq 36 and session.partner_id neq 31>	
		<cfset success = #structInsert(structLinks,39, "Rx Programs", "yes")# >
		<cfset success = #structInsert(structLinkDesc,"39", "Screens for a variety of programs that provide assistance for prescription drugs and health care costs including Medicare Prescription Drug Coverage and the Low Income Subsidy.", "yes")# >
<cfelseif session.subset_id eq 39 AND (session.partner_id IS NOT 24 AND session.partner_id IS NOT 25)>
	 <cfif (   (session.marital_stat eq 'Single' and session.hh_income_total_complete lt 1633 and session.hh_asset_total_complete lt 6000  ) or ( session.marital_stat neq 'Single'  and session.hh_income_total_complete lt 2200 and session.hh_asset_total_complete lt 6000  ) ) >
			<cfif session.subset_id IS NOT 39 AND session.subset_id IS NOT 19> 	
				<cfset success = #structInsert(structLinks,35, "Food Stamps, Housing and Energy Assistance Programs", "yes")# >
			</cfif>
			<cfset success = #structInsert(structLinkDesc,"35", "Helps determine whether you should apply for food stamps, housing and/or energy assistance programs.", "yes")# >
		
	</cfif>
<cfelseif session.subset_id eq 49>
		<cfset success = #structInsert(structLinks,19, "Patient Assistance Programs", "yes")# >
		<cfset success = #structInsert(structLinkDesc,"19", "Find low or no cost prescription drugs offered by private pharmaceutical companies.", "yes")# >
</cfif>

<div>
<cfif (session.partnerLinksFlag eq 1 and not StructIsEmpty(structLinks)) and (session.subset_id neq 40 and session.subset_id neq 67)>
		<h2>More Options</h2>
		<hr />
<cfelseif session.subset_id neq 40 >
	<cfif SESSION.partner_id EQ 0>
		<h2>More Options</h2>
		<hr>
<cfelseif session.partner_id eq 14>

<br>
		<h2>More Options</h2>

	<cfelse><br>
		<h2>More Options</h2>
		<hr size="1" color="ababab" noshade="noshade" />
	</cfif>

</cfif> 

<cfif session.subset_id neq 40 and session.subset_id neq  67>
	<p>Want to Change Some of Your Answers?</p>

	<ul class="striping">
		<li class="questionBar">
			You can review all of your answers to the questionnaire, 
			make changes, and resubmit it by clicking <cf_link href="startover.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&source_id=#session.source_id#&prev_id=#SESSION.screening_id#&org_id=#session.org_id#&partner_id=#session.partner_id#&subset_id=#session.subset_id#&language_id=EN&access_id=#session.access_id#&client_id=NULL&user_id=NULL&test_id=0" prev_id="#session.screening.id#">here</cf_link>.
		</li>
	</ul>

</cfif>
</div>
</cfoutput>
