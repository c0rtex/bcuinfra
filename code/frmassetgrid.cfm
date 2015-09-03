<!----=======================================
DESCRIPTION: Static form, for the user to fill out asset information
CALLED BY: proc_income.cfm
GOES TO: proc_asset.cfm
REQUIRED: N/A
============================================---->

<cf_logScreeningInput initvarname="accumAFList">
<cfif isdefined('url.debug')>
	<cfoutput>session.ch_income_total_unearned = #session.ch_income_total_unearned#</cfoutput> 
</cfif>
<cfif session.subset_id eq 70><cfset session.subsetGridFlag = 1></cfif>
<!--- if large assets from frmskipgrid.cfm skip page --->
<cfif session.skipassets eq 'n'>
	<cflocation URL="procAsset.cfm" addtoken="yes">
<cfelse>

	<cfquery name="getasset" datasource="#application.dbSrc#">
		SELECT a.assettype_name, a.assettype_varname, a.definition
		FROM <cfif session.subsetGridFlag eq 1>xsubset_xassettype sa, </cfif>xassettype a
		WHERE <cfif session.subsetGridFlag eq 1>sa.subset_id=#session.subset_id#
			AND sa.assettype_id=a.assettype_id<cfelse>a.exclude_flag=0</cfif>
		ORDER BY a.sort
	</cfquery>
	<cfif isdefined('url.debug') and url.debug eq 1><cfdump var="#getasset#"></cfif>	
	
	<cfif getasset.RecordCount eq 0>
	
		<cfquery name="getassetvar" datasource="#application.dbSrc#">
			SELECT i.assettype_varname
			FROM xassettype i
			ORDER BY i.sort
		</cfquery>
		<cfloop query="getassetvar">
			<cfset "session.s_asset_#assettype_varname#" = 0>
			<cfset "session.sp_asset_#assettype_varname#" = 0>
			<cfset "session.s_sp_asset_#assettype_varname#_simple" = 0>
			<cfset "session.s_sp_asset_#assettype_varname#" = 0>
			<cfset "session.hh_asset_#assettype_varname#_simple" = 0>
			<cfset "session.hh_asset_#assettype_varname#" = 0>
		</cfloop>
		<CFLOCATION URL="procAsset.cfm" addtoken="yes">
	
	<cfelse>
		<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77 )>
			<!--- Call to header tag --->
			<cf_buildHTML show_title="yes" guts="frmassetgrid.cfm">
				<style>
					#pageTip{ top:0px !important;}
				</style>
					
				<div class="row survey">
				
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
								<h2>Your Household Assets</h2>
						</div><!-- questionHolder -->
					</div><!-- question -->
			
					<!--- Output of the asset grid --->
					<CFOUTPUT>
					<div class="question">
						<div class="questionHolder questionBar">
							<span class="question_number"><cf_showQuestionNumber>.</span> 
                            	<cf_displayText code="question_assetgrid" group="question">
                                <cf_buildPopupLink code="assetgrid" text="HELP" textonly="TRUE">
								<!---p>
									Please enter the value of your assets in the &quot;Self&quot; column below.
									<cfif session.marital_stat eq 'Married' 
											Or session.marital_stat eq 'Widowed' 
											Or session.marital_stat eq '' 
											Or session.marital_stat eq 0>
											Enter the assets owned separately by your spouse in the 
											&quot;Spouse&quot; column.  If assets are owned jointly in both names, 
											enter them in the &quot;Joint&quot; column.  
									</cfif>
											Enter assets of any others living in the 
											household in the 
											&quot;Household&quot; column.
								</p>
								<cfif session.subset_id eq 0>
									<p>
										<strong>Please Note:</strong> Estimate or guess if exact asset numbers 
										are not readily available.  It is not necessary to fill 
										in all boxes for the questionnaire to work.  Don&rsquo;t worry 
										if all answers are not known, just fill in the information 
										available now and submit the questionnaire.
									</p>
								</cfif--->		
						</div><!-- questionHolder -->
					</div><!-- question -->	
					
					
					<table id="asset_grid_sub" align="center" width="100%" border="0">
	
					<form method="POST" action="procAsset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="form1" id="form1">
					</cfoutput>
					
					<cfif session.marital_stat eq 'Married' 
							Or session.marital_stat eq 'Widowed' 
							Or session.marital_stat eq '' 
							Or session.marital_stat eq 0>	
						<cfset cols = 4>
					</cfif>
			
				 <table id="income_grid_sub"  border="0" CELLSPACING="0" cellpadding="0">
					<tr class="income_grid_row">
						<td valign="bottom"class="income_grid_left"><strong>Types of Assets:</strong></td>
						<td valign="bottom" align="center" class="income_grid_header"><strong>Self&nbsp;</strong></td>	
						<cfif session.marital_stat eq 'Married' 
							Or session.marital_stat eq 'Widowed' 
							Or session.marital_stat eq '' 
							Or session.marital_stat eq 0>
						<td valign="bottom" align="center" class="income_grid_header"><strong>Spouse </strong></td>
						<td valign="bottom" align="center" class="income_grid_header"><strong> Joint </strong></td>
				</cfif>
						<td valign="bottom" align="center" class="income_grid_header">
							<strong><cf_buildPopupLink keyword="Household"></strong>
						</td>
					</tr>
			
				<cfoutput>
				<cfset rep="0">
				<cfloop query="getasset">
				
				    <cfset assetdisplayname = getasset.assettype_name>
					<cfif session.subset_id eq 29 or session.subset_id eq 39 >
						<cfif getasset.assettype_varname eq 'auto1'>
				        	<cfset assetdisplayname = 'Automobile'>
				        </cfif>
				    </cfif>
				    
					<tr <cfif NOT getasset.currentrow MOD 2>class="stripe"</cfif>>
						<td valign="bottom" class="income_grid_left">
							<cf_buildPopupLink keyword="#definition#" text="#assetdisplayname#">
						</td>
						
						<cfset matchVar = "s_asset_#assettype_varname#">
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
						
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					
						<cfif 	session.marital_stat eq 'Married' 
								Or session.marital_stat eq 'Widowed' 
								Or session.marital_stat eq '' 
								Or session.marital_stat eq 0>
								
							<cfset matchVar = "sp_asset_#assettype_varname#">
							
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
							
							<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
		
							<cfset matchVar = "s_sp_asset_#assettype_varname#_simple">
							<cfif session.screening.prepopulate>
								<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
							<cfelse>
								<cfset matchVal = ''>
							</cfif>
							
							<td valign="top" class="td_grid">
								<input type="text" name="#matchVar#" value="#matchVal#"\
										onBlur="chkDollar(this,value);" 
										class="grid_input"  
										MAXLENGTH="10">
							</td>
							
							<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					
					</cfif><!--- END <cfif 	session.marital_stat eq 'Married'... --->
					
					<cfset matchVar = "hh_asset_#assettype_varname#_simple">
					
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
							
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					</tr>
				<cfset rep = rep + 1>
			</cfloop>
			</table>
			</cfoutput>
			
			<!--- 09/01/2002 REM  Added in cfif process to cleanup the footer language if we're not done
			yet --->	
			<cfif session.subsetDrugFlag eq 0>
				<input type="hidden" NAME="Submit" VALUE="Next">
				<div id="surveyNav">
					<input type="hidden" NAME="Submit" VALUE=" View Results ">
					<p><div class="left"><input type="submit" value="  Next > " name="Submit" onClick="document.form1.submit();" /></div></p> 
				</div>
			<cfelse>
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
									value=" <cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>View Results<cfelse> Next > </cfif> " 
									onClick="document.form1.submit();" 
									name="submit" /></div></p> 
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
			</cfif><!--- END <cfif session.subsetDrugFlag eq 0> --->
			
			<cf_passScreeningInput varname="accumAFList" pagecode="assetgrid">
			</form>
	
			</div>
			</cf_buildHTML>
		<cfelse>
			<!--- PL Begins HERE --->
			<!--- Call to header tag --->
			<cf_buildHTML show_title="yes" guts="frmassetgrid.cfm">
			<table id="iaGridTable" width=100% border="0" align="center" cellpadding=12 cellspacing=2 class="text1">
				<TBODY>
				<tr>
				<td bgcolor=#FFFFFF colspan=2 style="padding: 0px 12px 12px 12px;">
			<!--Dynamic Area--><font face="arial" size="4" color="#000000">
			<cfif session.subset_id gt 0>
			It is important that you answer these questions to the best of your ability.  If you are not sure of any answers, it is much better to provide your best estimate instead of leaving it blank.  By answering these questions, you will get more accurate results and recommendations.<p class="text1"></p>
			</cfif>
			<!--- Output of the asset grid --->
			<span class="screeningInstructionText"><b>Your Household Assets</b></span><p class="text1"></p>
			
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
                	<span class="text1" style="font-family:arial;"><cf_displayText code="question_assetgrid" group="question"> <cf_displayHelpLink code="assetgrid"></span>
				 <!---FONT face="Arial" size="3">
			Please enter the value of your assets in the "Self" column below.  <cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>Enter the assets owned separately by your spouse in the "Spouse" column.  If assets are owned jointly in both names, enter them in the "Joint" column.  </cfif>Enter assets of any others living in the <cf_buildPopupLink keyword="household"> in the "Household" column. <cf_displayHelpLink code="assetgrid"><cfif session.subset_id eq 0><br><br>
			
			<b>Please Note:</b>
			Estimate or guess if exact asset numbers are not readily available.  It is not necessary to fill in all boxes for the questionnaire to work.  Don't worry if all answers are not known, just fill in the information available now and submit the questionnaire.</cfif></font--->
			<p class="text1"></p>
            <cfoutput>
			<form method="POST" action="procAsset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" name="form1" id="form1">
			</cfoutput>
			
			<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
				<cfset tableWidth = "99%">
				<cfset colWidth = "20%">
			<cfelse>
				<cfset tableWidth = "60%">
				<cfset colWidth = "33%">			
			</cfif>
			
			 <cfoutput><table border="0" CELLSPACING="0" cellpadding="0" width="#tableWidth#" class="text1"></cfoutput>
			 
				<tr>
					<td valign="bottom"><font face="arial"><b>Types of Assets:</b></font></Td>
					<td>&nbsp;&nbsp;</td>
					<td class="income_grid_header" valign="bottom" width="#colWidth#"><FONT FACE="Arial" SIZE="-1"><center><B>Self&nbsp;</B></center></FONT></Td>	
					<td>&nbsp;&nbsp;</td>
			<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
					<td class="income_grid_header" valign="bottom" width="#colWidth#"><FONT FACE="Arial" SIZE="-1"><center><B>Spouse </B></center></FONT></Td>
					<td>&nbsp;&nbsp;</td>
					<td class="income_grid_header" valign="bottom" width="#colWidth#"><FONT FACE="Arial" SIZE="-1"><center><B> Joint </B></center></FONT></Td>
					<td>&nbsp;&nbsp;</td>
			</cfif>
					<td class="income_grid_header" valign="bottom"><FONT FACE="Arial" SIZE="-1"><center><B><cf_buildPopupLink keyword="household" text="Household"></B></center></FONT></Td>
				</TR>
			
			<cfoutput>
			<cfset rep="0">
			<cfloop query="getasset">
				<cfif SESSION.partner_id NEQ 80>
					<cfif SESSION.partner_id NEQ 86>
						<tr>
							<!---<td><img src="images/pixel.gif" width="1" height="<cfif rep eq 0>7<cfelse>10</cfif>" border="0" alt=""></td> --->
						</tr>
					</cfif>
				</cfif>
			    <cfset assetdisplayname = getasset.assettype_name>
				<cfif session.subset_id eq 29 or session.subset_id eq 39 >
					<cfif getasset.assettype_varname eq 'auto1'>
			        	<cfset assetdisplayname = 'Automobile'>
			        </cfif>
			    </cfif>
					<tr>
						<td valign="top" width="#colWidth#"><FONT FACE="Arial"><cf_buildPopupLink keyword="#definition#" text="#assetdisplayname#"></FONT></TD>
						<td>&nbsp;</td>
						<cfset matchVar = "s_asset_#assettype_varname#">
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
						
						<td valign="top" width="#colWidth#"><input type="text" name="#matchVar#" value="#matchVal#" REQUIRED="NO" onBlur="chkDollar(this,value);"   STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>" MAXLENGTH="10"></TD>
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					<td>&nbsp;</td>
			<cfif session.marital_stat eq 'Married' Or session.marital_stat eq 'Widowed' Or session.marital_stat eq '' Or session.marital_stat eq 0>
						<cfset matchVar = "sp_asset_#assettype_varname#">
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
						<td valign="top" width="#colWidth#"><input type="text" name="#matchVar#" value="#matchVal#" REQUIRED="NO" onBlur="chkDollar(this,value);"   STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>" MAXLENGTH="10"></TD>
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					<td>&nbsp;</td>
						<cfset matchVar = "s_sp_asset_#assettype_varname#_simple">
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
						<td valign="top" width="#colWidth#"><input type="text" name="#matchVar#" value="#matchVal#" REQUIRED="NO" onBlur="chkDollar(this,value);"   STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>" MAXLENGTH="10"></TD>
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					<td>&nbsp;</td>
			</cfif>
						<cfset matchVar = "hh_asset_#assettype_varname#_simple">
						<cfif session.screening.prepopulate>
							<cf_handleScreeningAnswerfield action="get" code="#matchVar#" element="pre" var="matchVal">
						<cfelse>
							<cfset matchVal = ''>
						</cfif>
						<td valign="top" width="#colWidth#"><input type="text" name="#matchVar#" value="#matchVal#" REQUIRED="NO" onBlur="chkDollar(this,value);"   STYLE="<cfif SESSION.partner_id EQ 80>width: 90%<cfelse>width: 90%</cfif>" MAXLENGTH="10"></TD>
						<cfset accumAFList = ListAppend(accumAFList, "a-#matchVar#")>
					</TR>
			
				<cfset rep = rep + 1>
			</cfloop>
			
			
				</table></td></tr></table>
			</cfoutput>
			<!--- 09/01/2002 REM  Added in cfif process to cleanup the footer language if we're not done
			yet --->	
			<cfif session.subsetDrugFlag eq 0>
				<br>
				<input type="hidden" NAME="Submit" VALUE="Next">
				<font face="Arial">
			    <div align="right"><b><input type="button" name="Submit" value="  Next  " onClick="document.form1.submit();"></b></div>
			    </font>
			<cfelse>
					<cfif session.subset_id neq 44 and session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
                        <p class="text1"></p>
                        <span class="screeningInstructionText"><b>Congratulations!</b><br>
                        <a>You have just completed the last page of <cfif session.partner_id eq 22 and session.subset_id eq 70>the SNAP &amp; SCSEP Benefits Screening.<cfelse>NCOA's <cf_tagBCU>.</cfif></a></span>
					</cfif>
					<p class="text1"></p>
					<font face="Arial">
					<div align="right"><b><input type="button" name="Submit" value=" <cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>View Results<cfelse> Next </cfif> " onClick="document.form1.submit();"></b></div>
					</font>
					<cfif session.subsetOptionalFlag eq 1 and session.subsetDrugFlag eq 1>
					<p class="text1"></p>
					<span class="screeningInstructionText"><b><cfif session.subset_id eq 44>Your results will now be assembled.  It should just take another moment or two before they are displayed.  Thank you for using <cf_tagBCU>.<cfelse>It may take a few moments to process your answers against our national database of benefits programs. Please be patient.</cfif></b></span>
					</cfif>
			</cfif>
			<cf_passScreeningInput varname="accumAFList" pagecode="assetgrid">
			</form>
			<!--- Call to the footer tag --->
			</FONT></TD></TR></TBODY></TABLE>

			</cf_buildHTML>		
		</cfif><!--- END <cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0> --->
	</cfif>
</cfif>
