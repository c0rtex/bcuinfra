<?php

class TranslateSSA
{
	var $answers;

	function translateSSA($answers)
	{
		$this->answers = $answers;
	}

	function translateAll(& $answers)
	{
		foreach($answers as $key => $value)
		{
			switch ($key)
			{	
				case "BE_THRD_ADDRLN_1":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "BE_THRD_ADDRLN_2":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "BE_THRD_ADDRLN_3":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;
				case "BE_THRD_ADDRLN_4":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "BE_THRD_ADDR_CITY":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "CT_THRD_ADDR_ST_GRT":
					$answers[$key] = $this->translateStateCode($value);
					//echo "statecode:".$key.$value;		
					break;	
				case "BE_CLNT_MAIL_ADDRLN_2":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "BE_CLNT_MAIL_ADDRLN_3":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;	
				case "BE_CLNT_MAIL_ADDR_ST":
					$answers[$key] = $this->translateStateCode($value);			
					break;	
				case "BE_CLNT_MAIL_ADDRLN_1":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;						
				case "BE_CLNT_MAIL_APT_NO":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;
				case "BE_THRD_APT_NO":
					$answers[$key] = $this->translateAddr($value, $key);			
					break;		
				case "BE_RLTVS_SUP":
					$answers[$key] = $this->translateRelatives($value, $key);			
					break;
				case "BE_CNTCT_FNM":
					$this->translateContact_batch();
					break;
				case "CT_CNTCT_PHONE":
					$this->translateContact_batch();					
					break;	
				case "BE_THRD_ADDR_CITY":
					$answers[$key] = $this->translateAddr($value, $key);
					break;
				case "BE_CLNT_MAIL_ADDR_CITY":
					$answers[$key] = $this->translateAddr($value, $key);
					break;
				case "CT_THRD_PTY_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "CT_MAIL_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "CT_RECEIVE_MEDICARE_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "CT_OLDER_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "CT_SS_DISBLTY_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "CT_MRTL_STUS":
					$answers[$key] = $this->translateMaritalStatus($value, $key);					
					break;
				case "BE_SAV_LMT_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_THRD_REL":
					$answers[$key] = $this->translateThirdPartyRelationship($value, $key);
					break;
				case "BE_CLNT_SFX":
					$answers[$key] = $this->translateSuffix($value, $key);
					break;
				/* removed no longer used in release 2
				case "BE_CLNT_UNDER_AGE_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				*/
				case "BE_CLNT_WRKD_L2YR_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_WH_APPLY":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_SFX":
					$answers[$key] = $this->translateSuffix($value, $key);
					break;
				case "CT_CLNT_COSSN":
					$answers[$key] = $this->translateSSN($value, $key);
					break;
				case "CT_NONCL_COSSN":
					$answers[$key] = $this->translateSSN($value, $key);
					break;
				/* removed no longer used in release 2
				case "BE_NONCL_UNDER_AGE_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				*/
				case "BE_NONCL_WRKD_L2YR_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_CHG_ADDR_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					break;
				case "BE_CLNT_SUB_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					break;
				case "BE_THRD_SUB_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					break;
				case "BE_NONCL_SUB_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					break;
				/*MH-Removed for 12/31/2009 release
				case "BE_EXPENSE_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;*/
				case "BE_RES_BANK_ACC_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_RES_INVST_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_RES_CSH_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				/*MH-Removed for 12/31/2009 release
				case "BE_CLNT_INS_POL_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_INS_POL_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;*/
				case "BE_SEND_MSPINFO_CD":
					$answers[$key] = $this->translateCheckbox($value, $key);
					break;															
				case "BE_CLNT_BUEXP_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					//$this->translateResources('BE_CLNT_BUEXP_XND', 'BE_CLNT_INS_POL_XND');
					break;
				case "BE_NONCL_BUEXP_SW":
					$answers[$key] = $this->translateCheckbox($value, $key);
					//$this->translateResources('BE_NONCL_BUEXP_XND', 'BE_NONCL_INS_POL_XND');
					break;
				case "BE_RESTT_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_RR_INCM_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_RR_INCM_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_VA_BENEFITS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_VA_BENEFITS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_PENS_ANNUIT_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_PENS_ANNUIT_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_OTH_INCM_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_OTH_INCM_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_INCM_DECRS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_EARN_WGS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_NONCL_EARN_WGS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;					  
				case "BE_CLNT_EARN_LOSS_XND":					
					$answers[$key] = $this->translateEarnings($value, $key);	
					break;
				case "BE_NONCL_EARN_LOSS_XND":
					$answers[$key] = $this->translateEarnings($value, $key);						
					break;
				case "BE_WGS_DECRS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_STOP_WRK_XND":
					$answers[$key] = $this->translateTrueFalseNull($value, $key);
					$this->translateStopWork('BE_CLNT_STOP_WRK_XND', 'BE_CLNT_STOP_WRK_YEAR', 'BE_CLNT_STOP_WRK_MONTH');
					break;
				case "BE_NONCL_STOP_WRK_XND":
					$answers[$key] = $this->translateTrueFalseNull($value, $key);
					$this->translateStopWork('BE_NONCL_STOP_WRK_XND', 'BE_NONCL_STOP_WRK_YEAR', 'BE_NONCL_STOP_WRK_MONTH');
					break;
				case "BE_CLNT_PAY_DISBLTY_XND":
					$answers[$key] = $this->translateTrueFalseNull($value, $key);
					break;
				case "BE_NONCL_PAY_DISBLTY_XND":
					$answers[$key] = $this->translateTrueFalseNull($value, $key);
					break;	
				/*MH-Removed for 12/31/2009 release
				case "BE_EXPENSE_AMT":
					$answers[$key] = $this->translateAmount2($value);
					break;*/				
				case "BE_RES_BANK_ACC_AMT":
					$answers[$key] = $this->translateAmount2($value);					
					break; 
				case "BE_RES_INVST_AMT":
					$answers[$key] = $this->translateAmount2($value);
					break;
				case "BE_RES_CSH_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_RES_CSH_XND');
					break;	
				/*MH-Removed for 12/31/2009 release			
				case "BE_INS_POL_AMT":
					$answers[$key] = $this->translateAmount2($value);
					break;*/
				case "BE_CLNT_RR_INCM_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_RR_INCM_XND');
					break;
				case "BE_NONCL_RR_INCM_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_RR_INCM_XND');
					break;
				case "BE_CLNT_VA_BENEFITS_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_VA_BENEFITS_XND');
					break;
				case "BE_NONCL_VA_BENEFITS_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_VA_BENEFITS_XND');
					break;
				case "BE_CLNT_PENS_ANNUIT_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_PENS_ANNUIT_XND');
					break;
				case "BE_NONCL_PENS_ANNUIT_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_PENS_ANNUIT_XND');
					break;
				case "BE_CLNT_OTH_INCM_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_OTH_INCM_XND');
					break;
				case "BE_NONCL_OTH_INCM_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_OTH_INCM_XND');
					break;
				case "BE_CLNT_EARN_WGS_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_EARN_WGS_XND');
					break;
				case "BE_NONCL_EARN_WGS_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_EARN_WGS_XND');
					break;
				case "BE_CLNT_EARN_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_CLNT_EARN_LOSS_XND');
					break;
				case "BE_NONCL_EARN_AMT":
					$answers[$key] = $this->translateAmount($value, 'BE_NONCL_EARN_XND');
					break;	
				case "BE_NONCL_SS_BENEFITS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;		
				case "BE_CLNT_SS_BENEFITS_XND":
					$answers[$key] = $this->translateTrueFalse($value, $key);
					break;
				case "BE_CLNT_DOB_DAY":
					$answers[$key] = $this->translateDate($value, $key);
					break;
				case "BE_CLNT_DOB_MONTH":
					$answers[$key] = $this->translateDate($value, $key);
					break;
				case "BE_NONCL_DOB_DAY":
					$answers[$key] = $this->translateDate($value, $key);
					break;	
				case "BE_NONCL_DOB_MONTH":
					$answers[$key] = $this->translateDate($value, $key);
					break;	
				case "BE_CLNT_STOP_WRK_MONTH":
					$answers[$key] = $this->translateDate($value, $key);
					break;	
				case "BE_NONCL_STOP_WRK_MONTH":
					$answers[$key] = $this->translateDate($value, $key);
					break;	
				case "BE_THRD_REL_OTH":
					$answers[$key] = $this->translateRemoveNumbers($value);				
					break;	
				case "CT_LIVE_GRT":
					$answers[$key] = $this->translateStateCode($value);				
					break;
				case "CT_CLNT_MAIL_ADDR_ST_GRT":
					$answers[$key] = $this->translateStateCode($value);				
					break;
				case "CT_THRD_ADDR_ST_GRT": 
					$answers[$key] = $this->translateStateCode($value);				
					break;					
				default:
					$answers[$key] = $value;
			}
		}
	}

