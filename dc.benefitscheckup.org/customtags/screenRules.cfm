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
<cfinclude template="screenIncomeTables.cfm">

<!--- 07/09/2002 REM  Here we check to see if the 'ynDoBuffer' value has been set--if so, 
we append some info onto the custom tag rules and the session var (at the end). --->
<cfif isDefined("attributes.ynDoBuffer")>
	<cfset ynDoBuffer = "#attributes.ynDoBuffer#">
<cfelse>
	<cfset ynDoBuffer = "FALSE">
</cfif>

<!--- pulls in all the rules from the table for the programs that are needed --->
<!--- 04/21/2002 REM  This join is to make sure that the rules are using the pri_sec 
value of the prog table, not the one that may have been put into the rules table, since
that one may not correct (or consistent for all of the records). --->
<!--- 09/01/2002 REM  Added in cfif for RX Only version of the check to eliminate non-RX 
programs from the analysis.  This leads to the possibility that no programs are returned,
so I added the check for ListLen for session.prg_list. --->
<!--- 09/30/2002 REM  Expanded the CFIF to prevent running the rx programs if the user doesn't pass the initial threshold test--if we're doing RX Only and the user is not RXQualified, we force a zero-rec query.  --->
<!--- 11/21/2002 BShunn / Rewrote RX query as two queries, and eliminate dependence on RXQualified variable -- RXQualified has been removed as a session variable because we've unhardcoded the RXQualified rules, i.e., made them rules in tbl_rules --->
<!--- 01/14/2003 BShunn / Re-rewrote RX query as one --->
<!--- 01/26/2003 BShunn / Re-rewrote RX query as generalized subset query --->
<!--- 05/04/2005 BShunn / Re-rewrote as super-generalized subset query;
                          find eligibility for all base programs and ancestor programs --->
