<cfoutput>
<FORM ACTION="procgrid.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" METHOD="post" NAME="formThird">

	
	<font face="arial" size="3" color="##000000">

<cfset qNumOffset = 0>

<TABLE valign="top" border="0">


				<TR valign="top">
					<TD VALIGN='top' WIDTH='35'><font face="arial">
<b>#Evaluate("session.shownumber + qNumOffset")#.</b> 
					</font></td>
					<td><font face="arial">
<cfif session.marital_stat eq 'Married'>
	<cfif session.strClient eq 'Self'>
		What is the total <b>monthly</b> income for you and your spouse, before taxes and other deductions?  Include income from Social Security (including Medicare Part B Premium), dividends, interest, private pensions, retirement benefits, etc.
	<cfelse>
		What is the total <b>monthly</b> income for your #session.strClient# and #possessive# spouse, before taxes and other deductions?  Include income from Social Security (including Medicare Part B Premium), dividends, interest, private pensions, retirement benefits, etc.
	</cfif>
<cfelse>
	<cfif session.strClient eq 'Self'>
		What is your total <b>monthly</b> income, before taxes and other deductions?  Include income from Social Security (including Medicare Part B Premium), dividends, interest, private pensions, retirement benefits, etc.
	<cfelse>
		What is your #session.strClient#'s total <b>monthly</b> income, before taxes and other deductions?  Include income from Social Security (including Medicare Part B Premium), dividends, interest, private pensions, retirement benefits, etc.
	</cfif>
</cfif>					
					</font></td>
				</tr>
				<TR>
					<TD>
					</TD>
					<TD><font face="arial">
<CF_TagYeWhiteSpace>
$ <INPUT TYPE="Text"  NAME="s_income_other_nw" REQUIRED="No" onBlur="chkDollar(this,value); "   SIZE="7" MAXLENGTH="10">
					</font></td>
				</tr>




<!--- 2004-05-12 BShunn  Leave out SCHIP question for Rx (to be used when other subsets
                         implement the reduced grid) --->
<cfif IsDefined('session.subset_id') and session.subset_id eq 12 >
	<cfset session.wantchips = 'N'>
<cfelse>
<cfset qNumOffset = qNumOffset + 1>

<tr>
		<TD colspan="2">
			<FONT FACE="arial"><B>&nbsp;<br>
<FONT face="Arial" size="3"><b>If you are a grandparent, or know a grandparent, raising grandchildren you are not alone. Six percent of US children under 18 (3.9 million) live in grandparent-headed households. Additionally, over ten million children age 18 or under have no health insurance. Many families don't know their children are eligible for health insurance.</b></font><br>&nbsp;
		</td>
</tr>
<tr>
		<TD WIDTH="35" valign="top">
			<FONT FACE="arial"><B>
#Evaluate("session.shownumber + qNumOffset")#.</b></td>
		<TD VALIGN="top">
 <FONT face="Arial" size="3">We want to make sure that every child has adequate health insurance.  Do you know of any children, age 18 or younger, who do not have health insurance coverage?
					</font></td>
				</tr>
				<TR>
					<TD>
					</TD>
					<TD><font face="arial">
<CF_TagYeWhiteSpace>
<INPUT TYPE="radio" NAME="WantChips" VALUE="Y">Yes &nbsp;&nbsp;
<INPUT TYPE="radio" NAME="WantChips" VALUE="N" CHECKED>No</font>
					</td>
				</tr>
</cfif>


