<CFIF listcontains( #prg_list#, "129-307-2680-FD-FD") >
<cfset structIllness = structnew()>
<cfset result = structInsert(structIllness, "dn_HUMI1","Rheumatoid Arthritis")>
<cfset result = structInsert(structIllness, "dn_KINE1","Rheumatoid Arthritis")>
<cfset result = structInsert(structIllness, "dn_ENBR1","Rheumatoid Arthritis")>
<cfset result = structInsert(structIllness, "dn_COPA1","Multiple Sclerosis")>
<cfset result = structInsert(structIllness, "dn_REBI1","Multiple Sclerosis")>
<cfset result = structInsert(structIllness, "dn_AVON1","Multiple Sclerosis")>
<cfset result = structInsert(structIllness, "dn_BETA6","Multiple Sclerosis")>
<cfset result = structInsert(structIllness, "dn_MIAC1","Post Menopausal Osteoporosis (patient must be homebound)")>
<cfset result = structInsert(structIllness, "dn_ACTO1","Post Menopausal Osteoporosis (patient must be homebound)")>
<cfset result = structInsert(structIllness, "dn_TRAC1","Pulmonary Hypertension")>
<cfset result = structInsert(structIllness, "dn_HECT1","Secondary Hyperparathyroidism")>
<cfset result = structInsert(structIllness, "dn_FOSA1","Paget's Disease")>
<cfset result = structInsert(structIllness, "dn_ACTO1-2","Paget's Disease")>
<cfset result = structInsert(structIllness, "dn_PEGA2","Hepatitis C")>
<cfset result = structInsert(structIllness, "dn_PEG1","Hepatitis C")>
<cfset result = structInsert(structIllness, "dn_VALC1","CMV Retinitis")>
<cfset result = structInsert(structIllness, "dn_SOMA1","Acromegaly")>
<cfset result = structInsert(structIllness, "dn_TARG1","Anti-Cancer - Cutaneous T-cell Lymphoma")>
<cfset result = structInsert(structIllness, "dn_IRES1","Anti-Cancer - Non-small cell lung cancer")>
<cfset result = structInsert(structIllness, "dn_HEXA1","Anti-Cancer - Epithelial ovarian cancer")>
<cfset result = structInsert(structIllness, "dn_GLEE1","Anti-Cancer - Chronic Myelogenous Leukemia")>
<cfset result = structInsert(structIllness, "dn_GLEE1-2","Anti-Cancer - GI Stromal Tumor")>
<cfset result = structInsert(structIllness, "dn_THAL1","Anti-Cancer - Multiple Myeloma")>
<cfset result = structInsert(structIllness, "dn_ARIM1","Anti-Cancer - Breast Cancer (Stage 2-4 Only)")>
<cfset result = structInsert(structIllness, "dn_AROM1","Anti-Cancer - Breast Cancer (Stage 2-4 Only)")>
<cfset result = structInsert(structIllness, "dn_FEMA1","Anti-Cancer - Breast Cancer (Stage 2-4 Only)")>
<cfset result = structInsert(structIllness, "dn_NOLV1","Anti-Cancer - Breast Cancer (Stage 2-4 Only)")>
<cfset result = structInsert(structIllness, "dn_FARE1","Anti-Cancer - Breast Cancer (Stage 2-4 Only)")>
<cfset result = structInsert(structIllness, "dn_MESN1","a Prophylactic agent to reduce ifosfamide-induced hemorrhagic cystitis")>
	<cfif mode eq "Summary">
		<li>You may be eligible for the Medicare Replacement Drug Demonstration Program.</li>
	<cfelse>
		<cfset RxPrgList = #ListAppend(RxPrgList, "129-307-2680-FD-FD", ",")# >
		<li>
		<p>
		<cfif #StrClient# IS "self">You<cfelse>Your <cfoutput>#StrClient#</cfoutput></cfif> may be able to get additional help by applying to the Medicare Replacement Drug Demonstration, which offers significant savings on prescriptions for certain life-threatening diseases. For a fact sheet on this program, click <cfoutput><a href="frmDetails.cfm?prg_id=129-307-2680-FD-FD">here</a>. </cfoutput>   
		<cfloop collection="#structIllness#" item="drug">
			<cfif #listcontainsnocase(userMedications,drug,",")#>
				<cfoutput>This program may be helpful in paying for the prescription listed below. Click <a href="rx/dspfiles/dspChartMedDemo.cfm" target="_blank">here</a> for a list of medical conditions and prescriptions associated with this program. <!--- associated with #structfind(structIllness, drug)#:---> </cfoutput>
				<cfoutput><cf_tagGetDrugListBullets strClient="#strClient#" selectedDrugs="#drug#" strSummary="no"> </cfoutput>	
			</cfif>
		</cfloop>
		</p>
		</li>
	</cfif>
</CFIF>