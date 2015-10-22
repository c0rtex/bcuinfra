<?php
	
	function cys_get_spending_sections(){
		$spending = get_taxonomy_tree('spending', array(58, 55,56,57));
		return $spending;
	}
	
	function cys_get_tips($term_id){
		/* The Area for all the tips */
		$r .= '<table class="spendingTable spending-table table-lined"><thead class="table-head"><tr><th class="spending-action" colspan="2">Action</th><th class="spending-savings">Savings</th></tr></thead><tbody class="table-body y-scroll">';
		$tips = get_posts(
			array(
				'tax_query' => array(
					array('taxonomy' => 'spending', 'field' => 'id', 'terms' => $term_id),
				),
				'post_type' => 'actions',
				'orderby' => 'meta_value_num',
				'meta_key' => 'savings',
				'order' => 'DESC',
				
			)
		);
		
		$tc = 1;
		foreach($tips as $t){
			$tip = get_post_info($t->ID);
			//print_r($tip);
			$r .= '<tr class="add-todo row-'.$tc.'"><td class="checkbox-container">
			<input type="checkbox" name="'.$tip->post_name.'" value="'.$tip->post_title.'" class="checkbox-input trigger-cys-todo cys-todo-id-'.$tip->ID.'" data-id="'.$tip->ID.'" data-amount="'.$tip->savings.'"></td>';
			$r .= '<td><label for="'.$tip->post_name.'" class="checkbox-label">
			'.$tip->post_title.'</label></td>';
			$r .= '<td class="spending-savings"><span class="dollar">$</span><span class="spending-savings-value">'.$tip->savings.'</span></td></tr>';
			$tc++;
		}
		
		/* The blank row */
		$r .= '<tr class="add-todo spending-row add-your-own-tip"><td class="checkbox-container"><input type="checkbox" name="custom" value="Add your own" class="checkbox-input trigger-cys-todo"></td><td><input type="text" class="checkbox-label blank-input add-your-own-name" placeholder="Add your own"></td><td class="spending-savings"><span class="dollar">$</span><input type="text" placeholder="0" class="spending-savings blank-input add-your-own-amount"></td></tr>';
		
		/* The end of the table */
		$r .= '</tbody> <!-- y-scroll --></table>';
		return $r;
	}
	
?>
