<!----=======================================
DESCRIPTION: Displays the grid for the user to fill out for income numbers.
CALLED BY: frmQuestionsSecDep.cfm
GOES TO: ProcIncome.cfm
REQUIRED: N/A
============================================---->
<cf_logScreeningInput initvarname="accumAFList">
<cfif isdefined('url.debug')>
<cfquery name="getincome" datasource="#application.dbSrc#">
update xassettype  set assettype_name = 'Cash and Cash Equivalent' where assetTYPE_ID = 1000000
</cfquery>
<cfquery name="getincome" datasource="#application.dbSrc#">
select *
					from display d, display_language dl, language l
					where d.display_code like 'grid%'
						and d.display_id=dl.display_id
						and dl.language_id in ( 'EN')
						and dl.language_id=l.language_id
						and l.active = 1
					order by l.default_flag
</cfquery><cfdump var="#getincome#">
<cfquery name="getincome" datasource="#application.dbSrc#">
 SELECT * FROM xassettype i WHERE i.exclude_flag=0 ORDER BY i.sort
</cfquery>
<cfdump var="#getincome#">
</cfif>
<cfif session.subset_id eq 70><cfset session.subsetGridFlag = 2></cfif>
<!--- if high income from frmskipgrid, skip page --->
<cfif session.skipinc eq 'n'>
	<CFLOCATION URL="procincome.cfm" addtoken="Yes">
<cfelse>

<cfquery name="getincome" datasource="#application.dbSrc#">
	SELECT i.incometype_name, i.incometype_varname, i.definition
	FROM <cfif session.subsetGridFlag eq 1>xsubset_xincometype si, </cfif>xincometype i
	WHERE <cfif session.subsetGridFlag eq 1>si.subset_id=#session.subset_id#
		AND si.incometype_id=i.incometype_id<cfelse>i.exclude_flag=0</cfif>
	ORDER BY i.sort
</cfquery>

<cfif getincome.RecordCount eq 0>

	<cfquery name="getincomevar" datasource="#application.dbSrc#">
		SELECT i.incometype_varname
		FROM xincometype i
		ORDER BY i.sort
	</cfquery>
	<cfloop query="getincomevar">
		<cfset "session.s_income_#incometype_varname#" = 0>
		<cfset "session.sp_income_#incometype_varname#" = 0>
		<cfset "session.s_sp_income_#incometype_varname#_simple" = 0>
		<cfset "session.s_sp_income_#incometype_varname#" = 0>
		<cfset "session.hh_income_#incometype_varname#_simple" = 0>
		<cfset "session.hh_income_#incometype_varname#" = 0>
	</cfloop>
	<CFLOCATION URL="procincome.cfm" addtoken="Yes">
	
