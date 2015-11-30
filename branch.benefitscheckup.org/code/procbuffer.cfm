<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
	qualifies
CALLED BY: proc_asset.cfm
GOES TO: N/A
REQUIRED: N/A
============================================---->

<!--- set client --->
<cfif '#session.client1#' eq '#session.StrClient#' >
<cfset '#session.client1#' = '#session.StrClient#'>
</cfif>





<!--- need to of set the total figures by 500 and 100 respectively --->
<CFSET SESSION.S_asset_TOTAL_COMPLETE = SESSION.s_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.S_SP_asset_TOTAL_COMPLETE = SESSION.S_SP_asset_TOTAL_COMPLETE - 500>
<CFSET SESSION.HH_asset_TOTAL_COMPLETE = SESSION.HH_asset_TOTAL_COMPLETE - 500>

<CFSET SESSION.S_INCOME_TOTAL_COMPLETE = SESSION.s_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.S_SP_INCOME_TOTAL_COMPLETE = SESSION.S_SP_INCOME_TOTAL_COMPLETE - 100>
<CFSET SESSION.HH_INCOME_TOTAL_COMPLETE = SESSION.HH_INCOME_TOTAL_COMPLETE - 100>


<CFSET prg_list = "">
<cfset session.buff_list = ''>
<CFSET sec8table = 0>
<CFSET PHtable = 0>
<CFSET LIHEAPTABLE = 0>

<!--- pull in the income tables and make them as variables --->
<CFQUERY NAME="sec8" DATASOURCE = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='section 8' AND st='#session.st#'
</CFQUERY>
<CFOUTPUT QUERY="sec8"><CFSET sec8table = record></CFOUTPUT>

<CFQUERY NAME="PH" DATASOURCE = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='public housing' AND st='#session.st#'
</CFQUERY>
<CFOUTPUT QUERY="PH"><CFSET PHtable = record></CFOUTPUT>


<!--- pulling the figure from the income table for weatherization for the number in the household for public housing in the state of the client --->
	<CFQUERY NAME="weather" DATASOURCE = "#application.dbSrc#">
	SELECT mem#session.no_hh_members# AS record
	FROM tbl_inc_new
	WHERE tbl_nm='WEATHER' AND st='#session.st#'
	</CFQUERY>
	<!--- set the figure pulled in the query to the variable --->
	<CFOUTPUT QUERY="WEATHER"><CFSET WEATHERTABLE = record></CFOUTPUT>






<!--- pull in the income tables and make them as variables --->
<CFQUERY NAME="liheap" DATASOURCE = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS record
FROM tbl_inc_new
WHERE tbl_nm='liheap' AND st='#session.st#'
</CFQUERY>
<CFOUTPUT QUERY="liheap"><CFSET LIHEAPTable = record></CFOUTPUT>
<!--- pulling the figure from the income table for liheapASSET the number in the household for public housing in the state of the client --->
<cfquery name="lasset" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LASSET' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset LASSETTABLE = lasset.tbl>

<!--- this section queries the inc_tables in the db and puts them into an array.  then the rules
	will refference the line item in the array.....because cold fusion starts its arrays
	with line item 1 (and not zero) the index of the array will match the RecID in the table. --->


<!--- <CFQUERY NAME = "build_income_array" DATASOURCE = "#application.dbSrc#">
	SELECT mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8
	FROM tbl_inc_new
</CFQUERY>
<!--- Now we want to put the query into an session array, so we dont have to re-query the DB --->
<!--- Declare the array --->
<CFSET Session.Incometable = ArrayNew(2)>
<!--- Populate the array row by row --->
<CFLOOP QUERY = "build_income_array">
   <CFSET Session.Incometable[CurrentRow][1] = build_income_array.mem1[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][2] = build_income_array.mem2[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][3] = build_income_array.mem3[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][4] = build_income_array.mem4[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][5] = build_income_array.mem5[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][6] = build_income_array.mem6[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][7] = build_income_array.mem7[CurrentRow]>
   <CFSET Session.Incometable[CurrentRow][8] = build_income_array.mem8[CurrentRow]>
</CFLOOP> --->

