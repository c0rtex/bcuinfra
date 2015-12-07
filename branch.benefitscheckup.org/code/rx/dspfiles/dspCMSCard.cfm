<!-- CMS-APPROVED DISCOUNT CARDS ELIGIBLE( NOT WRAP AROUND - NOT TA) -->
<cfset session.MaxTACount = 0 >
<cfset session.OPTList = "">
<cfset MedicareCardList = "">
<cfset Cat_ID = 334 >
	<cfinclude template="qryMedApproved.cfm">
<cfif listcontains(  #prg_list#, "129-311-2523-FD-FD") >
<cfif mode neq "Summary">
	<cfinclude template="../dspOtherOptions.cfm">
<p>
<li>Sign up for a  Medicare-approved drug discount card.
		<cfset loopCount = 0>
		   <cfloop collection=#session.StructMedApproved# item="temp_prg_id" >
		   		<cfset loopCount = loopCount + 1 >
				<cfif loopCount eq 1>
					We recommend that <cfif #StrClient# IS "self">you select<cfelse>your <cfoutput>#StrClient# selects</cfoutput></cfif> the U Share Prescription Drug Discount Card (United HealthCare Insurance Company - D7089). For more information about this program, click <a href="frmDetails.cfm?prg_id=129-334-2654-FD-FD">here</a>. After paying the $19.95 program fee, <cfif session.StrClient IS "self">you<cfelse>your <cfoutput>#session.StrClient#</cfoutput></cfif> will receive discounts on all of your medicines and extra savings on the following prescriptions:
					</li></p>
					<ul>
				</cfif>
		<cf_tagGetPrgDrugs prg_id="#temp_prg_id#" TYPE="CMSNOTA">
		<cfset result = #StructUpdate(session.StructMedApproved, temp_prg_id, session.drugcount)#>
		<cfif session.drugCount gt session.MaxTACount >
					<cfset session.MaxTACount = session.drugCount >
		</cfif>
	  </cfloop>
	  <cfif loopCount gt 0>
			</ul>
		<!--- <p>
		The following Medicare-approved drug discount card offers the savings described above. <!--- We recommend that <cfif #StrClient# IS "self">you select<cfelse>your <cfoutput>#StrClient# selects</cfoutput></cfif> a card that is honored by a pharmacy nearby. --->
		</p> --->
	  <cfelse>
		These cards provide retail savings of 15% to 20% and in some cases more. Some cards are free and others cost up to $30 per year. However, because your income is over the eligibility limits for extra assistance and/or because you do not take any medicines that qualify you for additional savings, we cannot recommend a specific Medicare-approved drug discount card that will be substantially better for you than other cards.
		</p><p>
		To find the card that will provide you with the best savings for the medications that you use, we recommend that you click <a href="http://www.medicare.gov/AssistancePrograms/home.asp?version=default&browser=IE%7C6%7CWinXP&language=English&defaultstatus=0&pagelist=Home&dest=" target="_blank">here</a> for the Medicare Prescription Drug and Other Assistance Programs Tool or call 1-800-MEDICARE. Please read and complete the other recommendations in this ABC report and then contact Medicare to make a final decision about which Medicare-approved discount card to use.
			</li></p>
	  </cfif>

<cfelse>
<cfset templist="">
<cfloop collection="#session.StructMedApproved#" item="strPrgID" >
	<cfset tempList = listAppend(tempList,#strPrgID#,",")>
</cfloop>

<cfset loopcount = 0>
<cfset matchingdrugs = 0 >
<cfset hasOutputed = "No">
<cfloop list=#templist# index="temp_prg_id">
		<cf_tagGetPRgDrugs prg_id="#temp_prg_id#" type="CMSNOTA"  OUTPUT="No">
</cfloop>

<li>Sign up for a  Medicare-approved drug discount card.</li>
</cfif>


<cfif mode neq "Summary">
<ul>
<cfset tempList="" >
<cfloop collection="#session.StructMedApproved#" item="strPrgID" >
	<cfset tempList = listAppend(tempList,#strPrgID#,",")>
</cfloop>


<!--- <cfset tempList =  #ArrayToList( StructSort(session.StructMedApproved,"numeric","DESC"))# > --->
<cfset loopcount = 0>
<cfloop list=#templist# index="temp_prg_id">
	<Cfset tempVal =  #StructFind( session.StructMedApproved, temp_prg_id)#>
	<cfif tempVal neq 0>
	<cfset loopcount = loopcount + 1>
	<cfif loopcount lte 3>

		<cfoutput><cfset MedicareCardList = #ListAppend(MedicareCardList, #temp_prg_id#, ",")# ></cfoutput>
		<!--- <li> --->
		<Cfset temp_prg_nm =  #StructFind( session.structMedApprovedNames, temp_prg_id)#>
		<!--- <cfoutput>#temp_prg_nm# <!---for savings on:---> </cfoutput> --->
		<cfoutput><ul><cf_tagGetPrgDrugs prg_id="#temp_prg_id#" Type="SETDRUGSLIST"></ul>
		<!--- </li> --->
		<Cfset DNumber =  #StructFind( session.structMedApprovedDNumber, temp_prg_id)#>
		<Cfset LocatorEnable =  #StructFind( session.structMedApprovedLocatorEnable, temp_prg_id)#>
		<cfif LocatorEnable eq 1 > 
		<p><em>Click <a href="#session.PharmacyLocatorURL#?zip=#session.zip#&Network=#DNumber#" target="_blank">here</a> to locate the pharmacies closest to you that honor this card.</em></p>
		<cfelse>
		<p><em>Local pharmacies for this card have not been provided to us.</em></p>
		</cfif> 
		</cfoutput>
	</cfif>
	</cfif>
</cfloop>
</ul>
<!-- add to RX Prg list   --->
<cfif Len(MedicareCardList) gt 0>
	<cfif len(MedicareCardList) gt 20>
		<cfset MedicareCardList = "(" &  #MedicareCardList# & ")">
	</cfif>
<cfset RxPrgList = #ListAppend(RxPrgList, MedicareCardList, ",")# >
<cfelse>
	<cfset RxPrgList = #ListAppend(RxPrgList, "129-311-2523-FD-FD", ",")# > 
</cfif>
</cfif>
</cfif>

