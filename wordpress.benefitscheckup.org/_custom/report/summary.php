<p><ul>
<li>You live in <?php echo $state; ?>  (zip code: <?php echo $mqc_zipcode; ?>) </li>
<li>You are <?php 

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

//$age = 74;
//$age = $birthmonth;
$bdate = new DateTime();
$today = new DateTime();
$today->setDate($birthyear, $birthmonth, $birthday);
$ageInterval = $today->diff($bdate);
$age = $ageInterval->y;
   //echo "Age is:".$age;
echo $age; ?> years old</li>
<?php 
//print_r($AF_array);
$AFrow_index = searchForId('mqc_receivingparta', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ( $af == 'y' ) {
echo "<li>You have Medicare Part A";

$AFrow_index = searchForId('mqc_receivingparb', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y' ) {
echo ", Medicare Part B";
}
$AFrow_index = searchForId('mqc_receivepartd', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo " and Medicare Part D";
}
echo "</li>";
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
echo "<li>You have just recently enrolled in Medicare</li>";
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
echo "<li>You are receiving TRICARE benefits</li>";
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
$AFrow_index = searchForId('mqc_receivingspap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You are receiving a State Pharmaceutical Assistance Program (SPAP)</li>";
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
echo "<li>You expect to enroll in Medicare within the next year</li>";
}

$AFrow_index = searchForId('mqc_medigap', $AF_array);
$af = $AF_array[$AFrow_index]["option_code"];
if ($af == 'y') {
echo "<li>You have a Medigap Policy</li>";
}
?>
</ul></p>
