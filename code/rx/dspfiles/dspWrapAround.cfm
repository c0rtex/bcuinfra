<!-- Start List of Wrap Around PRGS to be passed to eforms -->
<cfset session.MaxTACount = 0 >
<cfset session.OPTList = "">
<cfset WrapAroundList = "">
<cfset noCards = "No">
<cfset tempList="" >
<cfparam name="session.RandList" default="">
<cfif not isdefined('session.qi1_receive')>
	<cfset session.qi1_receive = "">
</cfif>
<cfif  listcontains(  #prg_list#, "129-311-2526-FD-FD") >
<cfif mode neq "Summary">
	<cfset RxPrgList = #ListAppend(RxPrgList, "129-311-2526-FD-FD", ",")# >
	<cfinclude template="../dspOtherOptions.cfm">
	<li>
		<p>
		You can sign up for one of the free Medicare-approved 
		drug discount cards. These cards will provide additional assistance in 2005 
		that can be used to pay for medications. The amount of the additional 
		assistance offered depends on when you apply for the card. If you apply between October 1, 2005 and December 31, 2005 you will get $150.  
		</p>
		<p>
		   <cfset loopCount = 0>
		   <cfloop collection=#session.StructMedApproved# item="temp_prg_id" >   
		   		<cfset loopCount = loopCount + 1 >
				<cfif loopCount eq 1>
					In addition, by choosing one of the cards listed below, <cfif session.StrClient IS "self">you<cfelse>your <cfoutput>#session.StrClient#</cfoutput></cfif> will receive extra savings on the following prescriptions: 
					</p>
					<ul>
				</cfif>
				<cf_tagGetPRgDrugs prg_id="#temp_prg_id#" type="CMSTA" count="#loopCount#" output="Yes">
				<cfset result = #StructUpdate(session.StructMedApproved, temp_prg_id, session.drugcount)#>
				<cfif session.drugCount gt session.MaxTACount >
					<cfset session.MaxTACount = session.drugCount >
				</cfif>
			</cfloop>
			
			<cfif loopCount gt 0>
				</ul>
				
			<cfelse >
				
				<cfset noCards = 'Y'>
				You are eligible to receive the same additional assistance from most cards, but retail prices for different medicines may vary from card to card. 
				</P>
				
				<p>To decide which card is right for you, here are two options for you to consider:</p>
				<ol>
				<li>If <cfif #StrClient# IS "self">you spend<cfelse>your <cfoutput>#StrClient# spends</cfoutput></cfif> a lot more than the amount of the additional assistance on medicines and you are interested in getting the very best deal, click <a href="http://www.medicare.gov/AssistancePrograms/home.asp?version=default&browser=IE%7C6%7CWinXP&language=English&defaultstatus=0&pagelist=Home&dest=" target="_blank">here</a> for the Medicare Prescription Drug and Other Assistance Programs Tool or call 1-800-MEDICARE to find the card that will get you the most discounts on the medications that you take after the additional assistance has been used up.  Please read and complete the other recommendations in this ABC report and then contact Medicare to make a final decision about which Medicare-approved drug discount card to use.</li>
				<li>If you spend less than the amount of the additional assistance on medicines, most Medicare-approved drug discount cards are likely to provide you with similar levels of savings. </li>
				</ol>
				
					<cfif NOT #findNoCase("frmDetails.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("frmEForms.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("frmMedicareFrame.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("dspEnrollComplete.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("dspMedicareEnroll.cfm",cgi.HTTP_REFERER)# gt 0>
						<cfset reset = "Yes">
					<cfelse>
						<cfset reset = "No">
					</cfif>
			<cf_tagRandomTACard reset="#reset#">
					<cfif reset eq "Yes">
					<cfloop from="1" to="3" index="i">
						<cfset templist = #listAppend(templist,prg[i],",")#>
						
					</cfloop>
						<cfset session.templist = templist >
					<cfelse>	
							<CFSET templist = session.templist > 
					</cfif>
			</cfif>
			
			<cfset MaxNum = session.MaxTACount >

<!-- Randomize the order of card selection only if comming from questionnaire not other pages-->
<cfif NOT #findNoCase("frmDetails.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("frmEForms.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("frmMedicareFrame.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("dspEnrollComplete.cfm",cgi.HTTP_REFERER)# gt 0 and NOT #findNoCase("dspMedicareEnroll.cfm",cgi.HTTP_REFERER)# gt 0>
<cfset session.structRandTAPRG = StructNew()>
<cfset session.arrayRandTAPRG = ArrayNew(1)>
<cfset loopcount = 0>
<cfloop collection="#session.StructMedApproved#" item="strPrgID" >
<cfset loopcount = loopcount + 1>
		<cfset RandomNum = RandRange(1, 10000000) >
		<CFSET temp = ArrayAppend(session.arrayRandTAPRG, "#RandomNum#")>	
		<cfset results = #StructInsert(session.structRandTAPRG, RandomNum , strPrgID,"true")#>
</cfloop>	
<cfset session.randList = #ArrayToList(session.ArrayRandTAPRG,",")#>
<cfset session.randList = #ListSort(session.randList,"Numeric", "Desc",",")#>
</cfif>	
<!--- Pick output cards --->

</b>
<cfif templist eq "">
<cfset ListCount = 0 >
<cfloop from="-#session.MaxTACount#" to="0" index="x">
<cfloop list=#session.RandList# index="x" >
	<cfset StrPRGID = #StructFind(session.structRandTAPRG,x)#>
	<cfif listCount lt 3 > 
	<cfset tempNum = #StructFind(session.structMedApproved, StrPrgID)# >
	<!--- <cfif tempNum eq MaxNum > --->
	<cfif (tempNum eq session.MaxTACount) and (tempNum neq 0) >
		<cfset tempList = listAppend(tempList,#strPrgID#,",")>
		<cfset ListCount = ListCount + 1>
	</cfif>
	<!--- </cfif> --->
	</cfif>
</cfloop>
	<cfset Session.MaxTACount = Session.MaxTACount - 1 >
</cfloop>
</cfif>
<br>
<cfset loopcount = 0>
<cfset matchingdrugs = 0 >
<cfset hasOutputed = "No">
<table    >
<tr><td   valign=top colspan="2" width="100%" ><table width="100%"><Tr><td  align=left nowrap><font size=3><strong>Recommended Medicare-Approved Drug Discount Cards</strong></font></td><td align=right nowrap><A HREF="javascript:help3('dspWhyCards.cfm')">Why These Cards?</A></td></Tr></table></td></tr> 
<cfloop list=#templist# index="temp_prg_id">
		<cfif hasOutputed neq "Yes" >
		<cfif noCards eq 'Y'>
		<p>Here are three good options for you to consider. We recommend that you select a card that is honored at a pharmacy that is convenient to you.</p>
		<cfelse>
		<p>
		The following Medicare-approved drug discount cards offer the extra savings described above.  <u>Any one of these cards will be a good choice.</u>  We recommend that <cfif #StrClient# IS "self">you select<cfelse>your <cfoutput>#StrClient# selects</cfoutput></cfif> a card that is honored by a pharmacy nearby.
		</p>
		</cfif>
		</li>   
		<cfset hasOutputed = "Yes">
		</cfif>
		<cfset temp_prg_nm =  #StructFind( session.structMedApprovedNames, temp_prg_id)#>
		<Cfset CMSEnable =  #StructFind( session.structMedApprovedCMSEnable, temp_prg_id)#>
		<Cfset DNumber =  #StructFind( session.structMedApprovedDNumber, temp_prg_id)#>
		<Cfset LocatorEnable =  #StructFind( session.structMedApprovedLocatorEnable, temp_prg_id)#>
		<tr><td colspan="2" width="100%"><hr color="#999966"></td></tr> 
		<tr><td colspan="2" width="100%" height=50>
		<cfoutput><font size=+1>#temp_prg_nm#</font></cfoutput>
		</td></tr>

		<tr>
		<td colspan=2><table>
		<td width="180" valign=top >
		<cfoutput><cfif LocatorEnable eq 1 ><a href="#session.PharmacyLocatorURL#?zip=#session.zip#&Network=#DNumber#" target="_blank"><img alt="Find a Pharmacy" src="../../images/button_find-pharmacy.gif" border="0"></a><cfelse>Not Available</cfif></cfoutput>
		</td><td  valign=top>
		
		<font size=+1>
		<cfoutput><cfset WrapAroundList = #ListAppend(WrapAroundList, #temp_prg_id#, ",")# ></cfoutput> 
		<cfif LocatorEnable eq 1> 
		Click the button to the left to locate the pharmacies closest to you that honor this card.
		<cfelse>
		Local pharmacies for this card have not been provided to us.
		</cfif>
		</font>
		</td></tr></table>
		</td></tr>
		<cfset prg_id = "#temp_prg_id#">
		<tr><td colspan=2>
		<cfinclude template="../dspLinks.cfm">
		</td></tr>
</cfloop>
</table>

<cfif Len(WrapAroundList) gt 0>
	<cfif len(WrapAroundList) gt 20>
		<cfset WrapAroundList = "(" &  #WrapAroundList# & ")">
	</cfif>
<cfset RxPrgList = #ListAppend(RxPrgList, WrapAroundList, ",")# >
</cfif>
<cfelse>
<!---Summary --->
	<cfset Cat_ID = 333 >
	<cfinclude template="qryMedApproved.cfm">
<li>Sign up for a Medicare-approved drug discount card with the additional assistance. <cfif #qryMedicaid.recordCount# gt 0 >This program can help save you money on prescriptions while you wait to hear about your Medicaid application.</cfif></li>
</cfif>
</cfif>
