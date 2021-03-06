<?php

	function upstatement_load_scripts(){
		if (!is_admin()){
			wp_register_style('style', get_bloginfo('template_url').'/style.css');
			wp_enqueue_style('style');
			
			wp_register_style('style-jared', get_bloginfo('template_url').'/_css/style-jared.css');
			wp_enqueue_style('style-jared');
			
			wp_register_style('screen', get_bloginfo('template_url').'/_css/screen.css');
			wp_enqueue_style('screen');
    	}
	}
	
	//add_action('init', 'upstatement_load_scripts');
	//add_action('template_redirect', 'upstatement_load_scripts');

	require_once(ABSPATH . WPINC . '/registration.php');

	function get_gallery_info($gid){
		$query = "SELECT * FROM wp_ngg_gallery WHERE gid = '$gid'";
		$result = mysql_query($query);
		$row = mysql_fetch_object($result);
		return $row;
	}
	
	function add_links_to_string($str){
		$new = preg_replace("/(http:\/\/[^\s]+)/", "<a href=\"$1\">$1</a>", $str);
		return $new; /* will display $text with link to http://www.whyistheskyblue.com/... */
	}
	
	function twitterify($ret) {
		$ret = preg_replace("#(^|[\n ])([\w]+?://[\w]+[^ \"\n\r\t< ]*)#", "\\1<a href=\"\\2\" target=\"_blank\">\\2</a>", $ret);
		$ret = preg_replace("#(^|[\n ])((www|ftp)\.[^ \"\t\n\r< ]*)#", "\\1<a href=\"http://\\2\" target=\"_blank\">\\2</a>", $ret);
		$ret = preg_replace("/@(\w+)/", "<a href=\"http://www.twitter.com/\\1\" target=\"_blank\">@\\1</a>", $ret);
		$ret = preg_replace("/#(\w+)/", "<a href=\"http://search.twitter.com/search?q=\\1\" target=\"_blank\">#\\1</a>", $ret);
		return $ret;
	}

	
	function get_post_gallery($pid){
		$args = array( 'post_type' => 'attachment', 'numberposts' => -1, 'post_status' => null, 'post_parent' => $pid, 'orderby' => 'menu_order', 'order' => 'ASC' ); 
		$attachments = get_posts($args);
		$att2 = array();
		foreach($attachments as $att){
			if ($att->menu_order > 0){
				$att2[] = $att;
			}	
		}
		//print_r($attachments);
		return $att2;
	}
	
	function get_tax($slug){
		$terms = get_terms($slug);
		$tax = array();
		foreach($terms as $term){
			$tax[] = get_term_info($term->term_id);
		}
		return $tax;
	}
	
	function get_term_info($tid){
		global $wpdb;
		if (gettype($tid) == 'object'){
			$tid = $tid->term_id;
		}
		if (is_numeric($tid)){
			$query = "SELECT * FROM wp_terms WHERE term_id = '$tid'";
		} else {
			$query = "SELECT * FROM wp_terms WHERE slug = '$tid'";
		}
		$result = $wpdb->get_row($query);
		$result->ID = $result->term_id;
		$query = "SELECT * FROM wp_term_taxonomy WHERE term_id = '$result->ID'";
		$tax = $wpdb->get_row($query);
		$term = get_term($result->ID, $tax->taxonomy);
		$term->ID = $result->ID;
		if(function_exists('get_term_custom')){
			$term->custom = get_term_custom($result->term_id);
			if ($term->custom){
				foreach($term->custom as $key => $value){
					$term->$key = $value[0];
				}
			}
		}
		return $term;
	}
	
	function get_post_thumbnail_src($pid){
		$src = false;
		if (function_exists('get_post_thumbnail_id')){
			$tid = get_post_thumbnail_id($pid);
			$size = 'full';
			$src = wp_get_attachment_image_src($tid, $size);
			$src = $src[0];
		}
		return $src;
	}
	
	function get_post_thumbnail($pid=0, $w=0, $h=0){
		if (!$pid){
			$pid = get_the_ID();
		}
		$tid = get_post_thumbnail_id($pid);
		$size = 'full';
		
		$src = wp_get_attachment_image_src($tid, $size);
		$src = $src[0];
		if (!isset($src)){
			$gal = get_post_gallery($pid);
			$src = $gal[0]->guid;
		}
		if (isset($w) && $h == 0){
			$base = basename($src);
			$src = '/wp-content/image.php/'.$base.'?image='.$src.'&amp;width='.$w;
		} else if (isset($w) && isset($h)){
			$base = basename($src);
			$src = '/wp-content/image.php/'.$base.'?image='.$src.'&amp;width='.$w.'&amp;height='.$h.'&amp;cropratio='.$w.':'.$h;
		}
		return $src;
	}
	
	function get_post_thumbnail_info($pid){
		$tid = get_post_thumbnail_id($pid);
		return get_post_info($tid);
	}
	
	function get_resized_image($src, $w, $h = 0){
		if (isset($w) && $h == 0){
			$base = basename($src);
			$src = '/wp-content/image.php/'.$base.'?image='.$src.'&amp;width='.$w;
		} else if (isset($w) && isset($h)){
			$base = basename($src);
			$src = '/wp-content/image.php/'.$base.'?image='.$src.'&amp;width='.$w.'&amp;height='.$h.'&amp;cropratio='.$w.':'.$h;
		}
		return $src;
	}
	
	function get_editable_custom($key, $pid = 0){
		if ($pid == 0){
			$pid = get_the_ID();
		}
		$post = get_post_info($pid);
		$link = get_edit_post_link($post->ID);
		if ($link){
			$ret = '<span class="contenteditable custom" contenteditable="true" data-pid="'.$post->ID.'" data-key="'.$key.'">'.$post->$key.'</span>';
			return $ret;
		}
		return $post->$key;
	}
	
	function get_editable_title($fid = 0){
		if (!$fid){
			$fid = get_the_ID();
		}
		$post = get_post_info($fid);
		$link = get_edit_post_link($post->ID);
		if ($link){
			$ret = '<span class="contenteditable furniture-title" contenteditable="true" data-pid="'.$post->ID.'">'.$post->post_title.'</span>';
			return $ret;
		} 
		return $post->post_title;
	}

	function get_editable_furniture($fid){
		$post = get_post_info($fid);
		$link = get_edit_post_link($post->ID);
		if ($link){
			if (strlen(!$post->post_content)){
				//$post->post_content = get_the_content($post->ID);
			}
			$ret = '<span class="contenteditable furniture" contenteditable="true" data-pid="'.$post->ID.'">'.$post->post_content.'</span>';
			return $ret;
		} 
		return $post->post_content;
	}
	
	function get_taxonomy_tree($taxname, $order = array()){
		$pparents = get_categories(array('taxonomy' => $taxname));
		$parents = array();
		foreach($pparents as $parent){
			if ($parent->parent == 0){
				$parents[] = $parent;
			}
		}
		if (count($order)){
			$parents = array();
			foreach($order as $o){
				$parents[] = get_term($o, $taxname);
			}
		}
		foreach($parents as $parent){
			
			$children = get_terms($taxname, array(
				'parent' => $parent->term_id,
				'hide_empty' => 0
			));
			
			foreach($children as $child){
				$gc = get_terms($taxname, array(
					'parent' => $child->term_id,
					'hide_empty' => 0,
				));
				$child->children = $gc;
			}
			$parent->children = $children;
		}
		return $parents;
	}
	
	function get_post_id_by_name($post_name){
		global $wpdb;
		$query = "SELECT ID FROM $wpdb->posts WHERE post_name = '$post_name'";
		$result = $wpdb->get_row($query);
		return $result->ID;
	}
	
	function get_post_info($pid = 0){
		if ($pid == 0 && is_numeric($pid)){
			$pid = get_the_ID();
		}
		if (!is_numeric($pid)){
			$pid = get_post_id_by_name($pid);
		}
		$post = get_post($pid);
		$post->title = $post->post_title;
		$post->body = $post->post_content;
		$post->excerpt = $post->post_excerpt;
		$post->slug = $post->post_name;
		$post->custom = get_post_custom($pid);
		$post->permalink = get_permalink($pid);
		$post->path = str_replace($_SERVER['HTTP_HOST'], '', $post->permalink);
		$post->path = str_replace('http://', '', $post->path);
		$post->thumb_src = get_post_thumbnail_src($pid);
		if ($post->custom){
			foreach($post->custom as $key => $value){
				$v = $value[0];
                $post->$key = $v;
				if (gettype(unserialize($v)) == 'array'){
					$post->$key = unserialize($v);
				}
                
			}
		}

		$post->status = $post->post_status;
		$post->children = get_children('post_parent='.$pid.'&post_type='.$post->post_type);
		$post->parent = $post->post_parent;
		$post->post_type_info = get_post_type_object($post->post_type);
		return $post;
	}
	
	function get_post_title($pid){
		$post = get_post_info($pid);
		return $post->post_title;
	}
	
	function get_slug($pid){
		$post_obj = get_post_info($pid);
		return $post_obj->post_name;	
	}
	
	function struncate($string, $max = 20, $rep = '') { 
		if (strlen($string) <= ($max + strlen($rep))) { 
			return $string; 
		} 
		$leave = $max - strlen ($rep); 
		return substr_replace($string, $rep, $leave); 
	} 
	
	function truncate_simple($string, $limit, $break=" ", $pad="...") {
		// return with no change if string is shorter than $limit
		if(strlen($string) <= $limit) return $string;
	
		// is $break present between $limit and the end of the string?
		if(false !== ($breakpoint = strpos($string, $break, $limit))) {
			if($breakpoint < strlen($string) - 1) {
				$string = substr($string, 0, $breakpoint) . $pad;
			}
		}	
		return $string;
	}

	
	function truncate($string, $limit, $break=".", $pad="..."){
		// return with no change if string is shorter than $limit
		if (strlen($string) <= $limit) return $string;
		// is $break present between $limit and the end of the string?
		if (false !== ($breakpoint = strpos($string, $break, $limit))) {
			if($breakpoint < strlen($string) - 1) {
				$string = substr($string, 0, $breakpoint) . $pad;
			}
		}
		return $string;
	}
	
	function get_template_name(){
		foreach ( debug_backtrace() as $called_file ) {
			foreach ( $called_file as $index ) {
				if ( !is_array($index[0]) AND strstr($index[0],'/themes/') AND !strstr($index[0],'footer.php') ) {
					$template_file = $index[0] ;
				}
			}
		}
		$template_contents = file_get_contents($template_file) ;
		preg_match_all("(Template Name:(.*)\n)siU",$template_contents,$template_name);
		$template_name = trim($template_name[1][0]);
		if ( !$template_name ) { $template_name = '(default)' ; }
		$template_file = array_pop(explode('/themes/', basename($template_file)));
		return $template_file . ' > '. $template_name ;
	}

	add_filter('body_class', 'my_body_class', 10, 4);


	function my_body_class($classes, $class, $comment_id=0, $post_id=0) {
		if (is_page()) {
			$classes[] = sanitize_title_with_dashes(get_the_title($post_id));
		}
		$uri = $_SERVER["REQUEST_URI"];
		$dir = explode('/', $uri);
		$dir = $dir[1];
		if ($dir){
			$classes[] = 'section-'.$dir;
		}
		return $classes;
	}
	
	function email_to_nickname($email){
		if (strpos($email, '@')){
			$parts = explode('@',$email); 
			$email = $parts[0]; 
		}
		return $email;
	}
	
	function upstatement_comment($comment, $args, $depth){ 
		$GLOBALS['comment'] = $comment;
		echo '<li ';
		comment_class();
		echo ' id="li-comment-'.get_comment_ID().'">';
		echo '<div id="comment-'.get_comment_ID().'" class="clearfix">';
		echo '<div class="comment-col-meta">';
  
  
  		/* IMAGE SHIT */
		echo '<div class="comment-author vcard">';
		$comment_uid = $comment->user_id;
		$fbuid = get_user_meta($comment_uid, 'fbid');
		if ($fbuid){
    	//echo get_avatar($comment,$size='48',$default='https://graph.facebook.com/'.$fbuid[0].'/picture' );
			echo '<img src="https://graph.facebook.com/'.$fbuid[0].'/picture" class="avatar-facebook" />';
		} else {
			echo get_avatar($comment,$size='60');
		}
		echo '</div>';
  		
  		
  
  		/* COMMENTOR NAME SHIT */
		//print_r($comment);
  	 	echo '<div class="comment-author data">';
		//printf(__('<cite class="fn">%s</cite>'), get_comment_author_link());
    	echo '<strong>',email_to_nickname(get_user_meta($comment->user_id, 'nickname', true)),'</strong>';
		if ($comment->comment_approved == '0'){
			echo '<br /><em>Your comment is awaiting moderation</em>';
			echo  '<br />';
		}
		echo '<div class="comment-meta commentmetadata small-gray">';
		printf(__('%1$s at %2$s'), get_comment_date(),  get_comment_time());
		//edit_comment_link(__('(Edit)'),'  ','');
		echo '</div>';
		echo '</div>'; // end meta text column
		echo '</div>'; // end meta column;
		echo '<div class="comment-col-content">';
		comment_text();
		echo '</div>';
		echo '<div class="reply">';
       comment_reply_link(array_merge( $args, array('depth' => $depth, 'max_depth' => $args['max_depth'])));
		echo '</div> </div>';
	}
	
	function parse_signed_request($signed_request, $secret) {
		list($encoded_sig, $payload) = explode('.', $signed_request, 2); 
		// decode the data
		$sig = base64_url_decode($encoded_sig);
		$data = json_decode(base64_url_decode($payload), true);
		if (strtoupper($data['algorithm']) !== 'HMAC-SHA256') {
			error_log('Unknown algorithm. Expected HMAC-SHA256');
			return null;
		}
		// check sig
		$expected_sig = hash_hmac('sha256', $payload, $secret, $raw = true);
		if ($sig !== $expected_sig) {
			error_log('Bad Signed JSON signature!');
			return null;
		}
		return $data;
	}
	
	function find_user_by_meta($key, $value){
		global $wpdb;
		$query = "SELECT user_id FROM $wpdb->usermeta WHERE meta_key = '$key' AND meta_value = '$value'";
		$result = $wpdb->get_row($query);
		return $result->user_id;
	}
	
	function find_post_by_meta($key, $value){
		$query = "SELECT post_id FROM $wpdb->postmeta WHERE meta_key = '$key' AND meta_value = '$value'";
		$result = $wpdb->get_row($query);
		return $result->post_id;
	}

	function base64_url_decode($input) {
		return base64_decode(strtr($input, '-_', '+/'));
	}