	function translateDate($value, $key)
	{ 
		if(isset($value) AND strlen($value) < 2)
		{
			$value = "0".$value;			
		}	
		return $value;
	}	
	
	function translateRelatives($value, $key)
	{ 
		if($value > 97)
		{
			$value = 97;			
		}	
		return intval($value);
	}
	
	// specific to batch.
	function translateContact_batch()
	{
		if($this->answers['BE_CNTCT_FNM'] == "" AND $this->answers['BE_CNTCT_LNM'] == "")
		{
			$this->answers['CT_CNTCT_PHONE'] = "";
		}
		if($this->answers['CT_CNTCT_PHONE'] == "")	
		{
			$this->answers['BE_CNTCT_FNM'] = "";
			$this->answers['BE_CNTCT_LNM'] = "";	
		}
	}
	
	function translateAmount2($value)
	{
		if(substr($value, 0, 1) == ".")
		{
			$value = "0".$value;
		}
		return $value;	
	}
	
	function translateAmount($value, $xnd)
	{
		if($this->answers[$xnd] === 'y')
		{
			$this->answers[$xnd] = 1;	
		}
		if($this->answers[$xnd] === 'n')
		{
			$this->answers[$xnd] = 0;	
		}
		if(substr($value, 0, 1) == ".")
		{
			$value = "0".$value;
		}
		if($value <= 0 AND $this->answers[$xnd] == 1)
		{
			$value = NULL;
		}
		if($value == NULL AND $this->answers[$xnd] == 1 OR $value == 0 AND $this->answers[$xnd] == 1)
		{
			$this->answers[$xnd] = 0;				
		}
		//if($value > 99999)
		//{
		//	$value = 99999;
		//}		
		return $value;	
	}
		
