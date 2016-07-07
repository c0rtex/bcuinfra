<?php  

require_once("includes/config.php");  //always have to include this
require_once(INCLUDES_DIR."Logger.php");
require_once(INCLUDES_DIR."encryption.php");
require_once("Validate/Validate.php");

$smarty = new SetupSmarty;
$smarty->display("submitApplicant.tpl");

$screening_id = $_GET['Screening_id'];

/*
$query = "SELECT screening_id FROM screening_submission WHERE screening_id = '".$screening_id."' ";
$result = $GLOBALS['db']->query($query);
if($result->numRows() > 0)
{
	$log->write("<!---------------------screening_id $screening_id already exists---------------------");
}
*/
//else //only create a new submission if one doesn't exist for the screening_id
if( Validate::number($screening_id)) //scrub user input to check for sql injection
{
	$md5_ssn = md5($answers['BE_CLNT_COSSN']);//MH-encrypt ssn
	$query = "INSERT INTO screening_submission (screening_id, post_start_time) VALUES('".$screening_id."', getdate() )";//MH-Associates screening_id with submission rec
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
	if($row['encryption_flag'] == 1)//MH-decrypts encrypted SSN
	{
		$answers[$fieldname] = decryptString($row['encrypted_response']);
	}
	else if($row['responsetype'] == 3)//MH-if responsetype is 3 then answers[x] = option_code
	{
		$answers[$fieldname] = $row['option_code'];
	}
	else//MH-for all other answerfieldtypes answers[x] = response
	{
		$answers[$fieldname] = $row['response'];
	}
}

$md5_ssn = md5($answers['BE_CLNT_COSSN']);//MH-encrypts ssn
$query = "UPDATE screening_submission set ssn_hash = '".$md5_ssn."' WHERE submission_id = '".$submission_id."' ";
$GLOBALS['db']->query($query);


//$answers['BE_CLNT_COSSN'] = 743980341;
//MH-Log files are created here
$fileName = $screening_id."_".time().".html";
$logFile = LOG_DIR.$fileName;
$log = new Logger($logFile);

//MH-replaces first 5 digits of SSN to then be stored in the log files.
$feedback = print_r($answers, true);
$feedback = replace_ssn($answers['BE_CLNT_COSSN'], "XXX-XX-".substr($answers['BE_CLNT_COSSN'], -4), $feedback);
$feedback = replace_ssn($answers['BE_NONCL_COSSN'], "XXX-XX-".substr($answers['BE_NONCL_COSSN'], -4), $feedback);
$log->write($feedback.'<br><br>');

//MH-sets where to send the data based upon QA or prod version
if(QA)
{
	$ch = curl_init("https://secureval.ssa.gov/apps6z/i1020/main.html"); //qa
}
else
{
	$ch = curl_init("https://s044a90.ssa.gov/apps6z/i1020/ee001.jsp"); //prod
}

//MH-??Setting Parameters for data transfer
curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); // return into a variable
curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, TRUE);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_POST, true);
$page = curl_exec($ch);

if(QA) //go through the login form
{
//	curl_setopt($ch, CURLOPT_URL, "https://s044152.ssa.gov/pkmslogin.form");
//	curl_setopt($ch, CURLOPT_POSTFIELDS, 'username=stephen1&password=passwZrd0&login-form-type=pwd');
//	$page = curl_exec($ch);
//	$cookiejar = get_cookie($page);
//	curl_setopt($ch, CURLOPT_COOKIE, $cookiejar);
	curl_setopt($ch, CURLOPT_URL, "https://secureval.ssa.gov/apps6z/i1020/ee001.jsp");
	$page = curl_exec($ch);
	curl_setopt($ch, CURLOPT_URL, "https://secureval.ssa.gov/apps6z/i1020/Controller"); //qa
}
else//MH-no login for prod submission
{
	curl_setopt($ch, CURLOPT_URL, "https://s044a90.ssa.gov/apps6z/i1020/Controller"); //prod
}

