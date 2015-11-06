<p><ul>
<li>You live in <?php echo $state; ?>  (zip code: <?php echo $mqc_zipcode; ?>) </li>
<li>Your birth date is <?php 
$spap_name = 'State Pharma Assistance Program';
$medicaid_name = 'Medicaid';
$AFrow_index = searchForId('mqc_birth_day', $AF_array);
$birthday = $AF_array[$AFrow_index]["response"];
$AFrow_index = searchForId('mqc_birth_month', $AF_array);
$birthmonth = $AF_array[$AFrow_index]["response"];
$AFrow_index = searchForId('mqc_birth_year', $AF_array);
$birthyear = $AF_array[$AFrow_index]["response"];
$birthday_padded = sprintf("%02s", $birthday);
$birthmonth_padded = sprintf("%02s", $birthmonth);
$date_birth = $birthmonth_padded.'/'.$birthday_padded .'/'.$birthyear;
$_SESSION['date_birth'] = $date_birth;
//echo $_SESSION['date_birth'];

//Calculation Enrollment Data
//mqc_group_insurance_self
//mqc_group_insurance_spouse
//mqc_medicare_enroll_disability_yes
$AFrow_index = searchForId('mqc_group_insurance_self', $AF_array);
$mqc_group_insurance_self = $AF_array[$AFrow_index]["option_code"];
$AFrow_index = searchForId('mqc_group_insurance_spouse', $AF_array);
$mqc_group_insurance_spouse = $AF_array[$AFrow_index]["option_code"];
$AFrow_index = searchForId('mqc_medicare_enroll_disability_yes', $AF_array);
$mqc_medicare_enroll_disability_yes = $AF_array[$AFrow_index]["option_code"];
$AFrow_index = searchForId('mqc_renaldisease', $AF_array);
$mqc_renaldisease = $AF_array[$AFrow_index]["option_code"];
//echo 'Renal Disease:'.$mqc_renaldisease;
//$age = 74;
//$age = $birthmonth;
$today = new DateTime();
$three_months = new DateTime();
$three_months = date_sub($three_months, date_interval_create_from_date_string('3 months'));
$date_of_birth = new DateTime();
$date_of_birth->setDate($birthyear, $birthmonth, $birthday);
//$dob_formatted = $date_of_birth;
$dob_formatted = $birthmonth.'/'.$birthday.'/'.$birthyear;
$ageInterval = $date_of_birth->diff($today);
$age = $ageInterval->y;
$ageInterval3months = $date_of_birth->diff($three_months);
$age3months = $ageInterval3months->y;

$enrollment_endyear=$birthyear + 65;
$enrollment_startyear=$birthyear + 65;
//set start and end months 3 months before and after birth month
$enrollment_startmonth = $birthmonth - 3; 
if ( $enrollment_startmonth < 1) {
$enrollment_startmonth = $enrollment_startmonth + 12;
$enrollment_startyear=$enrollment_startyear - 1;
} 
$enrollment_endmonth = $birthmonth + 3; 
if ( $enrollment_endmonth > 12) {
$enrollment_endmonth = $enrollment_endmonth - 12;
$enrollment_endyear = $enrollment_endyear + 1;
} 
$lastdayofmonth = 31;
if ($enrollment_endmonth == 9 ||$enrollment_endmonth == 4 || $enrollment_endmonth == 6 || $enrollment_endmonth == 11 ) {
  $lastdayofmonth = 30;
}
elseif($enrollment_endmonth == 2) {
  $lastdayofmonth = 28;
}
$enrollment_startdate = $enrollment_startmonth.'/'.'01'.'/'.$enrollment_startyear;
$enrollment_enddate = $enrollment_endmonth.'/'.$lastdayofmonth.'/'.$enrollment_endyear;
echo $dob_formatted; 
//echo "<br>Testing - Age less three months is ".$age3months;
?> </li>
<?php 
//echo "<li>Testing Group Insurance - Self: ".$mqc_group_insurance_self." Spouse: ".$mqc_group_insurance_spouse."<br></li>";
//print_r($date_of_birth);
//print_r($today);
//print_r($three_months);
//print_r($AF_array);