</table>
			
			<input type="hidden" name="sp_income_earned" value="">
			<input type="hidden" name="s_sp_income_earned" value="">
			<input type="hidden" name="hh_income_earned" value="">

			<input type="hidden" name="sp_income_other_nw" value="">
			<input type="hidden" name="s_sp_income_other_nw" value="">
			<input type="hidden" name="hh_income_other_nw" value="">

			<input type="hidden" name="sp_asset_other_a" value="">
			<input type="hidden" name="s_sp_asset_other_a" value="">
			<input type="hidden" name="hh_asset_other_a" value="">


			<input type="hidden" name="s_income_pri_retire" value="">
			<input type="hidden" name="sp_income_pri_retire" value="">
			<input type="hidden" name="s_sp_income_pri_retire" value="">
			<input type="hidden" name="hh_income_pri_retire" value="">
			<input type="hidden" name="s_income_dividends" value="">
			<input type="hidden" name="sp_income_dividends" value="">
			<input type="hidden" name="s_sp_income_dividends" value="">
			<input type="hidden" name="hh_income_dividends" value="">
			<input type="hidden" name="s_income_ssi" value="">
			<input type="hidden" name="sp_income_ssi" value="">
			<input type="hidden" name="s_sp_income_ssi" value="">
			<input type="hidden" name="hh_income_ssi" value="">
			<input type="hidden" name="s_income_ss_disable" value="">
			<input type="hidden" name="sp_income_ss_disable" value="">
			<input type="hidden" name="s_sp_income_ss_disable" value="">
			<input type="hidden" name="hh_income_ss_disable" value="">
			<input type="hidden" name="s_income_ss_retire" value="">
			<input type="hidden" name="sp_income_ss_retire" value="">
			<input type="hidden" name="s_sp_income_ss_retire" value="">
			<input type="hidden" name="hh_income_ss_retire" value="">
			<input type="hidden" name="s_income_rr_ben" value="">
			<input type="hidden" name="sp_income_rr_ben" value="">
			<input type="hidden" name="s_sp_income_rr_ben" value="">
			<input type="hidden" name="hh_income_rr_ben" value="">
			<input type="hidden" name="s_income_vet_ben" value="">
			<input type="hidden" name="sp_income_vet_ben" value="">
			<input type="hidden" name="s_sp_income_vet_ben" value="">
			<input type="hidden" name="hh_income_vet_ben" value="">
			<input type="hidden" name="s_income_unemploy" value="">
			<input type="hidden" name="sp_income_unemploy" value="">
			<input type="hidden" name="s_sp_income_unemploy" value="">
			<input type="hidden" name="hh_income_unemploy" value="">
			<input type="hidden" name="s_income_tanf" value="">
			<input type="hidden" name="sp_income_tanf" value="">
			<input type="hidden" name="s_sp_income_tanf" value="">
			<input type="hidden" name="hh_income_tanf" value="">
			<input type="hidden" name="s_income_cash_assist" value="">
			<input type="hidden" name="sp_income_cash_assist" value="">
			<input type="hidden" name="s_sp_income_cash_assist" value="">
			<input type="hidden" name="hh_income_cash_assist" value="">
			
			<input type="hidden" name="s_asset_cash" value="">
			<input type="hidden" name="sp_asset_cash" value="">
			<input type="hidden" name="s_sp_asset_cash" value="">
			<input type="hidden" name="hh_asset_cash" value="">
			<input type="hidden" name="s_asset_auto1" value="">
			<input type="hidden" name="sp_asset_auto1" value="">
			<input type="hidden" name="s_sp_asset_auto1" value="">
			<input type="hidden" name="hh_asset_auto1" value="">
			<input type="hidden" name="s_asset_auto2" value="">
			<input type="hidden" name="sp_asset_auto2" value="">
			<input type="hidden" name="s_sp_asset_auto2" value="">
			<input type="hidden" name="hh_asset_auto2" value="">
			<input type="hidden" name="s_asset_home" value="">
			<input type="hidden" name="sp_asset_home" value="">
			<input type="hidden" name="s_sp_asset_home" value="">
			<input type="hidden" name="hh_asset_home" value="">
			<input type="hidden" name="s_asset_retirement" value="">
			<input type="hidden" name="sp_asset_retirement" value="">
			<input type="hidden" name="s_sp_asset_retirement" value="">
			<input type="hidden" name="hh_asset_retirement" value="">
			<input type="hidden" name="s_asset_stocks" value="">
			<input type="hidden" name="sp_asset_stocks" value="">
			<input type="hidden" name="s_sp_asset_stocks" value="">
			<input type="hidden" name="hh_asset_stocks" value="">
			<input type="hidden" name="s_asset_life_cash" value="">
			<input type="hidden" name="sp_asset_life_cash" value="">
			<input type="hidden" name="s_sp_asset_life_cash" value="">
			<input type="hidden" name="hh_asset_life_cash" value="">
			<input type="hidden" name="s_asset_life_face" value="">
			<input type="hidden" name="sp_asset_life_face" value="">
			<input type="hidden" name="s_sp_asset_life_face" value="">
			<input type="hidden" name="hh_asset_life_face" value="">
			<input type="hidden" name="s_asset_revocable" value="">
			<input type="hidden" name="sp_asset_revocable" value="">
			<input type="hidden" name="s_sp_asset_revocable" value="">
			<input type="hidden" name="hh_asset_revocable" value="">
			<input type="hidden" name="s_asset_irrevocable" value="">
			<input type="hidden" name="sp_asset_irrevocable" value="">
			<input type="hidden" name="s_sp_asset_irrevocable" value="">
			<input type="hidden" name="hh_asset_irrevocable" value="">
			<INPUT TYPE="hidden"  NAME="s_income_earned" value="">
			<INPUT TYPE="hidden" NAME="s_asset_other_a" value="">
<br>
	<font face="Arial" size="3">
    <b><input type="submit" name="Submit" value="Next"></b>
	<INPUT type="hidden" name="shownumber" value="#Evaluate("session.ShowNumber + qNumOffset + 1")#">
    </font>
	</form>

	
	</cfoutput>

