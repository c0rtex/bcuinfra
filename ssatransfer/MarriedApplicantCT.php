<?php

class MarriedApplicantCT
{
    var $pages = array( array('PAGEID'=> 'Ee001',  'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.START'=> 'Apply+Now'), 
                        array('PAGEID'=> 'Ee006b', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next'),
                        array('PAGEID'=> 'Ee002',  'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next', 
                              'CT_THRD_PTY_XND'=> '', 'CT_MAIL_XND'=> '', 'CT_RECEIVE_MEDICARE_XND'=> '', 'CT_OLDER_XND'=> '', 'CT_SS_DISBLTY_XND'=> '',
                              'CT_LIVE_GRT'=> '', 'CT_MRTL_STUS'=> '', 'BE_SAV_LMT_XND'=>''),
                              
                        array('PAGEID'=> 'Ee005b', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Apply+Now'),                        //MH-Added BE_SEND_MSPINFO_CD for 12/31/2009 release                                                                    
                        array('PAGEID'=> 'Mc001', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next',
                         	  'BE_THRD_FNM'=>'', 'BE_THRD_MNM'=>'', 'BE_THRD_LNM'=>'', 'BE_THRD_REL'=>'', 'BE_THRD_REL_OTH'=>'', 'BE_THRD_PHNAREA'=>'', 
                         	  'BE_THRD_PHNEXCH'=>'', 'BE_THRD_PHNNUM'=>'','CT_THRD_PHONE'=>'', 'BE_THRD_ADDRLN_1'=>'', 'BE_THRD_ADDRLN_2'=>'', 'BE_THRD_ADDRLN_3'=>'',  'BE_THRD_ADDRLN_4'=>'',  
							  'BE_THRD_ADDR_CITY'=>'', 'CT_THRD_ADDR_ST_GRT'=>'', 'BE_THRD_ADDR_ZIP5'=>'', 'BE_CLNT_FNM'=>'', 'BE_CLNT_MNM'=>'', 'BE_CLNT_LNM'=>'', 
                         	  'BE_CLNT_SFX'=>'', 'CT_CLNT_COSSN'=>'', 'BE_CLNT_WRKD_L2YR_XND'=>'', 'BE_WH_APPLY'=>'', 
                         	  'BE_SAV_LMT_XND'=>'', 'BE_SEND_MSPINFO_CD'=>'', 'BE_NONCL_FNM'=>'', 'BE_NONCL_MNM'=>'', 'BE_NONCL_LNM'=>'', 'BE_NONCL_SFX'=>'', 'CT_NONCL_COSSN'=>'', 
                         	  'BE_NONCL_WRKD_L2YR_XND'=>'', 'BE_CLNT_CHG_ADDR_SW'=>'', 'BE_CLNT_MAIL_ADDRLN_1'=>'',  
                         	  'BE_CLNT_MAIL_ADDRLN_2'=>'', 'BE_CLNT_MAIL_ADDRLN_3'=>'', 'BE_CLNT_MAIL_ADDRLN_4'=>'','BE_CLNT_MAIL_ADDR_CITY'=>'', 'CT_CLNT_MAIL_ADDR_ST_GRT'=>'', 'BE_CLNT_MAIL_ADDR_ZIP5'=>'', 
                         	  'BE_CLNT_PHNAREA'=>'', 'BE_CLNT_PHNEXCH'=>'', 'BE_CLNT_PHNNUM'=>'', 'BE_CNTCT_FNM'=>'', 'BE_CNTCT_LNM'=>'', 'BE_CNTCT_PHNAREA'=>'', 
                         	  'BE_CNTCT_PHNEXCH'=>'', 'BE_CNTCT_PHNNUM'=>'', 'CT_CNTCT_PHONE'=>'', 'CT_CLNT_PHONE'=>'','BE_CLNT_DOB_MONTH'=>'','BE_CLNT_DOB_DAY'=>'','BE_CLNT_DOB_YEAR'=>'',	
							  'BE_NONCL_DOB_MONTH'=>'','BE_NONCL_DOB_DAY'=>'','BE_NONCL_DOB_YEAR'=>''),
				                                                                                                               
                        array('PAGEID'=> 'Mc002', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next'),                        //MH-Removed BE_EXPENSE_XND and BE_EXPENSE_AMT for 12/31/2009 release
                        array('PAGEID'=> 'Mc003', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next',
                      	      'BE_RLTVS_SUP'=>''/*, 'BE_EXPENSE_XND'=>'','BE_EXPENSE_AMT'=>''*/),                      	            
						//MH-Removed BE_CLNT_INS_POL_XND, BE_NONCL_INS_POL_XND and BE_INS_POL_AMT for 12/31/2009 release
					    array('PAGEID'=> 'Mc006', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next',
                              'BE_RES_BANK_ACC_XND'=>'', 'BE_RES_BANK_ACC_AMT'=>'', 'BE_RES_INVST_XND'=>'', 'BE_RES_INVST_AMT'=>'', 'BE_RES_CSH_XND'=>'',
							  'BE_RES_CSH_AMT'=>'',/* 'BE_CLNT_INS_POL_XND'=>'', 'BE_NONCL_INS_POL_XND'=>'', 'BE_INS_POL_AMT'=>'',*/ 'BE_CLNT_BUEXP_SW'=>'',
							   'BE_NONCL_BUEXP_SW'=>'', 'BE_RESTT_XND'=>''),                     	
						array('PAGEID'=> 'Mc005', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next',
                     	      'BE_CLNT_RR_INCM_XND'=>'', 'BE_CLNT_RR_INCM_AMT'=>'', 'BE_NONCL_RR_INCM_XND'=>'', 'BE_NONCL_RR_INCM_AMT'=>'',
                     	      'BE_CLNT_VA_BENEFITS_XND'=>'', 'BE_CLNT_VA_BENEFITS_AMT'=>'', 'BE_NONCL_VA_BENEFITS_XND'=>'', 'BE_NONCL_VA_BENEFITS_AMT'=>'',
                              'BE_CLNT_PENS_ANNUIT_XND'=>'', 'BE_CLNT_PENS_ANNUIT_AMT'=>'', 'BE_NONCL_PENS_ANNUIT_XND'=>'', 'BE_NONCL_PENS_ANNUIT_AMT'=>'',
                              'BE_CLNT_OTH_INCM_XND'=>'', 'BE_CLNT_OTH_INCM_AMT'=>'', 'BE_CLNT_OTH_INCM_TYP'=>'', 'BE_NONCL_OTH_INCM_XND'=>'',
                              'BE_NONCL_OTH_INCM_AMT'=>'', 'BE_NONCL_OTH_INCM_TYP'=>'', 'BE_INCM_DECRS_XND'=>'', 'BE_CLNT_SS_BENEFITS_XND'=>'', 
                              'BE_CLNT_SS_BENEFITS_AMT'=>'', 'BE_NONCL_SS_BENEFITS_XND'=>'', 'BE_NONCL_SS_BENEFITS_AMT'=>'', 'BE_CLNT_WRKD_L2YR_XND'=>'', 'BE_NONCL_WRKD_L2YR_XND'=>''),                
                        array('PAGEID'=> 'Mc004', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next',
                        	  'BE_CLNT_EARN_WGS_XND'=>'', 'BE_CLNT_EARN_WGS_AMT'=>'', 'BE_NONCL_EARN_WGS_XND'=>'', 'BE_NONCL_EARN_WGS_AMT'=>'',                                                                                                         
  							  'BE_CLNT_EARN_LOSS_XND'=>'', 'BE_CLNT_EARN_AMT'=>'', 'BE_NONCL_EARN_LOSS_XND'=>'',   
                              'BE_NONCL_EARN_AMT'=>'', 'BE_WGS_DECRS_XND'=>'', 'BE_CLNT_STOP_WRK_XND'=>'',   
  							  'BE_CLNT_STOP_WRK_MONTH'=>'', 'BE_CLNT_STOP_WRK_YEAR'=>'', 'BE_NONCL_STOP_WRK_XND'=>'', 'BE_NONCL_STOP_WRK_MONTH'=>'',  						
                              'BE_NONCL_STOP_WRK_YEAR'=>'', 'BE_CLNT_PAY_DISBLTY_XND'=>'','BE_NONCL_PAY_DISBLTY_XND'=>'', 'BE_CLNT_WRKD_L2YR_XND'=>'', 'BE_NONCL_WRKD_L2YR_XND'=>''),   
               
                        array('PAGEID'=> 'Rs001', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.CONTINUE'=> 'Next'),
                        array('PAGEID'=> 'Rs003', 'PAGEOCCURRENCE'=> 1, 'PAGESETID'=> '', 'PAGESETOCCURRENCE'=> 0, 'ACTION.SUBMIT'=> 'Submit+Now',
                              'BE_THRD_SUB_SW'=>'', 'BE_CLNT_SUB_SW'=>'', 'BE_NONCL_SUB_SW'=>'') );
                              
   	function MarriedApplicantCT()
    {
    	
    }  
    
    function savingsLimit($BE_SAV_LMT_XND)
    {
    	if($BE_SAV_LMT_XND == 1)
   		{ 
   			$this->pages[3]['PAGEID'] = "Ee005a";
   		}    		 
    }    
    
    function thirdParty($BE_THRD_REL)
   	{
   		if($BE_THRD_REL == 0)
   		{
   			$this->pages[4]['PAGEID'] = "Mc001";
   			unset($this->pages[4]['BE_THRD_FNM']);
   			unset($this->pages[4]['BE_THRD_MNM']);
   			unset($this->pages[4]['BE_THRD_LNM']);
   			unset($this->pages[4]['BE_THRD_REL']);
   			unset($this->pages[4]['BE_THRD_REL_OTH']);
   			unset($this->pages[4]['BE_THRD_PHNAREA']);
   			unset($this->pages[4]['BE_THRD_PHNEXCH']);
   			unset($this->pages[4]['BE_THRD_PHNNUM']);
   			unset($this->pages[4]['BE_THRD_ADDRLN_1']);
   			unset($this->pages[4]['BE_THRD_ADDRLN_2']);
   			unset($this->pages[4]['BE_THRD_ADDRLN_3']);
			unset($this->pages[4]['BE_THRD_ADDRLN_4']);
   			unset($this->pages[4]['BE_THRD_ADDR_CITY']);
   			unset($this->pages[4]['CT_THRD_ADDR_ST_GRT']);
   			unset($this->pages[4]['BE_THRD_ADDR_ZIP5']);
   		}
   	}
   	
    function wagesEarning(
	$BE_CLNT_WRKD_L2YR_XND, 
	$BE_NONCL_WRKD_L2YR_XND,
	$BE_CLNT_PAY_DISBLTY_XND,
	$BE_NONCL_PAY_DISBLTY_XND,
	$BE_NONCL_DOB_YEAR,
	$BE_NONCL_STOP_WRK_XND)
    {
		if ( $BE_NONCL_PAY_DISBLTY_XND == 9)    
		{
		unset($this->pages[9]['BE_CLNT_PAY_DISBLTY_XND']); 
		}
		if ( $BE_CLNT_PAY_DISBLTY_XND == 9  )
		{
		unset($this->pages[9]['BE_CLNT_PAY_DISBLTY_XND']); 
		}
    	
    	if($BE_CLNT_WRKD_L2YR_XND == 0 AND $BE_NONCL_WRKD_L2YR_XND == 0) //skip the wages and earnings page
    	{    	    		
    		unset($this->pages[9]);    		
		}
    	//if($BE_CLNT_UNDER_AGE_XND == 0 AND $BE_NONCL_UNDER_AGE_XND == 0) //remove BE_CLNT_PAY_DISBLTY_XND and BE_NONCL_PAY_DISBLTY_XND questions from wages and earnings page
    	//{     		    		  
    	//	unset($this->pages[9]['BE_CLNT_PAY_DISBLTY_XND']);
    	//	unset($this->pages[9]['BE_NONCL_PAY_DISBLTY_XND']);     		 	    	
    	//}
		
		//ONLY INCLUDE IF BE_NONCL_WRKD_L2YR_XND = 'Y' AND SPOUSE AGE >= 65 (LOOK AT BE_NONCL_DOB FIELDS): BE_NONCL_PAY_DISBLTY_XND
		
	if($BE_CLNT_PAY_DISBLTY_XND == 9)
	{
		unset($this->pages[9]['BE_CLNT_PAY_DISBLTY_XND']); 
		}
	if($BE_NONCL_PAY_DISBLTY_XND == 9)
	{
		unset($this->pages[9]['BE_NONCL_PAY_DISBLTY_XND']); 
		}
	if($BE_NONCL_STOP_WRK_XND == 9)
	{
		unset($this->pages[9]['BE_NONCL_STOP_WRK_XND']); 
		}
   }

	/*MH-Removed for 12/31/2009 release
   function insPol($BE_CLNT_INS_POL_XND,$BE_NONCL_INS_POL_XND){
       if ($BE_CLNT_INS_POL_XND !== 'y' and $BE_NONCL_INS_POL_XND !== 'y')
		$BE_INS_POL_AMT = '';
   }*/

}
?>

