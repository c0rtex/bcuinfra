<?php

// File stored in resources/admin/books.php
PostType::make('ncoa-sponsors', 'NCOA Sponsors', 'NCOA Sponsor')->set([
    'public'    => true,
    'supports'	=> ['title','thumbnail','page-attributes', 'excerpt']
]);

Metabox::make('Featured', 'ncoa-sponsors', [
    'context'   => 'normal'
])->set([
    Field::checkbox('featured', 'featured'),

]);

Metabox::make('sponsor-link', 'ncoa-sponsors', [
    'context'   => 'normal',
    'title' => 'Sponsor Link'
])->set([
    Field::text('sponsor-url', array(
    	'title' => 'Sponsor URL'
	))
]);

