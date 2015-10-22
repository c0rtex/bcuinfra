<?php

	function alert($s){
		echo '<script type="text/javascript">alert("'.$s.'");</script>';
	}
	
	function trace($s){
		echo '<script type="text/javascript">trace("'.$s.'");</script>';
	}

	//require_once('connect.php');
	//require_once('JSON/JSON.php');
	//session_start(); 
	
	
	function shebang_get_parent_slug($pid = 0){
		$pi = get_post_info($pid);
		if ($pi->post_parent == 0){
			$planner_slug = $pi->post_name;
		} else {
			$parent = get_post_info($pi->post_parent);
			$planner_slug = $parent->post_name;
		}
		return $planner_slug;
	}
	
	function shebang_get_js_files($pid = 0){
		$r = '';
		$pi = get_post_info($pid);
		if ($pi->post_parent == 0){
			$planner_slug = $pi->post_name;
		} else {
			$parent = get_post_info($pi->post_parent);
			$planner_slug = $parent->post_name;
		}
		$js = array();
		$js[] = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/js/planner-'.$planner_slug.'-'.$pi->post_name.'.js';
		$js[] = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/js/planner-'.$planner_slug.'.js';

		foreach($js as $j){
			if (file_exists($j)){
				$r .= '<script src="'.str_replace($_SERVER['DOCUMENT_ROOT'], '', $j).'" type="text/javascript"></script>';
			}
		}
		return $r;
	}
	
	function shebang_get_json_payload($table){
		global $wpdb;
		$query = "SELECT * FROM $table";
		$result = $wpdb->get_results($query);
		$arr = array();
		foreach($result as $row){
			$r = array();
			foreach($row as $key=>$value){
				$r[$key] = $value;
			}
			$arr[] = $r;
		}
		
		$json = json_encode($arr);
		return '<div id="'.$table.'" class="json-payload">'.$json.'</div>';
	}
	
	function shebang_get_constants(){
		global $wpdb;
		$query = "SELECT * FROM shebang_constants";
		$result = $wpdb->get_results($query);
		$arr = array();
		foreach($result as $row){
			$key = $row->c_key;
			$val = $row->c_value;
			$arr[$key] = $val;
		}
		$json = json_encode($arr);
		return '<div id="shebang-constants" class="json-payload">'.$json.'</div>';
	}
	
	function shebang_get_include($dir=''){
		return '/wp-content/themes/shebang/_includes/'.$dir;
	}	
	
	function shebang_get_table($tname, $lookup_col){
		global $wpdb;
		$query = "SELECT * FROM $tname";
		$result = $wpdb->get_results($query);
		echo '<div id="table-'.$tname.'">';
		foreach($result as $row){
			$lookup = $row->$lookup_col;
			echo '<input type="hidden" class="lookup-'.$lookup.'"';
			foreach($row as $key => $value){
				echo 'data-'.$key.'="'.$value.'" ';
			}
			echo '/>';
		}
		echo '</div>';
	}
	
	function shebang_get_withdrawal_table(){
		global $wpdb;
		$query = "SELECT * FROM pln_target_withdrawal";
		$result = $wpdb->get_results($query);
		echo '<div id="table-withdrawal">';
		foreach($result as $row){
			echo '<input type="hidden" class="ytr-'.$row->year.'" data-pct="'.$row->pct.'"/>';
		}
		echo '</div>';
	}
	
	function shebang_get_bp_table(){
		global $wpdb;
		$query = "SELECT * FROM pln_target_bend_points";
		$result = $wpdb->get_results($query);
		echo '<div id="table-bend-points">';
		foreach($result as $row){
			echo '<input type="hidden" data-ytr="'.$row->ytr.'" data-bp1="'.$row->bp_1.'" data-bp2="'.$row->bp_2.'"/>';
		}
		echo '</div>';
	}
	
	function shebang_get_pia_table(){
		global $wpdb;
		$query = "SELECT * FROM pln_target_pia_pct";
		$result = $wpdb->get_results($query);
		echo '<div id="table-pia-factor">';
		foreach($result as $row){
			echo '<input type="hidden" class="year-born-'.$row->year_born.'" data-year_born="'.$row->year_born.'" 
			data-f62="'.$row->f62.'" 
			data-f63="'.$row->f63.'"
			data-f64="'.$row->f64.'"
			data-f65="'.$row->f65.'"
			data-f66="'.$row->f66.'"
			data-f67="'.$row->f67.'"
			data-f68="'.$row->f68.'"
			data-f69="'.$row->f69.'"
			data-f70="'.$row->f70.'" />';
		}
		echo '</div>';
	}
	
	function shebang_get_spousal_benefit_table(){
		global $wpdb;
		$query = "SELECT * FROM pln_target_spousal_benefit";
		$result = $wpdb->get_results($query);
		echo '<div id="table-spousal-benefit">';
		foreach($result as $row){
			echo '<input type="hidden" class="year-diff-'.$row->normal_planned_diff.'" data-pct="'.$row->benefit_pct.'"/>';
		}
		echo '</div>';
	}
	
	function shebang_get_user_meta_as($field, $id, $class='', $default = 0){
		$val = shebang_get_user_meta($field, '');
		if (!$val){
			$val = $default;
		}
		return '<input type="hidden" id="'.$id.'" value="'.$val.'" class="ls-field '.$class.'" data-field="'.$field.'"/>';
	}
	
	function shebang_hidden_field($field, $class='', $default = ''){
		$val = shebang_get_user_meta($field, $default);
		return '<input type="hidden" id="'.$field.'" value="'.$val.'" class="ls-field '.$class.'" data-field="'.$field.'"/>';
	}
	
	function shebang_hidden_constant($field, $class=''){
		$val = shebang_get_constant($field);
		return '<input type="hidden" id="'.$field.'" value="'.$val.'" class="'.$class.'"/>';
	}
	
	function shebang_get_constant($field){
		global $wpdb;
		$query = "SELECT c_value FROM shebang_constants WHERE c_key = '$field'";
		$result = $wpdb->get_row($query);
		return $result->c_value;
	}
	
	function shebang_get_user_meta_function($field, $default, $func, $args){
		if (is_user_logged_in()){
			global $current_user;
			get_currentuserinfo();
			$res = get_user_meta($current_user->ID, $field, true);
			if ($res){
				return $res;
			} 
		} else {
			if ($_SESSION[$field]){
				return $_SESSION[$field];
			} 
		}
		return $func($default, $args);
	}
	
	function shebang_get_boolean($field){
		$ch = trim(shebang_get_checked($field));
		if ($ch == 'checked="checked"'){
			return true;
		}
		return false;
	}
	
	function shebang_get_checked($field){
		global $current_user;
		get_currentuserinfo();
		$res = shebang_get_user_meta_db($current_user->ID, $field);
		if ($res == ''){
			$res = false;
		}
		$res = trim(strtolower($res));
		if ($res == 'on' || $res == true || $res == 'true'){
			return ' checked="checked" ';
		} else {
			return '';
		}
	}
	
	function shebang_get_user_meta_db($uid, $field){
		global $wpdb;
		$query = "SELECT meta_value FROM wp_usermeta WHERE meta_key = '$field' AND user_id = $uid";
		
		$row = $wpdb->get_row($query, ARRAY_N);
		if ($row[0] && $row[0] != ''){
			return $row[0];
		}
		return false;
		
	}
	
	function shebang_get_user_meta($field, $default, $fallback = 'poop'){
		if (is_user_logged_in()){
			global $current_user;
			get_currentuserinfo();
			$res = get_user_meta($current_user->ID, $field, true);
			if ($res != ''){
				return $res;
			} else if ($fallback == 'poop'){
				return $default;
			} else {
				//weve sent a valid fallback to send
				$res = get_user_meta($current_user->ID, $default, true);
				if ($res){
					return $res;
				} 
			}
		} else {
			if ($_SESSION[$field]){
				return $_SESSION[$field];
			} else if ($fallback != 'poop'){
				return $_SESSION[$default];
			}
		}
		if ($fallback == 'poop'){
			$fallback = $default;
		}
		return $fallback;
	}
	
	function get_slide_position(){
		$slides = get_planner_slides();
		//print_r($slides);
		$cp = get_post_info(get_the_ID());
		$j = 1;
		foreach($slides as $slide){
			if ($slide->ID == $cp->ID){
				return $j;
				//return $slide->menu_order;
			}
			$j++;
		}
		return 1;
	}
	
	function get_previous_slide(){
		$slides = get_planner_slides();
		$id = get_the_ID();
		$psp = 0;
		for ($i = 0; $i<count($slides); $i++){
			if ($slides[$i]->ID == $id){
				$psp = $i-1;
			}
		}
		if ($psp < 0){
			return null;
		}
		$prevSlide = $slides[$psp];
		return get_post_info($prevSlide->ID);
	}
	
	function get_previous_slide_link(){
		$ps = get_previous_slide();
		return $ps->permalink;
	}
	
	function get_planner_title(){
		$slides = get_planner_slides();
		return $slides[0]->post_title;
	}
	
	function get_next_slide_link(){
		$ns = get_next_slide();
		return $ns->permalink;
	}
	
	function get_next_slide(){
		$slides = get_planner_slides();
		$id = get_the_ID();
		$nsp = 0;
		for ($i = 0; $i<count($slides); $i++){
			if ($slides[$i]->ID == $id){
				$nsp = $i+1;
			}
		}
		if ($nsp >= count($slides)){
			return null;
		}
		$nextSlide = $slides[$nsp];
		return get_post_info($nextSlide->ID);
	}
	
	function get_last_slide($pid = 0){
		if (!$pid){
			$pid = get_the_ID();
		}
		$slides = get_planner_slides($pid);
		return end($slides);
	}
	
	function get_planner_slides($pid = 0){
		if (!$pid){
			$pid = get_the_ID();
		}
		$cp = get_post_info($pid);
		if ($cp->post_parent == 0){
			$parent_id = $cp->ID;
		} else {
			$parent_id = $cp->post_parent;
		}
		$args = array(
			'post_parent' => $parent_id, 
			'post_type' => $cp->post_type, 
			'orderby' => 'menu_order', 
			'order'=>'ASC'
		);
		$children = get_children($args);
		//echo 'ch';
		//echo count($children);
		//echo 'out';
		array_unshift($children, get_post_info($parent_id));
		return $children;
	}
	
	function get_slide_count(){
		$sl = get_planner_slides();
		return count($sl);
	}
	
	function cys_get_usermeta($field, $default){
		global $uid;
		if (($_SESSION[$field])){
			return $_SESSION[$field];
		}
		$query = "SELECT value FROM demo_data WHERE uid = '$uid' AND field = '$field'";
		$result = mysql_query($query);
		$row = mysql_fetch_array($result);
		$val = $row[0];
		$_SESSION[$field] = $val;
		if (isset($val)){
			return $val;
		} else if (isset($default)){
			return $default;
		}
		return '';
	}
	
	
	
	function cys_get_todos($type='all'){
		global $uid;
		if ($type == 'all'){
			$query = "SELECT * FROM demo_todos WHERE uid = '$uid' GROUP BY name";
		} else {
			$types = explode(',', $type);
			$in = '';
			$not = '';
			foreach($types as $tp){
				$tp = trim($tp);
				if (strpos($tp, '!') === 0){
					$tp = str_replace('!', '', $tp);
					$not .= '"'.$tp . '", ';
				} else {
					$in .= '"' .$tp . '", ';
				}
				
			}
			$query = "SELECT * FROM demo_todos WHERE uid = '$uid'";
			if (strlen($in)){
				$in = trim($in);
				$in = rtrim($in,',');
				$query .= " AND type IN ($in) ";
			}
			if (strlen($not)){
				$not = trim($not);
				$not = rtrim($not,',');
				$query .= " AND type NOT IN($not) ";
			}
			$query .= " GROUP BY name";
		}
		$result = mysql_query($query);
		$r = array();
		while ($row = mysql_fetch_object($result)){
			$r[] = $row;
		}
		return $r;
	}
	
	function cys_update_usermeta($uid, $field, $v){
		global $uid;
		$check = "SELECT * FROM demo_data WHERE uid = '$uid' AND field = '$field'";
		$result = mysql_query($check);
		if (mysql_num_rows($result)){
			$query = "UPDATE demo_data SET value = '$v' WHERE uid = '$uid' AND field = '$field'";
		} else {
			$query = "INSERT INTO demo_data (uid, field, value) VALUES ('$uid', '$field', '$v')";
		}
		mysql_query($query) or die(mysql_error());
	}
	
	function cys_update_todo($uid, $name, $amount, $status = 'new', $type = null){
		global $uid;
		$query = "SELECT todo_id FROM demo_todos WHERE uid = '$uid' AND name = '$name'";
		$result = mysql_query($query);
		if (mysql_num_rows($result)){
			//already in db, fuck it
			$tdid = mysql_fetch_object($result);
			return $tdid->todo_id;
		}
		$query = "INSERT INTO demo_todos (uid, name, amount, status, type) VALUES ('$uid', '$name', '$amount', '$status', '$type')";
		
		$result = mysql_query($query);
		return mysql_insert_id();
	}
	
	function cys_update_todo_status($tdid, $status){
		$query = "UPDATE demo_todos SET status = '$status' WHERE todo_id = '$tdid'";
		$result = mysql_query($query);
		return $tdid;
	}
	
	function cys_delete_todo($tdid){
		$query = "DELETE FROM demo_todos WHERE todo_id = '$tdid' LIMIT 1";
		$result = mysql_query($query);
		return $query;
	}
	
	function shebang_get_footer_menu($menu_name, $limit = 4){
		$menu = wp_get_nav_menu_items($menu_name);
		$output .= '<ul class="global-ftr-linklist">';
		for ($i = 0; $i<$limit; $i++){
			if ($item = $menu[$i]){
				$output .= '<li class="global-ftr-link-item"><a href="'.$item->url.'" class="'.$item->post_excerpt.'">'.$item->title.'</a></li>';
			}
		}
		$output .= '</ul> <!-- /.global-ftr-linklist -->';
		return $output;
	}	
	
	function shebang_get_breadcrumb(){
		if (is_single()){
			$output = '';
			$output .= '<ul class="article-breadcrumb">';
			$output .= '<li class="article-bc-item"><a href="/">Home</a></li>';
			$tags = get_the_tags();
			if (is_array($tags)){
				$tag = current($tags);
				$output .= '<li class="article-bc-item"><a href="/topics/'.$tag->slug.'">'.$tag->name.'</a></li>';
			} else {
				$pi = get_post_info();
				$output .= '<li class="article-bc-item"><a href="/'.$pi->post_type.'">'.$pi->post_type_info->labels->name.'</a></li>';
			}
			
			$output .= '<li class="article-bc-item"><a href="#">'.get_the_title().'</a></li>';
			$output .= '</ul> <!-- /.article-breadcrumb -->';
		} else {
			//directory page
		}
		return $output;

	}
	
	function get_shebang_edit_link($pid = 0, $text = 'Edit Slide', $class = ''){
		if ($pid){
			$url = get_edit_post_link($pid);
		} else {
			$url = get_edit_post_link();
		}
		if ($url){
			return '<a class="wp-edit-link '.$class.'" href="'.$url.'">'.$text.'</a>';
		}
		return '';
	}
	
	function shebang_edit_link($pid = 0, $text = 'Edit Slide', $class = ''){
		echo get_shebang_edit_link($pid, $text, $class);
	}
	
	include('functions-shebang-email.php');