/*
if (!function_exists('json_decode')) {
    function json_decode($content, $assoc=false) {
        require_once 'JSON/JSON.php';
        if ($assoc) {
            $json = new Services_JSON(SERVICES_JSON_LOOSE_TYPE);
        }
        else {
            $json = new Services_JSON;
        }
        return $json->decode($content);
    }
}

if (!function_exists('json_encode')) {
    function json_encode($content) {
        require_once 'JSON/JSON.php';
        $json = new Services_JSON;
        return $json->encode($content);
    }
}
*/

function atk_post_comment_meta($post_id){
	global $wpdb;
	$uid = $_POST['user_id'];
	$query = "UPDATE $wpdb->comments SET user_id = '$uid' WHERE comment_ID = '$post_id'";
	$result = $wpdb->get_row($query);
	$name = mysql_real_escape_string($_POST['comment_author']);
	$query = "UPDATE $wpdb->comments SET comment_author = '$name' WHERE comment_ID = '$post_id'";
	
	$result = $wpdb->get_row($query);
	update_user_meta($uid, 'nickname', $name);
}

add_action('comment_post', 'atk_post_comment_meta', 1);

function get_post_type_singular_name($post_id) {
	$slug = get_post_type($post_id);
	$typeobj = get_post_type_object($slug);
	return $typeobj->labels->singular_name;
}

