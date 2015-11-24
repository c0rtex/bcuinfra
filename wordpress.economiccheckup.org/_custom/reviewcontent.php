<?php 
$functionDebugging = "false"; // Debugging on = true and Debugging off = false
//TBD - Need to move DB connections to DB help functions
$wpdb = new wpdb(DB_USER,DB_PASSWORD,DB_NAME,DB_HOST);
$wpdb->show_errors();
$query_doposts = "
delete from wp_posts where id in (35,37,39,956,965,968,971,973,1673,1675,1677,1679,1683,1731,2185,2284,14608,2373,2424,2434,2537,2627,14609,2640,14610,3682,14611,2659,3683,2671,14612,2687,3134,3139,3161,14613,3164,14614,3184,3200,14615,3556,3581,3679,10288,10293,10433,10591,10898,11278,11280,11923,11938,12113,12356,12390,12450,12808,13053,13105,13244,13254,13260,13267,14616,13298,13307,13410,13411,13413,13516,13636,13803,13867,14617,14120,14488,14596,14740,14745,14771,14876,14888,15058,15401,15627,15792)
";
$doposts_query = $wpdb->get_results($query_doposts);  

$query_getposts = "
SELECT id,post_status
from wp_posts
where post_type = 'page' 
and post_status = 'trash'
";
$getposts_query = $wpdb->get_results($query_getposts);  
//print_r($getposts_query);  
$postcount = 0; 
 foreach ($getposts_query as $postObj) :
	$id = $postObj->id;
       if ($id != 0){
		$postcount ++;
		//echo "post type:".$postObj->post_type."post title:".$postObj->post_title."post id:".$postObj->id."post code:".$postObj->meta_value."<br>";
		echo $postObj->id.",".$postObj->post_status;
		}
  endforeach;
echo "post count".$postcount."<br><br>";
 foreach ($getposts_query as $postObj) :
	$id = $postObj->id;
       if ($id != 0){
		$postcount ++;
		//echo "post type:".$postObj->post_type."post title:".$postObj->post_title."post id:".$postObj->id."post code:".$postObj->meta_value."<br>";
		echo $postObj->id.",";
		}
  endforeach;
?>