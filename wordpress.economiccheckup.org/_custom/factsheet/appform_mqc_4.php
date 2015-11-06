<?php 
require_once('_custom/displaycontent_mqc_4.php');   
$getForms_query = $soapClient->getForms($program_id, $state_id);
//$getForms_query = restructureWSArray($getForms_query);
//print_r($getForms_query);  
$formcount = 0; 
 foreach ($getForms_query as $formObj) :
	$formtype_id = $formObj["FORMTYPE_ID"];
       if ($formtype_id != 3){
		$formcount ++;
		//echo "form type:".$formtype_id;
	}
  endforeach;

if ($formcount > 0) {                      
echo '
<section id="appforms">
                    	<div class="clearfix">
                        	<label for="xlInput"><h4><i class="icon-file-alt "></i> Application Forms</h4>
                                <p>Click below to get the application and/or document(s) for this program:
                                    <div class="nav nav-list">
                                    	<ul>
';
 $isOnlineApp = false;
 foreach ($getForms_query as $formObj) :
	$file = $formObj->string;
	$formTitle = $formObj->tag_name; 
	$form_id = $formObj->form_id;
	$formtype_id = $formObj->formtype_id;      
	
	if ($formtype_id == 3){
		$isOnlineApp = true;
              $appLink = $file;
	}
	   				  else {
        				  	echo '<li><a href="/forms/'.$file.'" target="_blank">'.$formTitle.'</a></li>';
				         }
					 
 endforeach;

 echo ' 
                                    	</ul>
                                    </div>
                             	</p>
                            </label>
                        </div>
                    </section>
';
}
?>
