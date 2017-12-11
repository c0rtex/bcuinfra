<?php

/*
* Custom Post Type for Partners Data, this houses all section of the fact that can be administered though the admin panel
*/

PostType::make('partners-data', 'Partners Data', 'Partners Data')->set([
    'public'    => true,
    'supports'	=> ['title', 'editor']
]);

Metabox::make('Partner Info', 'partners-data', [
    'context'   => 'normal'
])->set([
    Field::number('partner-id',[
        'title' => 'Partner ID'
    ]),
    Field::text('partner-code',[
        'title' => 'Partner Code'
    ]),
    Field::text('partner-name',[
        'title' => 'Partner Name'
    ]),
    Field::text('partner-url',[
        'title' => 'URL'
    ]),
    Field::text('partner-alt-name',[
        'title' => 'Partner Alt. Name'
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
    ],['title'=>'Partner Type']),
    Field::text('partner-title-bar',[
        'title' => 'Title Bar'
    ]),
    Field::text('partner-cms-document-no',[
        'title' => 'CMS Document No.'
    ]),
    Field::select('partner-login-only', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Login Only']),
    Field::select('partner-include-in-reports', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Include in Reports']),
    Field::select('partner-learn', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Learn']),
    Field::select('partner-race', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Race']),
    Field::select('partner-hispanic', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Hispanic']),
    Field::select('partner-prepop-links', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Prepop links']),
    Field::select('partner-pdf-logo', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'PDF logo']),
    Field::select('partner-demo', [
        [
            'No',
            'Yes'
        ]
    ],['title' => 'Demo']),
    Field::number('partner-parent-id',[
        'title' => 'Parent ID'
    ]),
]);

Metabox::make('Logo Info', 'partners-data', [
    'context'   => 'normal'
])->set([
    Field::text('logo',[
        'title' => 'Logo'
    ]),
    Field::text('logo-alt-text',[
        'title' => 'Logo Alt Text'
    ]),
    Field::text('logo-link',[
        'title' => 'Logo Link'
    ])
]);