	function translateStopWork($xnd, $year, $month)
	{
		if($this->answers[$year] == NULL or $this->answers[$month] == NULL)
		{
			$this->answers[$xnd] == 0;
			$this->answers[$year] == NULL;
			$this->answers[$month] == NULL;
		}
		if($this->answers[$year] != NULL AND $this->answers[$month] != NULL)
		{
			$this->answers[$xnd] == 1;
		}
	}
	
	function translateResources($buexp, $ins)
	{		
		if($this->answers['BE_RES_BANK_ACC_XND'] == 0 AND $this->answers['BE_RES_INVST_XND'] == 0 AND $this->answers['BE_RES_CSH_XND'] == 0 AND $this->answers[$ins] == 0)
		{
			$this->answers[$buexp] = NULL;
		}
	}
	
	function translateTrueFalse($value, $key)
	{
		if($value === 'y')
		{
			return 1;
		}
		if($value === 'n')
		{
			return 0;
		}
		if($value === 'yes')
		{
			return 1;
		}
		if($value === 'no')
		{
			return 0;
		}
		if($value === '')
		{
			return 0;
		}
		if($value === 0)
		{
			return 0;
		}
		if($value === 1)
		{
			return 1;
		}
		if($value === 'dontknow')
		{
			return 9;
		}
		else
		{
			echo "No handler for this $key value ".$value." yet";
			exit;
		}
		
		

		/* this doesn't work because if the value was 0 it still kept evaluating to case 'y'	
		switch ($value)
		{
			case 'y':
				echo "here $value $key end"; 
				return 1;
				break;
			case $value === "n":			
				return '0';  //must put the 0 in quotes 
				break;
			case $value === "":
				return '0'; 
			case $value === "0":
				return '0'; 
				break;
			case $value === "1":
				return '1';  
				break;
			case $value === "dontknow":
				return 9;
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;
		}
		*/
	}
	function translateTrueFalseNull($value, $key)
		{
		if($value === 'y')
		{
			return 1;
		}
		elseif($value === 'n')
		{
			return 0;
		}
		else
		{
			return 9;
		}
		}
	
	function translateAddr($value, $key) 
	{
		$value = ereg_replace("[^a-zA-Z0-9 \.\'-]", "", $value); 
		return $value;
	}
	
	function translateRemoveNumbers($value)
	{			
		$value = ereg_replace("([0-9])", "", $value); 
		return $value;
	}
	
	function translateSSN($value, $key) 
	{
		$ssn = str_replace('-', '', $value);
		return $ssn;
	}
	
	/*
	function whoApply($value, $key)
	{
		switch ($value)
		{
			case "wh_apply_self":
				return '0';  //must put the 0 in quotes 
				break;
			case "wh_apply_both":
				return 1;
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;
		}
	}
	*/
	
	function translateCheckbox($value, $key)
	{
		switch ($value)
		{
			case "y":
				return 1;
				break;
			case "n":
				return "";
				break;
			case "":
				return "";
				break;
			case "yes_net_earnings":
				return "1";
				break;
			case "yes_net_loss":
				return "1";
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;				
		}
	}

