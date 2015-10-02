<?php 
require_once('_custom/displaycontent.php');
//echo "Program ID for testing EP:".$program_id;
//echo " State ID for testing: ".$state_id;
//Build query to find the right office
$query_getOffice = "
select e.code, e.name, e.subname, e.address1, e.address2, e.address3,
		e.city, e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url,
		e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
		e.contact_suffix, dh.display_code hours_code, di.display_code info_code
	from entrypoint e left outer join display dh
			on e.hours_display_id=dh.display_id
		left outer join display di
			on e.info_display_id=di.display_id
	where e.entrypoint_id=1222
		and e.active_flag=1
";
 $getOffice_query = $bcudb->get_results($query_getOffice);                               
echo '
 <section id="moreinfo">
                       
				    <!-- Office locator summary info -->                              
';
//Display Each Entrypoint
 foreach ($getOffice_query as $epObj) :
	$officeTitle = $epObj->name;
	$officeaddress1 = $epObj->address1;
	$officeaddress2 = $epObj->address2;
	$officeaddress3 = $epObj->address3;
	$officecity = $epObj->city; 
	//$state_id = $epObj->state_id;
	$zipcode = $epObj->zipcode;
	$zipcode_plus4 = $epObj->zipcode_plus4;   
	$email = $epObj->email;   
	$url = $epObj->url; 
	$contact_title = $epObj->contact_title;
	$contact_first = $epObj->contact_first;
	$contact_middle = $epObj->contact_middle;
	$contact_last = $epObj->contact_last;
	$contact_suffix = $epObj->contact_suffix; 
	$hours_code = $epObj->hours_code;
	$info_code = $epObj->info_code;
         
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
require_once('_custom/factsheet/getep.php');
echo '
</section>
';
?>