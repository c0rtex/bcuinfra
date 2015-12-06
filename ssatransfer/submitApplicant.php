<?php  
/*
This template accepts a screening id from the previous page, queries the field data related to the screening id, uses the curl utilitity to send data page by page to ssa.gov
TABLES: screening, screening_answerfield, answerfield, screening_submission
*/
require_once("includes/config.php");  //always have to include this
require_once(INCLUDES_DIR."Logger.php");
require_once(INCLUDES_DIR."encryption.php");
require_once("Validate.php");
$debug = false;
$smarty = new SetupSmarty;
if ($debug == false){$smarty->display("submitApplicant.tpl");}

$screening_id = $_GET['Screening_id'];
$isBatch = "false";
if (isset($_GET['batch']))
{
	$isBatch = $_GET["batch"];
}

/*
$query = "SELECT screening_id FROM screening_submission WHERE screening_id = '".$screening_id."' ";
$result = $GLOBALS['db']->query($query);
if($result->numRows() > 0)
{
	$log->write("<!---------------------screening_id $screening_id already exists---------------------");
}
*/
//else //only create a new submission if one doesn't exist for the screening_id
if( Validate::number($screening_id) ) //scrub user input to check for sql injection
{
	$md5_ssn = md5($answers['BE_CLNT_COSSN']);//MH-encrypt ssn
	$query = "INSERT INTO screening_submission (screening_id, post_start_time) VALUES('".$screening_id."', now() )";//MH-Associates screening_id with submission rec
	$GLOBALS['db']->query($query);
	$query = "SELECT max(submission_id) FROM screening_submission"; 
	$submission_id = $GLOBALS['db']->getOne($query);//MH-//grabs submission record 
}
else
{
	echo "Invalid screening_id";
	exit;
}

 //MH-grabs data associated with this sreening_id ie all application info tied to this screening_id
$query = "SELECT a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code, sa.encryption_flag, sa.encrypted_response
         	FROM answerfield a 
         	INNER JOIN screening_answerfield sa ON a.answerfield_id = sa.answerfield_id 
          	LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id
          	WHERE     (sa.screening_id = '".$screening_id."')
          	ORDER BY a.answerfield ";
$result = $GLOBALS['db']->getAll($query, DB_FETCHMODE_ASSOC);

//MH-loop thru the data pulled per stored per application/screening_id and store them in the 'answers' array with a format consistent with SSA 
foreach($result as $row)
{
	$fieldname = strtoupper($row['answerfield']); //change all values to uppercase to be consistent with ssa
	if($row['encryption_flag'] == 1){
		$answers[$fieldname] = decryptString($row['encrypted_response']);
		if ($debug) { echo $answers[$fieldname]." was encrypted ".$row['response']."<br>"; }
	}
	else if($row['responsetype'] == 3){
		$answers[$fieldname] = $row['option_code'];
	}
	else{
		$answers[$fieldname] = $row['response'];
	}
	if ($debug) { echo $fieldname." is ".$row['response']."<br>";}
}


//$answers['CT_CLNT_COSSN'] = $answers['BE_CLNT_COSSN'];
//$answers['CT_NONCL_COSSN'] = $answers['BE_NONCL_COSSN'];

$normal_ssn1 = str_replace('-','',$answers['CT_CLNT_COSSN']);
$normal_ssn2 = str_replace('-','',$answers['CT_NONCL_COSSN']);
$hide_ssn1 = "XXXXX".substr($normal_ssn1,-4);
$hide_ssn2 = "XXXXX".substr($normal_ssn2,-4);

$hide_last_name1 = "XXXX".substr($answers['BE_CLNT_LNM'], -4);
$hide_first_name1 = "XXXX".substr($answers['BE_CLNT_FNM'], -4);
$hide_last_name2 = "XXXX".substr($answers['BE_NONCL_LNM'], -4);
$hide_first_name2 = "XXXX".substr($answers['BE_NONCL_FNM'], -4);

$normal_dash_ssn1 = $answers['CT_CLNT_COSSN'];
$normal_dash_ssn2 = $answers['CT_NONCL_COSSN'];

$hide_dash_ssn1 = "XX-XXX-".substr($normal_dash_ssn1,-4);
$hide_dash_ssn2 = "XX-XXX-".substr($normal_dash_ssn2,-4);



