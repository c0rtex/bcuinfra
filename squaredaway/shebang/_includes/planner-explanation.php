<?php
$exp = get_post_info(get_the_ID());
if (strlen($exp->body)){
	echo '<a class="explanations-trigger"><em class="i-circle tip-trigger">i<div class="tooltip">Click to learn more about the assumptions and equations used on this page</div></em>Explanations</a>';
	echo '<section class="explanations-section explanations-hidden">'.get_editable_furniture($exp->ID).'</section><!-- /.explanations-section -->';
}
?>