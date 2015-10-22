<?php

register_nav_menu('topics', __('Topics'));
register_nav_menu('life-stages', __('Life Stages'));
register_nav_menu('more', __('More'));
register_nav_menu('tools', __('Tools'));


add_post_type_support('post', 'page-attributes');
add_post_type_support('post', 'page-attributes');

add_post_type_support( 'calculators', 'post-formats' );

?>