//medicare parts
$AFrow_index1 = searchForId('mqc_receivingparta', $AF_array);
$AFrow_index2 = searchForId('mqc_receivingparb', $AF_array);
$AFrow_index3 = searchForId('mqc_receivepartd', $AF_array);
$af = $AF_array[$AFrow_index1]["option_code"];
$af2 = $AF_array[$AFrow_index2]["option_code"];
$af3 = $AF_array[$AFrow_index3]["option_code"];
if (($af == 'y' ) && ($af2 == 'y' ) && ($af3 == 'y' )  )  {
echo "<li>You have Medicare Part A, Medicare Part B and Medicare Part D</li>";
}
elseif (($af == 'y' ) && ($af2 == 'y' ))  {
echo "<li>You have Medicare Part A and Medicare Part B</li>";
}
elseif (($af2 == 'y' ) && ($af3 == 'y' ))  {
echo "<li>You have Medicare Part B and Medicare Part D</li>";
}
elseif (($af == 'y' ) && ($af3 == 'y' ))  {
echo "<li>You have Medicare Part A and Medicare Part D</li>";
}
elseif ($af == 'y' )   {
echo "<li>You have Medicare Part A</li>";
}
elseif ($af2 == 'y' )   {
echo "<li>You have Medicare Part B</li>";
}
elseif ($af3 == 'y' )   {
echo "<li>You have Medicare Part D</li>";
}

$AFrow_index = searchForId('mqc_medicare_enroll_past_3_months', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You enrolled in Medicare in the past 3 months </li>";
} 
$AFrow_index = searchForId('mqc_medicare_enroll_within_3_months', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You expect to enroll in Medicare within 3 months</li>";
}

$AFrow_index = searchForId('mqc_medicare_enroll_within_1_year_yes', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You expect to enroll in Medicare within the next 12 months</li>";
}
$AFrow_index = searchForId('mqc_medicare_enroll_disability_yes', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You enrolled in Medicare before age 65 because of a disability</li>";
}
$AFrow_index = searchForId('mqc_medicare_enroll_disability_no', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You enrolled in Medicare within the past 3 months (not due to a disability)</li>";
}
$AFrow_index = searchForId('mqc_medicare_enroll_age_65', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You first became eligible for Medicare when you turned age 65 and you have already been enrolled for more than 3 months</li>";
}
$AFrow_index = searchForId('mqc_not_sure_medicare_qualify', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are not sure if you qualify for Medicare</li>";
}

$AFrow_index = searchForId('mqc_not_receiving_parta', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You do not have Medicare Part A because you did not pay into Social Security for at least 40 quarters</li>";
}
$AFrow_index = searchForId('mqc_not_eligible_parta', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are not eligible for Medicare Part A</li>";
}

$AFrow_index = searchForId('mqc_originalmedicare', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Original Medicare</li>";
}

$AFrow_index = searchForId('mqc_medhealthplan', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have a Medicare Health Plan</li>";
}
$AFrow_index = searchForId('mqc_justenrolled', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have just recently enrolled in Medicare but have not selected your health insurance coverage</li>";
}

$AFrow_index = searchForId('mqc_covers_healthcare_and_drugs', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>Your plan covers health care and drugs</li>";
} 

$AFrow_index = searchForId('mqc_covers_healthcare_no_drugs', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>Your plan only covers health care, not drugs</li>";
} 

$AFrow_index = searchForId('mqc_covers_two_medicare_plans', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have two Medicare Plans; a health plan and a drug plan</li>";
}
$AFrow_index = searchForId('mqc_receivingrrb', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Railroad Retirement Board (RRB) benefits</li>";
}
$AFrow_index = searchForId('mqc_receivingtricare', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have TRICARE for Life (TFL)</li>";
}
$AFrow_index = searchForId('mqc_recvetben', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Veterans Health benefits</li>";
}
$AFrow_index = searchForId('mqc_govben', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Federal Employees Health Benefits Plan (FEHB) or State or Local retiree health benefits</li>";
}
$AFrow_index = searchForId('mqc_helpmedicaid', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Medicaid</li>";
}
$AFrow_index = searchForId('mqc_belongmsp', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Medicare Savings Program (MSP)</li>";
}

