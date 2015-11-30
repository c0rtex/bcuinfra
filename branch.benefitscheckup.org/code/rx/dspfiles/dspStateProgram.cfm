<!---  Check for State Program and get state prg text --->
<!-- display AutoEnroll  -->
<cfset request.stprg = "">
<cfif mode eq "Summary">
	<cfinclude template="qryStatePrograms.cfm">
</cfif>
<cfset StateList = "" >
<cfloop  query="qryStatePrg" startrow="1" endrow="2" >
<cfset prg_id =  qryStatePrg.prg_id >
<cfset request.stprg = prg_id  >
<cfif mode neq "Summary">
		<!-- Create list of state prg_ids to be passed to eforms page -->
		<cfset StateList = #ListAppend(StateList, prg_id, ",")# >
		<cfinclude template="../dspOtherOptions.cfm">
		
		<cfset rec = "#qryStatePrg.rec#">
		<cfset programNameText = "#prg_nm#">
		<cfset rec1 = #replace(rec,'{prg_nm}',programNameText,"all")# >
		<cfset rec2 = #replace(rec1,'prg_nm',programNameText,"all")# >
		<p><li><cfoutput>#rec2#</cfoutput>
		<cfif session.st eq 'PA' and #listcontains(prg_list, "XXX-311-1288-PA-ST")#  >
		<table cellpadding=2 >
						<table><tr><td width="140" valign=top>
		<a href="frmMedicareFrameSet.cfm?startpace=Y"><img alt="Apply Now" src="../../images/button_apply-now.gif" border="0"></a>
		</td><td  valign=top><b>Apply online for PACE</b></td></TR>
		</table>
		<cfelseif session.st eq 'PA' and  #listcontains(prg_list, "XXX-311-1289-PA-ST")# >
		<table cellpadding=2 >
						<table><tr><td width="140" valign=top>
		<a href="frmMedicareFrameSet.cfm?startpace=Y"><img alt="Apply Now" src="../../images/button_apply-now.gif" border="0"></a>
		</td><td  valign=top><b>Apply online for PACENET</b></td></TR>
		</table>		
</cfif>

<cfif stateType eq "receiving" >
	<cfset request.dontapply = "Yes">
</cfif>
<cfset success  = #arrayAppend(arraylinks, prg_id)#>
<cfif subset_id neq 14>
<br>
<cfinclude template="../dspLinks.cfm">
<cfelse>
<cfinclude template="../dspLISLinks.cfm">
</cfif>
</li></p>
<cfelse>
<cfif #len(summary)# gt 5 >
	<cfset summary = "#qryStatePrg.summary#">
			<cfset programNameText = "#prg_nm#">
			<cfset summary2 = #replace(summary,'{prg_nm}',programNameText)# >
	<cfset summary3 = #replace(summary2,"prg_nm",programNameText)# >
	<li><cfoutput>#summary3#</cfoutput></li>
</cfif>
</cfif>
</cfloop>
<cfif mode neq "Summary" and stateType eq "eligible">
<!-- add to RX Prg list   --->
<cfif Len(StateList) gt 0>
<cfif len(StateList) gt 20>
	<cfset StateList = "("&  #StateList# & ")">
</cfif>
	<cfset RxPrgList = #ListAppend(RxPrgList, StateList, ",")# >
</cfif>
</cfif>