$cookiejar = get_cookie($page);
curl_setopt($ch, CURLOPT_COOKIE, $cookiejar);

require_once("TranslateSSA.php");
require_once("Applicant.php");

$Applicant = new Applicant($answers);
//MH-calls a function in TranslateSSA.php to translate answers[x] values to be consistent with ssa
$Applicant->translateAll($Applicant->answers);
if($Applicant->answers['BE_CLNT_EARN_LOSS_XND'] == 99) //here we have to change the 99 to a 1 because due to some quirk in php the 1 in the class was always being changed to 0 before
{
	$Applicant->answers['BE_CLNT_EARN_LOSS_XND'] = 1;
}
if($Applicant->answers['BE_NONCL_EARN_LOSS_XND'] == 99) //here we have to change the 99 to a 1 because due to some quirk in php the 1 in the class was always being changed to 0 before
{
	$Applicant->answers['BE_NONCL_EARN_LOSS_XND'] = 1;
}
$Applicant->defaultThirdParty($Applicant->answers);//MH-??calls an empty function in Applicant.php
 
if($Applicant->answers['CT_MRTL_STUS'] == 'MLT')//MH-if married and living together
{
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
//MH-if widow or single or divorced
elseif($Applicant->answers['CT_MRTL_STUS'] == 'WDW' OR $Applicant->answers['CT_MRTL_STUS'] == 'SNG' OR $Applicant->answers['CT_MRTL_STUS'] == 'DIV' OR $Applicant->answers['CT_MRTL_STUS'] == 'SEP' OR $Applicant->answers['CT_MRTL_STUS'] == 'MLA')
{
	require_once("SingleApplicantCT.php");
	$ApplicantCT = new SingleApplicantCT();
	$ApplicantCT->savingsLimit($Applicant->answers['BE_SAV_LMT_XND']);
	$ApplicantCT->wagesEarning($Applicant->answers['BE_CLNT_WRKD_L2YR_XND'],$Applicant->answers['BE_CLNT_PAY_DISBLTY_XND'],$Applicant->answers['BE_CLNT_DOB_YEAR']);
}
else
{
	echo "No handler for this marital status -".$Applicant->answers['CT_MRTL_STUS']."- yet";
	exit;
}
$ApplicantCT->thirdParty($Applicant->answers['CT_THRD_PTY_XND']);
print_r($Applicant->answers).'<br><br>';
$feedback = print_r($Applicant->answers, true);
$feedback = replace_ssn($answers['BE_CLNT_COSSN'], "XXX-XX-".substr($answers['BE_CLNT_COSSN'], -4), $feedback);
$feedback = replace_ssn($answers['BE_NONCL_COSSN'], "XXX-XX-".substr($answers['BE_NONCL_COSSN'], -4), $feedback);
$log->write($feedback.'<br><br>');

foreach($ApplicantCT->pages as $page)
{
	$postFields = '';
	foreach($page as $key => $value)
	{
		//MH- SSA Page Properties. Subject to change per APP (PAGEID, PAGEOCCURRENCE, PAGESETID, PAGESETOCCURRENCE, ACTION.START, ACTION.CONTINUE, ACTION.SUBMIT) 
		//MH- Need to verify these properties by looking at the SSA website page source and comparing them
		if($key != 'PAGEID' AND $key != 'PAGEOCCURRENCE' AND $key != 'PAGESETID' AND $key != 'PAGESETOCCURRENCE' AND $key != 'ACTION.START' AND $key != 'ACTION.CONTINUE' AND $key != 'ACTION.SUBMIT')
		{
			$postFields .= "&".$key."=".$Applicant->answers[$key];	
			//print_r($page).'testing...<br><br>';
		}

		//SE - temp change for noncl work value issue
		elseif (($key <> 'BE_NONCL_STOP_WRK_XND') or ($value <> ''))
		{
			$postFields .= "&".$key."=".$value;
		}
	}
	curl_setopt($ch, CURLOPT_POSTFIELDS, substr($postFields, 1) );
	$postFields = replace_ssn($answers['BE_CLNT_COSSN'], "XXX-XX-".substr($answers['BE_CLNT_COSSN'], -4), $postFields);
	$postFields = replace_ssn($answers['BE_NONCL_COSSN'], "XXX-XX-".substr($answers['BE_NONCL_COSSN'], -4), $postFields);
	$log->write(substr($postFields, 1).'<br><br>');
	//echo substr($postFields, 1).'<br><br>'; //loggin to screen
	$feedback = curl_exec($ch);
	$feedback = replace_ssn($answers['BE_CLNT_COSSN'], "XXX-XX-".substr($answers['BE_CLNT_COSSN'], -4), $feedback);
	$feedback = replace_ssn($answers['BE_NONCL_COSSN'], "XXX-XX-".substr($answers['BE_NONCL_COSSN'], -4), $feedback);
	eregi("<title>(.*)</title>", $feedback, $title);
	if($title[1] == "Reentry Number Issued Normal Process")
	{
		preg_match_all("/(<span[^>]*>)([^<]*)(<\/span>)/", $feedback, $matches);
		$reentry = trim($matches[2][3]); //reentry number removing leading and trailing whitespace
		$md5_ssn = md5($answers['BE_CLNT_COSSN']);
		$query = "UPDATE screening_submission set reentry_number = '".$reentry."' WHERE submission_id = '".$submission_id."' ";
		$GLOBALS['db']->query($query);
	}
	$status = get_status(trim($title[1]));
	if($status == 1)
	{
		$feedback = ereg_replace('<style type="text/css" media="screen">(.*)</style>', "", $feedback);
	}
	$log->write($feedback);
	//echo $feedback; //loggin to screen
	if($title[1] == "Warning System Shutdown")
	{
		curl_setopt($ch, CURLOPT_POSTFIELDS, 'PAGEID=msg045&PAGEOCCURRENCE=1&PAGESETID=&PAGESETOCCURRENCE=0&ACTION.APPLYNOW=Apply Now');
		$feedback = curl_exec($ch);
		$log->write($feedback);
	}
	if($status)
	{		
		process_status($status, $feedback, $submission_id, $fileName);
		curl_close($ch);
		$log->close();
		//echo  headers_sent($filename, $linenum)."--$filename, $linenum<br>";	
		// Don't redirect if this is a batch submission
		if(isset($_GET['batch'])){}	
		else{redirect('../cf/confirmation.cfm?cfid='.$_GET['CFID'].'&ctoken='.$_GET['CFTOKEN'], 5);}
	}
}

if($status == 0)
{	
	process_status($status=16, $feedback="", $submission_id, $fileName);
}
curl_close($ch);
$log->close();
//echo  headers_sent()."-2<br>"; //logging
// Don't redirect if this is a batch submission
if(isset($_GET['batch'])){return;}	
else{redirect('../cf/confirmation.cfm?cfid='.$_GET['CFID'].'&ctoken='.$_GET['CFTOKEN'], 5);}

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
		case "Limit On The Number Of Tries To Start An Application":
			$status = 7;
			break;
		case "Name Check Mismatch":
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
		case "Off Hours Message":
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
			eregi('<div class="attentionMessage rowbackgrnd displayAnswer" tabindex="0">(.*)<div class="buttons">', $feedback, $matches);
			$feedback = str_replace("'", "''", $matches[1]); //add quotes to escape quotes for sql server
			$query = "UPDATE screening_submission set submission_status = $status, submission_result = '$feedback', file_name = '$fileName', post_finish_time = getdate() WHERE submission_id = '".$submission_id."' ";
			$GLOBALS['db']->query($query);
			break;
		default:
			$query = "UPDATE screening_submission set submission_status = '".$status."', file_name = '$fileName', post_finish_time = getdate() WHERE submission_id = '".$submission_id."' ";
			$GLOBALS['db']->query($query);
	}	
}
?>
