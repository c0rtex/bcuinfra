<?php 
require_once('_custom/displaycontent.php');   
$query_getForms = "
SELECT ft.string, t.tag_name,f.form_id,ft.formtype_id
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=".$program_id."
				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='".$state_id."')
				AND f.form_id=ft.form_id
				AND ft.formtype_id
				 in (1,3,4)
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort
";
$getForms_query = $bcudb->get_results($query_getForms);  
//print_r($getForms_query);  
$formcount = 0; 
 foreach ($getForms_query as $formObj) :
	$formtype_id = $formObj->formtype_id;
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

 echo '<li><a href="/cf/form_redirect.cfm?id='.$form_id.'&tgtPartner=77&tgt=/forms/'.$file.'" target="_blank">'.$formTitle.'</a></li>';

        				  	//echo '<li><a href="/forms/'.$file.'" target="_blank">'.$formTitle.'</a></li>';
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