if ($isBatch != "true")
{
	$answers['CT_CLNT_PHONE'] = $answers['BE_CLNT_PHNAREA'].$answers['BE_CLNT_PHNEXCH'].$answers['BE_CLNT_PHNNUM'];
	$answers['CT_THRD_PHONE'] = $answers['BE_THRD_PHNAREA'].$answers['BE_THRD_PHNEXCH'].$answers['BE_THRD_PHNNUM'];
	$answers['CT_CNTCT_PHONE'] = $answers['BE_CNTCT_PHNAREA'].$answers['BE_CNTCT_PHNEXCH'].$answers['BE_CNTCT_PHNNUM'];
}


$md5_ssn = md5($answers['CT_CLNT_COSSN']);//MH-encrypts ssn
$query = "UPDATE screening_submission set ssn_hash = '".$md5_ssn."' WHERE submission_id = '".$submission_id."' ";
$GLOBALS['db']->query($query);


$fileName = $screening_id."_".time().".html";
$logFile = LOG_DIR.$fileName;
$log = new Logger($logFile);

//$khfile = "kh.txt";
//$khlogfile = LOG_DIR.$khfile;
//$khlog = new Logger($khlogfile);


$log->write($feedback.'<br><br>');
//$khlog->write($answers['BE_CLNT_COSSN']."|".$hide_ssn1."|".$hide_ssn2."|".$hide_last_name1."|".$hide_first_name1."|".$hide_last_name2."|".$hide_first_name2);
//$khlog->write("------------------------------------------------------------------ 11111 -------------------------------------");


$array_of_values = print_r($answers, true);

$array_of_values = str_replace($normal_ssn1,$hide_ssn1,$array_of_values );
$array_of_values = str_replace($normal_ssn2,$hide_ssn2,$array_of_values );
$array_of_values = str_replace($answers['BE_CLNT_LNM'],$hide_last_name1,$array_of_values );
//$array_of_values = str_replace($answers['BE_CLNT_FNM'],$hide_first_name1,$array_of_values );
$array_of_values = str_replace($answers['BE_NONCL_LNM'],$hide_last_name2,$array_of_values );
//$array_of_values = str_replace($answers['BE_NONCL_FNM'],$hide_first_name2,$array_of_values );
$array_of_values = str_replace($normal_dash_ssn1,$hide_dash_ssn1,$array_of_values );
$array_of_values = str_replace($normal_dash_ssn2,$hide_dash_ssn2,$array_of_values );


$log->write($array_of_values.'<br><br>');

///TEST

if(QA){
	$ch = curl_init("https://secureete.ssa.gov/i1020/start"); //qa
}
else{
	$ch = curl_init("https://secure.ssa.gov/i1020/start"); //prod
}

curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); // return into a variable
curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, TRUE);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
curl_setopt($ch, CURLOPT_SSLVERSION, 4);

if(QA) {
	curl_setopt($ch, CURLOPT_URL, "https://secureete.ssa.gov/i1020/start"); //qa
	$page = curl_exec($ch);
	$cookiejar = get_cookie($page);
	curl_setopt($ch, CURLOPT_COOKIE, $cookiejar);
	curl_setopt($ch, CURLOPT_URL, "https://secureete.ssa.gov/i1020/start");
	$page = curl_exec($ch);
	
}
else{
	curl_setopt($ch, CURLOPT_URL, "https://secure.ssa.gov/i1020/start"); //prod
	$page = curl_exec($ch);
	$cookiejar = get_cookie($page);
	curl_setopt($ch, CURLOPT_COOKIE, $cookiejar);
	curl_setopt($ch, CURLOPT_URL, "https://secure.ssa.gov/i1020/start");
	$page = curl_exec($ch);
}

if ($isBatch == "true"){
	require_once("TranslateSSAbatch.php");
}
else{
	require_once("TranslateSSA.php");	
}
require_once("Applicant.php");
$Applicant = new Applicant($answers);
$answers['BE_THRD_SUB_SW'] = 'y';
$answers['BE_CLNT_SUB_SW'] = 'y';
$answers['BE_NONCL_SUB_SW'] = 'y';

$Applicant->translateAll($Applicant->answers);


if($Applicant->answers['BE_CLNT_EARN_LOSS_XND'] == 99){
	$Applicant->answers['BE_CLNT_EARN_LOSS_XND'] = 1;
}
if($Applicant->answers['BE_NONCL_EARN_LOSS_XND'] == 99) {
	$Applicant->answers['BE_NONCL_EARN_LOSS_XND'] = 1;
}
$Applicant->defaultThirdParty($Applicant->answers);//MH-??calls an empty function in Applicant.php
 