/* Return image tag for featured image. Class attribute optional. */
function getPostImage($postid, $class='') {
	if (has_post_thumbnail($postid)) {
		$thumbid = get_post_thumbnail_id($postid);
		$thumb = get_post($thumbid);
		return '<img src="'.$thumb->guid.'" title="'.$thumb->post_title.'" alt="'.$thumb->post_title.'" class="'.$class.'" />';
	}
}

/* Return source for featured image given post id. */
function getPostImageSrc($postid) {
	if (has_post_thumbnail($postid)) {
		$thumbid = get_post_thumbnail_id($postid);
		$thumb = get_post($thumbid);
		return $thumb->guid;
	}
}

/* PHP UTILITIES */

function array_unique_on_key($arr, $key){
	$keys = array();
	$result = array();
	foreach($arr as $row){
		if (is_array($row)){
			$val = $row[$key];
		} else {
			$val = $row->$key;
		}
		if (!in_array($val, $keys)){
			$result[] = $row;
			$keys[] = $val;
		}
	}
	return $result;
}

/* CLASS SETTER
=======================*/

$ups_classes;
$ups_classes = array();

//Add user admin when an admin is logged-in

function set_classes($tag, $class){
	/*if (!isset($ups_classes[$tag])){
		$ups_classes[$tag] = array();
	}*/
	global $ups_classes;
	$ups_classes[$tag] .= ' '.$class;
}

