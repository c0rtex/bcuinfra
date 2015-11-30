<cfif session.subset_id eq 19 >
  <!-- For States with no Pharmacy  programs -->
  <CFIF hasStateProgram is "N" >
  <!-- Scenario A  If Already Receiving Medicaid -->
      <cfif med_receive eq "Y">
          <!-- Scenario A -->
          <cfset Scenario="A">
      <!-- Scenario B If Medicaid Eligible, but not currently receiving Medicaid - need list of medicaid prg ids -->
      <cfelseif strMedicaidEligible eq "Y" >
          <!-- Scenario B -->
          <cfset Scenario="B">
      <!--  Scenario C If Not Medicaid Eligible, but TA Eligible -->
      <cfelseif listcontains(#prg_list#, "129-311-2526-FD-FD") >
          <!-- Scenario c -->
          <cfset Scenario="C">
      <!-- Scenario D Not Medicaid Eligible and Not TA Eligible -->
      <cfelse>
          <!-- Scenario d -->
          <cfset Scenario="D">
      </cfif>	
  <!-- USE Logic for States with Pharmacy Programs – (Ex. NYS EPIC 1) -->	
  <CFELSE>
      <!-- Scenario A	Already Receiving Medicaid    -->												
      <cfif med_receive eq "Y">
          <!-- Scenario A -->
          <cfset Scenario="A">				
      <!-- Scenario B	If Medicaid Eligible, but not currently receiving Medicaid	-->				
      <cfelseif strMedicaidEligible eq "Y" >
          <!-- Scenario B -->
          <cfset Scenario="B">		
      <!--Scenario C	Eligible for Both State Program and TA	-->
      <cfelseif listcontains(#prg_list#, "129-311-2526-FD-FD") and stateReceive neq "Y" >
              <!-- Apply for EPIC 1 and Auto Enroll in TA? -->
              <!-- Scenario C -->	
              <cfset Scenario="C">									
      <!-- Scenario D	Eligible for State Program but Not TA  (will vary from state-to-state)	-->			
      <cfelseif  not listcontains(#prg_list#, "129-311-2526-FD-FD")  and stateReceive neq "Y">	
              <!-- Scenario D -->
              <cfset Scenario="D">				
      <!-- Scenario E	Receiving State Program and Eligible for TA (will vary from state-to-state) -->				
      <cfelseif  listcontains(#prg_list#, "129-311-2526-FD-FD") and stateReceive eq "Y" >	
              <!-- Scenario E -->
              <cfset Scenario="E">	
      <!-- Scenario F	Receiving State Program and NOT Eligible for TA (will vary state-to-state)	 -->
      <cfelseif stateReceive eq "Y" and not listcontains(#prg_list#, "129-311-2526-FD-FD")   >	
              <!-- Scenario F -->
              <cfset Scenario="F">	
      <!-- Scenario G	Eligible for TA but not State (will vary state-to-state)		 -->
      <cfelseif listcontains(#prg_list#, "129-311-2526-FD-FD")  and stateReceive neq "Y" >	
          <!-- Not Applicable in NY - otherwise answers are the same as TA eligible in states w/o state programs -->
              <!-- Scenario G -->
              <cfset Scenario="G">	
      <!-- Scenario H	Not State and not TA		 -->
      <cfelse>
              <!-- Scenario H -->
              <cfset Scenario="G">	
      </cfif>
  </CFIF>

<CFELSEIF  session.subset_id eq 27 or session.subset_id eq 39 >
	<cfset scenario = "LIS">
	<cfif not  (listcontains( #prg_list#, "103-309-1031-FD-FD") 
or  listcontains( #prg_list#, "103-309-1071-FD-FD")
or listcontains( #prg_list#, "103-309-2681-AZ-ST")
or listcontains( #prg_list#, "103-309-2683-AZ-ST")
or listcontains( #prg_list#, "103-309-2940-NY-ST")
or listcontains( #prg_list#, "103-309-2939-CT-ST")
or listcontains( #prg_list#, "103-309-1032-FD-FD")
or listcontains( #prg_list#, "103-309-2682-AZ-ST" )) or  listcontains( #prg_list#, "103-311-2593-FD-FD" )  or (isdefined('session.receive_lis') and session.receive_lis eq 'y')>
	<cfset scenario = "Y">
	</cfif>
	<cfif 
	( isdefined('session.receive_msp') and session.receive_msp eq 'y') 
	or 
	(isdefined('session.ssi_receive') and  session.ssi_receive eq 'y' ) 
	or 
	( isdefined('session.med_receive') and session.med_receive eq 'y') >
		<cfset scenario = "Y">
	</cfif>
<CFELSE >
	<cfset Scenario="Y">
</CFIF>