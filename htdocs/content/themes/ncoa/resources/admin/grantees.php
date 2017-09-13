<?php
US_STATES' => '{"AL":"Alabama","AK":"Alaska","AS":"American Samoa","AZ":"Arizona","AR":"Arkansas","AE":"Armed Forces Africa, Canada, Europe, Middle East","AA":"Armed Forces Americas","AP":"Armed Forces Pacific","BD":"BAD STATE","CA":"California","CO":"Colorado","CT":"Connecticut","DE":"Delaware","FM":"Federated States of Micronesia","FL":"Florida","GA":"Georgia","GU":"Guam","HI":"Hawaii","ID":"Idaho","IL":"Illinois","IN":"Indiana","IA":"Iowa","KS":"Kansas","KY":"Kentucky","LA":"Louisiana","ME":"Maine","MH":"Marshall Islands","MD":"Maryland","MA":"Massachusetts","MI":"Michigan","MN":"Minnesota","MS":"Mississippi","MO":"Missouri","MT":"Montana","NE":"Nebraska","NV":"Nevada","NH":"New Hampshire","NJ":"New Jersey","NM":"New Mexico","NY":"New York","NC":"North Carolina","ND":"North Dakota","MP":"Northern Mariana Islands","OH":"Ohio","OK":"Oklahoma","OR":"Oregon","PW":"Palau","PA":"Pennsylvania","PR":"Puerto Rico","RI":"Rhode Island","SC":"South Carolina","SD":"South Dakota","TN":"Tennessee","TX":"Texas","UT":"Utah","VT":"Vermont","VI":"Virgin Islands","VA":"Virginia","WA":"Washington","DC":"Washington, DC","WV":"West Virginia","WI":"Wisconsin","WY":"Wyoming"}';

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
    Field::number('partner-id',[
        'title' => 'Partner ID'
    ])
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