$AFrow_index = searchForId('mqc_receivinglis', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Medicare Part D Low-Income Subsidy (Extra Help)</li>";
}
//SPAPS
$AFrow_index = searchForId('mqc_receivingspap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving a State Pharmaceutical Assistance Program (SPAP)</li>";
$spap_name = 'State Pharmaceutical Assistance Program (SPAP)';
}
$AFrow_index = searchForId('rec_wi_seniorcare', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Wisconsin SeniorCare (State Pharmacy Assistance Program)</li>";
$spap_name = 'Wisconsin SeniorCare (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_wa_pdp', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Washington Prescription Drug Program</li>";
$spap_name = 'Washington Prescription Drug Program';
}
$AFrow_index = searchForId('rec_vt_vpharm_and_healthyvermonters', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving VPharm or Healthy Vermonters</li>";
$spap_name = 'VPharm or Healthy Vermonters';
}
$AFrow_index = searchForId('rec_ri_ripae', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Rhode Island Pharmaceutical Assistance to the Elderly (RIPAE)</li>";
$spap_name = 'Rhode Island Pharmaceutical Assistance to the Elderly (RIPAE)';
}
$AFrow_index = searchForId('rec_pa_pace_pacenet', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving PACE or PACENET (Pharmaceutical Assistance Contract for the Elderly)</li>";
$spap_name = 'PACE or PACENET (Pharmaceutical Assistance Contract for the Elderly)';
}
$AFrow_index = searchForId('rec_or_pdap_2', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Oregon Prescription Drug Assistance</li>";
$spap_name = 'Oregon Prescription Drug Assistance';
}
$AFrow_index = searchForId('rec_ny_epic', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Elderly Pharmaceutical Insurance Coverage (EPIC)</li>";
$spap_name = 'Elderly Pharmaceutical Insurance Coverage (EPIC)';
}
$AFrow_index = searchForId('rec_nv_seniorrx', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Nevada Senior Rx (State Pharmacy Assistance Program)</li>";
$spap_name = 'Nevada Senior Rx (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_nj_paad', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Pharmaceutical Assistance to the Aged & Disabled (PAAD)</li>";
$spap_name = 'Pharmaceutical Assistance to the Aged & Disabled (PAAD)';
}
$AFrow_index = searchForId('rec_mt_bigskyrx', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Montana Big Sky Rx Program (State Pharmacy Assistance Program)</li>";
$spap_name = 'Montana Big Sky Rx Program (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_mo_rxplan', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Missouri Rx Plan (State Pharmacy Assistance Program)</li>";
$spap_name = 'Missouri Rx Plan (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_me_del_and_rxplus', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Maine Low Cost Drugs for the Elderly or Disabled (DEL) or Maine Rx Plus</li>";
$spap_name = 'Maine Low Cost Drugs for the Elderly or Disabled (DEL) or Maine Rx Plus';
}

$AFrow_index = searchForId('rec_ak_seniorbenefits', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Alaska Senior Benefits</li>";
$spap_name = 'Alaska Senior Benefits';
}
$AFrow_index = searchForId('rec_de_dpap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Delaware Prescription Assistance Program (DPAP)</li>";
$spap_name = 'Delaware Prescription Assistance Program (DPAP)';
}
$AFrow_index = searchForId('rec_in_hoosierrx', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving HoosierRx (State Pharmacy Assistance Program)</li>";
$spap_name = 'HoosierRx (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_ma_prescriptionadvantage', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Prescription Advantage Plan (State Pharmacy Assistance Program)</li>";
$spap_name = 'Prescription Advantage Plan (State Pharmacy Assistance Program)';
}
$AFrow_index = searchForId('rec_md_spdap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Maryland Senior Prescription Drug Assistance Program (SPDAP)</li>";
$spap_name = 'Maryland Senior Prescription Drug Assistance Program (SPDAP)';
}


$AFrow_index = searchForId('mqc_helpmedicaid_az', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have AHCCCS</li>";
$medicaid_name = 'AHCCCS';
}
$AFrow_index = searchForId('mqc_helpmedicaid_ca', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Medi-Cal</li>";
$medicaid_name = 'Medi-Cal';
}
$AFrow_index = searchForId('mqc_helpmedicaid_ct', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Husky C</li>";
$medicaid_name = 'Husky C';
}
$AFrow_index = searchForId('mqc_helpmedicaid_il', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Medical Assistance</li>";
$medicaid_name = 'Medical Assistance';
}
$AFrow_index = searchForId('mqc_helpmedicaid_ky', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have KyHealth Choices</li>";
$medicaid_name = 'KyHealth Choices';
}
$AFrow_index = searchForId('mqc_helpmedicaid_ma', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have MassHealth</li>";
$medicaid_name = 'MassHealth';
}
$AFrow_index = searchForId('mqc_helpmedicaid_mo', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have HealthNet</li>";
$medicaid_name = 'HealthNet';
}

