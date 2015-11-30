<?php

class Applicant extends TranslateSSA
{
	var $answers;

	function Applicant($answers)
	{
		$this->answers = $answers;
	}
	
	
	function defaultThirdParty(& $answers)
	{	
		/*		
		if(QA)
		{   
			$answers['BE_CLNT_DOB_MONTH'] = 4;
			$answers['BE_CLNT_DOB_DAY'] = 2;
			$answers['BE_CLNT_DOB_YEAR'] = 1940;	
			if($answers['CT_MRTL_STUS'] == 'MLT')
			{
				$answers['BE_NONCL_DOB_MONTH'] = 4;	
				$answers['BE_NONCL_DOB_DAY'] = 2;	
				$answers['BE_NONCL_DOB_YEAR'] = 1940;											
			}			
		}
		
		$answers['BE_THRD_REL'] = 'O';	
		if($answers['CT_THRD_PTY_XND'] == 0)
		{
			$answers['BE_THRD_REL_OTH'] = 'NCOA';
			$answers['BE_THRD_FNM'] = 'Customer';
			$answers['BE_THRD_LNM'] = 'Support';
			$answers['BE_THRD_PHNAREA'] = 212;
			$answers['BE_THRD_PHNEXCH'] = 481;
			$answers['BE_THRD_PHNNUM'] = 1995;
			$answers['BE_THRD_ADDRLN_1'] = '232 Madison Avenue';
			$answers['BE_THRD_ADDRLN_2'] = 'Suite 1204';
			$answers['BE_THRD_ADDR_CITY'] = 'New York';
			$answers['BE_THRD_ADDR_ST'] = 'NY';
			$answers['BE_THRD_ADDR_ZIP5'] = 10016;
		}
		else
		{
			if( strlen($answers['BE_THRD_REL_OTH']) > 20)
			{
				$answers['BE_THRD_REL_OTH'] = substr($answers['BE_THRD_REL_OTH'], 0, 20);
			}
			$answers['BE_THRD_REL_OTH'] .= '-NCOA';
		}		
		$answers['CT_THRD_PTY_XND'] = '1';		
		*/
	}
	
}
?>