if($Applicant->answers['CT_MRTL_STUS'] == 'MLT'){
	require_once("MarriedApplicantCT.php");
	$ApplicantCT = new MarriedApplicantCT();
	$ApplicantCT->savingsLimit($Applicant->answers['BE_SAV_LMT_XND']);
	$ApplicantCT->wagesEarning(
	$Applicant->answers['BE_CLNT_WRKD_L2YR_XND'], 
	$Applicant->answers['BE_NONCL_WRKD_L2YR_XND'],				
	$Applicant->answers['BE_CLNT_PAY_DISBLTY_XND'], 
	$Applicant->answers['BE_NONCL_PAY_DISBLTY_XND'],
	$Applicant->answers['BE_NONCL_DOB_YEAR'],
	$Applicant->answers['BE_NONCL_STOP_WRK_XND']);
}
elseif($Applicant->answers['CT_MRTL_STUS'] == 'WDW' OR $Applicant->answers['CT_MRTL_STUS'] == 'SNG' OR $Applicant->answers['CT_MRTL_STUS'] == 'DIV' OR $Applicant->answers['CT_MRTL_STUS'] == 'SEP' OR $Applicant->answers['CT_MRTL_STUS'] == 'MLA')
{
	require_once("SingleApplicantCT.php");
	$ApplicantCT = new SingleApplicantCT();
	$ApplicantCT->savingsLimit($Applicant->answers['BE_SAV_LMT_XND']);
	$ApplicantCT->wagesEarning($Applicant->answers['BE_CLNT_WRKD_L2YR_XND'],$Applicant->answers['BE_CLNT_PAY_DISBLTY_XND'],$Applicant->answers['BE_CLNT_DOB_YEAR']);
}
else
{
	echo "No handler for this  status -".$Applicant->answers['CT_MRTL_STUS']."- yet";
	exit;
}
$ApplicantCT->thirdParty($Applicant->answers['CT_THRD_PTY_XND']);
$log->write($feedback.'<br><br>');
//$khlog->write($feedback);
//$khlog->write("------------------------------------------------------------------ 22222 -------------------------------------");

