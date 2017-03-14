<!--- Created by BShunn 2005/09/28 --->
<cfparam name="attributes.initvarname" type="string" default="">
<cfparam name="attributes.varname" type="string" default="">
<cfparam name="attributes.structname" type="string" default="form">
<cfparam name="attributes.aflist" type="string" default="">
<cfparam name="attributes.loadsession" type="boolean" default="false">
<cfparam name="attributes.prepopulateWithInput" type="boolean" default="false">
<cfparam name="attributes.useOptionCodes" type="boolean" default="false">
<cfparam name="attributes.batch" type="boolean" default="false">
<cfparam name="attributes.debug" type="boolean" default="false">
<cfset application.lsidebug = false>
<cfif attributes.varname neq ''>
	<cfset lsiList=Evaluate("caller.#attributes.varname#")>
	<cfif attributes.debug><cfoutput><br>lsiList1: #lsiList#</cfoutput></cfif>
<cfelseif attributes.aflist neq ''>
	<cfset lsiList=attributes.aflist>
	<cfif attributes.debug><cfoutput><br>lsiList2: #lsiList#</cfoutput></cfif>
<cfelseif IsDefined("caller.#attributes.structname#.aflist")>
	<cfset lsiList=Evaluate("caller.#attributes.structname#.aflist")>
	<cfif attributes.debug><cfoutput><br>lsiList3: #lsiList# #caller.form.aflist#</cfoutput></cfif>
<cfelse>
	<cfset lsiList=''>
	<cfif attributes.debug><cfoutput><br>lsiList4: #lsiList#</cfoutput></cfif>
</cfif>
<cfif IsDefined('session.partner_id')>
	<cfif #findnocase('s-zip',lsiList)# gt 0 and (session.partner_id eq 81 or session.partner_id eq 61 or session.partner_id eq 63)  and #findnocase('o-pl_agency_list',lsiList)# eq 0 >
	  <cfset lsiList = lsiList & ',o-pl_agency_list' >
	</cfif>
	<cfif #findnocase('s-zip',lsiList)# gt 0 and session.partner_id eq 76 and #findnocase('o-fit_counseling_session_type',lsiList)# eq 0>
	  <cfset lsiList = lsiList & ',o-fit_counseling_session_type' >
	</cfif>
</cfif>
<!----Vars to store buexp_sw Validation criteria ---->
<cfset vMarital = "">
<cfset vBank = "">
<cfset vInvest = "">
<cfset vCash = "">
<cfset vnon_buexp_sw = "">

<!---- End buexp_sw validation criteria vars ---->

<cfset lsiDeriveList = ''>
<cfset lsiDeriveIncome = False>
<cfset lsiDeriveAssets = False>
<cfset lsiDerivePoverty = False>
<cfset lsiIncAssApprox = 'null'>

<cfif lsiList Eq ''>
<!--- No input being processed --->
<cfelse>
<cfif attributes.prepopulateWithInput>
	<cfset session.screening.prepopulate = 1>
</cfif>
<cfset lsiDateTime = CreateODBCDateTime(Now())>
<cfif IsDefined("caller.#attributes.structname#.pgno")>
	<cfset lsiPgNo = Evaluate("caller.#attributes.structname#.pgno")>
<cfelseif IsDefined('session.screening.pgno')>
	<cfset lsiPgNo = session.screening.pgno>
<cfelse>
	<cfset session.screening.pgno = 1>
	<cfset lsiPgNo = 1>
</cfif>
<cfif IsDefined("caller.#attributes.structname#.qno")>
	<cfset session.screening.qno = Evaluate("caller.#attributes.structname#.qno")>
<cfelseif Not IsDefined('session.screening.qno')>
	<cfset session.screening.qno = 1>
</cfif>
<cfif IsDefined("caller.#attributes.structname#.qnum") and Evaluate("caller.#attributes.structname#.qnum") eq 1>
	<cfset session.screening.qnum = session.screening.qno>
	<cfset session.screening.qno = 0>
</cfif>
<cfif session.screening.pgno gt lsiPgNo>
	<cfquery name="checkAnswerfields" datasource="#application.dbSrc#">
		select a.answerfield
		from screening_answerfield sa, answerfield a
		where sa.screening_id=#session.screening_id#
			and sa.pagenum >= #lsiPgNo#
			and sa.answerfield_id=a.answerfield_id
	</cfquery>
	<cfif checkAnswerfields.RecordCount gt 0>
		<cfloop query="checkAnswerfields">
			<cf_handleScreeningAnswerfield action="clear" code="#answerfield#">
		</cfloop>
		<cfquery name="deleteAnswerfields" datasource="#application.dbSrc#">
			delete from screening_answerfield 
			where screening_id=#session.screening_id#
				and pagenum >= #lsiPgNo#
		</cfquery>
	</cfif>
</cfif>

