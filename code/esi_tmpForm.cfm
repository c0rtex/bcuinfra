<!-- These values need to be placed elsewhere in the screening -->

<!-- END OBSOLESCENT -->

<!-- Initialize session.screening structure -->

<!-- The two variables below should be phased out along with all basic session-scope answerfields -->

<!--cfoutput action="get" app="#isApplication#" state_id="#sqState#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>BenefitsCheckUp for NCOA's Economic Security Initiative</title>
<style type="text/css">
<!--
body {
	background-image: url(http://bcuqa.benefitscheckup.org/esi_demo/images/bg_green.jpg);
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="http://bcuqa.benefitscheckup.org/css/ncoa_textstyles.css" rel="stylesheet" type="text/css" />
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org/css/fit.css" type="text/css" media="screen" />
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org/css/plmenu.css" type="text/css" media="screen" />
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org/css/screening.css" type="text/css" />
<!--[if IE]>
<link rel=stylesheet href="http://bcuqa.benefitscheckup.org//css/plmenuie.css" type="text/css" media="screen" />
<![endif]-->

<link rel=stylesheet href="http://bcuqa.benefitscheckup.org/css/print_pl.css" type="text/css" media="print">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
</head>

<body>
<form action="" name="esi_form" method="post" >
	<table width="902" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="1" colspan="3" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="1" height="1" /></td>
		</tr>
		<tr>
			<td width="1" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="1" height="1" /></td>
			<td align="right" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="4" align="center"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/image_topheader.jpg" width="862" height="91" /></td>
					</tr>
					<tr>
						<td height="1" colspan="4" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="1" height="1" /></td>
					</tr>
					<tr>
						<td colspan="4" align="center"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/image_subheader-5min.jpg" width="857" height="97" /></td>
					</tr>
					<tr>
						<td colspan="4" align="center"><table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr class="mainText">
									<td width="45">&nbsp;</td>
									<td width="31" align="left" valign="top">1.</td>
									<td width="391" align="left" valign="top">For whom are you completing this screening? </td>
									<td colspan="2" align="right" valign="top"><select name="esi_client" id="esi_client">
											<option value="" selected="selected">-- Select one --</option>
											<option value="1353-self">Self </option>
											<option value="2345-spouse">Spouse </option>
											<option value="1354-mother">Mother </option>
											<option value="1355-father">Father </option>
											<option value="1358-client">Client </option>
											<option value="1360-other">Other </option>
									</select>
										<br />
										<div id="client_textbox">
											<input type="text" name="esi_client_name" value="this field hidden unless Client selected" />
										</div>
										<div id="other_textbox">
											<input type="text" name="esi_other_name" value="this field hidden unless Other selected" />
										</div></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td width="136" align="right" valign="top">&nbsp;</td>
									<td width="153" align="right" valign="top">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td align="left" valign="top"><span class="mainText">2.</span></td>
									<td align="left" valign="top"><span class="mainText">Zip Code: </span></td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top"><span class="mainText">
										<input name="esi_zip" type="text" id="esi_zip" size="15" maxlength="5" />
										</span></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">3.</td>
									<td align="left" valign="top">Please enter your month and year of birth. (mm/yyyy)</td>
									<td colspan="2" align="right" valign="top"><input name="esi_birth" type="text" id="esi_zip" size="15" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">4.</td>
									<td align="left" valign="top">What is your marital status?</td>
									<td colspan="2" align="right" valign="top"><select name="esi_marital" id="esi_marital">
											<option value="" selected="selected">-- Select one --</option>
											<option value="1361-married_living_sep">Married Living Separately </option>
											<option value="4-married">Married </option>
											<option value="5-divorced">Divorced </option>
											<option value="6-single">Single </option>
											<option value="7-widowed">Widowed </option>
											<option value="2477-esi_living_with_partner">Living with Partner </option>
									</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">5.</td>
									<td align="left" valign="top">What is your gender?</td>
									<td colspan="2" align="right" valign="top"><select name="esi_gender" id="esi_gender">
											<option value="" selected="selected">-- Select one --</option>
											<option value="2-male">Male </option>
											<option value="3-female">Female </option>
									</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">6.</td>
									<td align="left" valign="top">What is your race/ethnicity? (optional)</td>
									<td colspan="2" align="right" valign="top"><select name="esi_race" id="esi_race">
											<option value="" selected="selected">-- Select one --</option>
											<option value="2478-esi_asian_pacific_islander"> Asian/Pacific Islander </option>
											<option value="2479-esi_black_african_american"> African American </option>
											<option value="2480-esi_caucasian_white"> Caucasian </option>
											<option value="2481-esi_hispanic_latin_american"> Hispanic </option>
											<option value="1385-other_race"> Other Race</option>
									</select></td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/subheader_5min_income.jpg" width="747" height="66" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">7.</td>
									<td align="left" valign="top">How challenging is it for you to provide for your basic needs on a monthly basis?</td>
									<td colspan="2" align="right" valign="top">
									<select name="esi_basicneeds">
											<option value="" selected="selected">-- Select one --</option>
											<option value="6539-esi_notachallenge"> Not a challenge </option>
											<option value="6540-esi_canbeachallenge"> Can be a challenge </option>
											<option value="6541-esi_isachallenge"> Is a challenge every month </option>
											<option value="6542-esi_ineedassistance"> Every month I need assistance </option>
											<option value="6543-esi_cannotmeetobligations"> Cannot meet obligations even with assistance </option>
										</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">8. </td>
									<td align="left" valign="top">What is the gross total monthly income for you and, if applicable, your spouse/partner from all sources before taxes and other deductions? Include income from Social Security, VA compensation/pension, dividends, interest, private pensions, retirement benefits, work, rental income, unemployment compensation, etc.</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">$
										<input name="esi_grossmonthlyincome" type="text" id="esi_grossmonthlyincome" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">9.</td>
									<td align="left" valign="top">Please enter your total value of assets (excluding the value of your home). </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">$
										<input name="esi_totalassets" type="text" id="esi_totalassets" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">10.</td>
									<td align="left" valign="top">How many people in your household does your income support (Including yourself)? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input name="esi_incomesupport" type="text" id="esi_incomesupport" value="" size="20" maxlength="3" />
									</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">11.</td>
									<td align="left" valign="top">Do you have any dependants? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_dependants" id="esi_dependants" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_dependants" id="esi_dependants" value="N" checked="checked" />
										No
									</td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/subheader_5min_employment.jpg" width="747" height="66" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">12. </td>
									<td colspan="2" align="left" valign="top">Please select the item that best describes your situation: </td>
									<td align="right" valign="top">
										<select name="esi_employmentsituation_list" id="esi_employmentsituation_list">
											<option value="" selected="selected">-- Select one --</option>
											<option value="2482-esi_employmentsituation_retired">Retired</option>
											<option value="2483-esi_employmentsituation_employed">Employed</option>
											<option value="2484-esi_employmentsituation_seeking">Seeking employment</option>
											<option value="2485-esi_employmentsituation_underemp">Underemployed</option>
											<option value="2486-esi_employmentsituation_none">None of the above</option>
										</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">13.</td>
									<td colspan="2" align="left" valign="top"> If you are seeking employment, please check all that apply.</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="right" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_seekingemployment_usehelp" type="checkbox" id="esi_seekingemployment_usehelp" value="Y" />
													I could use help with the job search. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_seekingemployment_refresher" type="checkbox" id="esi_seekingemployment_refresher" value="Y" />
													I could benefit from an online employment skill refresher course.</td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/subheader_5min_debt.jpg" width="747" height="66" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">14. </td>
									<td align="left" valign="top">Do you have any non-housing debt (credit cards, car loan, personal loan, etc.)?</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_nonhousingdebt" id="esi_nonhousingdebt" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_nonhousingdebt" id="esi_nonhousingdebt" value="N" checked="checked" />
										No
									</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">If Yes, please estimate the total amount of debt:</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">$<input name="esi_debtestimate" type="text" id="esi_debtestimate" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">15. </td>
									<td align="left" valign="top">Do any of these scenarios describe your situation? (select all that apply)</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_debtscenarios_creditlimit" type="checkbox" id="esi_debtscenarios_creditlimit" value="Y" />
													I am near or at the limit of my lines of credit. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_debtscenarios_minimum" type="checkbox" id="esi_debtscenarios_minimum" value="Y" />
													I can only make the minimum payments on my credit cards.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_debtscenarios_creditors" type="checkbox" id="esi_debtscenarios_creditors" value="Y" />
													I am receiving calls from creditors about overdue bills.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_debtscenarios_bankruptcy" type="checkbox" id="esi_debtscenarios_bankruptcy" value="Y" />
													I am considering filing for bankruptcy.</td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">16.</td>
									<td align="left" valign="top">Would you like help in balancing your budget, lowering costs, reducing debt, applying for senior help programs, and/or staying on top of your finances?</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_helpbalancing" id="esi_helpbalancing" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_helpbalancing" id="esi_helpbalancing" value="N" checked="checked" />
										No</td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/subheader_5min_housing.jpg" width="747" height="66" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">17.</td>
									<td align="left" valign="top">In what type of housing do you live?</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<select name="esi_housingtype" id="esi_housingtype">
											<option value="" selected="selected">-- Select one --</option>
											<option value="2487-esi_housingtype_own">Own Home</option>
											<option value="2488-esi_housingtype_rent">Rent Dwelling</option>
											<option value="2489-esi_housingtype_liveothers">Live w/ Others</option>
											<option value="2490-esi_housingtype_subsidized">Subsidized Housing</option>
											<option value="2491-esi_housingtype_homeless">Homeless/Shelter</option>
										</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"> <strong>If you are not a homeowner, skip to question 22.</strong></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">18. </td>
									<td colspan="2" align="left" valign="top">What is the estimated value of your house?</td>
									<td align="right" valign="top">$<input name="esi_estimatedvalue" type="text" id="esi_estimatedvalue" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">19.</td>
									<td colspan="2" align="left" valign="top">What is the total outstanding debt on your house (mortgage/other home loans)?</td>
									<td align="right" valign="top">$<input name="esi_totaldebthouse" type="text" id="esi_totaldebthouse" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">20.</td>
									<td align="left" valign="top">Do you have homeowner's insurance? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_homeinsurance" id="esi_homeinsurance" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_homeinsurance" id="esi_homeinsurance" value="N" checked="checked" />
										No</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">21.</td>
									<td colspan="3" align="left" valign="top">Please check all of the items below that describe your situation.</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
Y												<td align="left" valign="top"><input name="esi_housingsituation_mortgagepaidoff" type="checkbox" id="esi_housingsituation_mortgagepaidoff" value="" />
													My mortgage is paid off, but I have difficulty the utility and property tax payments are a challenge. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_housingsituation_underwater" type="checkbox" id="esi_housingsituation_underwater" value="Y" />
													The value of my mortgage exceeds the current value of my home.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_housingsituation_someequity" type="checkbox" id="esi_housingsituation_someequity" value="Y" />
													I have some equity in my home, but am having a difficult time with my monthly bills. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_housingsituation_foreclosure" type="checkbox" id="esi_housingsituation_foreclosure" value="Y" />
													I am behind on my mortgage and/or property taxes and am possibly facing foreclosure. </td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">22.</td>
									<td colspan="3" align="left" valign="top">Please check all of the items below that describe your situation.</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"> <strong>If you are not renting, skip to next question..</strong></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_rent_difficultypaying" type="checkbox" id="esi_rent_difficultypaying" value="Y" />
													I am able to pay my rent, but am having difficulty paying my other expenses. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_rent_behind" type="checkbox" id="esi_rent_behind" value="Y" />
													I am behind on my rent.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_rent_eviction" type="checkbox" id="esi_rent_eviction" value="Y" />
													I am behind on my rent and facing eviction. </td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">23.</td>
									<td align="left" valign="top"> What are your household's monthly, out of pocket, costs for heating fuel, gas, electricity, water, telephone, property taxes, homeowner's insurance, and rent or mortgage payments ?</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">$<input name="esi_outofpocket" type="text" id="esi_outofpocket" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top">MOBILITY HEADER HERE</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">24.</td>
									<td colspan="3" align="left" valign="top">Please select which best describes your mobility.</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_mobility_owncar" type="checkbox" id="esi_mobility_owncar" value="Y" />
													Own automobile or have transportation readily available.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_mobility_useavailable" type="checkbox" id="esi_mobility_useavailable" value="Y" />
													Use available transportation to meet basic needs with or without subsidies.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_mobility_limited" type="checkbox" id="esi_mobility_limited" value="Y" />
													Limited transportation depending on subsidies to access transportation. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_mobility_unreliable" type="checkbox" id="esi_mobility_unreliable" value="Y" />
													Transportation unreliable and/or unaffordable. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_mobility_notransportation" type="checkbox" id="esi_mobility_notransportation" value="Y" />
													No personal transportation or access to public transportation.</td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top">FOOD HEADER HERE</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">25.</td>
									<td colspan="3" align="left" valign="top">Please select which best describes your access and type of meals.</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_meals_balanced" type="checkbox" id="esi_meals_balanced" value="Y" />
													Well balanced meals with or without assistance.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_meals_withassistance" type="checkbox" id="esi_meals_withassistance" value="Y" />
													Daily well-balanced meals with social and/or community assistance.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_meals_relyonassistance" type="checkbox" id="esi_meals_relyonassistance" value="Y" />
													Relies on community/social assistance for basic nutritional needs.</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_meals_inadequate" type="checkbox" id="esi_meals_inadequate" value="Y" />
													Food inadequate for nutritional needs. </td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_meals_nofood" type="checkbox" id="esi_meals_nofood" value="Y" />
													No food and at risk for malnutrition.</td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td colspan="5" align="left" valign="top"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/subheader_5min_health.jpg" width="747" height="66" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">26. </td>
									<td align="left" valign="top">How would you rate your health? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
									<select name="esi_ratehealth" id="esi_ratehealth">
											<option value="" selected="selected">-- Select one --</option>
											<option value="esi_ratehealth_good">Good</option>
											<option value="esi_ratehealth_fair">Fair</option>
											<option value="esi_ratehealth_poor">Poor</option>
										</select></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">27. </td>
									<td align="left" valign="top">How much money do you spend monthly on medical expenses that are not covered by health insurance? For example, include your out-of-pocket costs for prescription drugs, doctor's fees, co-payments, transportation to doctor's visits, home health attendant's fees, health insurance premiums and annual deductibles, and medical equipment. </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">$<input name="esi_healthmonthly" type="text" id="esi_healthmonthly" value="" size="10" /></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">28.</td>
									<td align="left" valign="top">Do you have a chronic condition and/or disease? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_healthchronic" id="esi_healthchronic" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_healthchronic" id="esi_healthchronic" value="N" checked="checked" />
										No</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">29.</td>
									<td align="left" valign="top">Do you have a medically documented disability? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_healthdisability" id="esi_healthdisability" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_healthdisability" id="esi_healthdisability" value="N" checked="checked" />
										No</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">30.</td>
									<td align="left" valign="top">Are you enrolled in Medicare?</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_enrolledmedicare" id="esi_enrolledmedicare" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_enrolledmedicare" id="esi_enrolledmedicare" value="N" checked="checked" />
										No</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">31.</td>
									<td align="left" valign="top">If you are enrolled in Medicare, are you also enrolled in any of the following supplemental Medicare plans? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="3" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="50%" align="left" valign="top"><input name="esi_medicaresupplement_medigap" type="checkbox" id="esi_medicaresupplement_medigap" value="Y" />
													&nbsp;Medigap</td>
												<td width="50%" align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_medicaresupplement_medicareadvantage" type="checkbox" id="esi_medicaresupplement_medicareadvantage" value="Y" />
													&nbsp;Medicare Advantage </td>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td align="left" valign="top"><input name="esi_medicaresupplement_employer" type="checkbox" id="esi_medicaresupplement_employer" value="Y" />
													&nbsp;Employer sponsor retirement health insurance</td>
												<td align="left" valign="top">&nbsp;</td>
											</tr>
										</table></td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">32.</td>
									<td align="left" valign="top">Are you interested in meeting with a health insurance counselor to discuss ways to cut down on your out of pocket expenses? </td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">
										<input type="radio" name="esi_counselor" id="esi_counselor" value="Y" />
										Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="esi_counselor" id="esi_counselor" value="N" checked="checked" />
									No</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td colspan="2" align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
								</tr>
								<tr class="mainText">
									<td>&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="left" valign="top">&nbsp;</td>
									<td align="right" valign="top">&nbsp;</td>
									<td align="right" valign="top"><input type="submit" name="Submit" id="Submit" value="View Results" /></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr>
						<td width="30" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="25" height="1"></td>
						<td class="mainFooter" style="color: white; float: left; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px; font-weight: normal; padding: 4px 10px;" width="381" align="left" bgcolor="#002a5c">&copy; 2010 National Council on Aging. All rights reserved.</td>
						<td width="464" align="right" bgcolor="#002a5c"> <a href="#" class="mainFooterLinks" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;">Privacy Policy</a> <span class="mainFooter" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;">/ </span><a href="#" class="mainFooterLinks" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;">Terms of Use</a> <span class="mainFooter" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;">/</span> <a href="#" class="mainFooterLinks" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;">Feedback</a> <span class="mainFooter" style="color: white; font-family: verdana,arial,helvetica,sans-serif; font-size: 11px;"></span></td>

						<td width="25" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="25" height="1"></td>
					</tr>

				</table></td>
			<td width="1" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="1" height="1" /></td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="#002a5c"><img src="http://bcuqa.benefitscheckup.org/esi_demo/images/spacer.gif" width="1" height="1" /></td>
		</tr>
	</table>
	<input type="hidden" name="pgno" value="1">
	<input type="hidden" name="qno" value="31">
	<input type="hidden" name="aflist" value="">
	<input type="hidden" name="page" value="19">
	<input type="hidden" name="continue" value="2">
</form>
</body>
</html>
