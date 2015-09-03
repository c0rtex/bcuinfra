<cfcomponent   >
    <cffunction   access="public" name="processContentRules" output="true" returntype="void"  hint="process content rules" >
	<!-- pass arguments -->
	<cfargument name="screening_id" type="numeric" required="yes" >
	<cfargument name="subset_id" type="numeric" required="yes" >
	<cfargument name="responseStruct" required="yes"  >
	<cfargument name="debugOutput" type="numeric" required="no" default="false" >
	<cfset request.sep_narrative = false >
	<cfset request.iep_narrative = false >	
	<cfparam name="arguments.responseStruct.dob" default="">
			<cfquery name="rule_content" datasource="#application.dbSrc#">
				SELECT
				rule.rule_id,
				rule.code,
				rule.rule_text
				FROM
				rule
			  	INNER JOIN subset_content ON rule.code = subset_content.post_code 
				WHERE subset_content.subset_id = #arguments.subset_id#
			</cfquery>
	<cfif arguments.debugOutput><cfdump var="#request#"><h1>Data to Process</h1><cfdump var="#arguments.responseStruct#"></cfif>
	<cfif arguments.responseStruct.dob eq '' and arguments.subset_id eq 80>
		<cfset lsiMakeDOB = DateFormat(arguments.responseStruct.mqc_birth_month & "/01/" & arguments.responseStruct.mqc_birth_year, 'mm/dd/yyyy')>
		<cfset lsiAnswer = Abs(DateDiff("yyyy", DateFormat(NOW(), "mm/dd/yyyy"), lsiMakeDOB))>
		<cfset arguments.responseStruct.dob = lsiAnswer>
	</cfif>
	<cfif arguments.subset_id eq 83>
		<cfparam name="RESPONSESTRUCT.esi_category_retirement_planning" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_money_management" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_employment_training" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_credit_debt_management" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_health_resources" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_homeowner_resources" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_renter_resources" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_consumer_protection" default="">
		<cfparam name="RESPONSESTRUCT.esi_category_legal_resources" default="">
	</cfif>
	<cfloop query="rule_content">       
	<cfif arguments.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting cacheRulePool code="#rule_content.code#" <br /><br /></cfoutput></cfif>

			<cfset strRule = Replace(rule_content.rule_text, "gteq", "gte", "ALL")>
			<cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
			<!-- Do not use session vars --->
			<cfset strRule = Replace(strRule, "session", "arguments.responseStruct", "ALL")>
			<!-- any rule that calls upon an income table will replace the end bracket
			with the reference to the associated column of the income array for the 
			number of people in the household --->
			
				<cfif arguments.debugOutput><cfoutput><h2>#strRule#</h2></cfoutput></cfif>
				
			   <!--- Need an additional proc for the 'NOT IN' rules --->
				<cfset posIn = FindNoCase(' in ', strRule, 1)>
				<cfset posNotIn = FindNoCase(' not in ', strRule, 1)>
				<cfif posNotIn>
					<cfset posFind = posNotIn>
					<cfset posLen = 8>
				<cfelseif posIn>
					<cfset posFind = posIn>
					<cfset posLen = 4>
				<cfelse>
					<cfset posFind = 0>
				</cfif>
			   <cfif posFind>
				  <cfset strItem = Trim(Left(strRule, posFind - 1))>
				  <cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!-- Need to strip the opening '(' -->
				  <!-- Also strip apostrophes -->
				  <cfif Find("('", strItem) eq 1>
					  <cfset strItem = Mid(strItem, 3, Len(strItem) - 3)>
					<cfelse>
					 <cfset strItem = Mid(strItem, 2, Len(strItem) - 1)>
				</cfif>
				<cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!--Need to do this to extract the compare list -->
				  <cfset strList = Trim(Right(strRule, Len(strRule) - (posFind + posLen - 1)))>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <!-- Need to strip the closing ')' -->
				  <cfset strList = Mid(strList, 2, Len(strList) - 3)>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <cfloop index="element" from="1" to="#ListLen(strList)#">
					<cfset strList = ListSetAt(strList, element, Trim(ListGetAt(strList, element)))>
				  </cfloop>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <cfset temp = ListFindNoCase(strList, strItem)>
				  <cfif temp eq 0>
					<cfif posNotIn>
						<cfset answer="YES">
					 <cfelse>
						<cfset answer="NO">
					 </cfif>
				  <cfelse>
					<cfif posNotIn>
						<cfset answer="NO">
					 <cfelse>
						<cfset answer="YES">
					 </cfif>
				  </cfif>
			   <cfelse>	  
				  	<cfset answer=Evaluate("#strRule#")>  
			   </cfif>
			   <cfif arguments.debugOutput><cfoutput> = #answer#<br></cfoutput></cfif>
	    <cfset trimmed_code = #trim(rule_content.code)#>
	    <cfif arguments.subset_id eq 83>
	    <cfset dbtable = 'wp_'>
	    <cfelse>
	    <cfset dbtable = 'wp_2_'>
	    </cfif>
            <cfquery name="wp_posts" datasource="wp_benefitscheckup">           
            	SELECT
		#dbtable#posts.ID
		FROM
		#dbtable#postmeta
		INNER 
		JOIN #dbtable#posts 
		ON #dbtable#postmeta.post_id = #dbtable#posts.ID
		where meta_key = 'post_code'
		and meta_value like '#trimmed_code#'
		and #dbtable#posts.post_type = 'post' 
            </cfquery>
	   <cfoutput> <cfquery name="wp_posts" datasource="wp_benefitscheckup">           
            	SELECT
		#dbtable#posts.ID
		FROM
		#dbtable#postmeta
		INNER 
		JOIN #dbtable#posts 
		ON #dbtable#postmeta.post_id = #dbtable#posts.ID
		where meta_key = 'post_code'
		and meta_value like '#trimmed_code#'
		and #dbtable#posts.post_type = 'post' 
            </cfquery> </cfoutput>
	    <cfif wp_posts.recordcount gt 0>
	    <cfif answer eq 'yes' >
	    <cfif #findNoCase('mqc_report_mc_narrative_sep_',trimmed_code)# gt 0>
		<cfset request.sep_narrative = true>
	    </cfif>
	   <cfif #findNoCase('mqc_report_mc_narrative_iep_',trimmed_code)# gt 0>
		<cfset request.iep_narrative = true>
	    </cfif>
	    <cfquery name="content_insert" datasource="#application.dbSrc#">           
            	insert into screening_content
		(screening_id, post_id,content_code)
		values
		(#arguments.screening_id#,#wp_posts.id#,'#trimmed_code#')
            </cfquery>
	   </cfif>
	   </cfif>
	</cfloop>
	<cfif request.sep_narrative eq 'true' and request.iep_narrative eq 'false'>
		<cfquery name="content_insert2" datasource="#application.dbSrc#">           
            	insert into screening_content
		(screening_id, post_id,content_code)
		values
		(#arguments.screening_id#,12755,'mqc_report_iep_chart')
           	</cfquery>
	</cfif>
	<cfif arguments.debugOutput><cfquery name="showcontent" datasource="#application.dbSrc#">           
            	select * from screening_content
		where screening_id = '#arguments.screening_id#'
            </cfquery>
	   <cfdump var="#showcontent#">
	</cfif>
		    <cfif arguments.subset_id neq 83>
			<cfset enrollment_start_year = responseStruct.mqc_birth_year + 65 >
			<cfset enrollment_end_year = responseStruct.mqc_birth_year + 65 >
			<cfset enrollment_start_month = #responseStruct.mqc_birth_month# - 3  >
			<cfset enrollment_end_month = #responseStruct.mqc_birth_month# + 3  >
			<cfif enrollment_start_month lt 1 >
				<cfset enrollment_start_month  = enrollment_start_month  + 12>
				<cfset enrollment_start_year = enrollment_start_year - 1>
			</cfif>

			<cfif enrollment_end_month gt 12 >
				<cfset enrollment_end_month  = enrollment_end_month  - 12>
				<cfset enrollment_end_year = enrollment_end_year + 1>
			</cfif>
			<cfset lastdayofmonth = 31>
			<cfif enrollment_end_month eq 9 or enrollment_end_month eq 4 or enrollment_end_month eq 6 or enrollment_end_month eq 11 >
  				<cfset lastdayofmonth = 30 >
			<cfelseif enrollment_end_month eq 2>
  				<cfset lastdayofmonth = 28 >
			</cfif>
			<cfset enrollment_start_day = 1  >
			<cfset enrollment_end_day = lastdayofmonth  >

			 <cfset responseToSave = enrollment_start_month & "/" & enrollment_start_day & "/" & enrollment_start_year>
			
			 
			 <cfset encryptedResponseToSave = 'NULL'>
	     		 <cfset answerfield_id = "7476">
			 <cfset lsidTimestamp = CreateODBCDateTime(Now())>
			<cfquery name="logAnswerfield" datasource="#application.dbSrc#">
			INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
			VALUES
			(#arguments.screening_id#, #answerfield_id#, 2,
			 '#responseToSave#', null, 1, 
			 NULL,1,NULL, NULL,NULL, #lsidTimestamp#)
			</cfquery>
			 <cfset responseToSave = enrollment_end_month & "/" & enrollment_end_day & "/" & enrollment_end_year>

			 <cfset encryptedResponseToSave = 'NULL'>
	     		 <cfset answerfield_id = "7475">
			 <cfset lsidTimestamp = CreateODBCDateTime(Now())>
			<cfquery name="logAnswerfield" datasource="#application.dbSrc#">
			INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
			VALUES
			(#arguments.screening_id#, #answerfield_id#, 2,
			 '#responseToSave#', null, 1, 
			 NULL,1,NULL, NULL,NULL, #lsidTimestamp#)
			</cfquery>
		  </cfif>
  </cffunction>


  <cffunction   access="public" name="logScreeningInput" output="false" returntype="struct"  hint="store answers from screening" >
     <cfargument name="subset_id" type="numeric" required="yes" >
     <cfargument name="screening_id" type="numeric" required="yes" >
     <cfargument name="partner_id" type="numeric" required="no" >
     <cfargument name="responseStruct" required="yes">
     <cfargument name="aflist" type="string" required="yes">
     <cfargument name="debug" type="boolean" required="no" default="false">
<cfparam name="attributes.initvarname" type="string" default="">
<cfparam name="attributes.varname" type="string" default="">
<cfparam name="attributes.structname" type="string" default="responseStruct">
<cfparam name="attributes.aflist" type="string" default="">
<cfparam name="attributes.loadsession" type="boolean" default="false">
<cfparam name="attributes.prepopulateWithInput" type="boolean" default="false">
<cfparam name="attributes.useOptionCodes" type="boolean" default="false">
<cfparam name="attributes.batch" type="boolean" default="false">
<cfparam name="application.lsidebug" type="boolean" default="false">
<cfif arguments.aflist neq ''>
	<cfset lsiList=arguments.aflist>
	<cfif arguments.debug><cfset application.lsidebug = false><cfoutput><br>lsiList2: #lsiList#</cfoutput></cfif>
</cfif>
<cfif IsDefined('arguments.partner_id')>
	<cfif #findnocase('s-zip',lsiList)# gt 0 and (arguments.partner_id eq 81 or arguments.partner_id eq 61 or arguments.partner_id eq 63)  and #findnocase('o-pl_agency_list',lsiList)# eq 0 >
	  <cfset lsiList = lsiList & ',o-pl_agency_list' >
	</cfif>
	<cfif #findnocase('s-zip',lsiList)# gt 0 and arguments.partner_id eq 76 and #findnocase('o-fit_counseling_session_type',lsiList)# eq 0>
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
	<cfset responsedata.prepopulate = 1>
</cfif>
<cfset lsiDateTime = CreateODBCDateTime(Now())>
<cfif IsDefined('arguments.responseStruct.pgno')>
	<cfset lsiPgNo = arguments.responseStruct.pgno>
<cfelseif IsDefined('responsedata.pgno')>
	<cfset lsiPgNo = responsedata.pgno>
<cfelse>
	<cfset responsedata.pgno = 1>
	<cfset lsiPgNo = 1>
</cfif>
<cfif IsDefined("arguments.responseStruct.qno")>
	<cfset responsedata.qno = arguments.responseStruct.qno>
<cfelseif Not IsDefined('responsedata.qno')>
	<cfset arguments.screening.qno = 1>
</cfif>
<cfif IsDefined("arguments.responseStruct.qnum") and arguments.responseStruct.qnum eq 1>
	<cfset responsedata.qnum = responsedata.qno>
	<cfset responsedata.qno = 0>
</cfif>
<cfif responsedata.pgno gt lsiPgNo>
	<cfquery name="checkAnswerfields" datasource="#application.dbSrc#">
		select a.answerfield
		from screening_answerfield sa, answerfield a
		where sa.screening_id=#arguments.screening_id#
			and sa.pagenum >= #lsiPgNo#
			and sa.answerfield_id=a.answerfield_id
	</cfquery>
	<cfif checkAnswerfields.RecordCount gt 0>
		<cfquery name="deleteAnswerfields" datasource="#application.dbSrc#">
			delete from screening_answerfield 
			where screening_id=#arguments.screening_id#
				and pagenum >= #lsiPgNo#
		</cfquery>
	</cfif>
</cfif>

<cfif arguments.debug><cfoutput><br>New Response Data: <cfdump var="#responseStruct#"></cfoutput></cfif>
<!--- Insert questionnaire responses into screening_answerfield --->
<cfif arguments.debug><cfoutput><br>lsiList: #lsiList#</cfoutput></cfif>
<cfset badList = ''>
<cfloop list="#lsiList#" index="itemID"> 
	<cftry>
	<cfset lsiEncryptionFlag = 'NULL'>
	<cfset lsiType = ListGetAt(itemID, 1, '-')>
	<cfset lsiVar = ListGetAt(itemID, 2, '-')>
	<cfif arguments.debug><cfoutput><br>Item: #itemID# lsiType: #lsiType# lsiVar: #lsiVar#<br></cfoutput></cfif>
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

	<cfif IsDefined("responseStruct.#lsiVar#") or lsiType eq 'c'>
		<cfif IsDefined("responseStruct.#lsiVar#")>
			<cfset lsiVal = Evaluate("responseStruct.#lsiVar#")>
		<cfelse>
			<cfset lsiVal = ''>
		</cfif>
		<cfif arguments.debug><cfoutput><br>LIS VAL2A: 'responseStruct.#lsiVar#' #lsiVal#<br></cfoutput></cfif>
		<cfif lsiType eq 'o' And ListLen(lsiVal, '-') gt 1>
			<cfset tmpCode = ListDeleteAt(lsiVal, 1, '-')>
			<cfif attributes.useOptionCodes>
				<cfset "responsedata.#lsiVar#" = tmpCode>
				<cfset "responseStruct.#lsiVar#" = tmpCode>
			<cfelse>
				<cf_displayText group="option" code="option_#tmpCode#" language_id="EN" var="lsiOptionText">
				<cfset "responsedata.#lsiVar#" = lsiOptionText>
				<cfset "responseStruct.#lsiVar#" = tmpCode>
			</cfif>
			<cfif arguments.debug><cfoutput><br>LIS VAL2B:#lsiVal#<br></cfoutput></cfif>
		<cfelse>
			<cfset "responsedata.#lsiVar#" = lsiVal>
			<cfif arguments.debug><cfoutput><br>LIS VAL2C:#lsiVal#<br></cfoutput></cfif>
		</cfif>
		<cfif arguments.debug><cfoutput><br>LIS VAL2:#lsiVal#<br></cfoutput></cfif>
	<cfelse>
		<cfset lsiVal = ''>
		<cfset "responsedata.#lsiVar#" = 0>
		<cfif arguments.debug><cfoutput><br>LIS VAL3:#lsiVal#<br></cfoutput></cfif>
	</cfif>
	
	<cfif not isdefined('aftype')>
		<cfset aftype = ''>
    	</cfif>
	<cfif arguments.debug><cfoutput><br>LIS VAL4 :#lsiVal#<br></cfoutput></cfif>
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
					<cfif IsDefined("responseStruct.fit_homeowner_2") and responseStruct.fit_homeowner_2 neq '' and responseStruct.fit_health_homeowner1 eq ''>
						<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
					</cfif>
				<cfelseif lsiTrueVar eq 'fit_health_homeowner3' or lsiTrueVar eq 'fit_homeowner_3'>
					<cfif IsDefined("responseStruct.fit_homeowner_3") and responseStruct.fit_homeowner_3 neq '' and responseStruct.fit_health_homeowner1 eq ''>
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
     		 <cfif arguments.subset_id eq 63>
        	 <!--- MSP --->
        	<cfif lsiTrueVar eq 'receive_msp'>
            	<cfset receiveSelected1 = "false">
            	<cfif IsDefined("responseStruct.receive_msp")>
					<cfif Evaluate("responseStruct.receive_msp") EQ 'y'>
						<cfset receiveSelected1 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered1 = "false">
            	<cfif IsDefined("responseStruct.receive_msp_amount")>
					<cfif Evaluate("responseStruct.receive_msp_amount") NEQ ''>
						<cfset vobEntered1 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected1 EQ "true" and vobEntered1 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_msp_amount'>
            	<cfset receiveSelected2 = "false">
            	<cfif IsDefined("responseStruct.receive_msp")>
					<cfif Evaluate("responseStruct.receive_msp") EQ 'y'>
						<cfset receiveSelected2 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered2 = "false">
            	<cfif IsDefined("responseStruct.receive_msp_amount")>
					<cfif Evaluate("responseStruct.receive_msp_amount") NEQ ''>
						<cfset vobEntered2 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected2 EQ "false" and vobEntered2 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected2 EQ "true" and vobEntered2 EQ "true">
                	<cfif Evaluate("responseStruct.receive_msp_amount") LT 0 OR Evaluate("responseStruct.receive_msp_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
           	<!--- LIS --->
            <cfelseif lsiTrueVar eq 'receive_lis'>
            	<cfset receiveSelected3 = "false">
            	<cfif IsDefined("responseStruct.receive_lis")>
					<cfif Evaluate("responseStruct.receive_lis") EQ 'y'>
						<cfset receiveSelected3 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered3 = "false">
            	<cfif IsDefined("responseStruct.receive_lis_amount")>
					<cfif Evaluate("responseStruct.receive_lis_amount") NEQ ''>
						<cfset vobEntered3 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected3 EQ "true" and vobEntered3 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_lis_amount'>
            	<cfset receiveSelected4 = "false">
            	<cfif IsDefined("responseStruct.receive_lis")>
					<cfif Evaluate("responseStruct.receive_lis") EQ 'y'>
						<cfset receiveSelected4 = "true">
					</cfif>


                </cfif>
				<cfset vobEntered4 = "false">
            	<cfif IsDefined("responseStruct.receive_lis_amount")>
					<cfif Evaluate("responseStruct.receive_lis_amount") NEQ ''>
						<cfset vobEntered4 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected4 EQ "false" and vobEntered4 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected4 EQ "true" and vobEntered4 EQ "true">
                	<cfif Evaluate("responseStruct.receive_lis_amount") LT 0 OR Evaluate("responseStruct.receive_lis_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- SNAP --->
            <cfelseif lsiTrueVar eq 'fdstmp_receive'>
            	<cfset receiveSelected5 = "false">
            	<cfif IsDefined("responseStruct.fdstmp_receive")>
					<cfif Evaluate("responseStruct.fdstmp_receive") EQ 'y'>
						<cfset receiveSelected5 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered5 = "false">
            	<cfif IsDefined("responseStruct.receive_snap_amount")>
					<cfif Evaluate("responseStruct.receive_snap_amount") NEQ ''>
						<cfset vobEntered5 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected5 EQ "true" and vobEntered5 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_snap_amount'>
            	<cfset receiveSelected6 = "false">
            	<cfif IsDefined("responseStruct.fdstmp_receive")>
					<cfif Evaluate("responseStruct.fdstmp_receive") EQ 'y'>
						<cfset receiveSelected6 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered6 = "false">
            	<cfif IsDefined("responseStruct.receive_snap_amount")>
					<cfif Evaluate("responseStruct.receive_snap_amount") NEQ ''>
						<cfset vobEntered6 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected6 EQ "false" and vobEntered6 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected6 EQ "true" and vobEntered6 EQ "true">
                	<cfif Evaluate("responseStruct.receive_snap_amount") LT 0 OR Evaluate("responseStruct.receive_snap_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- LIHEAP --->
            <cfelseif lsiTrueVar eq 'liheap_receive'>
            	<cfset receiveSelected7 = "false">
            	<cfif IsDefined("responseStruct.liheap_receive")>
					<cfif Evaluate("responseStruct.liheap_receive") EQ 'y'>
						<cfset receiveSelected7 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered7 = "false">
            	<cfif IsDefined("responseStruct.receive_liheap_amount")>
					<cfif Evaluate("responseStruct.receive_liheap_amount") NEQ ''>
						<cfset vobEntered7 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected7 EQ "true" and vobEntered7 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_liheap_amount'>
            	<cfset receiveSelected8 = "false">
            	<cfif IsDefined("responseStruct.liheap_receive")>
					<cfif Evaluate("responseStruct.liheap_receive") EQ 'y'>
						<cfset receiveSelected8 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered8 = "false">
            	<cfif IsDefined("responseStruct.receive_liheap_amount")>
					<cfif Evaluate("responseStruct.receive_liheap_amount") NEQ ''>
						<cfset vobEntered8 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected8 EQ "false" and vobEntered8 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected8 EQ "true" and vobEntered8 EQ "true">
                	<cfif Evaluate("responseStruct.receive_liheap_amount") LT 0 OR Evaluate("responseStruct.receive_liheap_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
           	<!--- Medicaid --->
            <cfelseif lsiTrueVar eq 'med_receive'>
            	<cfset receiveSelected9 = "false">
            	<cfif IsDefined("responseStruct.med_receive")>
					<cfif Evaluate("responseStruct.med_receive") EQ 'y'>
						<cfset receiveSelected9 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered9 = "false">
            	<cfif IsDefined("responseStruct.receive_medicaid_amount")>
					<cfif Evaluate("responseStruct.receive_medicaid_amount") NEQ ''>
						<cfset vobEntered9 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected9 EQ "true" and vobEntered9 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_medicaid_amount'>
            	<cfset receiveSelected10 = "false">
            	<cfif IsDefined("responseStruct.med_receive")>
					<cfif Evaluate("responseStruct.med_receive") EQ 'y'>
						<cfset receiveSelected10 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered10 = "false">
            	<cfif IsDefined("responseStruct.receive_medicaid_amount")>
					<cfif Evaluate("responseStruct.receive_medicaid_amount") NEQ ''>
						<cfset vobEntered10 = "true">
					</cfif>
                </cfif>
		<cfif receiveSelected10 EQ "false" and vobEntered10 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected10 EQ "true" and vobEntered10 EQ "true">
                	<cfif Evaluate("responseStruct.receive_medicaid_amount") LT 0 OR Evaluate("responseStruct.receive_medicaid_amount") GT 9999>
                    	<cfset badList = ListAppend(badList, lsiTrueVar)>
						<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="numrange_0_9999">
                	</cfif>
              	</cfif>
            <!--- Property Tax Relief --->
            <cfelseif lsiTrueVar eq 'receive_propertytax'>
            	<cfset receiveSelected11 = "false">
            	<cfif IsDefined("responseStruct.receive_propertytax")>
					<cfif Evaluate("responseStruct.receive_propertytax") EQ 'y'>
						<cfset receiveSelected11 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered11 = "false">
            	<cfif IsDefined("responseStruct.receive_property_tax_amount")>
					<cfif Evaluate("responseStruct.receive_property_tax_amount") NEQ ''>
						<cfset vobEntered11 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected11 EQ "true" and vobEntered11 EQ "false">
            		<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_specify_amt">
                </cfif>
        	<cfelseif lsiTrueVar eq 'receive_property_tax_amount'>
            	<cfset receiveSelected12 = "false">
            	<cfif IsDefined("responseStruct.receive_propertytax")>
					<cfif Evaluate("responseStruct.receive_propertytax") EQ 'y'>
						<cfset receiveSelected12 = "true">
					</cfif>
                </cfif>
				<cfset vobEntered12 = "false">
            	<cfif IsDefined("responseStruct.receive_property_tax_amount")>
					<cfif Evaluate("responseStruct.receive_property_tax_amount") NEQ ''>
						<cfset vobEntered12 = "true">
					</cfif>
                </cfif>
				<cfif receiveSelected12 EQ "false" and vobEntered12 EQ "true">
                	<cfset badList = ListAppend(badList, lsiTrueVar)>
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="oesi_receive_select">
                <cfelseif receiveSelected12 EQ "true" and vobEntered12 EQ "true">
                	<cfif Evaluate("responseStruct.receive_property_tax_amount") LT 0 OR Evaluate("responseStruct.receive_property_tax_amount") GT 9999>
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
						<cfif isDefined("arguments.subset_id")>
							<cfif arguments.subset_id eq 61>
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
                    	<cfif isdefined(arguments.subset_id)>
							<cf_validateZip zipcode="#lsiVal#" subset_id="#arguments.subset_id#">
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
							<cfif IsDefined("responseStruct.#specifyDay#") and IsDefined("responseStruct.#specifyYear#")>
								<cfset lsiDay = Evaluate("responseStruct.#specifyDay#")>
								<cfset lsiYear = Evaluate("responseStruct.#specifyYear#")>
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
							<cfif IsDefined("responseStruct.#specifyMonth#") and IsDefined("responseStruct.#specifyYear#")>
								<cfset lsiMonth = Evaluate("responseStruct.#specifyMonth#")>
								<cfset lsiYear = Evaluate("responseStruct.#specifyYear#")>
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
							<cfif lsiVal eq specifyValue and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="esi_home_drilldown">
							<cfif IsDefined("responseStruct.esi_housingtype") >
								<cfset lsiHousingType = Evaluate("responseStruct.esi_housingtype")>
								<cfif lsiHousingType eq 'esi_housingtype_rent'>
									<cfif isDefined("responseStruct.esi_rent")>
										<cfset lsiRent = Evaluate("responseStruct.esi_rent")>
										<cfif lsiRent eq "">
											<cfset badList = ListAppend(badList, lsiTrueVar)>
											<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
										</cfif>
									<cfelse>
										<cfset badList = ListAppend(badList, lsiTrueVar)>
										<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="esi_home_drilldown">
									</cfif>
								<cfelseif lsiHousingType eq 'esi_housingtype_own'>
									<!---cfset lsiEstimatedvalue = Evaluate("responseStruct.esi_estimatedvalue")--->
									<cfset lsiTotaldebthouse = Evaluate("responseStruct.esi_totaldebthouse")>
									<cfset lsiHousingsituation = "">
									<cfif IsDefined("responseStruct.esi_housingsituation") >
										<cfset lsiHousingsituation = Evaluate("responseStruct.esi_housingsituation")>
									</cfif>
									<cfset lsiHomeinsurance = "">
									<cfif IsDefined("responseStruct.esi_homeinsurance") >
										<cfset lsiHomeinsurance = Evaluate("responseStruct.esi_homeinsurance")>
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
							<cfif lsiVal neq "" AND lsiVal NEQ "n" and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
			</cfcase>
                        <cfcase value="specifyHO2first">
			    <cfset specifyAF1 = ListGetAt(validationformula, 3, ':')><!---- H2 Age ---->
                            <cfset specifyAF2 = ListGetAt(validationformula, 4, ':')><!---- H3 Age ---->
			    <cfif lsiVal gte 1 and value lte 999>
                            	<cfif (NOT isDefined("responseStruct.#specifyAF1#") OR Evaluate("responseStruct.#specifyAF1#") eq '') AND (isDefined("responseStruct.#specifyAF2#") AND Evaluate("responseStruct.#specifyAF2#") neq '')>
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
                            
			    <cfif IsDefined("responseStruct.fit_homeowner_2") AND Evaluate("responseStruct.fit_homeowner_2") Neq '' AND IsDefined("responseStruct.fit_homeowner_3") AND Evaluate("responseStruct.fit_homeowner_3") Neq ''>
                            	<cfif (not IsDefined("responseStruct.#specifyAF1#") OR Evaluate("responseStruct.#specifyAF1#") eq '' or Evaluate("responseStruct.#specifyAF1#") eq 'n') AND (not IsDefined("responseStruct.#specifyAF2#") OR Evaluate("responseStruct.#specifyAF2#") eq '' or Evaluate("responseStruct.#specifyAF2#") eq 'n')>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner_age">
                                	
								<cfelseif not IsDefined("responseStruct.#specifyAF1#") OR Evaluate("responseStruct.#specifyAF1#") eq '' or Evaluate("responseStruct.#specifyAF1#") eq 'n'>
                                	<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
                                	
								<cfelseif not IsDefined("responseStruct.#specifyAF2#") OR Evaluate("responseStruct.#specifyAF2#") eq '' or Evaluate("responseStruct.#specifyAF2#") eq 'n'>
                            		<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner3_age">
                                    
                                </cfif>
                            <cfelseif IsDefined("responseStruct.fit_homeowner_2") AND Evaluate("responseStruct.fit_homeowner_2") Neq '' AND (NOT IsDefined("responseStruct.fit_homeowner_3") OR Evaluate("responseStruct.fit_homeowner_3") eq '')>
				<!---- if H2 health is not defined or blank or eq n ---->
                            	<cfif not IsDefined("responseStruct.#specifyAF1#") or Evaluate("responseStruct.#specifyAF1#") eq '' or Evaluate("responseStruct.#specifyAF1#") eq 'n'>
					<cfset badList = ListAppend(badList, lsiTrueVar)>
					<!---- throw fit_homeowner2_age validation ---->
					<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner2_age">
                            	</cfif>
			    <cfelseif IsDefined("responseStruct.fit_homeowner_3") AND Evaluate("responseStruct.fit_homeowner_3") Neq '' AND (NOT IsDefined("responseStruct.fit_homeowner_2") OR Evaluate("responseStruct.fit_homeowner_2") eq '')>
								<cfif not IsDefined("responseStruct.#specifyAF2#") or Evaluate("responseStruct.#specifyAF2#") eq '' or Evaluate("responseStruct.#specifyAF2#") eq 'n'>
									<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_homeowner3_age">
                                				<cfelseif not IsDefined("responseStruct.#specifyAF1#") or Evaluate("responseStruct.#specifyAF1#") eq '' or Evaluate("responseStruct.#specifyAF1#") eq 'n'>
                                					<cfset badList = ListAppend(badList, lsiTrueVar)>
									<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="fit_function_homeowner3_no2">
                            		
                                </cfif>
                            </cfif>
                        </cfcase>
                        <cfcase value="fit_specifymulti">
                            <cfset specifyValue = ListGetAt(validationformula, 3, ':')>
                            
                            <cfif lsiVal EQ specifyValue AND (NOT IsDefined("responseStruct.fit_mortgage_use_annuity") OR Evaluate("responseStruct.fit_mortgage_use_annuity") eq '') AND (NOT IsDefined("responseStruct.fit_mortgage_use_ltcare_ins") OR Evaluate("responseStruct.fit_mortgage_use_ltcare_ins") eq '') AND (NOT IsDefined("responseStruct.fit_mortgage_use_invest") OR Evaluate("responseStruct.fit_mortgage_use_invest") eq '') AND (NOT IsDefined("responseStruct.fit_mortgage_use_other") OR Evaluate("responseStruct.fit_mortgage_use_other") eq '')>
                                
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
                        </cfcase>
                        <cfcase value="fit_married_partner_check">
                            <!----<cfset specifyValue = ListGetAt(validationformula, 3, ':')>---->
                            <cfif lsiVal CONTAINS "fit_married_partner" AND ((NOT isDefined("responseStruct.fit_married_partner") OR Evaluate("responseStruct.fit_married_partner") eq '') OR (NOT isDefined("responseStruct.fit_married_partner_ins") OR Evaluate("responseStruct.fit_married_partner_ins") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "widowed" AND ((NOT IsDefined("responseStruct.fit_past12_widowed") OR Evaluate("responseStruct.fit_past12_widowed") eq '') OR (NOT IsDefined("responseStruct.live_alone_widowed") OR Evaluate("responseStruct.live_alone_widowed") eq '') OR (NOT IsDefined("responseStruct.fit_homeowner_gender_widowed") OR Evaluate("responseStruct.fit_homeowner_gender_widowed") eq ''))>
                                <!----<cfabort>---->
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "fit_div_sep" AND ((NOT IsDefined("responseStruct.fit_past12_fit_div_sep") OR Evaluate("responseStruct.fit_past12_fit_div_sep") eq '') OR (NOT IsDefined("responseStruct.live_alone_fit_div_sep") OR Evaluate("responseStruct.live_alone_fit_div_sep") eq '') OR (NOT IsDefined("responseStruct.fit_homeowner_gender_fit_div_sep") OR Evaluate("responseStruct.fit_homeowner_gender_fit_div_sep") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
                            <cfelseif lsiVal CONTAINS "single" AND ((NOT IsDefined("responseStruct.fit_homeowner_gender_single") OR Evaluate("responseStruct.fit_homeowner_gender_single") eq '') OR (NOT IsDefined("responseStruct.live_alone_single") OR Evaluate("responseStruct.live_alone_single") eq ''))>
                            	<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
                        </cfcase>
						<cfcase value="specifyor">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 4, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 5, ':')>
							<cfif (lsiVal eq specifyValue or (IsDefined("responseStruct.#specifyAF2#") and Evaluate("responseStruct.#specifyAF2#") eq specifyValue)) and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
                                
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyother">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset lastOpt = StructFind(afsort, ListGetAt(ListSort(StructKeyList(afsort), 'numeric', 'desc'), 1))>
                            <cfset myOPT = application.OptionPool.getOption(lastOpt)>
                            <cfset lastoptobjID = myOPT.id>
							<cfif lsiVal eq "#lastoptobjID#-#lastOpt#" and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyx2">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 4, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 5, ':')>
							<cfif lsiVal eq specifyValue and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '' or not IsDefined("responseStruct.#specifyAF2#") or Evaluate("responseStruct.#specifyAF2#") eq '')>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="specifyx2x2">
							<cfset specifyAF = ListGetAt(validationformula, 3, ':')>
							<cfset specifyValue = ListGetAt(validationformula, 4, ':')>
							<cfset specifyAF2 = ListGetAt(validationformula, 5, ':')>
							<cfset specifyValue2 = ListGetAt(validationformula, 6, ':')>
							<cfif (lsiVal eq specifyValue and (not IsDefined("responseStruct.#specifyAF#") or Evaluate("responseStruct.#specifyAF#") eq '')) or (lsiVal eq specifyValue2 and (not IsDefined("responseStruct.#specifyAF2#") or Evaluate("responseStruct.#specifyAF2#") eq ''))>
								<cfset badList = ListAppend(badList, lsiTrueVar)>
								<cf_handleScreeningAnswerfield action="set" code="#lsiTrueVar#" group="valid" error="#afvalid#">
							</cfif>
						</cfcase>
						<cfcase value="zipmatch">
							<cfset zipmatchState = ListGetAt(validationformula, 3, ':')>
							<cf_handleScreeningAnswerfield action="get" code="#zipmatchState#" element="val" var="zipmatchState">
							<cfif zipmatchState neq ''>
                            					<cfif isdefined(arguments.subset_id)>
									<cf_validateZip zipcode="#lsiVal#" subset_id="#arguments.subset_id#" state_id="#zipmatchState#">
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
                	<cfset StructDelete(responsedata.a, rxobj.code)>
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
					<cfset StructDelete(responsedata.a, x)>
					<cfset StructDelete(session, x)>
                <cfelse>
				</cfif>
                
			</cf_loopPoolStruct> ---->
			<cfset request.selectedDrugs = lsiVal>
			<cfif lsiVal neq '' and lsiVal neq 'null'>
				<cfloop index="drugID" list="#lsiVal#">
					<cfinvoke  component="util" method="logScreeningInputDetail" > 
						<cfinvokeargument name="screening_id" value="#arguments.screening_id#"/>
						<cfinvokeargument name="pgno" value="#lsiPgNo#"/> 
  						<cfinvokeargument name="response_type" value="c"/> 
  						<cfinvokeargument name="response_var" value="#drugID#"/>
  						<cfinvokeargument name="response"  value="Y"/>
 						<cfinvokeargument name="timestamp"  value="#lsiDateTime#"/>
						<cfinvokeargument name="prepopulateWithInput"  value="#attributes.prepopulateWithInput#"/>
                                         </cfinvoke>
					<cfset "request.#drugID#" = 'Y'>
				</cfloop>
			</cfif>
		<cfelseif lsiType eq 'i'>
			<cfset lsiDeriveIncome = True>
		<cfelseif lsiType eq 'a'>
			<cfset lsiDeriveAssets = True>
		<cfelse>
			<cfif lsiFlag eq 'a'>
				<cfinvoke  component="util" method="logScreeningInputDetail" > 
						<cfinvokeargument name="screening_id" value="#arguments.screening_id#"/>
						<cfinvokeargument name="pgno" value="#lsiPgNo#"/> 
  						<cfinvokeargument name="response_type" value="#lsiType#"/> 
  						<cfinvokeargument name="response_var" value="#lsiTrueVar#"/>
  						<cfinvokeargument name="response"  value="#lsiVal#"/>
 						<cfinvokeargument name="timestamp"  value="#lsiDateTime#"/>
						<cfinvokeargument name="approximation_flag"  value="1"/>
						<cfinvokeargument name="prepopulateWithInput"  value="#attributes.prepopulateWithInput#"/>
                                         </cfinvoke>
				<cfset lsiIncAssApprox = 1>
			<cfelse>
				<cfinvoke  component="util" method="logScreeningInputDetail" > 
						<cfinvokeargument name="screening_id" value="#arguments.screening_id#"/> 
						<cfinvokeargument name="pgno" value="#lsiPgNo#"/> 
  						<cfinvokeargument name="response_type" value="#lsiType#"/> 
  						<cfinvokeargument name="response_var" value="#lsiTrueVar#"/>
  						<cfinvokeargument name="response"  value="#lsiVal#"/>
 						<cfinvokeargument name="timestamp"  value="#lsiDateTime#"/>
						<cfinvokeargument name="encryption_flag"  value="#lsiEncryptionFlag#"/>
						<cfinvokeargument name="prepopulateWithInput"  value="#attributes.prepopulateWithInput#"/>
                                         </cfinvoke>
			</cfif>
		</cfif>
	</cfif>
	<cfcatch><cfif arguments.debug><cfoutput><br>Item: #itemID# lsiType: #lsiType# lsiVar: #lsiVar#<br></cfoutput></cfif></cfcatch></cftry>
</cfloop>
<cfset lsiDeriveList =  lsiDeriveList & "mqc_birth_month,mqc_birth_year">
<cfset request.lsiDeriveList = lsiDeriveList >
<!--- Derive DOB answerfield from DOB_MONTH and DOB_YEAR --->
<cfif ListFind(lsiDeriveList, 'mqc_birth_month') or ListFind(lsiDeriveList, 'mqc_birth_year')>
	<cf_handleScreeningAnswerfield action="get" code="mqc_birth_month" element="val" var="lsiMonth">
	<cf_handleScreeningAnswerfield action="get" code="mqc_birth_year" element="val" var="lsiYear">
	<cfif lsiMonth eq ''>
		<cfset lsiMonth = 1>
	</cfif>
	<cfif lsiYear neq ''>
		<cfset lsiMakeDOB = DateFormat(lsiMonth & "/01/" & lsiYear, 'mm/dd/yyyy')>
		<cfset lsiAnswer = Abs(DateDiff("yyyy", DateFormat(NOW(), "mm/dd/yyyy"), lsiMakeDOB))>
		<cfset request.dob = lsiAnswer>
		<cfinvoke  component="util" method="logScreeningInputDetail" > 
						<cfinvokeargument name="screening_id" value="#arguments.screening_id#"/> 
						<cfinvokeargument name="pgno" value="#lsiPgNo#"/> 
  						<cfinvokeargument name="response_type" value="n"/> 
  						<cfinvokeargument name="response_var" value="dob"/>
  						<cfinvokeargument name="response"  value="#lsiAnswer#"/>
 						<cfinvokeargument name="timestamp"  value="#lsiDateTime#"/>
						<cfinvokeargument name="derived_flag"  value="1"/>
						<cfinvokeargument name="prepopulateWithInput"  value="#attributes.prepopulateWithInput#"/>
                                         </cfinvoke>
	<cfelse>
		<cfset session.dob = 0>
	</cfif>
</cfif>
<cfset responsedata.badResponseList = badList>
</cfif>
	<cfif badList eq ''>
		<cfset responsedata.pgno = lsiPgNo + 1>
	</cfif>


	<cfif arguments.debug><cfdump var="#responsedata#"></cfif>
	<cfreturn responsedata >
  </cffunction>


  <cffunction name="logScreeningInputDetail" access="public"  output="true" returntype="void"  hint="process answerfields to db " >
   <cfargument name="screening_id" type="numeric"  required="yes">
   <cfargument name="pgno" type="numeric" default="0" required="yes">
   <cfargument name="response_type" type="string" default="" required="yes">
   <cfargument name="response_var" type="string" default="" required="yes">
   <cfargument name="response" type="any" default="" required="yes">
   <cfargument name="timestamp" type="numeric" default="0">
   <cfargument name="prepopulateWithInput" type="boolean" default="false" required="no">
   <cfargument name="composite_id" type="string" default="" required="no">
   <cfargument name="debug" type="boolean" default="false" required="no">
   <cfargument name="retained_flag" type="any" default="NULL" required="no">
   <cfargument name="derived_flag" type="any" default="NULL" required="no">
   <cfargument name="approximation_flag" type="any" default="NULL" required="no">
   <cfargument name="encryption_flag" type="any" default="NULL" required="no">

<cfif arguments.debug><cfoutput><br>response_type: #arguments.response_type# response_var #arguments.response_var#  response #arguments.response# composite_id #arguments.composite_id#</br></cfoutput></cfif>
<cfif arguments.response_var eq 'no_hh_members'>
	<cfif isdefined('request.marital_stat') and request.marital_stat eq 'married'>
		<cfif arguments.response lt 2>
			<cfset arguments.response = 2 >
		</cfif>
	<cfelseif isdefined('request.marital_stat') and request.marital_stat neq 'married'>
		<!--- 01/12/2010 MH - Set no_hh_members to default to 1 if single and no_hh_members doesn't have a value --->
		<cfif arguments.response lt 1>
			<cfset arguments.response = 1 >
		</cfif>
	</cfif>
<cfelseif arguments.response_var eq 'hh_depend'>
	<cfif isdefined('request.marital_stat') and request.marital_stat eq 'married'>
		<cfif arguments.response lt 2>
			<cfset arguments.response = 2 >
		</cfif>
	<cfelseif isdefined('request.marital_stat') and request.marital_stat neq 'married'>
		<!--- 01/12/2010 MH - Set no_hh_members to default to 1 if single and hh_depend doesn't have a value --->
		<cfif arguments.response lt 1>
			<cfset arguments.response = 1 >
		</cfif>
	</cfif>
</cfif>
<cfif arguments.composite_id Eq ''>
	<cfset lsidType = arguments.response_type>
	<cfset lsidVar = arguments.response_var>
<cfelse>
	<cfset lsidType = ListGetAt(arguments.composite_id, 1, '-')>
	<cfset lsidVar = ListGetAt(arguments.composite_id, 2, '-')>
</cfif>
<cfset lsidVal = arguments.response>
<cfif lsidVal eq 0>
	<cfset arguments.approximation_flag = 'NULL'>
</cfif>
<cfif arguments.timestamp Eq ''>
	<cfset lsidTimestamp = CreateODBCDateTime(Now())>
<cfelse>
	<cfset lsidTimestamp = arguments.timestamp>
</cfif>
<cfif lsidType eq 'n'>
	<cfset lsidVal = Replace(lsidVal, ',', '', 'ALL')>
</cfif>

<cfset lsidResponse = 'NULL'>
<cfset lsidOptionID = 'NULL'>

<cfif lsidVal Neq ''>
	<cfif lsidType eq 'n' or lsidType eq 'i' or lsidType eq 'a'>
		<cfset lsidResponseType = 1>
		<cfif IsNumeric(lsidVal)>
			<cfloop condition="Len(lsidVal) gt 1 And Left(lsidVal, 1) eq '0'">
				<cfset lsidVal = Right(lsidVal, Len(lsidVal) - 1)>
			</cfloop>
			<cfset lsidResponse = lsidVal>
		</cfif>
		<cfset lsidStore = lsidVal>
	<cfelseif lsidType eq 's'>
		<cfset lsidResponseType = 2>
		<cfset lsidResponse = Left(lsidVal, 64)>
		<cfset lsidStore = lsidVal>
	<cfelseif lsidType eq 'y' Or lsidType eq 'c'>
		<cfset lsidResponseType = 3>
		<cfif lsidVal eq 'y' OR lsidVal eq 'Y'>
			<cfset lsidOptionID = 1>
		<cfelseif lsidVal eq 'notsure'> <!-- the rare NOT SURE case -->
			<cfset lsidOptionID = 1462>
		<cfelseif lsidVal eq 'dontknow'> <!-- the rare I DON'T KNOW case -->
			<cfset lsidOptionID = 1474>
       	<cfelseif lsidVal eq 'unsure'>
			<cfset lsidOptionID = 1462>
		<cfelse>
			<cfset lsidOptionID = 0>
		</cfif>
		<cfset lsidStore = lsidOptionID>
	<cfelseif lsidType eq 'g'>
		<cfset lsidResponseType = 3>
		<cfif lsidVal eq 'm' OR lsidVal eq 'M'>
			<cfset lsidOptionID = 2>
		<cfelse>
			<cfset lsidOptionID = 3>
		</cfif>
		<cfset lsidStore = lsidOptionID>
	<cfelseif lsidType eq 'o'>
		<cfset lsidResponseType = 3>
		<cfset lsidOptionID = ListGetAt(lsidVal, 1, '-')>
		<cfset lsidStore = lsidOptionID>
	</cfif>
<cfelse>
	<cfif lsidType eq 'n' or lsidType eq 'i' or lsidType eq 'a'>
		<cfset lsidResponseType = 1>
	<cfelseif lsidType eq 's'>
		<cfset lsidResponseType = 2>
	<cfelse>
		<cfset lsidResponseType = 3>
	</cfif>
	<cfset lsidStore = ''>
</cfif>
<cfset ansObj = application.answerfieldPool.getAnswerfield(lsidVar)>
<cfif ansObj.exists>
	<cfset varExists = true>
	<cfset id = ansObj.id>
<cfelse>
	<cfset varExists = false>
</cfif>

<cfif varExists>
		<cfquery name="delScreeningAnswerfield" datasource="#application.dbSrc#">
			DELETE FROM screening_answerfield
			WHERE screening_id=#arguments.screening_id#
				AND answerfield_id=#id#
		</cfquery>
	<cfset responseToSave = lsidResponse>
	<cfset encryptedResponseToSave = 'NULL'>
	<cfif lsidResponse neq 'NULL'>
		<cfif arguments.encryption_flag eq 1>
			<cf_encodeString text="#lsidResponse#" var="responseToSave">
		</cfif>
		<cfset responseToSave = "'" & Replace(responseToSave, "'", "''", 'ALL') & "'">
		<cfif arguments.encryption_flag eq 1>
			<cfset encryptedResponseToSave = responseToSave>
			<cfset responseToSave = 'NULL'>
		</cfif>
	</cfif>
	<cfquery name="logAnswerfield" datasource="#application.dbSrc#">
		INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#arguments.screening_id#, #id#, #lsidResponseType#,
			 #PreserveSingleQuotes(responseToSave)#, #lsidOptionID#, #arguments.pgno#, 
			 #arguments.retained_flag#,#arguments.derived_flag#,#arguments.approximation_flag#, #arguments.encryption_flag#,
			 #PreserveSingleQuotes(encryptedResponseToSave)#, #lsidTimestamp#)
	</cfquery>
	<cfif arguments.debug><cfoutput>INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#arguments.screening_id#, #id#, #lsidResponseType#,
			 #PreserveSingleQuotes(responseToSave)#, #lsidOptionID#, #arguments.pgno#, 
			 #arguments.retained_flag#,#arguments.derived_flag#,#arguments.approximation_flag#, #arguments.encryption_flag#,
			 #PreserveSingleQuotes(encryptedResponseToSave)#, #lsidTimestamp#)</cfoutput>..<br>
	</cfif>
  </cfif>
  <cfif arguments.derived_flag neq '1' and ListFind('dob_month,dob_year,sp_dob_month,sp_dob_year,ct_mrtl_stus,ct_clnt_mail_addr_st_grt,be_clnt_mail_addr_zip5,ct_ss_disblty_xnd,be_clnt_under_age_xnd,be_noncl_under_age_xnd,be_res_bank_acc_amt,be_res_invst_amt,be_res_csh_amt,be_clnt_ss_benefits_amt,be_clnt_rr_incm_amt,be_clnt_va_benefits_amt,be_clnt_pens_annuit_amt,be_clnt_oth_incm_amt,be_noncl_ss_benefits_amt,be_noncl_rr_incm_amt,be_noncl_va_benefits_amt,be_noncl_pens_annuit_amt,be_noncl_oth_incm_amt,be_clnt_earn_wgs_xnd,be_clnt_earn_wgs_amt,be_clnt_earn_loss_xnd,be_clnt_earn_amt,be_clnt_stop_wrk_xnd,be_noncl_earn_wgs_xnd,be_noncl_earn_wgs_amt,be_noncl_earn_loss_xnd,be_noncl_earn_amt,be_noncl_stop_wrk_xnd,zip,skipinc,skipassets,ct_live,be_clnt_fnm,be_noncl_fnm,be_thrd_fnm,be_clnt_dob_day,be_clnt_dob_month,be_clnt_dob_year,be_noncl_dob_day,be_noncl_dob_month,be_noncl_dob_year,chip', lsidVar)>
	<cfset request.lsiDeriveList = ListAppend(request.lsiDeriveList, lsidVar)>
  </cfif>

 </cffunction>	

 <cffunction name="getAFListVar" access="public"  output="false" returntype="string"  hint="return type of af list var for data storage" >
  <cfargument name="answerfield" type="string" required="yes">

<cfquery name="aspvar" datasource="#application.dbSrc#">	
select 
a.answerfield, at.code
from answerfield a inner join answerfieldtype at
on a.answerfieldtype_id=at.answerfieldtype_id			
left outer join rule r
on a.rule_id=r.rule_id
left outer join validation v				
on a.validation_id=v.validation_id			
left outer join answerfield_option ao				
on a.answerfield_id=ao.answerfield_id			
left outer join `option` o				
on ao.option_id=o.option_id	
where a.answerfield like '#arguments.answerfield#'	
order by a.answerfield, ao.sort	
</cfquery>

<cfset listvar = "">

<cfif aspvar.code eq "checkbox">
	<cfset listvar = "c-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "select">
	<cfset listvar = "o-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "text">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "currency">
	<cfif aspvar.answerfield contains 'asset'>
		<cfset aftype = 'a-'>
	<cfelseif  aspvar.answerfield contains 'income'>
		<cfset aftype = 'i-'>
	<cfelse >
		<cfset aftype = 'n-'>
	</cfif>
	<cfset listvar = "#aftype#" & aspvar.answerfield > 
<cfelseif aspvar.code eq "zipcode">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "yn">
	<cfset listvar = "y-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "integer">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "state">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "drug">
	<cfset listvar = "d-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "ssn">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "income">
	<cfset listvar = "i-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "asset">
	<cfset listvar = "a-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "city">
	<cfset listvar = "a-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "no">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "year">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "month">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "day">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "gender">
	<cfset listvar = "g-" & aspvar.answerfield > 
<cfelse >
	<cfset listvar = "s-" & aspvar.answerfield > 
</cfif>

	<cfreturn listvar >

 </cffunction>
	<cffunction name="getStateCountyFromZip" access="public"  output="false" returntype="query"  hint="returns a valid state,county, lat,lon if exists for a zipcode" >
		<cfargument name="zipcode" type="numeric" required="yes" >
		<cfquery name="getStateCountyData" datasource="#application.dbSrc#">
			select c.county_id, c.county_name, z.state_id, z.latitude, z.longitude
			from zip z, county c
			where z.zipcode='#zipcode#'
				and z.valid=1
				and z.county_id=c.county_id
		</cfquery>
		<cfreturn getStateCountyData>
	</cffunction>
 	    <cffunction   access="public" name="processAonContact" output="false" returntype="void"  hint="process content rules" >
			<cfset test = 1>
            </cffunction>
		
	    <cffunction access="remote" name="getStateDetails" output="false" returntype="query"  hint="Get State Name by state or zip"  >
        <!-- pass arguments -->
        <cfargument name="state_zip" type="string" required="yes" default="" >
        <cfset queryState = QueryNew("statetype_id,statetype_name,state_id,statetype_id,state_name,state_map_code,state_map_code2")>
        <cfset state_id = state_zip>
<!--- check state and zip data --->
        <cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfquery name="queryState" datasource="#application.dbSrc#">
SELECT
statetype.statetype_id,
statetype.statetype_name,
state.state_id,
state.statetype_id,
state.state_name,
state.state_map_code,
state.state_map_code2
FROM
statetype
INNER JOIN state ON state.statetype_id = statetype.statetype_id
WHERE state.state_id = '#state_id#'
and statetype.statetype_id = 1
		</cfquery>
        <cfreturn  queryState>
    </cffunction>
</cfcomponent>