$AFrow_index = searchForId('mqc_helpmedicaid_me', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have MaineCare</li>";
$medicaid_name = 'MaineCare';
}
$AFrow_index = searchForId('mqc_helpmedicaid_pa', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Medical Assistance</li>";
$medicaid_name = 'Medical Assistance';
}
$AFrow_index = searchForId('mqc_helpmedicaid_tn', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have TennCare</li>";
$medicaid_name = 'TennCare';
}
$AFrow_index = searchForId('mqc_helpmedicaid_wi', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have ForwardHealth Plan</li>";
$medicaid_name = 'ForwardHealth Plan';
}
$AFrow_index = searchForId('mqc_helpmedicaid_wy', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have EqualityCare</li>";
$medicaid_name = 'EqualityCare';
}

$AFrow_index = searchForId('mqc_receiving_ssi_retirement', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Social Security Retirement/Railroad Retirement or Survivors Benefits</li>";
}
$AFrow_index = searchForId('mqc_receiving_ssdi', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Social Security Disability Income (SSDI)</li>";
}
$AFrow_index = searchForId('mqc_receiving_ssi', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving Supplemental Security Income (SSI)</li>";
}
$AFrow_index = searchForId('mqc_livenursingfacility', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are currently living in a skilled nursing facility </li>";
} 


$AFrow_index = searchForId('mqc_renaldisease', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have End-Stage Renal Disease (ESRD)</li>";
}  
$AFrow_index = searchForId('mqc_als', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have Amyotrophic Lateral Sclerosis (ALS or Lou Gehrig's disease)</li>";
} 
$AFrow_index = searchForId('mqc_medicare_drug_plan', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have a separate Medicare Drug Plan</li>";
} 
$AFrow_index = searchForId('mqc_medigap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have a Medigap Policy</li>";
}
if ($mqc_group_insurance_self == 'y') {
echo "<li>You still work and have group health insurance from your current employer</li>";
}
if ($mqc_group_insurance_spouse == 'y') {
echo "<li>Your spouse still works and you have group health insurance from his/her current employer</li>";
}

$AFrow_index = searchForId('mqc_employees_lt_20_self', $AF_array);
$mqc_employees_lt_20_self = $AF_array[$AFrow_index]["option_code"];
if ($mqc_employees_lt_20_self == 'y') {
echo "<li>You work for a company with fewer than 20 employees</li>";
} 
$AFrow_index = searchForId('mqc_employees_gt_20_self', $AF_array);
$mqc_employees_gt_20_self = $AF_array[$AFrow_index]["option_code"];
if ($mqc_employees_gt_20_self == 'y') {
echo "<li>You work for a company with 20 or more employees and less than 100 employees</li>";
} 
$AFrow_index = searchForId('mqc_employees_gt_100_self', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You work for a company with 100 or more employees</li>";
} 

$AFrow_index = searchForId('mqc_employees_lt_20_spouse', $AF_array);
$mqc_employees_lt_20_spouse = $AF_array[$AFrow_index]["option_code"];
if ($mqc_employees_lt_20_spouse == 'y') {
echo "<li>Your spouse works for a company with fewer than 20 employees</li>";
} 
$AFrow_index = searchForId('mqc_employees_gt_20_spouse', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>Your spouse works for a company with 20 or more employees and less than 100 employees</li>";
} 
$AFrow_index = searchForId('mqc_employees_gt_100_spouse', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>Your spouse works for a company with 100 or more employees</li>";
} 

$AFrow_index = searchForId('mqc_former_employer_retiree_benefit', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have retiree health benefits from your or your spouse's former employer</li>";
} 
$AFrow_index = searchForId('mqc_individual_insurance', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have individual insurance (not from an employer or union) that you pay for yourself</li>";
} 
$AFrow_index = searchForId('mqc_cobra', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have COBRA or your spouse has COBRA (which also provides coverage for you)</li>";
} 
$AFrow_index = searchForId('mqc_other_insurance', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have other additional insurance such as hospital indemnity or critical illness</li>";
} 
$AFrow_index = searchForId('mqc_health_insurance_creditable', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have creditable coverage for your prescription drugs</li>";
} 





// sep and iep charts
$showIEP = 0;
$showSEP = 0;
if ($mqc_renaldisease != 'y' and $mqc_medicare_enroll_disability_yes != 'y' and $mqc_group_insurance_self != 'y' and $mqc_group_insurance_spouse != 'y') {
$showIEP = 1;
}
elseif (($mqc_group_insurance_self == 'y' || $mqc_group_insurance_spouse == 'y') and ($mqc_medicare_enroll_disability_yes != 'y') and ($mqc_renaldisease != 'y') and ($mqc_employees_lt_20_spouse != 'y') and ($mqc_employees_lt_20_self != 'y'))  {
$showSEP = 1;
}
?>
</ul></p>