foreach($ApplicantCT->pages as $page)
{
	$postFields = '';
	foreach($page as $key => $value)
	{
		if($key != 'PAGEID' AND $key != 'PAGEOCCURRENCE' AND $key != 'PAGESETID' AND $key != 'PAGESETOCCURRENCE' AND $key != 'ACTION.START' AND $key != 'ACTION.CONTINUE' AND $key != 'ACTION.SUBMIT')
		{
			$postFields .= "&".$key."=".$Applicant->answers[$key];	
		}
		elseif (($key <> 'BE_NONCL_STOP_WRK_XND') or ($value <> ''))
		{
			$postFields .= "&".$key."=".$value;
		}
		if ($key == 'PAGEID')
		{
			if(QA){
				$tempurl = "https://secureete.ssa.gov/i1020/".$value."Submit.do";
			}
			else {
				$tempurl = "https://secure.ssa.gov/i1020/".$value."Submit.do";
			}
		if ($debug) {echo "POST URL: ".$tempurl."<br><br>";}
		curl_setopt($ch, CURLOPT_URL,$tempurl);	
		}
		
	}
	curl_setopt($ch, CURLOPT_POSTFIELDS, substr($postFields, 1) );
	$post_for_logger = $postFields;

	$post_for_logger = str_replace($normal_ssn1,$hide_ssn1,$post_for_logger );
	$post_for_logger  = str_replace($normal_ssn2,$hide_ssn2,$post_for_logger );
	$post_for_logger  = str_replace($answers['BE_CLNT_LNM'],$hide_last_name1,$post_for_logger );
	//$post_for_logger  = str_replace($answers['BE_CLNT_FNM'],$hide_first_name1,$post_for_logger );
	$post_for_logger  = str_replace($answers['BE_NONCL_LNM'],$hide_last_name2,$post_for_logger );
	//$post_for_logger  = str_replace($answers['BE_NONCL_FNM'],$hide_first_name2,$post_for_logger );



	$log->write(substr($post_for_logger, 1).'<br><br>');
	
	$feedback = curl_exec($ch);
	$feedback = ereg_replace('<script type="text/javascript">(.*)</script>', "", $feedback);
	$feedback = str_replace('if (SSA.page && SSA.page.timeout) { SSA.page.timeout.config({url:"Controller"}); }', " ", $feedback);


	eregi("<title>(.*)</title>", $feedback, $title);
	if ($debug) {print_r($title);}
	$parts = explode(",",$title[1]);
	if ($debug) { print_r($parts);}
	if ($debug) {echo "<b>TITLE: </b>".$parts[0]."<br><br>";}

	if(trim($parts[0]) == "Print The Re-entry Number")
	{
		if ($debug) {echo "<b>GET REENTRY:</b>";}
		preg_match_all('/(<span class="uef-reEntryNumber">)([^<]*)(<\/span>)/', $feedback, $matches);
		$reentry = trim($matches[2][1]); //reentry number removing leading and trailing whitespace
		$reentry = $reentry;
		if ($debug) {print_r($matches);}
		if ($debug) {echo "<b>RE-ENTRY NUM:</b>".$reentry."|";}
		$md5_ssn = md5($answers['CT_CLNT_COSSN']);
		$query = "UPDATE screening_submission set reentry_number = '".$reentry."' WHERE submission_id = '".$submission_id."' ";
		$GLOBALS['db']->query($query);   
	}
	$status = get_status(trim($parts[0]));
	if ($debug) { echo "<b>STATUS:".$status."</b>".$parts[0]."<br><br>";}
	//$khlog->write("-----TITLE = ".$parts[0]."--------------------".$status."-----------------");
	
	if($status == 1)
	{
		$feedback = ereg_replace('HTTP/1.1 200(.*)expires: Sun, 7 May 1995 12:00:00 GMT', "", $feedback);
		$feedback = ereg_replace('h6', "h4", $feedback);
		$feedback = ereg_replace('h5', "h3", $feedback);
		$feedback = ereg_replace('<!doctype html>(.*)<form name="Rs004Form" method="post" action="/i1020/Rs004Submit.do">', "", $feedback);
		$feedback = ereg_replace('<p>If you need help completing this application, call Social Security toll-free at: <br/> <strong>1-800-772-1213</strong> or <br/>TTY <strong>1-800-325-0778</strong>, <br/>Monday-Friday 7am-7pm</p>', "", $feedback);
		$feedback = ereg_replace('<head>(.*)</head>', "", $feedback);
		$feedback = ereg_replace('<div class="uef-formControls" id="bottom">(.*)</div>', "", $feedback);
		$feedback = ereg_replace('<p>Select this link to <a href="./msgpages/Rs007.jsp" rel="msg" target="_blank">print this page or save</a> it to your computer.</p>', "", $feedback);
		$feedback = ereg_replace('For instructions on how to print, save, or view the saved file, please refer to the <a href="./msgpages/Msg063.jsp" rel="msg" target="_blank">Print/Save/View Guide</a>.</p>', "<br>", $feedback);
	}
	$feedback = ereg_replace('<script type="text/javascript">(.*)</script>', "", $feedback);
	$feedback = str_replace('if (SSA.page && SSA.page.timeout) { SSA.page.timeout.config({url:"Controller"}); }', " ", $feedback);
	$feedback = ereg_replace('SSA.page.timeout.config', "", $feedback);
	$feedback = str_replace($normal_ssn1,$hide_ssn1,$feedback);
	$feedback = str_replace($normal_ssn2,$hide_ssn2,$feedback);
	$feedback_for_log = $feedback;
	$feedback_for_log = str_replace($answers['BE_CLNT_LNM'],$hide_last_name1,$feedback_for_log);
	$feedback_for_log = str_replace($answers['BE_NONCL_LNM'],$hide_last_name2,$feedback_for_log);
	//$feedback = str_replace($answers['BE_NONCL_FNM'],$hide_first_name2,$feedback);
	//$feedback = str_replace($answers['BE_CLNT_FNM'],$hide_first_name1,$feedback);
	$log->write($feedback_for_log);
//	$khlog->write($feedback);
//	$khlog->write("------------------------------------------------------------------ 33333 -------------------------------------");
	if ($debug) { echo $feedback; } //loggin to screen 
	//if($status == "Warning: System Will Shut Down")
	if(trim($parts[0]) == "Warning: System Will Shut Down")
	{
		if ($debug) {echo"<h3>System Shutdown</h3>";}
		curl_setopt($ch, CURLOPT_POSTFIELDS, 'PAGEID=msg045&PAGEOCCURRENCE=1&PAGESETID=&PAGESETOCCURRENCE=0&ACTION.CONTINUE=Apply+Now');

		if(QA) //go through the login form
			{$tempurl = "https://secureete.ssa.gov/i1020/Msg045Submit.do";}
		else 
			{$tempurl = "https://secure.ssa.gov/i1020/Msg045Submit.do";}
		if ($debug) {echo "POST URL: ".$tempurl."<br><br>";}
		curl_setopt($ch, CURLOPT_URL,$tempurl);	
		
		$feedback = curl_exec($ch);
		$feedback = ereg_replace('<script type="text/javascript">(.*)</script>', "", $feedback);
	        $feedback = str_replace('if (SSA.page && SSA.page.timeout) { SSA.page.timeout.config({url:"Controller"}); }', " ", $feedback);

//	        $khlog->write("------------------------------------------------------------------ SHUTDOWN -------------------------------------");
		$log->write($feedback);

	}
	if($status)
	{		
		process_status($status, $feedback, $submission_id, $fileName);
		curl_close($ch);
//		$khlog->close();
		$log->close();
		if (QA) {		
			redirect('/cf/lisapp/confirmation.cfm?cfid='.$_GET['CFID'].'&cftoken='.$_GET['CFTOKEN'].'&prev_id='.$screening_id, 5);
		}
		else {
			redirect('/cf/lisapp/confirmation.cfm?cfid='.$_GET['CFID'].'&cftoken='.$_GET['CFTOKEN'].'&prev_id='.$screening_id, 5);
		}
	}
}

