<?php 
require_once('_custom/displaycontent.php');
// Get List of Requisites
$query_getReqs = "
SELECT
rq.`code`,
rq.requisite_id,
prq.sort,
p.program_id,
dl1.display_text as requiredmaterial,
dl2.display_text as reqtitle
FROM
program AS p ,
program_requisite AS prq ,
requisite AS rq
INNER JOIN display AS d ON rq.display_id = d.display_id
LEFT OUTER JOIN display AS dd ON rq.def_display_id = dd.display_id
INNER JOIN display_language dl1 ON dl1.display_id = dd.display_id
INNER JOIN display_language dl2 ON dl2.display_id = d.display_id
where p.program_id = ".$program_id."
			and p.program_id=prq.program_id
			and prq.requisite_id=rq.requisite_id
		  and dl1.language_id = 'EN'
      and dl2.language_id = 'EN'
order by prq.sort
";


echo '
    			<section id="materials">
                        <div class="clearfix">
                            <label for="xlInput"><h4><i class="icon-check "></i> Please be prepared to have the following materials available:</h4>
                                <p>(Click on the links below to view examples.)
                                	<div class="nav nav-list">
                                        <ul>';
 $getReqs_query = $bcudb->get_results($query_getReqs);
 foreach ($getReqs_query as $reqObj) :
	$requiredmaterial = $reqObj->requiredmaterial;
	$reqtitle = $reqObj->reqtitle;  
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
