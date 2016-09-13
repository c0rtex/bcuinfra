<cfif mode eq "Summary"> 
<cf_matchCat category_id="23" prg_list="#session.prg_list#">
<cfif matchCat >
	<cfquery name="qrySNAPPrg" datasource="#application.dbSrc#">
		SELECT *  
		FROM          
		program p, programcategory pc
        where pc.programcategory_id = p.programcategory_id
        and pc.programcategory_id = 23
        and p.state_id =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2"> limit 0, 1
      </cfquery> 
<cfif qrySNAPPrg.recordcount gt 0>
	<cfset programNameText = "">
	<cf_displaytext group="program" code="program_#qrySNAPPrg.program_code#" var="programName">
	<cfset programNameText = programName>
<cfelse>              
	<cfset programNameText = "SNAP">
</cfif>
<cfset rec1 = #replace('test','{prg_nm}',programNameText,"all")# >
<cfoutput><li>Apply for the #programNameText#.</li></cfoutput>
</cfif>
<CFIF listcontains( #prg_list#, "101-302-1023-FD-FD") >
<li>Apply for Supplemental Security Income (SSI), which can offer you monthly cash assistance.</li>
</cfif>
<cfelse>
<cfif matchCat >
<cfset RxPrgList = #ListAppend(RxPrgList, matched_prg_id, ",")# >
	<cfset programNameText = "">
	<cf_displaytext group="program" code="program_#qrySNAPPrg.program_code#" var="programName">
	<cfset programNameText = programName>
<p><li><cfoutput>
Apply for the #programNameText#, which can offer you coupons or an electronic card that you can use to buy food at most grocery stores.</cfoutput>
</li></p>
<cfset prg_id = "#matched_prg_id#">
<cfinclude template="../dspLinks.cfm">
</cfif>
<CFIF listcontains( #prg_list#, "101-302-1023-FD-FD") >
<cfset RxPrgList = #ListAppend(RxPrgList, "101-302-1023-FD-FD", ",")# >
<p>
<li>
Apply for SSI, which can offer you monthly cash assistance and give you a minimum level of income each month.
</li> 
</p>
<cfset prg_id = "101-302-1023-FD-FD">
<cfinclude template="../dspLinks.cfm">
</cfif>
</CFIF>