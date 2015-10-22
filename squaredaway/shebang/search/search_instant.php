<?php
include_once($_SERVER['DOCUMENT_ROOT'].'/wp-load.php' );
global $wpdb;

require ( $_SERVER['DOCUMENT_ROOT']."/sphinx/api/sphinxapi.php" );

$cl = new SphinxClient();
// start off by wildcard searching the kwindex
$q = $_GET['q'] . '*';
if (!$q){
	$q = $_POST['q'] . '*';
}
$index = 'kwindex';
$cl->SetMatchMode ( SPH_MATCH_ANY );
$res = $cl->Query ( $q, $index );

$arr = array();
$results = array();

if ( $res===false ) {
	echo "Failed: " . $cl->GetLastError() . ".\n";

} else {
   // if there are keyword matches, return the posts tagged with that 
   // keyword
   if ( is_array($res["matches"]) ) {
      // keys hold the term_id for each matched keyword
		foreach ( $res["matches"] as $key => $value ) {
			$arr[] = $key;
		}
		
		// make a big fancy db query
		$args = array(
			'tax_query' => array(
				array(
					'taxonomy' => 'search',
					'field' => 'term_id',
					'terms' => $arr
				)
			)
		);
		$the_query = new WP_Query($args);
		$n = 0;
		
		// return post info. return max 4 posts.
		while ( $the_query->have_posts() ) : $the_query->the_post();
			if ($n == 3) break;
			$resarr = array();
			$resarr['title'] = $post->post_title;
			$resarr['post_type'] = $post->post_type;
			$resarr['thumb_src'] = get_post_thumbnail_src($post->ID);
			$resarr['permalink'] = get_permalink($post->ID);
			$ex = get_the_excerpt();
			$resarr['excerpt'] = strip_tags(truncate_simple($ex, 150));
			$results[] = $resarr;
			$n++;
		endwhile;
		rewind_posts();
	} else {
	   // if there are no keyword matches, hit the fulltext index
	   $q2 = $_GET['q'];
	   if (!$q2){
	   		$q2 = $_POST['q'];
	   }
	   $index = 'test1';
	   $res = $cl->Query ( $q, $index );
	   if ( is_array($res["matches"]) ) {
         $m = 0;
		   foreach ( $res["matches"] as $key => $value ) {
		      if ($m == 3) break;
            $postobj = get_post_info($key);
		      if ($postobj->status == 'publish') {
               if ($postobj->parent === 0) {
                  if (array_search($key, $arr) === false) {
                     $arr[] = $key;
                     $resarr = array();
                     $resarr['title'] = $postobj->post_title;
                     $resarr['post_type'] = $postobj->post_type;
                     $resarr['thumb_src'] = $postobj->thumb_src;
                     $resarr['permalink'] = $postobj->permalink;
                     $ex = $postobj->body;
                     $resarr['excerpt'] = strip_tags(truncate_simple($ex, 150));
                     $results[] = $resarr;
                     $m++;
                  }
               } else {
                  if (array_search($postobj->parent, $arr) === false) {
                     $arr[] = $postobj->parent;
                     $par = get_post_info($postobj->parent);
                     $resarr = array();
                     $resarr['title'] = $par->post_title;
                     $resarr['post_type'] = $par->post_type;
                     $resarr['thumb_src'] = $par->thumb_src;
                     $resarr['permalink'] = $par->permalink;
                     $ex = $par->body;
                     $resarr['excerpt'] = strip_tags(truncate_simple($ex, 150));
                     $results[] = $resarr;
                     $m++;
                  }
               }
            }
		   }
		}
	}
}
echo json_encode($results);
exit;
//print_r($results);