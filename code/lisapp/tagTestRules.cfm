
<cfparam name="attributes.ynDoBuffer" type="boolean" default="false">
<cfparam name="attributes.debugOutput" type="boolean" default="false">
<!---=================================================================================
This next section of code pulls all the rules for the programs that are availible within
the clients state.  it will then loop those rules through the evaluation code.  first checking
to see if the rule calls one of the hard coded tags,  and then evaluating dwn to a boolean,
adding the anser on to the end of the test string.  It will loop through the evaluation 
through each change of the program ID   then will check the test string for the prg ID to 
see if there was a false(no) result for the program.  if all rules returned true(YES) then 
that program ID will be added to tmp_prg_list and session.prg_list which will at the end of the 
process be a complete list of the programs for which the client is eligible.
=================================================================================--->


<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagGetIncomeTables<br /><br /></cfoutput></cfif>
<cfinclude template="tagGetIncomeTables.cfm">
<cfset showOutput = attributes.debugOutput>
<cfset showMoreOutput = attributes.debugOutput>
<cfset testPrograms = "">
<!--- set initial values of blank --->
<cfset tmp_prg_list = ''>
<cfset oldid = ''>
<cfset test = ''>
<cfset loopindex = 0>
<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting cacheSubsetProgramPool<br /><br /></cfoutput><cfdump var="#testPrograms#"></cfif>
<!---cf_cacheSubsetProgramPool action="get" state_id="#session.st#" subset_id="#session.subset_id#" var="testPrograms" --->
<cfquery name="querySubsetProgram" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(100,0,0,0)#">
            select p.program_id, p.program_code
		from subset_program_sum sp, program p
		where sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.subset_id#" maxlength="4">
			and sp.program_id=p.program_id
			and p.active_flag=1
			and (p.state_id is null or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.st#" maxlength="2">)
		order by p.sort
		
        </cfquery>
<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting loopPoolStruct struct="testPrograms"<br /><br /><cfdump var="#querySubsetProgram#"></cfoutput></cfif>
<cfloop query="querySubsetProgram" >
	<cfset loopindex = loopindex + 1>
	<cfif attributes.debugOutput>
		<cfoutput>#CreateODBCDateTime(Now())#: Starting cacheProgramPool code="#program_code#" Teststring: #test#<br /></cfoutput>
		<cfoutput>|------------------------------------------------------------------------------------------------------|<br /><br /></cfoutput>
	</cfif>
	<cf_cacheProgramPool action="get" code="#program_code#" var="testProgram">
	<cfset prg_id = ''>
	<cfif isdefined('testProgram.legacy')>
		<cfset prg_id = testProgram.legacy>
	</cfif>
	<cfif prg_id eq ''>
		<cfset prg_id = "XXX-XXX-#testProgram.id#-XX-XX">
	</cfif>

		<!-- SE Moved codeblock up here from bottom of inner loop to avoid problem evaluating first helper program -->
		<cfif loopindex gt 1>
		  <cfset test1 = FINDNOCASE("no", test, 1)>
		  <cfif test neq "" and test1 EQ 0>
			<!--- if there are no false(NO) readings...then the client is eligible for 
				  that program and it needs to be added to the tmp_prg_list variable--->
			 <cfset tmp_prg_list = ListAppend(tmp_prg_list, "'#oldid#'")>
		   </cfif>
		 </cfif>
	<cfif not attributes.ynDoBuffer or ListFind(session.prg_list, "'#prg_id#'") eq 0>
		<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting loopPoolStruct struct="testProgram"<br /><br /></cfoutput></cfif>
		<cf_loopPoolStruct struct="testProgram" index="rule">
			<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting cacheRulePool code="#rule#" Teststring: #test#<br /><br /></cfoutput></cfif>

			<cf_cacheRulePool action="get" code="#rule#" var="testRule">
			<cfset strRule = Replace(testRule.text, "gteq", "gte", "ALL")>
			<cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
			<!--- any rule that calls upon an income table will replace the end bracket
			with the reference to the associated column of the income array for the 
			number of people in the household --->
			<!--- 07/09/2002 REM  Since I'm now limiting the struct_mem to a single mem value for each table (instead of pulling all 8 for each one) the XX value is now irrelevant, so we ditch it.  The old rule was: <cfset strRule = Replace(strRule, "XX[" , "#session.no_hh_members#[", "ALL")>.  The new rule is:--->
			<cfset strRule = Replace(strRule, "XX[" , "[", "ALL")>
			
			<!--- 07/09/2002 REM  MODIFIED THE BELOW CUSTOM TAGS TO PASS THE SELF AND SPOUSE VALUES AS IS DONE IN SSIINC, SO WE CAN EITHER LOOKUP THE VALUES FOR THOSE VARS FROM A TABLE OR PASS THEM HARD-CODED INTO THE RULES.   --->         
			
			<cfif FINDNOCASE("BuyInQI2asset", strRule, 1) NEQ 0>
				<cfif IsDefined('session.skipassets') and session.skipassets EQ "N">
					<cfset answer = "NO">
				<cfelse>
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeMedicareBuyInAss<br /><br /></cfoutput></cfif>
				   <cf_tagYeMedicareBuyInAss 
						rule="#strRule#" 
						ynDoBuffer="#attributes.ynDoBuffer#"
						self = "#gettoken(strRule,2,"-")#"	
						self_spouse = "#gettoken(strRule,3,"-")#">
				</cfif>
			<cfelseif FINDNOCASE("BuyInQI2inc", strRule, 1) NEQ 0>
				<cfif IsDefined('session.skipinc') and session.skipinc EQ "N">
					<cfset answer = "NO">
				<cfelse>
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeMedicareBuyInInc<br /><br /></cfoutput></cfif>
				   <cf_tagYeMedicareBuyInInc 
						rule="#strRule#" 
						ynDoBuffer="#attributes.ynDoBuffer#"
						self_high = "#gettoken(strRule,2,"-")#"	
						self_low = "#gettoken(strRule,3,"-")#"
						s_sp_high = "#gettoken(strRule,4,"-")#"
						s_sp_low = "#gettoken(strRule,5,"-")#">
				</cfif>
			<cfelseif FINDNOCASE("MXASSET", strRule, 1) NEQ 0>
				<cfset strTable = Replace(strRule,"(","","ALL")>
				<cfset strTable = Trim(ReplaceNoCase(strTable,"MXASSET)","","ALL"))>
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagGetMxAssetVals<br /><br /></cfoutput></cfif>
				<cfinclude template="tagGetMxAssetVals.cfm">
				<cfif IsDefined('session.skipassets') and session.skipassets EQ "N">
					<!--- 07/18/02 REM  If the table val is $1MM, then everyone passes --->
					<cfif getMxAssetVals.single GTE 1000000>
						<cfset answer = "YES">
					<cfelse>
						<cfset answer = "NO">
					</cfif>
				<cfelse>
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeMedicareBuyInAss<br /><br /></cfoutput></cfif>
					<cf_tagYeMedicareBuyInAss 
						rule="#strRule#" 
						ynDoBuffer="#attributes.ynDoBuffer#"
						self = "#getMxAssetVals.single#"	
						self_spouse = "#getMxAssetVals.couple#">
				</cfif>
			<cfelseif FINDNOCASE("MXINCOME", strRule, 1) NEQ 0>
				<cfif IsDefined('session.skipinc') and session.skipinc EQ "N">
					<cfset answer = "NO">
				<cfelse>
					<cfset strTable = Replace(strRule,"(","","ALL")>
					<cfset strTable = Trim(ReplaceNoCase(strTable,"MXINCOME)","","ALL"))>
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagGetMxIncVals<br /><br /></cfoutput></cfif>
					<cfinclude template="tagGetMxIncVals.cfm">
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeMedicareBuyInInc<br /><br /></cfoutput></cfif>
				   <cf_tagYeMedicareBuyInInc 
						rule="#strRule#" 
						ynDoBuffer="#attributes.ynDoBuffer#"
						self_high = "#getMxIncVals.single_max#"	
						self_low = "#getMxIncVals.single_min#"
						s_sp_high = "#getMxIncVals.couple_max#"
						s_sp_low = "#getMxIncVals.couple_min#">
				</cfif>
			<cfelseif FINDNOCASE("childstatessiinc", strRule, 1) NEQ 0>
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeChildSSIInc checkState="true"<br /><br /></cfoutput></cfif>
			   <cf_tagYeChildSSIInc ynDoBuffer="#attributes.ynDoBuffer#" checkState="true">
			<cfelseif FINDNOCASE("childssiinc", strRule, 1) NEQ 0>
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeChildSSIInc<br /><br /></cfoutput></cfif>
			   <cf_tagYeChildSSIInc ynDoBuffer="#attributes.ynDoBuffer#">
			<cfelseif FINDNOCASE("ssiinc", strRule, 1) NEQ 0>
				<cfif IsDefined('session.skipinc') and session.skipinc EQ "N">
					<cfset answer = "NO">
				<cfelse>
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeSSIInc<br /><br /></cfoutput></cfif>
				   <cf_tagYeSSIInc 
						self="#gettoken(strRule,2,"-")#" 
						self_spouse="#gettoken(strRule,3,"-")#" 
						ynDoBuffer="#attributes.ynDoBuffer#">
				</cfif>
			<cfelseif FINDNOCASE("prg", strRule, 1) NEQ 0>
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYePrgFind<br /><br /></cfoutput></cfif>
			   <cf_tagYePrgFind 
					rule="#strRule#" 
					ynDoBuffer="#attributes.ynDoBuffer#">
				<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Ending tagYePrgFind<br /><br /></cfoutput></cfif>
			<cfelseif FINDNOCASE("spenddowninc", strRule, 1) NEQ 0>
				<cfif IsDefined('session.skipinc') and session.skipinc EQ "N">
					<cfset answer = "NO">
				<cfelse>
				   <cfset ynConvertStructMem = FINDNOCASE("struct_mem", strRule, 1)>
				   <!--- If 'struct_mem' is part of the Rule that is getting passed to the 
				   TagYeSpendDown --->
				   <cfif ynConvertStructMem>
					  <cfset strStructMem = getToken(strRule,3," ")>
					  <cfset valStructMem = Evaluate("#strStructMem#")> 
					  <!--- now replace the part of the passed in rule with its evaluate --->
					  <cfset strConvertedRule = ReplaceNoCase(strRule, strStructMem, valStructMem)>
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeSpendDown<br /><br /></cfoutput></cfif>
					  <cf_tagYeSpendDown 
							rule="#strConvertedRule#" 
							EvaluateRule="TRUE" 
							ynDoBuffer="#attributes.ynDoBuffer#">
				   <cfelse>
						<!--- if there is no 'struct_mem getting passed in --->                  
					<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Starting tagYeSpendDown<br /><br /></cfoutput></cfif>
					  <cf_tagYeSpendDown 
							rule="#strRule#" 
							EvaluateRule="FALSE" 
							ynDoBuffer="#attributes.ynDoBuffer#">
				   </cfif>
				</cfif>
			<cfelse>
				<cfif showOutput><cfoutput><h2>#strRule#</h2></cfoutput></cfif>
				<cfset findPos = 1>
				<cfloop condition="Find('##', strRule, findPos)">
					<cfset firstPound = Find('##', strRule, findPos)>
					<cfset secondPound = Find('##', strRule, firstPound + 1)>
					<cfif secondPound gt firstPound>
						<cfset variableName = Mid(strRule, firstPound + 1, secondPound - firstPound - 1)>
						<cfif showOutput><cfoutput><li>#variableName#: </cfoutput></cfif>
						<cfif FindNoCase('struct_mem[', variableName) eq 1 Or FindNoCase('listable[', variableName) eq 1 Or FindNoCase('childtable[', variableName) eq 1 Or IsDefined(variableName)>
							<cfset eVal = Evaluate(variableName)>
						<cfelseif FindNoCase('session.', variableName) eq 1>
							<cfset newVariableName = RemoveChars(variableName, 1, 8)>
							<cf_handleScreeningAnswerfield action="get" code="#newVariableName#" element="val" var="eVal">
						<cfelse>
							<cfset eVal = 0>
						</cfif>
						<cfif eVal eq ''>
							<cfset eVal = 0>
						</cfif>
						<cfif Not IsNumeric(eVal) Or (IsNumeric(eVal) And Len(eVal) gt 1 And Left(eVal, 1) eq '0')>
							<cfset eVal = "'#eVal#'">
						</cfif>
						<cfif showOutput><cfoutput>#eVal#</cfoutput></cfif>
						<cfset strRule = Replace(strRule, "###variableName###", eVal, 'ONE')>
					<cfelse>
						<cfset findPos = firstPound + 1>
					</cfif>
				</cfloop>
				<cfif showOutput><cfoutput><br><br>#strRule#</cfoutput></cfif>
			   <!--- 07/09/2002 REM  If we get to here, we evaluate the rule  --->
			   <!--- 2/11/02 REM Added a process to account for List Compare rules (e.g., 
			   session.county IN 'countyA, countyB, countyC').  --->
			   <!--- 03/09/2002 REM  Need an additional proc for the 'NOT IN' rules --->
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
				  <!--- 03/09/2002 REM  Need to strip the opening '(' --->
				  <!--- 10/25/2005 BShunn  Also strip apostrophes --->
				  <cfif Find("('", strItem) eq 1>
					  <cfset strItem = Mid(strItem, 3, Len(strItem) - 3)>
					<cfelse>
					 <cfset strItem = Mid(strItem, 2, Len(strItem) - 1)>
				</cfif>
				<cfif showMoreOutput><cfoutput> (#strItem#)</cfoutput></cfif>
				  <!--- 03/09/2002 REM  Need to do this to extract the compare list --->
				  <cfset strList = Trim(Right(strRule, Len(strRule) - (posFind + posLen - 1)))>
				  <cfif showMoreOutput><cfoutput> (#strList#)</cfoutput></cfif>
				  <!--- 03/09/2002 REM  Need to strip the closing ')' --->
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
				  
				  <cftry>
				  	<cfset answer=Evaluate("#strRule#")>
				  <cfcatch type="any">
				  	<cfset answer="YES">
				  </cfcatch>
				  </cftry>
				  
			   </cfif>
			   <cfif showOutput><cfoutput> = #answer#<br></cfoutput></cfif>
			</cfif>
			
			 <cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Before List  - oldid: #oldid#; prg_id: #prg_id#; test: #test#; answer: #answer#; tmp_prg_list = {#tmp_prg_list#}<br /><br /></cfoutput></cfif>

			 <!--- check to see if the prg id has changed --->
			 <cfif oldid IS "" OR oldid IS prg_id>
			   <!--- if it hasn't set the answer on to the end of the answer string --->
			   <cfset test = test & answer>
			 <cfelse>
			   <!--- if the program id has changed, then check the old string of answers for a 
			   no reading --->
			   <!--- start the new string of answers for the new prg id --->
			   <cfset test = answer>
			 </cfif>
					 
			<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: After LIST -  oldid: #oldid#; prg_id: #prg_id#; test: #test#; answer: #answer#; tmp_prg_list = {#tmp_prg_list#}<br /><br /></cfoutput></cfif>

			<!--- set the old id to the current id--->
			<cfset oldid = prg_id>
		
		</cf_loopPoolStruct>
	</cfif>
</cfloop>
   
<!--- this code is for the last program through the output,  because there is 
no change in the program id, the last one through never got evaluated....
this code picks that up --->
<cfset test1 = FINDNOCASE("no", test, 1)>
<cfif test1 EQ 0 and oldid neq ''>
	  <cfset tmp_prg_list = ListAppend(tmp_prg_list, "'#oldid#'")>
</cfif>   
<!--- 09/30/2002 REM  Insert a check here for a blank list --->
<cfif tmp_prg_list eq "''">
	<cfset tmp_prg_list = ''>
</cfif>

<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: tmp_prg_list = {#tmp_prg_list#}<br /><br /></cfoutput></cfif>

<cfif not attributes.ynDoBuffer>
  <cfset session.prg_list = tmp_prg_list>
<cfelse>
  <cfset session.buff_list = tmp_prg_list>
</cfif>

<cfif attributes.debugOutput><cfoutput>#CreateODBCDateTime(Now())#: Finishing tagTestRules<br /><br /></cfoutput></cfif>