<cf_populateTableFromView table="subset_program_sum" subset_id="#session.subset_id#">
<cfquery name="programstofind" datasource="#application.dbSrc#">
	SELECT p.prg_id, p.pri_sec
	FROM subset_program_sum sp, tbl_prg_all p
	WHERE sp.subset_id=#session.subset_id#
			AND sp.program_id=p.RecID
			<cfif ynDoBuffer AND ListLen(session.prg_list)>
				AND p.prg_id NOT IN (#PreserveSingleQuotes(session.prg_list)#)
			</cfif>
			AND (p.inactive_flag = 0 OR p.inactive_flag IS NULL)
			AND (p.st='#session.st#' OR p.st='FD')
	GROUP BY p.prg_id, p.pri_sec
	ORDER BY p.pri_sec, p.prg_id
</cfquery>


<!--- set initial values of blank --->
<cfset tmp_prg_list = "">
<cfset oldid = "">
<cfset test = "">

<cfloop query="programstofind">
<cfset save_the_prg_id=prg_id>
<cfset save_the_pri_sec=pri_sec>
<cfquery name="rules" datasource="#application.dbSrc#">
	SELECT elig_rule
	FROM tbl_rules
	WHERE prg_id = '#programstofind.prg_id#'
</cfquery>
<cfloop query="rules">
<cfset prg_id=save_the_prg_id>
<cfset pri_sec=save_the_pri_sec>
<!--- replacing gteq with gte    lteq with lte  --->
<cfset strRule = Replace(rules.elig_rule, "gteq", "gte", "ALL")>
<cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
<!--- any rule that calls upon an income table will replace the end bracket
with the refence to the associated column of the income array for the 
number of people in the household --->
<!--- 07/09/2002 REM  Since I'm now limiting the struct_mem to a single mem value for each table (instead of pulling all 8 for each one) the XX value is now irrelevant, so we ditch it.  The old rule was: <cfset strRule = Replace(strRule, "XX[" , "#session.no_hh_members#[", "ALL")>.  The new rule is:--->
<cfset strRule = Replace(strRule, "XX[" , "[", "ALL")>

<!--- 07/09/2002 REM  MODIFIED THE BELOW CUSTOM TAGS TO PASS THE SELF AND SPOUSE VALUES AS IS DONE IN SSIINC, SO WE CAN EITHER LOOKUP THE VALUES FOR THOSE VARS FROM A TABLE OR PASS THEM HARD-CODED INTO THE RULES.   --->         


<cfif FINDNOCASE("BuyInQI2asset", strRule, 1) NEQ 0>
	<cfif session.skipassets EQ "N">
		<cfset answer = "NO">
	<cfelse>
	   <cf_tagYeMedicareBuyInAss 
			rule="#strRule#" 
			ynDoBuffer="#ynDoBuffer#"
			self = "#gettoken(strRule,2,"-")#"	
			self_spouse = "#gettoken(strRule,3,"-")#">
	</cfif>
<cfelseif FINDNOCASE("BuyInQI2inc", strRule, 1) NEQ 0>
	<cfif session.skipinc EQ "N">
		<cfset answer = "NO">
	<cfelse>
	   <cf_tagYeMedicareBuyInInc 
			rule="#strRule#" 
			ynDoBuffer="#ynDoBuffer#"
			self_high = "#gettoken(strRule,2,"-")#"	
			self_low = "#gettoken(strRule,3,"-")#"
			s_sp_high = "#gettoken(strRule,4,"-")#"
			s_sp_low = "#gettoken(strRule,5,"-")#">
	</cfif>
<cfelseif FINDNOCASE("MXASSET", strRule, 1) NEQ 0>
	<cfset strTable = Replace(strRule,"(","","ALL")>
	<cfset strTable = Trim(ReplaceNoCase(strTable,"MXASSET)","","ALL"))>
	<cfinclude template="screenMxAssetVals.cfm">
	<cfif session.skipassets EQ "N">
		<!--- 07/18/02 REM  If the table val is $1MM, then everyone passes --->
		<cfif getMxAssetVals.single GTE 1000000>
			<cfset answer = "YES">
		<cfelse>
			<cfset answer = "NO">
		</cfif>
	<cfelse>
		<cf_tagYeMedicareBuyInAss 
			rule="#strRule#" 
			ynDoBuffer="#ynDoBuffer#"
			self = "#getMxAssetVals.single#"	
			self_spouse = "#getMxAssetVals.couple#">
	</cfif>
<cfelseif FINDNOCASE("MXINCOME", strRule, 1) NEQ 0>
	<cfif session.skipinc EQ "N">
		<cfset answer = "NO">
	<cfelse>
		<cfset strTable = Replace(strRule,"(","","ALL")>
		<cfset strTable = Trim(ReplaceNoCase(strTable,"MXINCOME)","","ALL"))>
		<cfinclude template="screenMxIncVals.cfm">
	   <cf_tagYeMedicareBuyInInc 
			rule="#strRule#" 
			ynDoBuffer="#ynDoBuffer#"
			self_high = "#getMxIncVals.single_max#"	
			self_low = "#getMxIncVals.single_min#"
			s_sp_high = "#getMxIncVals.couple_max#"
			s_sp_low = "#getMxIncVals.couple_min#">
	</cfif>
<cfelseif FINDNOCASE("ssiinc", strRule, 1) NEQ 0>
	<cfif session.skipinc EQ "N">
		<cfset answer = "NO">
	<cfelse>
	   <cf_tagYeSSIInc 
			self="#gettoken(strRule,2,"-")#" 
			self_spouse="#gettoken(strRule,3,"-")#" 
			ynDoBuffer="#ynDoBuffer#">
	</cfif>
<cfelseif FINDNOCASE("prg", strRule, 1) NEQ 0>
   <cf_tagYePrgFind 
		rule="#strRule#" 
		ynDoBuffer="#ynDoBuffer#">
<cfelseif FINDNOCASE("spenddowninc", strRule, 1) NEQ 0>
	<cfif session.skipinc EQ "N">
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
	      <cf_tagYeSpendDown 
				rule="#strConvertedRule#" 
				EvaluateRule="TRUE" 
				ynDoBuffer="#ynDoBuffer#">
	   <cfelse>
			<!--- if there is no 'struct_mem getting passed in --->                  
	      <cf_tagYeSpendDown 
				rule="#strRule#" 
				EvaluateRule="FALSE" 
				ynDoBuffer="#ynDoBuffer#">
	   </cfif>
	</cfif>
<cfelse>
   <!--- 07/09/2002 REM  If we get to here, we evaluate the rule  --->
   <!--- 2/11/02 REM Added a process to account for List Compare rules (e.g., 
   session.county IN 'countyA, countyB, countyC').  --->
   <!--- 03/09/2002 REM  Need an additional proc for the 'NOT IN' rules --->
   <cfif FindNoCase(" IN ", strRule, 1)>
      <cfset strItem=getToken(strRule, 1, " ")>
      <!--- 03/09/2002 REM  Need to strip the opening '(' --->
      <cfset strItem=Right(strItem,Len(strItem)-1)>
      <!--- 03/09/2002 REM  Need to do this to extract the compare list --->
      <cfset strList=Trim(Right(strRule, Len(strRule)-Find("IN",strRule)-2))>
      <!--- 03/09/2002 REM  Need to strip the closing ')' --->
      <cfset strList=Left(strList, Len(strList)-1)>
      <cfset temp = ListContainsNoCase(strList, Evaluate(strItem))>
      <cfif temp EQ 0>
        <cfif FindNoCase(" NOT IN ", strRule, 1)>
            <cfset answer="YES">
         <cfelse>
            <cfset answer="NO">
         </cfif>
      <cfelse>
        <cfif FindNoCase(" NOT IN ", strRule, 1)>
            <cfset answer="NO">
         <cfelse>
            <cfset answer="YES">
         </cfif>
      </cfif>
   <cfelse>
      <cfset answer=Evaluate("#strRule#")>
   </cfif>
</cfif>    

<!--- check to see if the prg id has changed --->
<cfif oldid IS "" OR oldid IS prg_id>
   <!--- if it hasn't set the answer on to the end of the answer string --->
   <cfset test = test & answer>               
<cfelse>
   <!--- if the program id has changed, then check the old string of answers for a 
   no reading --->
   <cfset test1 = FINDNOCASE("no", test, 1)>
   <cfif test1 EQ 0>
      <!--- if there are no false(NO) readings...then the client is eligible for 
      that program and it needs to be added to the tmp_prg_list variable--->
      <cfset tmp_prg_list = tmp_prg_list & "'" & oldid & "',">
   </cfif>
   <!--- start the new string of answers for the new prg id --->
   <cfset test = answer>
</cfif>
         
<!--- set the old id to the current id--->
<cfset oldid = prg_id>
</cfloop>
</cfloop>
   
<!--- this code is for the last program through the output,  because there is 
no change in the program id, the last one through never got evaluated....
this code picks that up --->
<cfset test1 = FINDNOCASE("no", test, 1)>
<cfif test1 EQ 0>
	   <cfset tmp_prg_list = tmp_prg_list & "'" & oldid & "',">
</cfif>   
<!--- trim the last comma off of the tmp_prg_list and assign it to the session var--->   
<cfif Len(tmp_prg_list)>
	<cfset tmp_prg_list = Left(tmp_prg_list, Len(tmp_prg_list)-1)>
</cfif>
<!--- 09/30/2002 REM  Insert a check here for a blank list --->
<cfif tmp_prg_list EQ "''">
	<cfset tmp_prg_list = "">
</cfif>

<cfif NOT ynDoBuffer>
  <cfset session.prg_list = tmp_prg_list>
<cfelse>
  <cfset session.buff_list = tmp_prg_list>
</cfif>
