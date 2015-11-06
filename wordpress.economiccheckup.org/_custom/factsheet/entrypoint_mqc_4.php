<?php 
require_once('_custom/displaycontent_mqc_4.php');
//echo "Program ID for testing EP:".$program_id;
//echo " State ID for testing: ".$state_id;
//Build query to find the right office

$getOffice_query = $soapClient->getOffice('1222');
//$getOffice_query = restructureWSArray($getOffice_query);
echo '
 <section id="moreinfo">
                       
				    <!-- Office locator summary info -->                              
';
//Display Each Entrypoint
 foreach ($getOffice_query as $epObj) :
	$officeTitle = $epObj["NAME"];
	$officeaddress1 = $epObj["ADDRESS1"];
	$officeaddress2 = $epObj["ADDRESS2"];
	$officeaddress3 = $epObj["ADDRESS3"];
	$officecity = $epObj["CITY"]; 
	//$state_id = $epObj->state_id;
	$zipcode = $epObj["ZIPCODE"];
	$zipcode_plus4 = $epObj["ZIPCODE_PLUS4"];   
	$email = $epObj["EMAIL"];   
	$url = $epObj["URL"]; 
	$contact_title = $epObj["CONTACT_TITLE"];
	$contact_first = $epObj["CONTACT_FIRST"];
	$contact_middle = $epObj["CONTACT_MIDDLE"];
	$contact_last = $epObj["CONTACT_LAST"];
	$contact_suffix = $epObj["CONTACT_SUFFIX"];
	$hours_code = $epObj["HOURS_CODE"];
	$info_code = $epObj["INFO_CODE"];
         
   $noshow = ' <p>This office that serves your county. All program inquiries should be made through this office
                                <ul>
					<li>
                                        <h5>'.$officeTitle.'</h5>
                                        <small>'.$officeaddress1.$officeaddress2.$officeaddress3.'<BR>
                                        '.$officecity.' , '.$state_id.' '.$zipcode.' '.$zipcode_plus4.'<BR>
                                        Toll-Free: <BR>
                                        Phone: <BR>
					     Website: '.$url.' <BR>
					     </small>
                                    </li> 
  </ul>
					</p>
';

 endforeach;

 
                                                                    
echo '                             
				</label>
                        </div>
'>
require_once('_custom/factsheet/getep_mqc_4.php');
echo '
</section>
';
?>
