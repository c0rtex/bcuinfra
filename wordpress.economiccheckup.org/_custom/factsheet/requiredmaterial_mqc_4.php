<?php 
require_once('_custom/displaycontent_mqc_4.php');
// Get List of Requisites

echo '
    			<section id="materials">
                        <div class="clearfix">
                            <label for="xlInput"><h4><i class="icon-check "></i> Please be prepared to have the following materials available:</h4>
                                <p>(Click on the links below to view examples.)
                                	<div class="nav nav-list">
                                        <ul>';
 $getReqs_query = $soapClient->getReqs($program_id);
 //$getReqs_query = restructureWSArray($getReqs_query);
 foreach ($getReqs_query as $reqObj) :
	$requiredmaterial = $reqObj["REQUIREDMATERIAL"];
	$reqtitle = $reqObj["REQTITLE"]; 
	$requiredmaterial = htmlentities($requiredmaterial);                                      
echo '
		<li><a data-content="'.$requiredmaterial.'" html="true" data-html="true" title="" data-toggle="popover" class="" href="#" data-original-title="'.$reqtitle.'">'.$reqtitle.'</a></li>
';
 endforeach;      
                                      
echo '                                  </ul>
					</div>
                                </p>
				</label>
                        </div>
			</section>
';
?>
