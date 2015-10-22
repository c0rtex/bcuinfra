<?php

	function get_top_level_posts($type = 'any', $limit = -1){
		if ($type == 'any'){
			$query = array(	'post_type' => array('learn-more', 'planners', 'calculators', 'how-to'),
							'post_parent' => 0,
							'posts_per_page' => $limit,
							'orderby' => 'rand'
			);
		} else {
			$query = array(	'post_type' => array($type),
							'post_parent' => 0,
							'posts_per_page' => $limit,
							'orderby' => 'rand'
			);
		}
		$posts = get_posts($query);
		return $posts;
	}
	
	function get_taxonomy_posts($term, $tax, $type = 'any', $limit = -1){
		$otype = $type;
		if ($type == 'any' || $type == 'all'){
			$type = array('learn-more', 'planners', 'calculators', 'how-to');
		}
		$query = array(
			"posts_per_page" => $limit,
			'post_type' => $type,
			'tax_query' => array(array(
				'taxonomy' => $tax,
				'field' => 'slug',
				'terms' => $term,
				'operator' => 'IN',
			)),
			'orderby' => 'rand',
			'post_parent' =>0,
			'post_status' => 'publish'
		);
		if ($tax == 'post_tag' || $tax == 'post_tags'){
			$query = array(
				"posts_per_page" => $limit,
				'post_type' => $type,
				'tag' => $term,
				'post_parent' => 0,
				'post_status' => 'publish'
			);
			//print_r($query);
		}
		$ti = get_term_info($term);
		$posts = array();
		if (strlen($ti->priority_treatments)){
			$ti->priority_treatments = explode(',', $ti->priority_treatments);
			foreach($ti->priority_treatments as $pri){
				$post_info = get_post_info(trim($pri));
				if ($otype == 'any' || $otype == 'all' || $type == $post_info->post_type){
					if ($post_info->post_type != 'furniture' && $post_info->post_status == 'publish'){
						$posts[] = $post_info;
					}
				}
			}
		}
		//print_r($query);
		$extras = get_posts($query);
		//print_r($extras);
		$posts = array_merge($posts, $extras);
		$posts = array_unique_on_key($posts, 'ID');
		if ($limit > 0){
			array_splice($posts, $limit);
		}
		foreach($posts as $key=>$row){
			if ($row->post_status != 'publish'){
				unset($posts[$key]);
			}
		}
	
		return $posts;
	}
	
	function get_topic_posts($tag, $type = 'any', $limit = -1){
		if ($type == 'any' || $type == 'all'){
			$type = array('learn-more', 'planners', 'calculators', 'how-to');
		}
		$posts = get_posts(array(
			"posts_per_page" => $limit,
			'post_type' => $type,
			'tag' => $tag,
			'post_status' => 'publish',
			'post_parent' =>0)
		);
		return $posts;
	}

?>