<cfelse>
	<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>
		<!--- Call header tag --->
		<cf_buildHTML show_title="yes" guts="frmincomegrid.cfm"> 
			<style>
				#pageTip{ top:0px !important;}
			</style>
				
			<div class="row survey">
			<!--Dynamic Area-->
			
				<div class="question">
					<div class="questionHolder questionBar">
						<div id="pageTip" class="helpTip">
							<h2><cf_displayText group="site" code="site_questionnaire_instructions_title"></h2>
                            <p><cf_displayText group="site" code="site_questionnaire_instructions_body"></p>
                            <cfif IsDefined('session.partner_id') And session.partner_id eq 6>
                                <br /><br />
                                <a href="javascript:help2('neededinfo-rx.cfm')">Click here</a> 
                                to see if you need to gather any information before you begin.<br />
                            </cfif>
					</div><!-- pageTip -->
					</div><!-- questionHolder -->
				</div><!-- question -->
		
			<cfoutput>
			
			<cfif session.subset_id gt 0>
				<div class="question">
					<div class="questionHolder questionBar">
							<p>
								 It is important that you answer these questions to the 
								 best of your ability.  If you are not sure of any answers, 
								 it is much better to provide your best estimate instead of 
								 leaving it blank.  By answering these questions, you will 
								 get more accurate results and recommendations.
							</p>
					</div><!-- questionHolder -->
				</div><!-- question -->
			</cfif>
		
			<div class="question">
				<div class="questionHolder questionBar">
						<h2>Your Monthly Household Income</h2>
				</div><!-- questionHolder -->
			</div><!-- question -->
		
			<div class="question">
				<div class="questionHolder questionBar">
					<span class="question_number"><cf_showQuestionNumber>.</span> 
                    	<cf_displayText code="question_incomegrid" group="question">
                        <cf_buildPopupLink code="incomegrid" text="HELP" textonly="TRUE">
                    	<!---p>
							Please enter your current <strong>monthly</strong> income in the &quot;Self&quot; column below.
							<cfif session.marital_stat eq 'Married' 
									Or session.marital_stat eq 'Widowed' 
									Or session.marital_stat eq '' 
									Or session.marital_stat eq 0>
									Enter your spouse&rsquo;s income in the &quot;Spouse&quot; column.  
									If any income is received jointly in both names, enter it in the 
									&quot;Joint&quot; column.  
							</cfif>
							Enter the income of any others living in the 
							household in the 
							&quot;Household&quot; column.
						</p>
						<cfif session.subset_id eq 0>
							<p>
								<strong>Please Note:</strong> Estimate or guess if exact income numbers 
								are not readily available.  It is not necessary to fill 
								in all boxes for the questionnaire to work.  Don&rsquo;t 
								worry if all answers are not known, just fill in the 
								information available now and proceed to the next page.
							</p>
						</cfif--->		
				</div><!-- questionHolder -->
			</div><!-- question -->	
		 
			<form method="POST" action="procincome.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="form1" id="form1">
				<cfset cols = 2>
		
				<cfif session.marital_stat eq 'Married' 
						Or session.marital_stat eq 'Widowed' 
						Or session.marital_stat eq '' 
						Or session.marital_stat eq 0>
					<cfset cols = 4>
				</cfif>
				
				<!---<ul class="striping">
					<li class="questionBar income_grid_row">
						<span><strong>Types of Monthly Income:</strong></span>
						<span><strong>Self</strong></span>
					</li>--->
				
				  <table id="income_grid_sub"  border="0" CELLSPACING="0" cellpadding="0">
					<tr class="income_grid_row">
						<td valign="bottom"class="income_grid_left"><strong>Types of Monthly Income:</strong></td>
						<td valign="bottom" align="center" class="income_grid_header"><strong>Self</strong></td>	
						<cfif session.marital_stat eq 'Married' 
								Or session.marital_stat eq 'Widowed' 
								Or session.marital_stat eq '' 
								Or session.marital_stat eq 0>
							<td valign="bottom" align="center" class="income_grid_header"><strong>Spouse</strong></td>
							<td valign="bottom" align="center" class="income_grid_header"><strong>Joint</strong></td>					
						</cfif>
						<td valign="bottom" align="center" class="income_grid_header">
							<strong><cf_buildPopupLink keyword="Household"></strong>
						</td>
					</tr>
		
					<cfset rep="0">
					<cfloop query="getincome">
					
						<cfset matchVar = "s_income_#incometype_varname#">
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
					
							<tr <cfif NOT getincome.currentrow MOD 2>class="stripe"</cfif>>
								<td valign="bottom" class="income_grid_left">
									<cfif isdefined('url.debug')><cfoutput>keyword="#definition#" text="#incometype_name#"</cfoutput></cfif>
							
									<cfif isdefined('url.debug')><cf_buildPopupLink keyword="#definition#" text="#incometype_name#" debug="true"><cfelse>
										<cf_buildPopupLink keyword="#definition#" text="#incometype_name#">
									</cfif>
								</td>
								<td valign="top" class="td_grid">
									<input type="text" name="#matchVar#" value="#matchVal#" 
										onBlur="chkDollar(this,value);" 
										class="grid_input" 
										MAXLENGTH="10">
								</td>
								
								<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
								
						<cfif session.marital_stat eq 'Married' 
							Or session.marital_stat eq 'Widowed' 
							Or session.marital_stat eq '' 
							Or session.marital_stat eq 0>
							
							<cfset matchVar = "sp_income_#incometype_varname#">
							
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = ''>
							</cfif>
							
								<td valign="top" class="td_grid">
									<input type="text" name="#matchVar#" value="#matchVal#" 
									onBlur="chkDollar(this,value);" 
									class="grid_input" 
									MAXLENGTH="10">
								</td>
								
								<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
								
							<cfset matchVar = "s_sp_income_#incometype_varname#_simple">
							
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = ''>
							</cfif>
							
								<td valign="top" class="td_grid">
									<input type="text" name="#matchVar#" value="#matchVal#" 
										onBlur="chkDollar(this,value);" 
										class="grid_input"  
										MAXLENGTH="10">
								</td>
								
								<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
						</cfif><!--- END CFIF line 183 --->
						
						<cfset matchVar = "hh_income_#incometype_varname#_simple">
						
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
							
								<td valign="top" class="td_grid">
									<input type="text" name="#matchVar#" value="#matchVal#" 
										onBlur="chkDollar(this,value);" 
										class="grid_input" 
										MAXLENGTH="10">
								</td>
								
							<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
							</tr>
					
						<cfset rep = rep + 1>
					</cfloop>
						</table><!--- END <table id="income_grid_sub" --->
					</cfoutput>
		
				<!--- 09/01/2002 REM  Added in the RX Only check --->
				<!--- 01/26/2004 BS Changed to generalized subset check --->
				<cfif session.skipassets eq 'N' And (((Not IsDefined('session.subset_id') Or (IsDefined('session.subset_id') 
						And session.subset_id eq 0)) And session.subsetDrugFlag eq 1) 
						Or (IsDefined('session.subset_id') And session.subset_id gt 1))>
				
						<cfif session.subset_id neq 44 and session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
							<div id="surveyNav">
								<h2>Congratulations!</h2>
								<p>
									You have just completed the last page of NCOA&rsquo;s <cf_tagBCU>.
								</p> 
							</div>
						</cfif>
						
						<div id="surveyNav">
							<input type="hidden" NAME="Submit" VALUE=" View Results ">
							<p><div class="left">
								<input class="view_results" type="submit" 
										value="  <cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>View Results<cfelse> Next > </cfif> " name="submit" /></div></p> 
						</div>
		
						<cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
							<div class="question">
								<div class="questionHolder questionBar">
									<p>
										<cfif session.subset_id eq 44>
											Your results will now be assembled. It should just take 
											another moment or two before they are displayed. Thank 
											you for using <cf_tagBCU>.
										<cfelse>
											It may take a few moments to process your answers 
											against our national database of benefits programs. Please be patient.
										</cfif>
									</p>
								</div><!-- questionHolder -->
							</div><!-- question -->
						</cfif>
						
				<cfelse>
					<input type="hidden" NAME="Submit" VALUE="Next">
					<div id="surveyNav">
						<input type="hidden" NAME="Submit" VALUE=" View Results ">
						<p><div class="left"><input type="submit" value="  Next > " name="Submit" /></div></p> 
					</div>
				</cfif>
			<cf_passScreeningInput varname="accumAFList" pagecode="incomegrid">
			</form>
		</div>
		<!--- Call footer tag --->
		</cf_buildHTML>
	<cfelse>
		<!--- PL Begins HERE --->
		<!--- Call header tag --->
		 <cf_buildHTML show_title="yes" guts="frmincomegrid.cfm"> 
		 
		 <table <cfif SESSION.partner_id EQ 100>id="frmincomegrid" width="700px"<cfelse>width=100%</cfif> border="0" align="center" cellpadding=12 cellspacing=2 class="text1">
			<TBODY>
			<tr>
			<td bgcolor=#FFFFFF colspan=2 style="padding: 0px 12px 12px 12px;">
		<!--Dynamic Area--><font face="arial" size="4" color="#000000">
		<CFOUTPUT>
		<cfif session.subset_id gt 0>
			<span class="screeningInstructionText">It is important that you answer these questions to the best of your ability.  If you are not sure of any answers, it is much better to provide your best estimate instead of leaving it blank.  By answering these questions, you will get more accurate results and recommendations.</span>
        	<p class="text1"></p>
		</cfif>
		<span class="screeningInstructionText"><b>Your Monthly Household Income</b></span><p class="text1"></p>
		<table align="center" width="100%" border="0" class="text1">
		<tr>
			<TD WIDTH="35" valign="top">
				<cfif SESSION.partner_id NEQ 80>
					<FONT FACE="arial"><B>
					<cf_showQuestionNumber>.</b>
				<cfelse>
					<div class="question_number">
						<cf_showQuestionNumber>.
					</div>
				</cfif>
			</td>
			<TD VALIGN="top">
            	<span class="text1" style="font-family:arial;"><cf_displayText code="question_incomegrid" group="question"> <cf_displayHelpLink code="incomegrid"></span>
			 <!---FONT face="Arial" size="3">
		Please enter your current <b>monthly</b> income in the "Self" column below.  <cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>Enter your spouse's income in the "Spouse" column.  If any income is received jointly in both names, enter it in the "Joint" column.  </cfif>Enter the income of any others living in the <cf_buildPopupLink keyword="household"> in the "Household" column. <cf_displayHelpLink code="incomegrid"><cfif session.subset_id eq 0><br><br>
		
		<b>Please Note:</b>
		Estimate or guess if exact income numbers are not readily available.  It is not necessary to fill in all boxes for the questionnaire to work.  Don't worry if all answers are not known, just fill in the information available now and proceed to the next page.</cfif>
		</font--->
		<p class="text1"></p>
		<form method="POST" action="procincome.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="form1" id="form1">
		
			<cfset cols = 2>
		
			<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
				<cfset cols = 4>
				<cfset tableWidth = "99%">
			<cfelse>
				<cfset tableWidth = "74%">
			</cfif>
			
			<cfset colWidth = 100 / cols>
		
		  <table  border="0" CELLSPACING="0" cellpadding="0" width="#tableWidth#" class="text1" id="iaGridTable">
			<tr>
				<td valign="bottom"><b>Types&nbsp;of&nbsp;Monthly&nbsp;Income:</b></Td>
				<td>&nbsp;&nbsp;</td>
				<td valign="bottom" class="income_grid_header"><FONT FACE="Arial" SIZE="-1"><center><B>Self&nbsp;</B></center></FONT></Td>	
				<td>&nbsp;&nbsp;</td>
					<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
						<td valign="bottom" class="income_grid_header"><FONT FACE="Arial" SIZE="-1"><center><B>Spouse </B></center></FONT></Td>
						<td>&nbsp;&nbsp;</td>
						<td valign="bottom" class="income_grid_header"><FONT FACE="Arial" SIZE="-1"><center><B> Joint </B></center></FONT></Td>
						<td>&nbsp;&nbsp;</td>
					</cfif>
				<td valign="bottom" class="income_grid_header"><FONT FACE="Arial" SIZE="-1"><center><B> <cf_buildPopupLink keyword="household" text="Household"> </B></center></FONT></Td>
			</TR>
		
		<cfset rep="0">
		<cfloop query="getincome">
		
			<cfset matchVar = "s_income_#incometype_varname#">
		
			<cfif session.screening.prepopulate>
				<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
			<cfelse>
				<cfset matchVal = ''>
			</cfif>
			<cfif SESSION.partner_id NEQ 80>
				<cfif SESSION.partner_id NEQ 86>
					<tr>
						<!---<td><img src="images/pixel.gif" width="1" height="<cfif rep eq 0>7<cfelse>10</cfif>" border="0" alt=""></td> --->
					</tr>
				</cfif>
			</cfif>
		
				<tr>