if($status == 0)
{	
	process_status($status=16, $feedback="", $submission_id, $fileName);
}
curl_close($ch);
$log->close();
//$khlog->close();
if (QA) {		
		//redirect('/cf/lisapp/confirmation.cfm?cfid='.$_GET['CFID'].'&cftoken='.$_GET['CFTOKEN'], 5);
}
else {
		redirect('/cf/lisapp/confirmation.cfm?cfid='.$_GET['CFID'].'&cftoken='.$_GET['CFTOKEN'].'&prev_id='.$screening_id, 1);
}

function replace_ssn($ssn, $replacement, $string)
{
	$ssn_int = str_replace("-", "", $ssn);
	$ssn_string = substr($ssn_int, 0, 3)."-".substr($ssn_int, 3, 2)."-".substr($ssn_int, 5, 4);
	$string = str_replace($ssn_int, $replacement, $string);
	$string = str_replace($ssn_string, $replacement, $string);
	return $string;
}

function get_status($title)
{
	switch ($title)
	{
		case "Successful Submission - Print Or Save Your Receipt":
			$status = 1;
			break;
		case "Authentication - Medicare Part D Database Not Eligible Or SSI Recipient":
			$status = 2;
			break;
		case "Check The Social Security Number You Entered":
			$status = 3;
			break;
		case "Check The Social Security Numbers You Entered":
			$status = 4;
			break;
		case "Limit Number Of Restarts":
			$status = 5;
			break;
		case "Limit Number Of Starts For A New Application":
			$status = 6;
			break;
		case "Limit On The Number Of Tries To Start The Application":
			$status = 7;
			break;
		case "Check The Information You Entered":
			$status = 8;
			break;
		case "System Failure":
			$status = 9;	//same as we cannot process your request
			break;
		case "Not Eligible For The Prescription Drug Plan":
			$status = 10;
			break;
		//case "You Are Not Eligible For The Extra Help":
		//	$status = 10;
		//	break;
		case "We Cannot Process Your Request At This Time":
			$status = 11;
			break;
			/*
			case "Sign-In Problem": //only used for reentry this should never occur
			$status = 12;
			break;
			*/
		case "System Failure":
			$status = 13;
			break;
		case "There Is A Pending Application For This Social Security Number":
			$status = 14;
			break;
		case "We Cannot Process Your Request":
			$status = 15;
			break;
		case "You Have Already Sent Us An Application":
			$status = 17;
			break;
		default:
			$status = 0;
	}
	return $status;
}

function process_status($status, $feedback, $submission_id, $fileName)
{
	switch ($status)
	{
		case 1:
			$query = "UPDATE screening_submission set submission_status = $status, submission_result = '$feedback', file_name = '$fileName', post_finish_time = now() WHERE submission_id = '".$submission_id."' ";
			$GLOBALS['db']->query($query);
			break;
		default:
			$query = "UPDATE screening_submission set submission_status = '".$status."', file_name = '$fileName', post_finish_time = now() WHERE submission_id = '".$submission_id."' ";
			$GLOBALS['db']->query($query);
	}	
}
?>
