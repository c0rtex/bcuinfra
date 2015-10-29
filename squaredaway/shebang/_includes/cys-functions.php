<?php

	require_once('connect.php');
	require_once('JSON/JSON.php');
	require_once('generic-functions.php');
	
	if ($_SESSION['uid']){
		$uid = $_SESSION['uid'];
	} else if ($_COOKIE['uid']){
		$uid = $_COOKIE['uid'];
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
