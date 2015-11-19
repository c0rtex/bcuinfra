<cfparam name="attributes.incassRealVarName" type="string">
<cfparam name="attributes.incassType" type="string" default="i">
<cfparam name="attributes.questionText" type="string">
<cfparam name="attributes.listvarname" type="string" default="">

<cfset incassRealVarName = attributes.incassRealVarName>
<cfset questionText = attributes.questionText>
			<cfoutput>
			
			<!-- Display -->
			<cfif incassRealVarName eq 's_income_earned' or incassRealVarName eq 's_sp_income_earned_simple'>
				<!--- Work income dropdown --->
				<!--- Display  Drop Downs --->
				<TR valign="top">
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber increment="false">.</b></font>
					</td>
					<td><font face="arial">#questionText#</font></td>
				</tr>
				<TR><TD>
					</TD>
					<TD><font face="arial"><CF_TagYeWhiteSpace>
					<select name="income_earned_General" onchange="listIncomeEarned.populate(); showIncomeEarned();"><option value="">Select an Income Range</option><option value="0">None</option><option value="1">1 - 999</option><option value="1000">1,000 - 1,999</option><option value="2000">2,000 - 2,999</option><option value="3000">3,000 - 3,999</option><option value="4000">4,000 - 4,999</option><option value="5000">5,000+</option></select>
					</font><br><br></td>
				</tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "na-income_earned_general")>
					</cfif>
				<!-- Display hidden javascript fields -->
				<TR id="sections_income_earned" style="display: none;" ><td colspan=2>
				<table>
				<tr>
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber>a.</b> </font>
					</td>
					<td>
						<font face="arial">Please further choose a narrower monthly income range to help us determine what programs are best for you.</font>
					</td>
				</tr>
				<TR  ><TD>
					</TD>
					<TD><font face="arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="#incassRealVarName#"><script language="JavaScript">listIncomeEarned.printOptions()</script><option value="">Select an Initial Range first</option></select>
					</font><br><br></td>
				</tr>
				</table>
				</td></tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "#attributes.incassType#a-#incassRealVarName#")>
					</cfif>
				<cfelseif incassRealVarName eq 's_income_other_nw' or incassRealVarName eq 's_sp_income_other_nw_simple'>
				<!-- Non Work Income Dropdown -->
				<TR valign="top">
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber increment="false">.</b></font>
					</td>
					<td><font face="arial">#questionText#</font></td>
				</tr>
				<TR><TD>
					</TD>
					<TD><font face="arial"><CF_TagYeWhiteSpace>
					<select name="income_other_nw_General" onchange="listIncomeOtherNW.populate(); showIncomeOtherNW();"><option value="">Select an Income Range</option><option value="0">None</option><option value="1">1 - 999</option><option value="1000">1,000 - 1,999</option><option value="2000">2,000 - 2,999</option><option value="3000">3,000 - 3,999</option><option value="4000">4,000 - 4,999</option><option value="5000">5,000+</option></select>
					</font><br><br></td>
				</tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "na-income_other_nw_general")>
					</cfif>
				<!-- Display hiddend javascript fields -->
				<TR id="sections_income_other_nw" style="display: none;" ><td colspan=2>
				<table>
				<tr>
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber>a.</b> </font>
					</td>
					<td>
						<font face="arial">Please further choose a narrower monthly income range to help us determine what programs are best for you.</font>
					</td>
				</TR>
				<TR  ><TD>
					</TD>
					<TD><font face="arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="#incassRealVarName#"><script language="JavaScript">listIncomeOtherNW.printOptions()</script><option value="">Select an Initial Range first</option></select>
					</font><br><br></td>
				</tr>
				</table>
				</td></tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "#attributes.incassType#a-#incassRealVarName#")>
					</cfif>
				<cfelseif incassRealVarName eq 's_asset_other_a'>
				<!-- Asset Dropdown -->
				<TR valign="top">
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber>.</b></font>
					</td>
					<td><font face="arial">#questionText#</font></td>
				</tr>
				<TR><TD>
					</TD>
					<TD><font face="arial"><CF_TagYeWhiteSpace>
					<select name="#incassRealVarName#"><option value="">Select an Asset Range</option><option value="12001">Over 12,000</option><option value="0">None</option><option value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;-&nbsp;&nbsp;&nbsp;2,000</option><option value="2001">&nbsp;&nbsp;2,001&nbsp;-&nbsp;&nbsp;&nbsp;3,000</option><option value="3001">&nbsp;&nbsp;3,001&nbsp;-&nbsp;&nbsp;&nbsp;4,000</option><option value="4001">&nbsp;&nbsp;4,001&nbsp;-&nbsp;&nbsp;&nbsp;4,999</option><option value="5001">&nbsp;&nbsp;5,001&nbsp;-&nbsp;&nbsp;&nbsp;6,000</option><option value="6001">&nbsp;&nbsp;6,001&nbsp;-&nbsp;&nbsp;&nbsp;8,000</option><option value="8001">&nbsp;&nbsp;8,001&nbsp;-&nbsp;10,000</option><option value="10001">10,001 - 11,500</option><option value="11501">11,501 - 12,000</option></select>
					</font></td>
				</tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "#attributes.incassType#a-#incassRealVarName#")>
					</cfif>
				<cfelseif incassRealVarName eq 's_sp_asset_other_a_simple'>
				<!-- Asset Dropdown -->
				<TR valign="top">
					<TD VALIGN='top' WIDTH='35'>
						<font face="arial"><b><cf_showQuestionNumber>.</b></font>
					</td>
					<td><font face="arial">#questionText#</font></td>
				</tr>
				<TR><TD>
					</TD>
					<TD><font face="arial"><CF_TagYeWhiteSpace>
					<select name="#incassRealVarName#"><option value="">Select an Asset Range</option><option value="23001">Over 23,000</option><option value="0">None</option><option value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;-&nbsp;&nbsp;&nbsp;2,000</option><option value="2001">&nbsp;&nbsp;2,001&nbsp;-&nbsp;&nbsp;&nbsp;3,000</option><option value="3001">&nbsp;&nbsp;3,001 -&nbsp;&nbsp;&nbsp;4,000</option><option value="4001">&nbsp;&nbsp;4,001&nbsp;-&nbsp;&nbsp;&nbsp;4,999</option><option value="5001">&nbsp;&nbsp;5,001&nbsp;-&nbsp;&nbsp;&nbsp;6,000</option><option value="6001">&nbsp;&nbsp;6,001&nbsp;-&nbsp;10,000</option><option value="10001">10,001 - 15,000</option><option value="15001">15,001 - 18,000</option><option value="18001">18,001 - 23,000</option></select>
					</font></td>
				</tr>
					<cfif attributes.listvarname neq ''>
						<cfset "caller.#attributes.listvarname#" = ListAppend(Evaluate("caller.#attributes.listvarname#"), "#attributes.incassType#a-#incassRealVarName#")>
					</cfif>
				</cfif>
</cfoutput>