<!--- NOTE: following chunk of code copied from dev's  proceligibility.cfm by Andrew on 12/26/01 --->
		<CFQUERY NAME = "build_income_array" DATASOURCE = "#application.dbSrc#">
	SELECT mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8, proc_id
	FROM tbl_inc_new
	ORDER BY proc_id
	</CFQUERY>

	<cfset struct_mem1 = structNew()>
		<cfset struct_mem2 = structNew()>
			<cfset struct_mem3 = structNew()>
				<cfset struct_mem4 = structNew()>
					<cfset struct_mem5 = structNew()>
						<cfset struct_mem6 = structNew()>
							<cfset struct_mem7 = structNew()>
								<cfset struct_mem8 = structNew()>
	
	
	<!--- loop through query results and place each row of data in a structure, one structure for each column --->
	<CFLOOP QUERY = "build_income_array">
	<cfset Result = StructInsert(struct_mem1, #proc_id#, #mem1#, "true")>
			<cfset Result = StructInsert(struct_mem2, #proc_id#, #mem2#, "true")>
					<cfset Result = StructInsert(struct_mem3, #proc_id#, #mem3#, "true")>
							<cfset Result = StructInsert(struct_mem4, #proc_id#, #mem4#, "true")>
							<cfset Result = StructInsert(struct_mem5, #proc_id#, #mem5#, "true")>
					<cfset Result = StructInsert(struct_mem6, #proc_id#, #mem6#, "true")>
			<cfset Result = StructInsert(struct_mem7, #proc_id#, #mem7#, "true")>
	<cfset Result = StructInsert(struct_mem8, #proc_id#, #mem8#, "true")>
	
	</CFLOOP >


<!--- pulls in all the rules from the table for the programs that are needed --->
<!--- 04/21/2002 REM  This join is to make sure that the rules are using the pri_sec 
value of the prog table, not the one that may have been put into the rules table, since
that one may not correct (or consistent for all of the records). --->
<cfquery name="rules" datasource="#application.dbSrc#">
	SELECT r.prg_id, r.elig_rule, p.pri_sec
	FROM tbl_rules r, tbl_prg_all p
	WHERE r.prg_id = p.prg_id
		AND r.prg_id in (
			select p.prg_id
			from tbl_prg_all p, program_answerfield pa
			where (p.st='#session.st#' OR p.st='FD')
				and p.RecID=pa.program_id
			group by p.prg_id
		)
	ORDER BY p.pri_sec, r.prg_id
</cfquery>

			<CFSET oldid = "">
			<CFSET test = "">
	<CFOUTPUT QUERY="rules">
				
		<!--- replaceing gteq with gte    lteq with lte  --->
				<CFSET strRule = #Replace(#rules.elig_rule#, "gteq", "gte", "ALL")#>
				<CFSET strRule = #Replace(#strRule#, "lteq", "lte", "ALL")#>
			<!--- NOTE: On 12/26/01, Andrew replaced below strRule with the non-commented out strRule, which comes from beneftischeckup4 on dev! --->
				 <!--- <CFSET strRule = #Replace(#strRule#, "]", "][#session.no_hh_members#]", "ALL")#>  --->
				 <cfset strRule = #Replace(#strRule#, "XX[" , "#session.no_hh_members#[", "ALL")#>
				<!---  checking for rules that apply to other programs or tables and rid-ing them --->

	<!--- this is checking to see if the rules is a call to a custom tag --->
			<CFSET assetbuy = FINDNOCASE("BuyInQI2asset", strRule, 1)>
			<CFSET incbuy = FINDNOCASE("BuyInQI2inc", strRule, 1)>
			<CFSET ssiinc = FINDNOCASE("ssiinc", strRule, 1)>
			<CFSET prgfind = FINDNOCASE("prg", strRule, 1)>
			<CFSET spenddowninc = FINDNOCASE("spenddowninc", strRule, 1)>

		<!--- If the rule is a call to cutom tag, then call the appropriate one, and send attributes 
			if there was no call to a custom tag.  then do a boolean evaluation of the rule --->
				<CFIF assetbuy NEQ 0>
					<CF_TagYeMedicareBuyInAssBuffer rule=#strRule#>
						<CFSET temp=#answer#>
				<CFELSEIF incbuy NEQ 0>
					<CF_TagYeMedicareBuyInIncBuffer rule=#strRule#>
						<CFSET temp=#answer#>
				<CFELSEIF ssiinc NEQ 0>
					<CFSET self = gettoken(strRule,2,"-")>
					<CFSET self_spouse = gettoken(strRule,3,"-")>
					<CF_TagYeSSIIncBuffer self=#self# self_spouse=#self_spouse#>
						<CFSET temp=#answer#>
				<CFELSEIF prgfind NEQ 0>
					<CF_TagYePrgFindBuffer rule=#strRule# prg_list=#prg_list#>
					<CFSET temp=#answer#>
				<CFELSEIF spenddowninc NEQ 0>
					<!--- please see notes on the logic of the call to tagYeSpendDownBuffer on the it --->
					<CFSET passMeIn = FINDNOCASE("struct_mem", strRule, 1)>
					<!--- If 'struct_mem' is part of the Rule that is getting passed to the TagYeSpendDownBuffer --->
					<CFIF passMeIn>
						<CFSET akstring = getToken(strRule,3," ")>
						<CFSET passMeIn = #evaluate("#akstring#")#> 
					<!--- now replace the part of the passed in rule with its evaluate --->
						<CFSET passInRule = #ReplaceNoCase(strRule, akstring, passMeIn)#>
						<CF_TagYeSpendDownBuffer rule=#passInRule# passMeIn=#passMeIn#>
						<!--- answer is what is passed back by the tag (seems to be Either YES or NO --->
						<CFSET temp=#answer#>
					<cfelse><!--- if there is no 'struct_mem getting passed in --->						
						<CF_TagYeSpendDownBuffer rule=#strRule# passMeIn=""><!--- pass attribute passMeIn with no length --->
						<CFSET temp=#answer#>
					</cfif>
				<CFELSE>
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
                        <cfset temp="YES">
                     <cfelse>
                        <cfset temp="NO">
                     </cfif>
                  <cfelse>
                    <cfif FindNoCase(" NOT IN ", strRule, 1)>
                        <cfset temp="NO">
                     <cfelse>
                        <cfset temp="YES">
                     </cfif>
                  </cfif>
               <cfelse>
                  <cfset temp=Evaluate(strRule)>
               </cfif>
				</CFIF>
				
					<CFIF #oldid# IS "" OR #oldid# IS #prg_id#>
						<CFSET test = #test# & #temp#>
					<CFELSE>
								<CFSET test1 = FINDNOCASE("no", test, 1)>
								<CFIF test1 EQ 0>
								<CFIF #ListFindNoCase(session.prg_list, "'#oldid#'")# IS 0>
								<CFSET prg_list = prg_list & "'" & #oldid# & "',">
								</CFIF>
								</CFIF>
								<CFSET test = #temp#>
					</CFIF>
					<CFSET oldid = #prg_id#>
	</CFOUTPUT>
							<!--- this code os for the last program through the output,  because there is 
							no change in the program id, the last one through never got evaluated....
							this code picks that up --->
						<CFSET test1 = FINDNOCASE("no", test, 1)>
								<CFIF test1 EQ 0>
									<CFIF #ListFindNoCase(session.prg_list, "'#oldid#'")# IS 0>
									<CFSET prg_list = prg_list & "'" & #oldid# & "',">
										<!--- CFQuERY datasource="#application.dbSrc#">
										INSERT INTO tbl_answers (ID, FIELD, ANSWER)
										Select #session.clientnum#, 'bufferprogram', '#oldid#'
										</cfquery --->
									</CFIF>
								</CFIF>
								
						<!--- trim the last comma off of the prg_list and assign it to the session var--->	


<CFIF prg_list NEQ "">
<CFSET x = #Len('#prg_list#')#>
<CFSET prg_list = #LEFT(prg_list, x-1)#>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
SELECT prg_id, prg_nm, order_num, st, Cat_ID, major_cat, id_number
	FROM tbl_prg_all, tbl_major_cat_list
	WHERE tbl_major_cat_list.id_number = tbl_prg_all.Cat_ID and prg_id IN (#preservesinglequotes(prg_list)#)
	ORDER BY order_num
</CFQUERY>

<CFOUTPUT>
<br>
<b>Other Programs to Consider</b><br>
<hr>
<p><font face="Arial">There is some chance that <cfif session.StrClient is 'self'> you are<cfelse>your #session.StrClient# is</cfif>  eligible for the following programs,
 although <cfif session.StrClient is 'self'> your <cfelse>your #session.StrClient#'s </cfif> income and assets appear to be too high.  If these programs could be helpful to <cfif session.StrClient is 'self'>you<cfelse>your #session.StrClient#</cfif>, 
 <cfif session.StrClient is 'self'>you<cfelse>your #session.StrClient#</cfif> may want to apply so that a formal determination can be made. </font></p>
 </CFOUTPUT>
	<Table>
	<cfset monkeycounter = 0>
	
	<cfset session.buff_list = ''>

<CFLOOP QUERY="prgs" startrow="1" endrow="#prgs.recordcount#">
		<cfset monkeycounter = monkeycounter + 1>
		<CFSET majid = #mid(#prgs.prg_id#, 5, 3)#>

		<CFOUTPUT>
			<tr><td valign="top">#monkeycounter#.</td><td><A HREF="frmDetails.cfm?prg_id=#prgs.prg_id#"><FONT FACE="arial">#prgs.prg_nm#</FONT></A> (#prgs.major_cat#)
			</td></tr>
		</CFOUTPUT>
		<CFSET majid = #mid(#prgs.prg_id#, 5, 3)#>
	
		
		<CFSET session.buff_list = session.buff_list & "'" & #prg_id# & "',">
</CFLOOP>
	</table>
											<CFIF #Len(session.buff_list)# GT 1>
												<CFSET trim = #Len(session.buff_list)#>
												<CFSET trim = #trim# - 1>
												<CFSET session.buff_list = #Left(session.buff_list, #trim#)#>
											</CFIF>
<CFELSE>
</CFIF>

