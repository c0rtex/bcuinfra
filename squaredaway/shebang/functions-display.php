<?php

	function shebang_display_slide_media($pid = 0){
		if (!$pid){
			$pid = get_the_ID();
		}	
		$pi = get_post_info($pid);
		$img = getPostImageSrc($pid);
		
		$video = get_post_meta($pid, 'video-url', true);
		$displaystyle = get_post_meta($pid, 'img-display-style', true);
		$vidid = '';
		if ($video != '') {
			$pos = strpos($video, 'youtube');
			if ($pos !== false) {
				$vidid = substr($video, 31, 11);
			}
		}
		
		if ($vidid != '') { 
			
			$r .= '<!-- UI Pattern: Art Caption -->';
			$r .= '<div class="ui-pattern-art-caption">					
				<div class="article-large-art-container col-1">
					<div class="article-large-img"><iframe width="400" height="205" src="http://www.youtube.com/embed/'.$vidid.'" frameborder="0"></iframe></div>
				</div> <!-- /.article-small-art-container -->';
			$r .= '<div class="article-caption-col col-2">
					<p><strong><?php echo get_editable_title(); ?></strong></p>';
			$r .= get_the_content();
			$r .= get_shebang_edit_link();
			$r .= '</div> <!-- /.article-text /.col-2-->';
			$r .= '</div> <!-- /.ui-pattern-art-caption -->';
			
		} else if ($img != '') {
			if ($displaystyle == 'Large Image') { 
				
				$r .= '<!-- UI Pattern: Art Caption -->';
				$r .= '<div class="ui-pattern-art-caption"><div class="article-large-art-container col-1">';
				$img_src = get_post_thumbnail($pid, 255);
				$r .= '<img class="article-large-img" src="'.$img_src.'"/></div> <!-- /.article-small-art-container -->';
				$r .= '<div class="article-caption-col col-2"><p><strong>'.get_editable_title().'</strong></p>';
				$r .= get_the_content();
				$r .= get_shebang_edit_link();
				$r .= '</div> <!-- /.article-text /.col-2--></div> <!-- /.ui-pattern-art-caption -->';				
			} else { 
				$r .= '<!-- UI Pattern: Small Art --><div class="ui-pattern-small-art"><div class="article-small-art-container col-1">';
				$img_src = get_post_thumbnail(get_the_ID(), 255);
				$r .= '<img class="article-small-img" src="'.$img_src.'" /></div> <!-- /.article-small-art-container -->';
				$r .= '<div class="article-text col-2">';
				$r .= '<h4 class="article-h3">'.get_editable_title().'</h4>';
				$r .= get_the_content();
				$r .= get_shebang_edit_link();
				$r .= '</div> <!-- /.article-text /.col-2--></div> <!-- /.ui-pattern-small-img -->';
				
			}
		} else {
			return false;
		}
		echo $r;
		
		return true;
}