function get_classes($tag){
	global $ups_classes;
	return $ups_classes[$tag];
}

function echo_classes($tag){
	echo get_classes($tag);
}


function my_body_class_names($classes, $class=null) {
	$classes[] = get_classes('body');
	return $classes;
}

function get_user_by_nicename($nn){
	global $wpdb;
	$q = "SELECT * FROM wp_users WHERE user_nicename = '$nn'";
	$row = $wpdb->get_row($q);
	$user = get_userdata($row->ID);
	return $user;	
}

function osort(&$array, $prop) {
    usort($array, function($a, $b) use ($prop) {
        return $a->$prop > $b->$prop ? 1 : -1;
    }); 
}
/*
function usort_by_key(&$array, $key, $asc=SORT_ASC) { 
    $sort_flags = array(SORT_ASC, SORT_DESC); 
    if(!in_array($asc, $sort_flags)) throw new InvalidArgumentException('sort flag only accepts SORT_ASC or SORT_DESC'); 
    $cmp = function(array $a, array $b) use ($key, $asc, $sort_flags) { 
        if(!is_array($key)) { //just one key and sort direction 
            if(!isset($a[$key]) || !isset($b[$key])) { 
                throw new Exception('attempting to sort on non-existent keys'); 
            } 
            if($a[$key] == $b[$key]) return 0; 
            return ($asc==SORT_ASC xor $a[$key] < $b[$key]) ? 1 : -1; 
        } else { //using multiple keys for sort and sub-sort 
            foreach($key as $sub_key => $sub_asc) { 
                //array can come as 'sort_key'=>SORT_ASC|SORT_DESC or just 'sort_key', so need to detect which 
                if(!in_array($sub_asc, $sort_flags)) { $sub_key = $sub_asc; $sub_asc = $asc; } 
                //just like above, except 'continue' in place of return 0 
                if(!isset($a[$sub_key]) || !isset($b[$sub_key])) { 
                    throw new Exception('attempting to sort on non-existent keys'); 
                } 
                if($a[$sub_key] == $b[$sub_key]) continue; 
                return ($sub_asc==SORT_ASC xor $a[$sub_key] < $b[$sub_key]) ? 1 : -1; 
            } 
            return 0; 
        } 
    }; 
    usort($array, $cmp); 
}
*/

ini_set('post_max_size', '32M');
ini_set('upload_max_filesize', '32M');

add_filter('body_class','my_body_class_names');
/*
	wp_schedule_event(time(), 'hourly', 'cron_by_hour');
	
	
	function cron_by_hour() {
		call_url('http://beta.kendallsq.org/wp-content/feeds/greenhorn/parser.php');
		call_url('http://beta.kendallsq.org/wp-content/feeds/curata/parser.php');
	}
	
	function call_url($url){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_exec($ch);
		curl_close($ch);
	}
*/
