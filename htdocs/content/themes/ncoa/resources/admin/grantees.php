<?php

/*
* Custom Post Type for Grantees, this houses all section of the fact that can be administered though the admin panel
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

Metabox::make('Partner Info', 'grantees', [
    'context'   => 'normal'
])->set([
     Field::number('partner-id',[
        'title' => 'Partner ID'
    ]),
    Field::text('partner-code',[
        'title' => 'Partner Code'
    ]),
    Field::select('partner-type',[
        [
            'sponsor' => 'Sponsor',
            'nonsponsor' => 'Non Sponsor',
            'organization' => 'Organization',
            'hospital' => 'Hospital',
            'center' => 'Center',
            'batch' => 'LIS Batch',
            'nonpl' => 'Non Private Label',
            'mippa' => 'MIPPA',
            'mippaplus' => 'MIPPA Plus',
            'fit' => 'FIT',
        ]
    ],['title'=>'Partner Type'])
]);