	function translateEarnings($value, $key) //used for qa
	{
		switch ($value)
		{			
			case  $value === "0":			
				return 0;
				break;	
			case  $value === "yes_net_loss":
				return 2;
				break;
			case  $value === "yes_net_earnings":
				return 99; //should return a 1 but due to some quirk in php 1 always gets changed to 0
				break;
			case  $value === "n":
				return 0;
				break;
			case 1:
				return 1;
				break;
			case 2:
				return 2;
				break;				
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;				
		}
	}

	function translateMaritalStatus($value, $key)
	{ 		
		switch ($value)
		{
			case "married_living_together":
				return "MLT";
				break;
			case "married_not_living_together":
				return "MLA";
				break;
			case "single":
				return "SNG";
				break;
			case "divorced":
				return "DIV";
				break;
			case "widowed":
				return "WDW";
				break;
			case "separated":
				return "SEP";
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;
		}
	}

	function translateStateCode($value)
	{ 	
		//echo" first function value for state is:".$value;
		switch ($value)
		{
			case "AL":
				return 1;
				break;
			case "AK":
				return 2;
				break;
			case "AZ":
				return 4;
				break;
			case "AR":
				return 5;
				break;
			case "CA":
				return 6;
				break;
			case "CO":
				return 7;
				break;
			case "CT":
				return 8;
				break;
			case "DC":
				return 10;
				break;
			case "DE":
				return 9;
				break;
			case "FL":
				return 12;
				break;
			case "GA":
				return 13;
				break;
			case "HI":
				return 15;
				break;
			case "ID":
				return 16;
				break;
			case "IL":
				return 17;
				break;
			case "IN":
				return 18;
				break;
			case "IA":
				return 19;
				break;
			case "KS":
				return 20;
				break;
			case "KY":
				return 21;
				break;
			case "LA":
				return 22;
				break;
			case "ME":
				return 23;
				break;
			case "MD":
				return 25;
				break;
			case "MA":
				return 26;
				break;			
			case "MI":
				return 27;
				break;			
			case "MN":
				return 28;
				break;			
			case "MS":
				return 29;
				break;			
			case "MO":
				return 30;
				break;			
			case "MT":
				return 31;
				break;			
			case "NE":
				return 32;
				break;			
			case "NV":
				return 33;
				break;			
			case "NH":
				return 34;
				break;			
			case "NJ":
				return 35;
				//echo "returned 35";
				break;			
			case "NM":
				return 36;
				break;			
			case "NY":
				return 37;
				break;			
			case "NC":
				return 38;
				break;			
			case "ND":
				return 39;
				break;			
			case "OH":
				return 41;
				break;			
			case "OK":
				return 42;
				break;			
			case "OR":
				return 43;
				break;			
			case "PA":
				return 45;
				break;			
			case "RI":
				return 47;
				break;			
			case "SC":
				return 48;
				break;			
			case "SD":
				return 49;
				break;			
			case "TN":
				return 50;
				break;			
			case "TX":
				return 51;
				break;			
			case "UT":
				return 52;
				break;			
			case "VT":
				return 53;
				break;			
			case "VA":
				return 55;
				break;			
			case "WA":
				return 56;
				break;			
			case "WV":
				return 57;
				break;			
			case "WI":
				return 58;
				break;			
			case "WY":
				return 59;
				break;			
			default:
				return "OT";
				break;
			//echo" 2nd function value for state is:".$value;
		}
	}

	function translateSuffix($value, $key)
	{
		switch ($value)
		{
			case "":
				return "";
				break;
			case "sfx_junior":
				return "Jr";
				break;
			case "sfx_senior":
				return "Sr";
				break;
			case "sfx_1":
				return "I";
				break;
			case "sfx_2":
				return "II";
				break;
			case "sfx_3":
				return "III";
				break;
			case "sfx_4":
				return "IV";
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;
		}
	}

	function translateThirdPartyRelationship($value, $key)
	{
		switch ($value)
		{
			case "rel_family_member":
				return "M";
				break;
			case "rel_friend":
				return "F";
				break;
			case "rel_attorney":
				return "T";
				break;
			case "rel_agency":
				return "A";
				break;
			case "rel_advocate":
				return "D";
				break;
			case "rel_social_worker":
				return "S";
				break;
			case "rel_rx_provider":
				return "P";
				break;
			case "rel_state_medicaid":
				return "G";
				break;
			case "rel_other":
				return "O";
				break;
			default:
				echo "No handler for this $key value ".$value." yet";
				exit;
		}
	}
}

?>