<!--- Insert questionnaire responses into screening_answerfield --->
<cfif attributes.debug><cfoutput><br>lsiList: #lsiList#</cfoutput></cfif>
<cfset badList = ''>
<cfloop list="#lsiList#" index="itemID"> 
	<cftry>
	<cfset lsiEncryptionFlag = 'NULL'>
	<cfset lsiType = ListGetAt(itemID, 1, '-')>
	<cfset lsiVar = ListGetAt(itemID, 2, '-')>
	<cfif attributes.debug><cfoutput><br>Item: #itemID# lsiType: #lsiType# lsiVar: #lsiVar#<br></cfoutput></cfif>
	<cfif ListLen(itemID, '-') gt 2>
		<cfset lsiTrueVar = ListGetAt(itemID, 3, '-')>
	<cfelse>
		<cfset lsiTrueVar = lsiVar>
	</cfif>
	<cfif Len(lsiType) eq 2>
		<cfset lsiFlag = Right(lsiType, 1)>
		<cfset lsiType = Left(lsiType, 1)>
	<cfelse>
		<cfset lsiFlag = ''>
	</cfif>
    	<!--- get rid of afobj causing memory crashes --->
		<cfset ansObj = application.answerfieldPool.getAnswerfield(lsiTrueVar)>
       <cfset aftype = ansObj.type>
       <cfset aflength = ansObj.length>
       <cfset afvalid = ansObj.valid>
       <cfset afsort = ansObj.sort>
	<cfif attributes.loadsession>
		<cf_handleScreeningAnswerfield action="get" code="#lsiTrueVar#" element="val" var="lsiVal">
		<cfif (aftype eq 'select' or aftype eq 'yn' or aftype eq 'ynd' or aftype eq 'yns' or aftype eq 'ynns' or aftype eq 'checkbox' or aftype eq 'drug' or aftype eq 'generic' or aftype eq 'rxco') and lsiVal neq ''>
			<!---- <cf_cacheOptionPool action="getCodeByID" id="#lsiVal#" var="optCode"> ---->
            <cfset optCode = application.OptionPool.getOptionsById(lsiVal)>
			<cfif optCode eq ''>
				<cfset "session.#lsiVar#" = 0>
			<cfelse>
				<cfset "session.#lsiVar#" = optCode>
			</cfif>
		<cfelse>
			<cfset "session.#lsiVar#" = lsiVal>
		</cfif>
	<cfif attributes.debug><cfoutput><br>LIS VAL1:#lsiVal#<br></cfoutput></cfif>
	<cfelseif IsDefined("caller.#attributes.structname#.#lsiVar#") or lsiType eq 'c'>
		<cfif IsDefined("caller.#attributes.structname#.#lsiVar#")>
			<cfset lsiVal = Evaluate("caller.#attributes.structname#.#lsiVar#")>
		<cfelse>
			<cfset lsiVal = ''>
		</cfif>
		<cfif attributes.debug><cfoutput><br>LIS VAL2A: 'caller.#attributes.structname#.#lsiVar#' #lsiVal#<br></cfoutput></cfif>
		<cfif ansObj.type eq 'druglist'>
		<cfif attributes.debug>druglist is: <cfoutput>#lsiVal#</cfoutput></cfif>	
		</cfif>
		<cfif lsiType eq 'o' And ListLen(lsiVal, '-') gt 1>
			<cfset tmpCode = ListDeleteAt(lsiVal, 1, '-')>
			<cfif attributes.useOptionCodes>
				<cfset "session.#lsiVar#" = tmpCode>
				<cfset "caller.#attributes.structname#.#lsiVar#" = tmpCode>
			<cfelse>
				<cf_displayText group="option" code="option_#tmpCode#" language_id="EN" var="lsiOptionText">
				<cfset "session.#lsiVar#" = lsiOptionText>
				<cfset "caller.#attributes.structname#.#lsiVar#" = tmpCode>
			</cfif>
			<cfif attributes.debug><cfoutput><br>LIS VAL2B:#lsiVal#<br></cfoutput></cfif>
		<cfelse>
			<cfset "session.#lsiVar#" = lsiVal>
			<cfif attributes.debug><cfoutput><br>LIS VAL2C:#lsiVal#<br></cfoutput></cfif>
		</cfif>
		<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" val="#lsiVal#">
		<cfif attributes.debug><cfoutput><br>LIS VAL2:#lsiVal#<br></cfoutput></cfif>
	<cfelse>
		<cfset lsiVal = ''>
		<cfset "session.#lsiVar#" = 0>
		<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" val="">
		<cfif attributes.debug><cfoutput><br>LIS VAL3:#lsiVal#<br></cfoutput></cfif>
	</cfif>
	
	<cfif not isdefined('aftype')>
		<cfset aftype = ''>
    	</cfif>
	<cfif attributes.debug><cfoutput><br>LIS VAL4 :#lsiVal#<br></cfoutput></cfif>
	<!--- In the section below, we do validity checking on the input --->
	<cfset typeError = false>
	<cfif not attributes.loadsession>
		<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="" error="">
        <cf_handleScreeningAnswerfield action="get" code="#lsiTrueVar#" element="req" var="lsiReq">
		<cfif application.lsidebug eq true><cfoutput>#lsiTrueVar# / #lsiReq# / #lsiType#</cfoutput><br></cfif>	
		<cfif lsiVal eq '' and lsiType neq 'c'  and lsiReq neq 2>
			<cfif lsiReq eq 1 or lsiTrueVar eq 'lisapp_org_humanarc' or lsiTrueVar eq 'pl_agency_list'>
				<cfif lsiTrueVar eq 'fit_homeowner_2'>
					<cfif IsDefined("fit_health_homeowner2") and fit_health_homeowner2 neq ''>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_H2Age_health_check">
					</cfif>
				<cfelseif lsiTrueVar eq 'fit_homeowner_3'>
					<cfif IsDefined("fit_health_homeowner3") and fit_health_homeowner3 neq ''>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_H3Age_health_check">
					</cfif>
				<cfelseif lsiTrueVar eq 'fit_health_homeowner2' or lsiTrueVar eq 'fit_homeowner_2'>
					<cfif IsDefined("session.fit_homeowner_2") and session.fit_homeowner_2 neq '' and session.fit_health_homeowner1 eq ''>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
					</cfif>
				<cfelseif lsiTrueVar eq 'fit_health_homeowner3' or lsiTrueVar eq 'fit_homeowner_3'>
					<cfif IsDefined("session.fit_homeowner_3") and session.fit_homeowner_3 neq '' and session.fit_health_homeowner1 eq ''>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner3_age">
                            		</cfif>
				<cfelse>
					<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="response_required">
				</cfif>
			</cfif>

		<!---- LIS consent checkboxes are required  ---->
		<cfelseif lsiVal eq '' and (lsiTrueVar eq 'be_thrd_sub_sw' or lsiTrueVar eq 'be_clnt_sub_sw' or lsiTrueVar eq 'be_noncl_sub_sw')>

			<cfset badList = ListAppend(badList, lsiTrueVar)>
			<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="response_required">
			
		<cfelse>
		 <!--- 7037 --->    
     		 <cfif session.subset_id eq 63>
        	 <!--- MSP --->
        	<cfif lsiTrueVar eq 'receive_msp'>
            	<cfset receiveSelected1 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_msp")>
					<cfif Evaluate("caller.#attributes.structname#.receive_msp") EQ 'y'>
						<cfset receiveSelected1 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered1 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_msp_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_msp_amount") NEQ ''>
						<cfset vobEntered1 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected1 EQ "true" and vobEntered1 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_msp_amount'>
            	<cfset receiveSelected2 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_msp")>
					<cfif Evaluate("caller.#attributes.structname#.receive_msp") EQ 'y'>
						<cfset receiveSelected2 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered2 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_msp_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_msp_amount") NEQ ''>
						<cfset vobEntered2 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected2 EQ "false" and vobEntered2 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected2 EQ "true" and vobEntered2 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_msp_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_msp_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
           	<!--- LIS --->
            <cfelseif lsiTrueVar eq 'receive_lis'>
            	<cfset receiveSelected3 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_lis")>
					<cfif Evaluate("caller.#attributes.structname#.receive_lis") EQ 'y'>
						<cfset receiveSelected3 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered3 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_lis_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_lis_amount") NEQ ''>
						<cfset vobEntered3 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected3 EQ "true" and vobEntered3 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_lis_amount'>
            	<cfset receiveSelected4 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_lis")>
					<cfif Evaluate("caller.#attributes.structname#.receive_lis") EQ 'y'>
						<cfset receiveSelected4 = "true">
					</cfif>


                </cfif>
				<cfset vobEntered4 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_lis_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_lis_amount") NEQ ''>
						<cfset vobEntered4 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected4 EQ "false" and vobEntered4 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected4 EQ "true" and vobEntered4 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_lis_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_lis_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- SNAP --->
            <cfelseif lsiTrueVar eq 'fdstmp_receive'>
            	<cfset receiveSelected5 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.fdstmp_receive")>
					<cfif Evaluate("caller.#attributes.structname#.fdstmp_receive") EQ 'y'>
						<cfset receiveSelected5 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered5 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_snap_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_snap_amount") NEQ ''>
						<cfset vobEntered5 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected5 EQ "true" and vobEntered5 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_snap_amount'>
            	<cfset receiveSelected6 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.fdstmp_receive")>
					<cfif Evaluate("caller.#attributes.structname#.fdstmp_receive") EQ 'y'>
						<cfset receiveSelected6 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered6 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_snap_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_snap_amount") NEQ ''>
						<cfset vobEntered6 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected6 EQ "false" and vobEntered6 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected6 EQ "true" and vobEntered6 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_snap_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_snap_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- LIHEAP --->
            <cfelseif lsiTrueVar eq 'liheap_receive'>
            	<cfset receiveSelected7 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.liheap_receive")>
					<cfif Evaluate("caller.#attributes.structname#.liheap_receive") EQ 'y'>
						<cfset receiveSelected7 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered7 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_liheap_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_liheap_amount") NEQ ''>
						<cfset vobEntered7 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected7 EQ "true" and vobEntered7 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_liheap_amount'>
            	<cfset receiveSelected8 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.liheap_receive")>
					<cfif Evaluate("caller.#attributes.structname#.liheap_receive") EQ 'y'>
						<cfset receiveSelected8 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered8 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_liheap_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_liheap_amount") NEQ ''>
						<cfset vobEntered8 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected8 EQ "false" and vobEntered8 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected8 EQ "true" and vobEntered8 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_liheap_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_liheap_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
           	<!--- Medicaid --->
            <cfelseif lsiTrueVar eq 'med_receive'>
            	<cfset receiveSelected9 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.med_receive")>
					<cfif Evaluate("caller.#attributes.structname#.med_receive") EQ 'y'>
						<cfset receiveSelected9 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered9 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_medicaid_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_medicaid_amount") NEQ ''>
						<cfset vobEntered9 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected9 EQ "true" and vobEntered9 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_medicaid_amount'>
            	<cfset receiveSelected10 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.med_receive")>
					<cfif Evaluate("caller.#attributes.structname#.med_receive") EQ 'y'>
						<cfset receiveSelected10 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered10 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_medicaid_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_medicaid_amount") NEQ ''>
						<cfset vobEntered10 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected10 EQ "false" and vobEntered10 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected10 EQ "true" and vobEntered10 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_medicaid_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_medicaid_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- Property Tax Relief --->
            <cfelseif lsiTrueVar eq 'receive_propertytax'>
            	<cfset receiveSelected11 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_propertytax")>
					<cfif Evaluate("caller.#attributes.structname#.receive_propertytax") EQ 'y'>
						<cfset receiveSelected11 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered11 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_property_tax_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_property_tax_amount") NEQ ''>
						<cfset vobEntered11 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected11 EQ "true" and vobEntered11 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_property_tax_amount'>
            	<cfset receiveSelected12 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_propertytax")>
					<cfif Evaluate("caller.#attributes.structname#.receive_propertytax") EQ 'y'>
						<cfset receiveSelected12 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered12 = "false">
            	<cfif IsDefined("caller.#attributes.structname#.receive_property_tax_amount")>
					<cfif Evaluate("caller.#attributes.structname#.receive_property_tax_amount") NEQ ''>
						<cfset vobEntered12 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected12 EQ "false" and vobEntered12 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected12 EQ "true" and vobEntered12 EQ "true">
                	<cfif Evaluate("caller.#attributes.structname#.receive_property_tax_amount") LT 0 OR Evaluate("caller.#attributes.structname#.receive_property_tax_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            </cfif>
	   </cfif>
			<cfif lsiVar eq "ct_mrtl_stus">
				<cfset vMarital = "#lsiVal#">
			</cfif>
			<cfif lsiVar eq "be_res_bank_acc_xnd">
				<cfset vBank = "#lsiVal#">
			</cfif>
			<cfif lsiVar eq "be_res_invst_xnd">
				<cfset vInvest = "#lsiVal#">
			</cfif>
			<cfif lsiVar eq "be_res_csh_xnd">
				<cfset vCash = "#lsiVal#">
			</cfif>
			<cfif lsiVar eq "be_noncl_buexp_sw">
				<cfset vnon_buexp_sw = "#lsiVal#">
			</cfif>
			
			<cfswitch expression="#aftype#">
				<cfcase value="currency">
					<!---- 2/3/10 MH: Added '(^[$]?)' to RegEx below to not throw an error if a '$' exists at the beginning of the value ---->
					<cfif REFind("[-]", lsiVal) or Not REFind("^[$]?((([0-9]{1,3})(\,[0-9]{3})*(\.[0-9]{2})?)|([0-9]*(\.[0-9]{2})?))$", lsiVal)>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_currency_format">
						<cfset typeError = true>
					<!----<cfelseif aflength neq '' and lsiVal gt aflength>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="numeric_field_exceeds_limit|#lsiTrueVar#">
						<cfset typeError = true>---->
					<cfelse>
						<cfset lsiVal = Replace(lsiVal, ',', '', 'ALL')>
						<!---- 2/3/10 MH: Added code to strip '$' from currency ---->
						<cfset lsiVal = Replace(lsiVal, '$', '', 'ALL')>				
					</cfif>
				</cfcase>
				<cfcase value="float">
					<cfif Not IsNumeric(lsiVal)>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_numeric_format">
						<cfset typeError = true>
					<!----<cfelseif aflength neq '' and lsiVal gt aflength>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="numeric_field_exceeds_limit|#lsiTrueVar#">
						<cfset typeError = true>---->
					</cfif>
				</cfcase>
				<cfcase value="integer">
					<cfif Not IsNumeric(lsiVal) or REFind("[-.]", lsiVal)>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<!---- 2/5/10 MH: Hardcoded exception to use error 'fit_bad_int_format' for the FIT app only ---->
						<cfif isDefined("session.subset_id")>
							<cfif session.subset_id eq 61>
								<!---- MH: 2/8/10 Hardcoded exception to use a different error msg for Homeowner1,2,3 and how_long_in_home---->
								<cfif lsiTrueVar eq "fit_homeowner_1" OR lsiTrueVar eq "fit_homeowner_2" OR lsiTrueVar eq "fit_homeowner_3" OR lsiTrueVar eq "how_long_in_home">
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="fit_bad_age_format">
								<cfelse>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="fit_bad_int_format">
								</cfif>
							<cfelse>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_int_format">
							</cfif>
						<cfelse>
							<!---- I am in logScreeningInput.cfm line 214 ---->
							<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_int_format">
						</cfif>
						<cfset typeError = true>
					<!----<cfelseif aflength neq '' and lsiVal gt aflength>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="numeric_field_exceeds_limit|#lsiTrueVar#">
						<cfset typeError = true>---->
					</cfif>
				</cfcase>
				<cfcase value="ssn">
					<cfif (Len(lsiVal) neq 9 or REFind("[0-9]{9}", lsiVal) neq 1) And (Len(lsiVal) neq 11 Or REFind("[0-9]{3}-[0-9]{2}-[0-9]{4}", lsiVal) neq 1)>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_ssn_format">
						<cfset typeError = true>
					</cfif>
					<cfset lsiEncryptionFlag = 1>
				</cfcase>
				<cfcase value="zipcode">
					<cfif Len(lsiVal) neq 5 or REFind("[0-9]{5}", lsiVal) neq 1>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_zip_format">
						<cfset typeError = true>
					<cfelse>
                    	<cfif isdefined(session.subset_id)>
							<cf_validateZip zipcode="#lsiVal#" subset_id="#session.subset_id#">
                        <cfelse>
                        	<cf_validateZip zipcode="#lsiVal#" >
                        </cfif>
						<cfif not validationResult>
							<cfset badList = ListAppend(badList, lsiTrueVar)>
							<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="error" error="bad_zip_invalid">
							<cfset typeError = true>
						</cfif>
					</cfif>
				</cfcase>
			</cfswitch>
			<cfif not typeError and afvalid neq ''>
                <cfset vobj = application.ValidationPool.getValidation(afvalid)>
                <!---- <cfset validationformula = Evaluate("application.bcuValidationPool.v.#afvalid#.formula")> ---->
                <cfset validationFormula = vobj.formula>
				<cfset value = lsiVal>
				<cfif ListGetAt(validationformula, 1, ':') eq 'fn'>
					<cfswitch expression="#ListGetAt(validationformula, 2, ':')#">
						<cfcase value="datefuture">
							<cfset specifyDay = ListGetAt(validationformula, 3, ':')>
							<cfset specifyYear = ListGetAt(validationformula, 4, ':')>
							<cfset validDate = false>
							<cfif IsDefined("caller.#attributes.structname#.#specifyDay#") and IsDefined("caller.#attributes.structname#.#specifyYear#")>
								<cfset lsiDay = Evaluate("caller.#attributes.structname#.#specifyDay#")>
								<cfset lsiYear = Evaluate("caller.#attributes.structname#.#specifyYear#")>
								<cfif lsiVal neq '' and lsiYear neq ''>
									<cfif (lsiYear / 4) eq int(lsiYear / 4) and ((lsiYear / 100) neq int(lsiYear / 100) or (lsiYear / 400) eq int(lsiYear / 400))>
										<cfset mdList = '31,29,31,30,31,30,31,31,30,31,30,31'>
									<cfelse>
										<cfset mdList = '31,28,31,30,31,30,31,31,30,31,30,31'>
									</cfif>
									<cfif lsiDay lte ListGetAt(mdList, lsiVal)>
										<cfif lsiYear gt Year(Now()) or (lsiYear eq Year(Now()) and lsiVal gt Month(Now())) or (lsiYear eq Year(Now()) and lsiVal eq Month(Now()) and lsiDay gt Day(Now()))>
											<cfset badList = ListAppend(badList, lsiTrueVar)>
											<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
											<cfset typeError = true>
										</cfif>
									</cfif>
								</cfif>
							</cfif>
						</cfcase>
						<cfcase value="datevalid">
							<cfset specifyMonth = ListGetAt(validationformula, 3, ':')>
							<cfset specifyYear = ListGetAt(validationformula, 4, ':')>
							<cfset validDate = false>
							<cfif IsDefined("caller.#attributes.structname#.#specifyMonth#") and IsDefined("caller.#attributes.structname#.#specifyYear#")>
								<cfset lsiMonth = Evaluate("caller.#attributes.structname#.#specifyMonth#")>
								<cfset lsiYear = Evaluate("caller.#attributes.structname#.#specifyYear#")>
								<cfif lsiMonth neq '' and lsiYear neq ''>
									<cfif (lsiYear / 4) eq int(lsiYear / 4) and ((lsiYear / 100) neq int(lsiYear / 100) or (lsiYear / 400) eq int(lsiYear / 400))>
										<cfset mdList = '31,29,31,30,31,30,31,31,30,31,30,31'>
									<cfelse>
										<cfset mdList = '31,28,31,30,31,30,31,31,30,31,30,31'>
									</cfif>
									<cfif lsiVal gt ListGetAt(mdList, lsiMonth)>
										<cfset badList = ListAppend(badList, lsiTrueVar)>
										<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
										<cfset typeError = true>
									</cfif>
								</cfif>
							</cfif>
							<!---<cfoutput><h1>Month: #lsiMonth#; Day: #lsiVal#; Year: #lsiYear#</h1><h2>Months: #mdList#</h2><h3>Month limit: #ListGetAt(mdList, lsiMonth)#</h3></cfoutput>--->
						</cfcase>
						<cfcase value="specify">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 4, ':')>
							<cfif lsiVal eq specifyValue and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="esi_home_drilldown">
							<cfif IsDefined("caller.#attributes.structname#.esi_housingtype") >
								<cfset lsiHousingType = Evaluate("caller.#attributes.structname#.esi_housingtype")>
								<cfif lsiHousingType eq 'esi_housingtype_rent'>
									<cfif isDefined("caller.#attributes.structname#.esi_rent")>
										<cfset lsiRent = Evaluate("caller.#attributes.structname#.esi_rent")>
										<cfif lsiRent eq "">
											<cfset badList = ListAppend(badList, lsiTrueVar)>
											<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
										</cfif>
									<cfelse>
										<cfset badList = ListAppend(badList, lsiTrueVar)>
										<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
									</cfif>
								<cfelseif lsiHousingType eq 'esi_housingtype_own'>
									<!---cfset lsiEstimatedvalue = Evaluate("caller.#attributes.structname#.esi_estimatedvalue")--->
									<cfset lsiTotaldebthouse = Evaluate("caller.#attributes.structname#.esi_totaldebthouse")>
									<cfset lsiHousingsituation = "">
									<cfif IsDefined("caller.#attributes.structname#.esi_housingsituation") >
										<cfset lsiHousingsituation = Evaluate("caller.#attributes.structname#.esi_housingsituation")>
									</cfif>
									<cfset lsiHomeinsurance = "">
									<cfif IsDefined("caller.#attributes.structname#.esi_homeinsurance") >
										<cfset lsiHomeinsurance = Evaluate("caller.#attributes.structname#.esi_homeinsurance")>
									</cfif>
									<!---cfif lsiEstimatedvalue eq "" or lsiHousingsituation eq "" or lsiHomeinsurance eq "" or lsiTotaldebthouse eq ""--->
									<cfif lsiHousingsituation eq "" or lsiHomeinsurance eq "" or lsiTotaldebthouse eq "">
										<cfset badList = ListAppend(badList, lsiTrueVar)>
										<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
									</cfif>
								<cfelseif lsiHousingType eq ''>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
								</cfif>
							    <cfelse>
							     <cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
							</cfif>
						</cfcase>
                       					 <cfcase value="specifyhealth">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfif lsiVal neq "" AND lsiVal NEQ "n" and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
			</cfcase>
                        <cfcase value="specifyHO2first">
			    <cfset specifyAF1 = ListGetAt(validationformula, 3, ':')><!---- H2 Age ---->
                            <cfset specifyAF2 = ListGetAt(validationformula, 4, ':')><!---- H3 Age ---->
			    <cfif lsiVal gte 1 and value lte 999>
                            	<cfif (NOT isDefined("caller.#attributes.structname#.#specifyAF1#") OR Evaluate("caller.#attributes.structname#.#specifyAF1#") eq '') AND (isDefined("caller.#attributes.structname#.#specifyAF2#") AND Evaluate("caller.#attributes.structname#.#specifyAF2#") neq '')>
                                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_function_homeowner3_no2">
                                </cfif>
                            <cfelse>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
				<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_age_1_999">
                            </cfif>
                        </cfcase>
			<!---- MH: Please do not remove this function. It is being used to require answerfields that don't require validation ---->
			<cfcase value="donothing">

			</cfcase>
                        <cfcase value="specifyage">
                            <cfset specifyAF1 = ListGetAt(validationformula, 3, ':')>
                            <cfset specifyAF2 = ListGetAt(validationformula, 4, ':')>
                            
			    <cfif IsDefined("caller.#attributes.structname#.fit_homeowner_2") AND Evaluate("caller.#attributes.structname#.fit_homeowner_2") Neq '' AND IsDefined("caller.#attributes.structname#.fit_homeowner_3") AND Evaluate("caller.#attributes.structname#.fit_homeowner_3") Neq ''>
                            	<cfif (not IsDefined("caller.#attributes.structname#.#specifyAF1#") OR Evaluate("caller.#attributes.structname#.#specifyAF1#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq 'n') AND (not IsDefined("caller.#attributes.structname#.#specifyAF2#") OR Evaluate("caller.#attributes.structname#.#specifyAF2#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq 'n')>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner_age">
                                	
								<cfelseif not IsDefined("caller.#attributes.structname#.#specifyAF1#") OR Evaluate("caller.#attributes.structname#.#specifyAF1#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq 'n'>
                                	<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
                                	
								<cfelseif not IsDefined("caller.#attributes.structname#.#specifyAF2#") OR Evaluate("caller.#attributes.structname#.#specifyAF2#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq 'n'>
                            		<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner3_age">
                                    
                                </cfif>
                            <cfelseif IsDefined("caller.#attributes.structname#.fit_homeowner_2") AND Evaluate("caller.#attributes.structname#.fit_homeowner_2") Neq '' AND (NOT IsDefined("caller.#attributes.structname#.fit_homeowner_3") OR Evaluate("caller.#attributes.structname#.fit_homeowner_3") eq '')>
				<!---- if H2 health is not defined or blank or eq n ---->
                            	<cfif not IsDefined("caller.#attributes.structname#.#specifyAF1#") or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq 'n'>
					<cfset badList = ListAppend(badList, lsiTrueVar)>
					<!---- throw fit_homeowner2_age validation ---->
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
                            	</cfif>
			    <cfelseif IsDefined("caller.#attributes.structname#.fit_homeowner_3") AND Evaluate("caller.#attributes.structname#.fit_homeowner_3") Neq '' AND (NOT IsDefined("caller.#attributes.structname#.fit_homeowner_2") OR Evaluate("caller.#attributes.structname#.fit_homeowner_2") eq '')>
								<cfif not IsDefined("caller.#attributes.structname#.#specifyAF2#") or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq 'n'>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner3_age">
                                				<cfelseif not IsDefined("caller.#attributes.structname#.#specifyAF1#") or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq '' or Evaluate("caller.#attributes.structname#.#specifyAF1#") eq 'n'>
                                					<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_function_homeowner3_no2">
                            		
                                </cfif>
                            </cfif>
                        </cfcase>
                        <cfcase value="fit_specifymulti">
                            <cfset specifyValue = ListGetAt(validationformula, 3, ':')>
                            
                            <cfif lsiVal EQ specifyValue AND (NOT IsDefined("caller.#attributes.structname#.fit_mortgage_use_annuity") OR Evaluate("caller.#attributes.structname#.fit_mortgage_use_annuity") eq '') AND (NOT IsDefined("caller.#attributes.structname#.fit_mortgage_use_ltcare_ins") OR Evaluate("caller.#attributes.structname#.fit_mortgage_use_ltcare_ins") eq '') AND (NOT IsDefined("caller.#attributes.structname#.fit_mortgage_use_invest") OR Evaluate("caller.#attributes.structname#.fit_mortgage_use_invest") eq '') AND (NOT IsDefined("caller.#attributes.structname#.fit_mortgage_use_other") OR Evaluate("caller.#attributes.structname#.fit_mortgage_use_other") eq '')>
                                
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
                        </cfcase>
                        <cfcase value="fit_married_partner_check">
                            <!----<cfset specifyValue = ListGetAt(validationformula, 3, ':')>---->
                            <cfif lsiVal CONTAINS "fit_married_partner" AND ((NOT isDefined("caller.#attributes.structname#.fit_married_partner") OR Evaluate("caller.#attributes.structname#.fit_married_partner") eq '') OR (NOT isDefined("caller.#attributes.structname#.fit_married_partner_ins") OR Evaluate("caller.#attributes.structname#.fit_married_partner_ins") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "widowed" AND ((NOT IsDefined("caller.#attributes.structname#.fit_past12_widowed") OR Evaluate("caller.#attributes.structname#.fit_past12_widowed") eq '') OR (NOT IsDefined("caller.#attributes.structname#.live_alone_widowed") OR Evaluate("caller.#attributes.structname#.live_alone_widowed") eq '') OR (NOT IsDefined("caller.#attributes.structname#.fit_homeowner_gender_widowed") OR Evaluate("caller.#attributes.structname#.fit_homeowner_gender_widowed") eq ''))>
                                <!----<cfabort>---->
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "fit_div_sep" AND ((NOT IsDefined("caller.#attributes.structname#.fit_past12_fit_div_sep") OR Evaluate("caller.#attributes.structname#.fit_past12_fit_div_sep") eq '') OR (NOT IsDefined("caller.#attributes.structname#.live_alone_fit_div_sep") OR Evaluate("caller.#attributes.structname#.live_alone_fit_div_sep") eq '') OR (NOT IsDefined("caller.#attributes.structname#.fit_homeowner_gender_fit_div_sep") OR Evaluate("caller.#attributes.structname#.fit_homeowner_gender_fit_div_sep") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "single" AND ((NOT IsDefined("caller.#attributes.structname#.fit_homeowner_gender_single") OR Evaluate("caller.#attributes.structname#.fit_homeowner_gender_single") eq '') OR (NOT IsDefined("caller.#attributes.structname#.live_alone_single") OR Evaluate("caller.#attributes.structname#.live_alone_single") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
                        </cfcase>
						<cfcase value="specifyor">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 4, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 5, ':')>
							<cfif (lsiVal eq specifyValue or (IsDefined("caller.#attributes.structname#.#specifyAF2#") and Evaluate("caller.#attributes.structname#.#specifyAF2#") eq specifyValue)) and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
                                
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyother">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset lastOpt = StructFind(afsort, ListGetAt(ListSort(StructKeyList(afsort), 'numeric', 'desc'), 1))>
                            <cfset myOPT = application.OptionPool.getOption(lastOpt)>
                            <cfset lastoptobjID = myOPT.id>
							<cfif lsiVal eq "#lastoptobjID#-#lastOpt#" and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyx2">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 4, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 5, ':')>
							<cfif lsiVal eq specifyValue and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '' or not IsDefined("caller.#attributes.structname#.#specifyAF2#") or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyx2x2">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 4, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 5, ':')>
							<cfset specifyValue2 = ListGetAt(validationformula, 6, ':')>
							<cfif (lsiVal eq specifyValue and (not IsDefined("caller.#attributes.structname#.#specifyAF#") or Evaluate("caller.#attributes.structname#.#specifyAF#") eq '')) or (lsiVal eq specifyValue2 and (not IsDefined("caller.#attributes.structname#.#specifyAF2#") or Evaluate("caller.#attributes.structname#.#specifyAF2#") eq ''))>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="zipmatch">
							<cfset zipmatchState = ListGetAt(validationformula, 3, ':')>
							<cf_handleScreeningAnswerfield action="get" code="#zipmatchState#" element="val" var="zipmatchState">
							<cfif zipmatchState neq ''>
                            					<cfif isdefined(session.subset_id)>
									<cf_validateZip zipcode="#lsiVal#" subset_id="#session.subset_id#" state_id="#zipmatchState#">
                        					<cfelse>
                        						<cf_validateZip zipcode="#lsiVal#" state_id="#zipmatchState#" >
                        					</cfif>
								<cfif not validationResult>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
									<cfset typeError = true>
								</cfif>
							</cfif>
						</cfcase>
						<cfcase value="fit_agencyvalidation">
							
							<cf_handleScreeningAnswerfield action="get" code="fit_agency_id" element="val" var="fit_agency_id">
							<cfset firstchar = Left(fit_agency_id, 1)>
							<cfset isValid = evaluate("REFind('^[0-9]{5}$',fit_agency_id)")>
							<cfif (firstchar neq 8 and firstchar neq 9)  or not (isvalid) >
                            					<cfset badList = ListAppend(badList,lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
								<cfset typeError = true>
								
							</cfif>	
							
						</cfcase>
					</cfswitch>
				<cfelse>
					<cfset result = Evaluate(validationformula)>
					<!---- 01/12/10 MH: Override be_noncl_buexp_sw Validation rule if the app originates from a batch ---->
					<cfif attributes.batch and not result and lsiVar eq "be_noncl_buexp_sw">
						<cfif vnon_buexp_sw eq "n" and vMarital eq "2347-married_living_together" and vBank eq "n" and vInvest eq "n" and vCash eq "n">
							<cfset badList = ListAppend(badList, 'be_noncl_buexp_sw')>
							<cf_handleScreeningAnswerfield action="set" code="be_noncl_buexp_sw" group="valid" error="#afvalid#">
						</cfif>
					<cfelse>
						<cfif not result>
							<cfset badList = ListAppend(badList, lsiTrueVar)>
							<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
        
	<cfelse>
		<cfset badList=''>
	</cfif>
	<!--- Now we save the answer, assuming it was validated successfully --->
	<cfif typeError>
		<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" val="#lsiVal#" type="#lsiType#">
	<cfelse>
		<cfif lsiType eq 'd'>
			<!--- Loop through all drugs, destroying refs for those not found in drug list --->
            <cf_loopRxStruct grouplist="rx,generic" object="rxobj">
            	<cfif NOT listFind(lsiVar, rxobj.code)>
                	<cfset StructDelete(session.screening.a, rxobj.code)>
					<cfset StructDelete(session, rxobj.code)>
                </cfif>
            </cf_loopRxStruct>
			<!---- <cf_loopPoolStruct struct="afpool" index="x">
            	<cfset ansObj = application.answerfieldPool.getAnswerfield(x)>
                <cfset rx = ansObj.rx>
                <cfif lsiVal NEQ "null">
                	<cfoutput>#lsiVal#<br /><br /></cfoutput>
                </cfif>
				<cfif rx and not ListFind(lsiVar, x)>
					<cfset StructDelete(session.screening.a, x)>
					<cfset StructDelete(session, x)>
                <cfelse>
				</cfif>
                
			</cf_loopPoolStruct> ---->
			<cfset session.selectedDrugs = lsiVal>
			<cfif attributes.debug>Step 2: session.selectedDrugs:#session.selectedDrugs#</cfif>
			<cfif lsiVal neq '' and lsiVal neq 'null'>
				<cfloop index="drugID" list="#lsiVal#">
					<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="c" response_var="#drugID#" response="Y" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
					<cfset "session.#drugID#" = 'Y'>
					<cfif attributes.debug><cfoutput>#drugID#</cfoutput> is Yes</cfif>
					<cfset drgObj = application.answerfieldPool.getAnswerfield(drugID)>
					<cfif drgObj.type eq 'generic'>
					<!--- if generic drug set the brand equivalent as a session var in the rule evaluation  --->
				
				 	<CFQUERY NAME="qryGenericDrg" DATASOURCE="#application.dbSrc#">
				select aa.answerfield
				from answerfield_relationship ar, answerfield aa
				where ar.right_answerfield_id=#drgObj.id#
				and ar.relationship_id=1
				and ar.left_answerfield_id=aa.answerfield_id
				 	</CFQUERY>
				 	<cfloop query="qryGenericDrg">
						<cfset "session.#answerfield#" = 'Y'>
					<cfif attributes.debug><cfoutput>brand rx: session.#answerfield#</cfoutput></cfif>
				 	</cfloop>
				
				</cfif>
				</cfloop>
			</cfif>
		<cfelseif lsiType eq 'i'>
			<cfset lsiDeriveIncome = True>
		<cfelseif lsiType eq 'a'>
			<cfset lsiDeriveAssets = True>
		<cfelse>
			<cfif lsiFlag eq 'a'>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="#lsiType#" response_var="#lsiTrueVar#" response="#lsiVal#" approximation_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset lsiIncAssApprox = 1>
			<cfelse>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="#lsiType#" response_var="#lsiTrueVar#" response="#lsiVal#" timestamp="#lsiDateTime#" encryption_flag="#lsiEncryptionFlag#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			</cfif>
		</cfif>
	</cfif>
	<cfcatch></cfcatch></cftry>
</cfloop>

<cfset "caller.badResponseList" = badList>

<!--- Don't do any deriving if we're loading a shadow screening --->
<cfif not attributes.loadsession>

<!--- Derive DOB answerfield from DOB_MONTH and DOB_YEAR --->
<cfif ListFind(lsiDeriveList, 'dob_month') or ListFind(lsiDeriveList, 'dob_year')>
	<cf_handleScreeningAnswerfield action="get" code="dob_month" element="val" var="lsiMonth">
	<cf_handleScreeningAnswerfield action="get" code="dob_year" element="val" var="lsiYear">
	<cfif lsiMonth eq ''>
		<cfset lsiMonth = 1>
	</cfif>
	<cfif lsiYear neq ''>
		<cfset lsiMakeDOB = DateFormat(lsiMonth & "/01/" & lsiYear, 'mm/dd/yyyy')>
		<cfset lsiAnswer = Abs(DateDiff("yyyy", DateFormat(NOW(), "mm/dd/yyyy"), lsiMakeDOB))>
		<cfset session.dob = lsiAnswer>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob" response="#lsiAnswer#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset session.dob = 0>
	</cfif>
</cfif>
<!--- Derive SP_DOB answerfield from SP_DOB_MONTH and SP_DOB_YEAR --->
<cfif ListFind(lsiDeriveList, 'sp_dob_month') or ListFind(lsiDeriveList, 'sp_dob_year')>
	<cf_handleScreeningAnswerfield action="get" code="sp_dob_month" element="val" var="lsiMonth">
	<cf_handleScreeningAnswerfield action="get" code="sp_dob_year" element="val" var="lsiYear">
	<cfif lsiMonth eq ''>
		<cfset lsiMonth = 1>
	</cfif>
	<cfif lsiYear neq ''>
		<cfset lsiMakeDOB = DateFormat(lsiMonth & "/01/" & lsiYear, 'mm/dd/yyyy')>
		<cfset lsiAnswer = Abs(DateDiff("yyyy", DateFormat(NOW(), "mm/dd/yyyy"), lsiMakeDOB))>
		<cfset session.sp_dob = lsiAnswer>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiAnswer#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset session.sp_dob = 0>
	</cfif>
</cfif>
<!--- Derive marital_status answerfield from ct_mrtl_stus --->
<cfif ListFind(lsiDeriveList, 'ct_mrtl_stus')>
	<cf_handleScreeningAnswerfield action="get" code="ct_mrtl_stus" element="val" var="afVal">
	<cfset lsiTemp = 1>
	<cfswitch expression="#afVal#">
		<cfcase value="5">
			<cfset lsiAnswer = '5-divorced'>
			<cfset session.marital_stat = 'divorced'>
		</cfcase>
		<cfcase value="6">
			<cfset lsiAnswer = '6-single'>
			<cfset session.marital_stat = 'single'>
		</cfcase>
		<cfcase value="7">
			<cfset lsiAnswer = '7-widowed'>
			<cfset session.marital_stat = 'widowed'>
		</cfcase>
		<cfcase value="2346">
			<cfset lsiAnswer = '5-divorced'>
			<cfset session.marital_stat = 'divorced'>
		</cfcase>
		<cfcase value="2347">
			<cfset lsiAnswer = '4-married'>
			<cfset session.marital_stat = 'married'>
			<cfset lsiTemp = 2>
		</cfcase>
		<cfcase value="2348">
			<cfset lsiAnswer = '1361-married_living_sep'>
			<cfset session.marital_stat = 'married_living_sep'>
		</cfcase>
		<cfdefaultcase>
			<cfset lsiAnswer = ''>
			<cfset session.marital_stat = ''>
		</cfdefaultcase>
	</cfswitch>
	<cfif lsiAnswer neq ''>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="marital_stat" response="#lsiAnswer#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfset session.no_hh_members = lsiTemp>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="no_hh_members" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive state answerfield from ct_clnt_mail_addr_st_grt --->
<cfif ListFind(lsiDeriveList, 'ct_clnt_mail_addr_st_grt')>
	<cf_handleScreeningAnswerfield action="get" code="ct_clnt_mail_addr_st_grt" element="val" var="valSt">
	<cfif valSt neq ''>
		<cfset session.st = valSt>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="st" response="#session.st#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!--- Derive zip answerfield from be_clnt_mail_addr_zip5 --->
<cfset useDerivedZip = false>
<cfif ListFind(lsiDeriveList, 'be_clnt_mail_addr_zip5')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_mail_addr_zip5" element="val" var="valZip">
	<cfif valZip neq ''>
		<cfset session.zip = valZip>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="zip" response="#session.zip#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset useDerivedZip = true>
	</cfif>
</cfif>
<!--- Derive dob, sp_dob and over_60 answerfields from be_clnt_under_age_xnd and be_noncl_under_age_xnd --->
<cfif ListFind(lsiDeriveList, 'be_clnt_under_age_xnd') or ListFind(lsiDeriveList, 'be_noncl_under_age_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_under_age_xnd" element="val" var="valCUA">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_under_age_xnd" element="val" var="valNUA">
	<cfif valCUA neq ''>
		<cfif valCUA eq 0>
			<cfset lsiTemp = 65>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.dob = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif valNUA neq ''>
		<cfif valNUA eq 0>
			<cfset lsiTemp = 65>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.sp_dob = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif valCUA neq '' and valNUA neq ''>
		<cfif valCUA eq 0 and valNUA eq 0>
			<cfset lsiTemp = 2>
		<cfelseif valCUA eq 0 or valNUA eq 0>
			<cfset lsiTemp = 1>
		<cfelse>
			<cfset lsiTemp = 0>
		</cfif>
		<cfset session.over_60 = lsiTemp>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="over_60" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!--- Derive dob, sp_dob, over_60, etc. from be_clnt_dob_* and be_noncl_dob_* --->
<cfif (ListFind(lsiDeriveList, 'be_clnt_dob_day') and ListFind(lsiDeriveList, 'be_clnt_dob_month') and ListFind(lsiDeriveList, 'be_clnt_dob_year')) or (ListFind(lsiDeriveList, 'be_noncl_dob_day') and ListFind(lsiDeriveList, 'be_noncl_dob_month') and ListFind(lsiDeriveList, 'be_noncl_dob_year'))>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_day" element="val" var="lsiTempDay">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_month" element="val" var="lsiTempMonth">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_dob_year" element="val" var="lsiTempYear">
	<cfif ListFind(lsiDeriveList, 'be_clnt_dob_day') and IsNumeric(lsiTempDay) and ListFind(lsiDeriveList, 'be_clnt_dob_month') and IsNumeric(lsiTempMonth) and ListFind(lsiDeriveList, 'be_clnt_dob_year') and IsNumeric(lsiTempYear)>
		<cfset lsiTempDate = CreateDate(lsiTempYear, lsiTempMonth, lsiTempDay)>
		<cfset lsiTempAge = DateDiff('yyyy', lsiTempDate, Now())>
		<cfset lsiTempAgeMinus = DateDiff('yyyy', DateAdd('d', -1, lsiTempDate), Now())>
		<cfset session.dob_month = lsiTempMonth>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob_month" response="#lsiTempMonth#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.dob_year = lsiTempYear>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob_year" response="#lsiTempYear#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.dob = lsiTempAge>
		<cfset session.dob_minus_day = lsiTempAgeMinus>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="dob" response="#lsiTempAge#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset lsiTempAge = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_day" element="val" var="lsiTempDay">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_month" element="val" var="lsiTempMonth">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_dob_year" element="val" var="lsiTempYear">
	<cfif ListFind(lsiDeriveList, 'be_noncl_dob_day') and IsNumeric(lsiTempDay) and ListFind(lsiDeriveList, 'be_noncl_dob_month') and IsNumeric(lsiTempMonth) and ListFind(lsiDeriveList, 'be_noncl_dob_year') and IsNumeric(lsiTempYear)>
		<cfset lsiTempDate = CreateDate(lsiTempYear, lsiTempMonth, lsiTempDay)>
		<cfset lsiTempAgeSpouse = DateDiff('yyyy', lsiTempDate, Now())>
		<cfset lsiTempAgeMinusSpouse = DateDiff('yyyy', DateAdd('d', -1, lsiTempDate), Now())>
		<cfset session.sp_dob_month = lsiTempMonth>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob_month" response="#lsiTempMonth#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.sp_dob_year = lsiTempYear>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob_year" response="#lsiTempYear#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.sp_dob = lsiTempAgeSpouse>
		<cfset session.sp_dob_minus_day = lsiTempAgeMinusSpouse>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="sp_dob" response="#lsiTempAgeSpouse#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfelse>
		<cfset lsiTempAgeSpouse = 0>
	</cfif>
	<cfif lsiTempAge gt 59 and lsiTempAgeSpouse gt 59>
		<cfset lsiTemp = 2>
	<cfelseif lsiTempAge gt 59 or lsiTempAgeSpouse gt 59>
		<cfset lsiTemp = 1>
	<cfelse>
		<cfset lsiTemp = 0>
	</cfif>
	<cfset session.over_60 = lsiTemp>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="over_60" response="#lsiTemp#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive assets answerfields from be_res_bank_acc_amt, be_res_invst_amt, and be_res_csh_amt --->
<cfif ListFind(lsiDeriveList, 'be_res_bank_acc_amt') and ListFind(lsiDeriveList, 'be_res_invst_amt') and ListFind(lsiDeriveList, 'be_res_csh_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_res_bank_acc_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_res_invst_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_res_csh_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cf_handleScreeningAnswerfield action="get" code="be_ins_pol_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>
	<cfset session.s_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="s_asset_total_complete" response="#session.s_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_asset_total_complete = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="sp_asset_total_complete" response="#session.sp_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="s_sp_asset_total_complete" response="#session.s_sp_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_asset_total_complete = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="hh_asset_total_complete" response="#session.hh_asset_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive self unearned income from turbo app vars --->
<cfif ListFind(lsiDeriveList, 'be_clnt_ss_benefits_amt') and ListFind(lsiDeriveList, 'be_clnt_rr_incm_amt') and ListFind(lsiDeriveList, 'be_clnt_va_benefits_amt') and ListFind(lsiDeriveList, 'be_clnt_pens_annuit_amt') and ListFind(lsiDeriveList, 'be_clnt_oth_incm_amt')>

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_ss_benefits_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset session.s_income_ss_retire = lsiTemp1>
	<cfset session.s_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_ss_retire" response="#session.s_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_ss_disable" response="#session.s_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_ss_retire = 0>
	<cfset session.sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_retire" response="#session.sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_disable" response="#session.sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_ss_retire = lsiTemp1>
	<cfset session.s_sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_retire" response="#session.s_sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_disable" response="#session.s_sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_ss_retire = lsiTemp1>
	<cfset session.hh_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_retire" response="#session.hh_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_disable" response="#session.hh_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_rr_incm_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset session.s_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_rr_ben" response="#session.s_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_rr_ben = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_rr_ben" response="#session.sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_rr_ben" response="#session.s_sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_rr_ben" response="#session.hh_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_va_benefits_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cfset session.s_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_vet_ben" response="#session.s_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_vet_ben = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_vet_ben" response="#session.sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_vet_ben" response="#session.s_sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_vet_ben" response="#session.hh_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_pens_annuit_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>

	<cf_handleScreeningAnswerfield action="get" code="be_clnt_oth_incm_amt" element="val" var="lsiTemp5">
	<cfif lsiTemp5 eq ''>
		<cfset lsiTemp5 = 0>
	</cfif>

	<cfset session.s_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_unearned" response="#session.s_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_unearned = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_unearned" response="#session.sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_unearned" response="#session.s_sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_unearned" response="#session.hh_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not IsDefined('session.s_income_earned')>
		<cfset session.s_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_earned" response="#session.s_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.sp_income_earned')>
		<cfset session.sp_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.s_sp_income_earned')>
		<cfset session.s_sp_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfif not IsDefined('session.hh_income_earned')>
		<cfset session.hh_income_earned = 0>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
	<cfset session.s_income_total_complete = session.s_income_total_unearned + session.s_income_earned  >
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_complete" response="#session.s_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive spouse unearned income from turbo app vars --->
<cfif ListFind(lsiDeriveList, 'be_noncl_ss_benefits_amt') and ListFind(lsiDeriveList, 'be_noncl_rr_incm_amt') and ListFind(lsiDeriveList, 'be_noncl_va_benefits_amt') and ListFind(lsiDeriveList, 'be_noncl_pens_annuit_amt') and ListFind(lsiDeriveList, 'be_noncl_oth_incm_amt')>

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_ss_benefits_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset session.sp_income_ss_retire = lsiTemp1>
	<cfset session.sp_income_ss_disable = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_retire" response="#session.sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_ss_disable" response="#session.sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_ss_retire')><cfset session.s_income_ss_retire = 0></cfif>
	<cfset session.s_sp_income_ss_retire = session.s_income_ss_retire + lsiTemp1>
	<cfif not isdefined('session.s_income_ss_disable')><cfset session.s_income_ss_disable = 0></cfif>
	<cfset session.s_sp_income_ss_disable = session.s_income_ss_disable>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_retire" response="#session.s_sp_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_ss_disable" response="#session.s_sp_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_ss_retire = session.s_income_ss_retire + lsiTemp1>
	<cfset session.hh_income_ss_disable = session.s_income_ss_disable>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_retire" response="#session.hh_income_ss_retire#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_ss_disable" response="#session.hh_income_ss_disable#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_rr_incm_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset session.sp_income_rr_ben = lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_rr_ben" response="#session.sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_rr_ben')><cfset session.s_income_rr_ben = 0></cfif>
	<cfset session.s_sp_income_rr_ben = session.s_income_rr_ben + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_rr_ben" response="#session.s_sp_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_rr_ben = session.s_income_rr_ben + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_rr_ben" response="#session.hh_income_rr_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_va_benefits_amt" element="val" var="lsiTemp3">
	<cfif lsiTemp3 eq ''>
		<cfset lsiTemp3 = 0>
	</cfif>
	<cfset session.sp_income_vet_ben = lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_vet_ben" response="#session.sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfif not isdefined('session.s_income_vet_ben')><cfset session.s_income_vet_ben = 0></cfif>
	<cfset session.s_sp_income_vet_ben = session.s_income_vet_ben + lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_vet_ben" response="#session.s_sp_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_vet_ben = session.s_income_vet_ben + lsiTemp3>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_vet_ben" response="#session.hh_income_vet_ben#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_pens_annuit_amt" element="val" var="lsiTemp4">
	<cfif lsiTemp4 eq ''>
		<cfset lsiTemp4 = 0>
	</cfif>

	<cf_handleScreeningAnswerfield action="get" code="be_noncl_oth_incm_amt" element="val" var="lsiTemp5">
	<cfif lsiTemp5 eq ''>
		<cfset lsiTemp5 = 0>
	</cfif>

	<cfset session.sp_income_total_unearned = lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cfif not isdefined('session.s_income_total_unearned')><cfset session.s_income_total_unearned = 0></cfif>
	<cfif not isdefined('session.sp_income_earned')><cfset session.sp_income_earned = 0></cfif>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_unearned" response="#session.sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_unearned = session.s_income_total_unearned + lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_unearned" response="#session.s_sp_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_unearned = session.s_income_total_unearned + lsiTemp1 + lsiTemp2 + lsiTemp3 + lsiTemp4 + lsiTemp5>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_unearned" response="#session.hh_income_total_unearned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cfif not isdefined('session.S_INCOME_EARNED')><cfset session.S_INCOME_EARNED = 0></cfif>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_income_total_unearned + session.s_income_earned + session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.s_income_total_unearned + session.s_income_earned + session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Correct work question if didn't really work --->
<cfif ListFind(lsiDeriveList, 'be_clnt_earn_wgs_xnd') and ListFind(lsiDeriveList, 'be_clnt_earn_loss_xnd') and ListFind(lsiDeriveList, 'be_clnt_stop_wrk_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_wgs_xnd" element="val" var="lsiTemp1">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_loss_xnd" element="val" var="lsiTemp2">
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_stop_wrk_xnd" element="val" var="lsiTemp3">
	<cfif lsiTemp1 eq 0 and lsiTemp2 eq 0 and lsiTemp3 eq 0>
		<cfset session.be_clnt_wrkd_l2yr_xnd = 'n'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="be_clnt_wrkd_l2yr_xnd" response="n" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!--- Correct work question if spouse didn't really work --->
<cfif ListFind(lsiDeriveList, 'be_noncl_earn_wgs_xnd') and ListFind(lsiDeriveList, 'be_noncl_earn_loss_xnd') and ListFind(lsiDeriveList, 'be_noncl_stop_wrk_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_wgs_xnd" element="val" var="lsiTemp1">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_loss_xnd" element="val" var="lsiTemp2">
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_stop_wrk_xnd" element="val" var="lsiTemp3">
	<cfif lsiTemp1 eq 0 and lsiTemp2 eq 0 and lsiTemp3 eq 0>
		<cfset session.be_noncl_wrkd_l2yr_xnd = 'n'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="be_noncl_wrkd_l2yr_xnd" response="n" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!--- Derive self earned income from turbo app vars --->
<cfif ListFind(lsiDeriveList, 'be_clnt_earn_wgs_amt') and ListFind(lsiDeriveList, 'be_clnt_earn_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_wgs_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset lsiTemp1 = lsiTemp1 / 12>
	<cf_handleScreeningAnswerfield action="get" code="be_clnt_earn_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset lsiTemp2 = lsiTemp2 / 12>
	<cfset session.s_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_earned" response="#session.s_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_earned = 0>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_income_total_complete = session.s_income_total_unearned + session.s_income_earned >
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_income_total_complete" response="#session.s_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive spouse earned income from turbo app vars --->
<cfif ListFind(lsiDeriveList, 'be_noncl_earn_wgs_amt') and ListFind(lsiDeriveList, 'be_noncl_earn_amt')>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_wgs_amt" element="val" var="lsiTemp1">
	<cfif lsiTemp1 eq ''>
		<cfset lsiTemp1 = 0>
	</cfif>
	<cfset lsiTemp1 = lsiTemp1 / 12>
	<cf_handleScreeningAnswerfield action="get" code="be_noncl_earn_amt" element="val" var="lsiTemp2">
	<cfif lsiTemp2 eq ''>
		<cfset lsiTemp2 = 0>
	</cfif>
	<cfset lsiTemp2 = lsiTemp2 / 12>
	<cfset session.sp_income_earned = lsiTemp1 + lsiTemp2>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_earned" response="#session.sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_earned = session.s_income_earned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_earned" response="#session.s_sp_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_earned = session.s_income_earned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_earned" response="#session.hh_income_earned#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.sp_income_total_complete = session.sp_income_total_unearned + session.sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="sp_income_total_complete" response="#session.sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.s_sp_income_total_complete = session.s_sp_income_total_unearned + session.s_sp_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="s_sp_income_total_complete" response="#session.s_sp_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	<cfset session.hh_income_total_complete = session.hh_income_total_unearned + session.hh_income_earned>
	<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="hh_income_total_complete" response="#session.hh_income_total_complete#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
</cfif>
<!--- Derive hh_disabled and disabled answerfields from ct_ss_disblty_xnd --->
<cfif ListFind(lsiDeriveList, 'ct_ss_disblty_xnd')>
	<cf_handleScreeningAnswerfield action="get" code="ct_ss_disblty_xnd" element="val" var="afVal">
	<cfif afVal eq 1>
		<cfset session.hh_disabled = 1>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="hh_disabled" response="1" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.disabled = 1>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="disabled" response="1-y" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
	</cfif>
</cfif>
<!--- Derive COUNTY and COUNTY_ID answerfields from ZIP (and ST if necessary, and CITY and CITY_ID if possible).  This
      is a rare case where we allow one set of vars to be derived from another derived var, to avoid duplicating code
      from where 'zip' gets derived from 'be_clnt_mail_addr_zip5' above.  Of course, if the actual 'zip' field was
      entered in the questionnaire and not derived, we can use that value. --->
<cfif ListFind(lsiDeriveList, 'zip') or useDerivedZip>
	<cf_handleScreeningAnswerfield action="get" code="county" element="val" var="lsiCounty">
	<cf_handleScreeningAnswerfield action="get" code="county_id" element="val" var="lsiCountyID">
	<cf_handleScreeningAnswerfield action="get" code="city" element="val" var="lsiCity">
	<cf_handleScreeningAnswerfield action="get" code="city_id" element="val" var="lsiCityID">
	<cf_handleScreeningAnswerfield action="get" code="zip" element="val" var="lsiZip">
	<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="lsiSt">
	<cf_handleScreeningAnswerfield action="get" code="pri_resident" element="val" var="lsiRes">
	<cfif lsiCounty eq '' and lsiCountyID eq '' and lsiZip neq '' and lsiSt neq ''>
		<cfquery name="getCounty" datasource="#application.dbSrc#">
			select c.county_id, c.county_name
			from zip z, county c
			where z.zipcode='#lsiZip#'
				and z.valid=1
				and z.state_id='#lsiSt#'
				and z.county_id=c.county_id
		</cfquery>
		<cfif getCounty.RecordCount gt 0>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county_id" response="#getCounty.county_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county_id = getCounty.county_id>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county" response="#getCounty.county_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county = getCounty.county_name>
		</cfif>
	<cfelseif lsiSt eq '' and lsiCounty eq '' and lsiCountyID eq '' and lsiZip neq ''>
		<cfquery datasource="#application.dbSrc#" name="getCounty">
			select z.state_id, s.statetype_id, c.county_id, c.county_name
			from zip z, county c, state s
			where z.zipcode='#lsiZip#'
				and z.valid=1
				and z.state_id=s.state_id
				and <cfif session.subset_id neq 59 and session.subset_id neq 3 and session.subset_id neq 62 >
				s.statetype_id=1
				    <cfelseif session.subset_id eq 3 or session.subset_id eq 62>
				(s.statetype_id=1 or s.state_id = 'VI')
				    <cfelse>
				s.state_id = 'VI'
				    </cfif>
				and z.county_id=c.county_id
		</cfquery>
		<cfif getCounty.RecordCount gt 0>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="st" response="#getCounty.state_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.st = getCounty.state_id>
			<cfif lsiRes eq ''>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="y" response_var="pri_resident" response="Y" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset session.pri_resident = 'Y'>
			</cfif>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county_id" response="#getCounty.county_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county_id = getCounty.county_id>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="county" response="#getCounty.county_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.county = getCounty.county_name>
		</cfif>
	</cfif>
	<cfif IsDefined('application.chicagovars') AND lsiCity eq '' and lsiCityID eq '' and lsiZip neq '' And StructKeyExists(application.chicagovars, lsiZip)>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="o" response_var="city" response="2376-chicago" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_name" response="CHICAGO" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.city = 'chicago'>
		<cfset session.city_name = 'CHICAGO'>
		<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_id" response="#StructFind(application.chicagovars, lsiZip)#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
		<cfset session.city_id = StructFind(application.chicagovars, lsiZip)>
	<cfelseif lsiCity eq '' and lsiCityID eq '' and lsiZip neq ''>
		<cfquery datasource="#application.dbSrc#" name="getCity">
			select cz.city_id, c.city_name
			from view_city_zip_preferred cz, city c
			where cz.zipcode='#Trim(lsiZip)#'
				and cz.city_id=c.city_id
				and c.valid=1
			order by c.city_name
		</cfquery>
		<cfif getCity.RecordCount eq 1>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_name" response="#getCity.city_name#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.city = getCity.city_name>
			<cfset session.city_name = getCity.city_name>
			<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="s" response_var="city_id" response="#getCity.city_id#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfset session.city_id = getCity.city_id>
		<cfelse>
			<cfset session.city = 0>
			<cfset session.city_name = 0>
			<cfset session.city_id = 0>
		</cfif>
	</cfif>
</cfif>
<!--- Derive INCOME variables --->
<cfif lsiDeriveIncome>
	<cfif not isdefined('session.scsep_inc') >
		<cfset session.scsep_inc = 0 >
	<cfelseif session.scsep_inc eq ''>
		<cfset session.scsep_inc = 0 >
	</cfif>
	<cfloop index="class" list="s,sp,s_sp,hh">
		<cfset "colaccumvar_#class#_unearned" = 0>
		<cfset "colaccumvar_#class#_complete" = 0>
	</cfloop>
	<cfloop index="element" list="pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,unemployment,child_support,cash_assist,other_nw,earned,total_unearned,total_complete">
		<cfset rowaccumvar = 0>
		<cfloop index="class" list="s,sp,s_sp,hh,ch">
			<cfif class neq "ch" or element eq "total_unearned" or element eq "earned" or element eq "child_support">
				<cfset sessionvarname = "#class#_income_#element#">
				<cfif class eq 's_sp' or class eq 'hh'>
					<cfset databasevarname = "#sessionvarname#_simple">
				<cfelse>
					<cfset databasevarname = sessionvarname>
				</cfif>
				<cfif IsDefined("caller.#attributes.structname#.#databasevarname#")>
					<cfset databaseval = Evaluate("caller.#attributes.structname#.#databasevarname#")>
					<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
					<cfif databaseval eq '' >
						<cfset databaseval = 0>
					</cfif>
				<cfelseif element eq 'total_unearned' and class neq "ch">
					<cfset databaseval = Evaluate("colaccumvar_#class#_unearned")>
					<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfelseif element eq 'total_complete' and class neq "ch">
					<cfset databaseval = Evaluate("colaccumvar_#class#_complete")>
					<cfif class eq 's'><!--- add scsep value to total from special question --->
						<cfset databaseval = Evaluate("colaccumvar_#class#_complete") + session.scsep_inc>
					</cfif>
					<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfelse>
					<cfset databaseval = 0>
				</cfif>
				<cfif databaseval eq 'undefined'>
					<cfset databaseval = 0>
				</cfif>
				<cfset databaseval = ReReplace(databaseval,'\.(.*)','','ALL')> <!--- remove anything after a .--->
				<cfset databaseval = reReplaceNoCase(databaseval, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
				<cfset "session.#databasevarname#" = databaseval>
				<cfset rowaccumvar = rowaccumvar + databaseval>
				<cfif element neq 'earned' and element neq 'total_unearned' and element neq 'total_complete' and class neq "ch">
					<cfset "colaccumvar_#class#_unearned" = Evaluate("colaccumvar_#class#_unearned") + databaseval>
				</cfif>
				<cfif (element eq 'earned' or element eq 'total_unearned') and class neq "ch">
					<cfset "colaccumvar_#class#_complete" = Evaluate("colaccumvar_#class#_complete") + databaseval>
				</cfif>
				<cfif sessionvarname neq databasevarname>
					<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="i" response_var="#sessionvarname#" response="#rowaccumvar#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
					<cfset "session.#sessionvarname#" = rowaccumvar>
				</cfif>
			</cfif>
		</cfloop>
	</cfloop>
	<cfset lsiDerivePoverty = True>
</cfif>
<!--- Derive ASSETS variables --->
<cfif lsiDeriveAssets>
	<cfloop index="class" list="s,sp,s_sp,hh">
		<cfset "colaccumvar_#class#_complete" = 0>
	</cfloop>
	<cfloop index="element" list="cash,stocks,life_cash,life_face,auto1,auto2,retirement,home,revocable,irrevocable,other_a,total_complete">
		<cfset rowaccumvar = 0>
		<cfloop index="class" list="s,sp,s_sp,hh,ch">
			<cfif class neq "ch" or  element eq "total_complete">
			<cfset sessionvarname = "#class#_asset_#element#">
			<cfif class eq 's_sp' or class eq 'hh'>
				<cfset databasevarname = "#sessionvarname#_simple">
			<cfelse>
				<cfset databasevarname = sessionvarname>
			</cfif>
			<cfif IsDefined("caller.#attributes.structname#.#databasevarname#")>
				<cfset databaseval = Evaluate("caller.#attributes.structname#.#databasevarname#")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#databasevarname#" response="#databaseval#" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfif databaseval eq ''>
					<cfset databaseval = 0>
				</cfif>
			<cfelseif element eq 'total_complete' and class neq "ch">
				<cfset databaseval = Evaluate("colaccumvar_#class#_complete")>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#databasevarname#" response="#databaseval#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			<cfelse>
				<cfset databaseval = 0>
			</cfif>
			<cfset "session.#databasevarname#" = databaseval>
<cfset databaseval = ReReplace(databaseval,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset databaseval = reReplaceNoCase(databaseval, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->

			<cfset rowaccumvar = rowaccumvar + databaseval>
			<cfif element neq 'life_face' and element neq 'irrevocable' and element neq 'total_complete' and class neq "ch">
				<cfset "colaccumvar_#class#_complete" = Evaluate("colaccumvar_#class#_complete") + databaseval>
			</cfif>
			<cfif sessionvarname neq databasevarname>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="a" response_var="#sessionvarname#" response="#rowaccumvar#" derived_flag="1" approximation_flag="#lsiIncAssApprox#" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
				<cfset "session.#sessionvarname#" = rowaccumvar>
			</cfif>
			</cfif>
		</cfloop>
	</cfloop>
</cfif>
<!--- Derive session income values if skipping income questions --->
<cfif ListFind(lsiDeriveList, 'skipinc')>
	<cf_handleScreeningAnswerfield action="get" code="skipinc" element="val" var="lsiSkipIncome">
	<cfif lsiSkipIncome eq 0>
		<cfloop index="class" list="s,sp,s_sp,hh">
			<cfset "session.#class#_income_total_unearned" = 0>
			<cfset "session.#class#_income_total_complete" = 0>
		</cfloop>
		<cfloop index="element" list="pri_retire,dividends,ssi,ss_disable,ss_retire,rr_ben,vet_ben,unemploy,tanf,unemployment,child_support,cash_assist,other_nw,earned">
			<cfloop index="class" list="s,sp,s_sp,hh">
				<cfset "session.#class#_income_#element#" = 99999999>
				<cfif element neq 'earned'>
					<cfset "session.#class#_income_total_unearned" = Evaluate("session.#class#_income_total_unearned") + 99999999>
				</cfif>
				<cfset "session.#class#_income_total_complete" = Evaluate("session.#class#_income_total_complete") + 99999999>
			</cfloop>
		</cfloop>
	</cfif>
</cfif>
<!--- Derive session asset values if skipping asset questions --->
<cfif ListFind(lsiDeriveList, 'skipassets')>
	<cf_handleScreeningAnswerfield action="get" code="skipassets" element="val" var="lsiSkipAssets">
	<cfif lsiSkipAssets eq 0>
		<cfloop index="class" list="s,sp,s_sp,hh">
			<cfset "session.#class#_asset_total_complete" = 0>
		</cfloop>
		<cfloop index="element" list="cash,stocks,life_cash,life_face,auto1,auto2,retirement,home,revocable,irrevocable,other_a">
			<cfloop index="class" list="s,sp,s_sp,hh">
				<cfset "session.#class#_asset_#element#" = 99999999>
				<cfset "session.#class#_asset_total_complete" = Evaluate("session.#class#_asset_total_complete") + 99999999>
			</cfloop>
		</cfloop>
	</cfif>
</cfif>
<!--- Derive POVERTY_INDEX from HH_TOTAL_INCOME_COMPLETE --->
<cfif lsiDerivePoverty>
	<cf_handleScreeningAnswerfield action="get" code="hh_income_total_complete" element="val" var="lsiIncome">
	<cfif lsiIncome neq '' and IsNumeric(lsiIncome)>
		<cf_handleScreeningAnswerfield action="get" code="no_hh_members" element="val" var="povMem">
		<cfif povMem eq '' or not IsNumeric(povMem)>
			<cf_handleScreeningAnswerfield action="get" code="hh_depend" element="val" var="povMem">
			<cfif povMem eq '' or not IsNumeric(povMem)>
				<cfset povMem = 1>
			</cfif>
		</cfif>
		<cfif povMem eq 0>
			<cfset povMem = 1>
		<cfelseif povMem gt 8>
			<cfset povMem = 8>
		</cfif>
		<!--- POVERTYINDEX=HH_INCOME_TOTAL_COMPLETE/poverylevel --->
		<!--- povertylevel is retrieved from db, by using session.NO_HH_MEMBERS and tbl_id of 330 (HARDCODED !) --->
		<!--- for now, hardcode it; otherwise retrieve from table (based on state, family members, etc.? ) --->
		<cfquery datasource="#application.dbSrc#" name="getPoverty">
			SELECT mem#povMem# AS povLevel
			FROM tbl_inc_new
			WHERE proc_id = 484
		</cfquery>
		<cfif getPoverty.RecordCount>
			<cfset povVal = getPoverty.povLevel>
			<cfif povVal neq 0>
				<cfset povVal = lsiIncome / povVal>
				<cf_logScreeningInputDetail pgno="#lsiPgNo#" response_type="n" response_var="poverty_index" response="#povVal#" derived_flag="1" timestamp="#lsiDateTime#" prepopulateWithInput="#attributes.prepopulateWithInput#">
			</cfif>
			<cfset session.povertyindex = povVal>
		</cfif>
	</cfif>
</cfif>
<!--- Derive ct_clnt_mail_addr_st_grt from CT_LIVE --->
<cfif ListFind(lsiDeriveList, 'ct_live_grt') or (1 eq 1)>
	<cf_handleScreeningAnswerfield action="get" code="ct_live_grt" element="val" var="lsiLive">
	<cf_handleScreeningAnswerfield action="set" code="ct_clnt_mail_addr_st_grt" val="#lsiLive#">
	<cfset session.ct_clnt_mail_addr_st_grt = lsiLive>
</cfif>
<!--- Derive full names from name variables --->
<cfif ListFind(lsiDeriveList, 'be_clnt_fnm')>
	<cf_buildFullName firstvar="be_clnt_fnm" initialvar="be_clnt_mnm" lastvar="be_clnt_lnm" suffixvar="be_clnt_sfx" var="session.be_clnt_fullname">
</cfif>
<cfif ListFind(lsiDeriveList, 'be_noncl_fnm')>
	<cf_buildFullName firstvar="be_noncl_fnm" initialvar="be_noncl_mnm" lastvar="be_noncl_lnm" suffixvar="be_noncl_sfx" var="session.be_noncl_fullname">
</cfif>
<cfif ListFind(lsiDeriveList, 'be_thrd_fnm')>
	<cf_buildFullName firstvar="be_thrd_fnm" initialvar="be_thrd_mnm" lastvar="be_thrd_lnm" var="session.be_thrd_fullname">
</cfif>
<!--- Derive wantchips from chip --->
<cfif ListFind(lsiDeriveList, 'chip')>
	<cf_handleScreeningAnswerfield action="get" code="chip" element="val" var="lsiChip">
	<cfif lsiChip>
		<cfset session.wantchips = 'Y'>
	<cfelse>
		<cfset session.wantchips = 'N'>
	</cfif>
</cfif>
</cfif>

	<cfif badList eq ''>
		<cfset session.screening.pgno = lsiPgNo + 1>
	</cfif>
</cfif>

<cfif attributes.initvarname Neq ''>
	<cfset "caller.#attributes.initvarname#" = ''>
</cfif>
<cfif attributes.debug><cfabort></cfif>