<cfset OtherCardsList = "">
<!--- Consider applying for TogetherRx  132-332-2372-FD-FD) --->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2372-FD-FD">

<cfif  listcontains(  #prg_list#, "132-332-2372-FD-FD") > 
	<cfif mode eq "Summary">
		<li>Apply for the free Together Rx Program&trade;  Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2372-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Together Rx Program&trade; Discount Card because 
				it may offer <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				further savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif>
				will save through the program(s) listed above. 
				Click <a href="frmDetails.cfm?prg_id=132-332-2372-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2372-FD-FD" Type="OtherCards">
			</li>
		</p>
	</cfif>
</cfif>

<!--- Consider applying for TogetherRx 132-332-2514-FD-FD --->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2514-FD-FD">

<CFIF listcontains(  #prg_list#, "132-332-2514-FD-FD")   >
	<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2514-FD-FD", ",")# >
	<cfif mode eq "Summary">
		<li>Apply for the free Together Rx Program&trade; Discount Card.</li>
	<cfelse>
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Together Rx Program&trade;  Discount Card because it may offer 
				<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				further savings above and beyond what <cfif #StrClient# IS "self">you
				<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif>
				will save through the program(s) listed above. 
				Click <a href="frmDetails.cfm?prg_id=132-332-2514-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2514-FD-FD" Type="OtherCards">
			</li>
		</p>
		<cfinclude template="../dspOtherOptions.cfm">
	</cfif>
</cfif>

<!-- Consider Lilly Answers ---- 132-332-2385-FD-FD   -->	
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2385-FD-FD" >

<cfif  listcontains(  #prg_list#, "132-332-2385-FD-FD")   >
	<cfif mode eq "Summary">
		<li>Apply for the free LillyAnswers&trade; Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2385-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<li>
			Apply for the free LillyAnswers&trade; Discount Card because it may 
			offer <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
			further savings above and beyond what 
			<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> will 
			save through the program(s) listed above. Click 
			<a href="frmDetails.cfm?prg_id=132-332-2385-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
			for details about how to save money for the drug(s) listed below. 
			<cf_tagGetPrgDrugs Type="OtherCards" prg_id="132-332-2385-FD-FD">
		</li>
	</cfif>
</cfif>

<!-- GlaxoSmithKline Orange CardSM ----  132-332-2402-FD-FD   -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2402-FD-FD">

<cfif  listcontains(  #prg_list#, "132-332-2402-FD-FD")  >
	<cfif mode eq "Summary">
		<li>Apply for the free GlaxoSmithKline Orange Card&trade;  Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2402-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free GlaxoSmithKline Orange Card&trade;  Discount Card 
				because it may offer <cfif #StrClient# IS "self">you<cfelse>your 
				<cfoutput>#StrClient#</cfoutput></cfif> further savings above and 
				beyond what <cfif #StrClient# IS "self">you<cfelse>your 
				<cfoutput>#StrClient#</cfoutput></cfif> will save through the program(s) 
				listed above. Click 
				<a href="frmDetails.cfm?prg_id=132-332-2402-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a>  
				for details about how to save money for the drug(s) listed below.  
				<cf_tagGetPrgDrugs Type="OtherCards" prg_id="132-332-2402-FD-FD">
			</li>
		</p>
	</cfif>
</cfif>

<!-- Together Rx Access (132-332-2692-FD-FD)  -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2692-FD-FD">
<cfif  listcontains(  #prg_list#, "132-332-2692-FD-FD")   >
	<cfif mode eq "Summary">
		<li>Apply for the free Together Rx Access Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2692-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Together Rx Access Discount Card because it may offer 
				<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				further savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your 
				<cfoutput>#StrClient#</cfoutput></cfif> will save through the program(s) listed above.  
				Click <a href="frmDetails.cfm?prg_id=132-332-2692-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2692-FD-FD" Type="OtherCards"> 
			 </li>
		</p>
	</cfif>
</cfif>

<!-- Pfizer Pfriends 132-332-2691-FD-FD  -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2691-FD-FD">

<cfif  listcontains(  #prg_list#, "132-332-2691-FD-FD")  >
	<cfif mode eq "Summary">
		<li>Apply for the free Pfizer Pfriends Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2691-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Pfizer Pfriends Discount Card because it may offer 
				<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> further 
				savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your 
				<cfoutput>#StrClient#</cfoutput></cfif> will save through the program(s) 
				listed above. Click 
				<a href="frmDetails.cfm?prg_id=132-332-2691-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2691-FD-FD" Type="OtherCards"> 
			</li>
		</p>
	</cfif>
</cfif>

<!-- Pfizer for Living Share Card™ Program   -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2384-FD-FD">

<cfif  listcontains(  #prg_list#, "132-332-2384-FD-FD")   >
	<cfif mode eq "Summary">
		<li>Apply for the free Pfizer for Living Share Card &trade; Program Discount Card.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2384-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Pfizer for Living Share Card &trade; Program Discount Card 
				because it may offer <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				further savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your 
				<cfoutput>#StrClient#</cfoutput></cfif> will save through the program(s) listed above. 
				Click <a href="frmDetails.cfm?prg_id=132-332-2384-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2384-FD-FD" Type="OtherCards"> 
			</li>
		</p>
	</cfif>
</cfif>

<!-- Pfizer for Living Share Card™ Program   -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="132-332-2701-FD-FD">

<cfif  listcontains(  #prg_list#, "132-332-2701-FD-FD")  >
	<cfif mode eq "Summary">
		<li>Apply for the free Merck Prescription Discount Program.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2701-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Merck Prescription Discount Program because it may offer 
				<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> further 
				savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				will save through the program(s) listed above. 
				Click <a href="frmDetails.cfm?prg_id=132-332-2701-FD-FD&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="132-332-2701-FD-FD" Type="OtherCards"> 
			</li>
		</p>
	</cfif>
</cfif>
<!-- Rx Outreach   -->
<cf_tagGetPrgDrugs Type="CheckCount" prg_id="XXX-XXX-1881-XX-XX">

<cfif  listcontains(  #prg_list#, "XXX-XXX-1881-XX-XX")  >
	<cfif mode eq "Summary">
		<li>Apply for the free Rx Outreach Program.</li>
	<cfelse>
		<cfset OtherCardsList = #ListAppend(OtherCardsList, "132-332-2701-FD-FD", ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		<p>
			<li>
				Apply for the free Rx Outreach Program because it may offer 
				<cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> further 
				savings above and beyond what <cfif #StrClient# IS "self">you<cfelse>your <cfoutput>#StrClient#</cfoutput></cfif> 
				will save through the program(s) listed above. 
				Click <a href="frmDetails.cfm?prg_id=XXX-XXX-1881-XX-XX&ReportType=<cfoutput>#url.reporttype#</cfoutput>">here</a> 
				for details about how to save money for the drug(s) listed below. 
				<cf_tagGetPrgDrugs prg_id="XXX-XXX-1881-XX-XX" Type="OtherCards"> 
			</li>
		</p>
	</cfif>
</cfif>
<!-- add to RX Prg list   -->
<cfif Len(OtherCardsList) gt 0>
 <!--- <cfif len(OtherCardsList) gt 20 >
	<cfset OtherCardsList = "(" &  #OtherCardsList# & ")">
  </cfif> --->
	<cfset RxPrgList = #ListAppend(RxPrgList, OtherCardsList, ",")# >
</cfif>