<cfif session.partner_id neq 14>
					<td valign="bottom"><FONT FACE="Arial"><cf_buildPopupLink keyword="#definition#" text="#incometype_name#"></FONT></TD>
<cfelse>
					<td valign="top"><FONT FACE="Arial"><cf_buildPopupLink keyword="#definition#" text="#incometype_name#"></FONT></TD>
</cfif>
				<td>&nbsp;</td>
					<td valign="top" width="#colWidth#%"><input type="text" name="#matchVar#" value="#matchVal#" onBlur="chkDollar(this,value);" STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>"  MAXLENGTH="10"></TD>
				<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
				<td>&nbsp;</td>
		<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
				<cfset matchVar = "sp_income_#incometype_varname#">
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
					<td valign="top" width="#colWidth#%"><input type="text" name="#matchVar#" value="#matchVal#" onBlur="chkDollar(this,value);" STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>" MAXLENGTH="10"></TD>
				<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
				<td>&nbsp;</td>
				<cfset matchVar = "s_sp_income_#incometype_varname#_simple">
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
					<td valign="top" width="#colWidth#%"><input type="text" name="#matchVar#" value="#matchVal#" onBlur="chkDollar(this,value);" STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>"  MAXLENGTH="10"></TD>
				<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
				<td>&nbsp;</td>
		</cfif>
				<cfset matchVar = "hh_income_#incometype_varname#_simple">
				<cfif session.screening.prepopulate>
					<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
				<cfelse>
					<cfset matchVal = ''>
				</cfif>
					<td valign="top" width="#colWidth#%"><input type="text" name="#matchVar#" value="#matchVal#" onBlur="chkDollar(this,value);" STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>"  MAXLENGTH="10"></TD>
				<cfset accumAFList = ListAppend(accumAFList, "i-#matchVar#")>
				</TR>
		
			<cfset rep = rep + 1>
			
		</cfloop>
		
			</table>
		</cfoutput>
		
		</td></tr></table>
		
		<!--- 09/01/2002 REM  Added in the RX Only check --->
		<!--- 01/26/2004 BS Changed to generalized subset check --->
		<cfif session.skipassets eq 'N' And (((Not IsDefined('session.subset_id') Or (IsDefined('session.subset_id') And session.subset_id eq 0)) And session.subsetDrugFlag eq 1) Or (IsDefined('session.subset_id') And session.subset_id gt 1))>
		
				<br>
				<cfif session.subset_id neq 44 and session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
				<span class="screeningInstructionText"><b>Congratulations!</b><br>
				<a>You have just completed the last page of <cfif session.partner_id eq 22 and session.subset_id eq 70>the SNAP &amp; SCSEP Benefits Screening.<cfelse>NCOA's <cf_tagBCU>.</cfif></a></span>
				<p class="text1"></p>
				</cfif>
				<table width="100%" class="text1">
				<tr>
					<td valign="top" rowspan="2" align="right">
			        <input type="hidden" NAME="Submit" VALUE=" View Results ">
			        <font face="Arial">
			        <div align="right"><b><input type="button" name="Submit" value=" <cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>View Results<cfelse> Next </cfif> " onClick="document.form1.submit();"></b></div>
			         </font>
			        </td>
				</tr>
				</table>
				<cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
				<p class="text1"></p>
				<span class="screeningInstructionText"><b><cfif session.subset_id eq 44>Your results will now be assembled.  It should just take another moment or two before they are displayed.  Thank you for using <cf_tagBCU>.<cfelse>It may take a few moments to process your answers against our national database of benefits programs. Please be patient.</cfif></b></span>
				</cfif>
		<cfelse>
			<br>
			<input type="hidden" NAME="Submit" VALUE="Next">
			<font face="Arial">
		    <div align="right"><b><input type="button" name="Submit" value="  Next  " onClick="document.form1.submit();"></b></div>
		    </font>
		</cfif>
		<cf_passScreeningInput varname="accumAFList" pagecode="incomegrid">
		</form>
		</FONT></TD></TR></TBODY></TABLE>
		<!--- Call footer tag --->
		</cf_buildHTML>		
	</cfif>

</cfif>
</cfif>
