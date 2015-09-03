<CFIF session.subset_id neq 27 and session.subset_id neq 39 >
<!--- Group 2 --->
<cfset arrayLISOutputs =  arraynew(1)>
<cfset structLISReceives =  structnew()>
	<cfif isdefined('session.receive_medicare_discount') and session.receive_medicare_discount eq 'y' >
		<cfset success = arrayAppend(arrayLISOutputs, 'MEDICARECARD')>
		<cfset success = structinsert(structLISReceives, 'MEDICARECARD', 'receive_medicare_discount',"Yes") >
	</cfif>
	<cfif isdefined('session.receive_medicare_discount_credit') and   session.receive_medicare_discount_credit eq 'y' >
		<cfset success = arrayAppend(arrayLISOutputs, 'MEDICARECREDIT')>
		<cfset success = structinsert(structLISReceives, 'MEDICARECREDIT', 'receive_medicare_discount_credit',"Yes") >
	</cfif>
	<cfif isdefined('session.receive_pap') and session.receive_pap eq 'y' >
		<cfset success = arrayAppend(arrayLISOutputs, 'PAP')>
		<cfset success = structinsert(structLISReceives, 'PAP', 'receive_pap',"Yes") >
	</cfif>
	<cfif isdefined('session.receive_trx') and session.receive_trx eq 'y' >
		<cfset success = arrayAppend(arrayLISOutputs, 'TOGETHER')>
		<cfset success = structinsert(structLISReceives, 'TOGETHER', 'receive_trx', "Yes") >
	</cfif>
	<cfif isdefined('session.receive_drug_discount_card') and session.receive_drug_discount_card eq 'y' >
		<cfset success = arrayAppend(arrayLISOutputs, 'DISCOUNTCARD')>
		<cfset success = structinsert(structLISReceives, 'DISCOUNTCARD', 'receive_drug_discount_card',"Yes") >
	</cfif>
<cfset listLISOutputs = arraytolist(arrayLISOutputs)>
<cfloop list="#listLISOutputs#" index="template">
<cfif isdefined('TYPE')>
<!-- Get content from db-->
<cfset answerfield = #structFind(structLISReceives, template)#>
<cfquery name="qryContent" datasource="#application.dbSrc#">
	SELECT      pt.Programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
    pt.benefit=<cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2"> 
	and pt.template=<cfqueryparam 
                        value="#template#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="30">  
	and active  = 1
	and answerfield =<cfqueryparam 
                        value="#answerfield#" 
                        cfsqltype="cf_sql_varchar"
                        maxlength="30">  
</cfquery>
<!-- OUTPUT RESULTS-->
<cfloop  query="qryContent" >
<cfif mode eq "Summary">		
			<cfoutput><cfif len(Summary) gt 3><li>#Summary#</li></cfif></cfoutput>
<cfelse>
	<cfif len(qryContent.actions) gt 0 >
		<cfset success = #arrayAppend(arrayActions, qryContent.Programtext_id)#></cfif>
		<cfset success  = #arrayAppend(arraylinks, "")#>
		<cfinclude template="../dspOtherOptions.cfm">
		<cfset rec = "#qryLIS.rec#">
		<!---<cfset programNameText = "#prg_nm#">
		<cfset rec1 = #replace(rec,'{prg_nm}',programNameText,"all")# >
		<cfset rec2 = #replace(rec1,'prg_nm',programNameText,"all")# > --->
		<p>
			<li>
			<!--- Recommendation ---->
			<cfset programNameText = "Program">
			<cfset rec1 = #replace(rec,'{prg_nm}',programNameText,"all")# >
			<cfoutput>#rec1#</cfoutput>
			</li>
	<cfif TYPE eq 'ELIGIBLE' and session.subset_id neq 14>
	<br>
		<cfinclude template="../dspLinks.cfm">
	</cfif>
</p>
</cfif>
</cfloop>
</cfif>	
</cfloop>
</CFIF>