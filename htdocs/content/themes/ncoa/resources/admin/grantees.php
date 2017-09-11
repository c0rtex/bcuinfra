<?php

/*
* Custom Post Type for Fact Sheets, this houses all section of the fact that can be administered though the admin panel
*/

PostType::make('grantees', 'Grantees', 'Grantees')->set([
    'public'    => true,
    'supports'	=> ['title', 'editor']
]);

Metabox::make('General info', 'grantees', [
    'context'   => 'normal'
])->set([
    Field::select('state', [json_decode(Config::get('constants')["US_STATES"],true)],
        ['title' => 'State']),
    Field::text('site-url', [
        'title' => 'Site URL'
    ]),
    Field::text('logo-url', [
        'title' => 'Logotype URL'
    ]),
    Field::text('img-url', [
        'title' => 'Image URL'
    ]),
]);

/*Metabox::make('Requirements', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::editor('requirement-info',array(
        'title' => 'Requirement Info'
    )),
    Field::editor('requirement-info-alt',array(
        'title' => 'Requirement Info Alternate'
    ))
]);

Metabox::make('General Information', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::text('fact-sheet-category',array(
        'title'	=> 'Category'
    )),
    Field::media('fact-sheet-category-icon', array(
        'title' => 'Category Icon'
    ))
]);


Metabox::make('Button Information', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::text('button-title', array(
        'title'	=> 'Button Title'
    )),
    Field::text('button-url', array(
        'title' => 'Button Url'
    ))
]);

Metabox::make('Fact Sheet Languages', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::text('english-title', array(
        'title'	=> 'English Title'
    )),
    Field::text('english-url', array(
        'title'	=> 'English URL'
    )),
    Field::text('spanish-title', array(
        'title'	=> 'Spanish Title'
    )),
    Field::text('spanish-url', array(
        'title'	=> 'Spanish URL'
    )),
    Field::text('more-languages', array(
        'title'	=> 'More Languages'
    )),
    Field::text('more-languages-url', array(
        'title'	=> 'More Languages Url'
    ))
]);

Metabox::make('Faqs', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::infinite('faqs-list', [
        Field::text('question', array(
            'title'	=> 'Question'
        )),
        Field::textarea('answer', array(
            'title'	=> 'Answer'
        ))
    ])
]);

Metabox::make('CTA', 'fact-sheets', [
    'context'   => 'normal'
])->set([
    Field::text('title', array(
        'title'	=> 'Title'
    )),
    Field::textarea('body-copy', array(
        'title'	=> 'Body Copy'
    ))
]);
*/


