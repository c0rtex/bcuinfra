<?php

$template = "";

//Check for templates and create custom Meta for editing
if (!empty($_GET['post']))
{
    $template = Meta::get($_GET['post'], '_themosisPageTemplate');
}

//Save template metabox data
if (!empty($_POST['post_ID']))
{
    $template = Meta::get($_POST['post_ID'], '_themosisPageTemplate');
}

//Check empty and use switch for multiple templates (if you have them)
if (!empty($template))
{

    switch ($template)
    {
        case 'sponsors-template':

            Metabox::make('Hero Section', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('title', array(
                	'title' => 'Title'
            	)),
                Field::textarea('body-copy', array(
            	 	'title' => 'Body Copy'
            	))
            ]);

            Metabox::make('CTA Section', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('cta-title', array(
                	'title' => 'Title'
            	)),
                Field::textarea('cta-body-copy', array(
            	 	'title' => 'Body Copy'
            	)),
            	Field::text('cta-button-text', array(
            	 	'title' => 'Button Text'
            	))
            ]);

            break;

        case 'resources-template':
            
            Metabox::make('Headlines', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('resources-headline', array(
                    'title' => 'Headline'
                )),
                Field::text('resources-subtitle', array(
                    'title' => 'SubHead'
                ))
            ]);

            Metabox::make('Search Box', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('searchbox-headline', array(
                    'title' => 'Headline'
                )),
                Field::text('searchbox-body', array(
                    'title' => 'Body Copy'
                ))
            ]);

            Metabox::make('Key Programs Box', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('program-headline', array(
                    'title' => 'Headline'
                )),
                Field::text('program-body', array(
                    'title' => 'Body Copy'
                )),
                Field::infinite('KeyProgram', [
                    Field::media('program-icon'),
                    Field::text('program-title'),
                    Field::text('program-link')
                ])
            ]);

            Metabox::make('Categories Box', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('categories-headline', array(
                    'title' => 'Headline'
                )),
                Field::text('categories-body', array(
                    'title' => 'Body Copy'
                )),
                Field::infinite('KeyCategories', [
                    Field::media('category-icon'),
                    Field::text('category-title'),
                    Field::text('category-link')
                ])
            ]);

        break;

        case 'AboutUsTemplate':

            Metabox::make('About Us Hero', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('hero-headline', array(
                    'title' => 'Headline'
                )),
                Field::media('hero-image')
            ]);

            Metabox::make('About Us Body Items', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::infinite('body-item', [
                    Field::text('body-item-headline'),
                    Field::media('body-item-icon'),
                    Field::textarea('body-item-copy')
                ])
            ]);

            Metabox::make('Works Section', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text("work-title"),
                Field::infinite('work-item', [
                    Field::media('work-item-icon'),
                    Field::text('work-item-headline'),
                    Field::textarea('work-item-copy')
                ])
            ]);

        break;

        case 'home-template':

            Metabox::make('Hero', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::editor('headline', array(
                    'title' => 'Headline'
                ),array(
                    'media_buttons' => false,
                    'editor_height' => 100
                ))
            ]);

            Metabox::make('Testimonials', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::infinite('testimonial-item', [
                    Field::media('testimonial-image'),
                    Field::text('testimonial-quote'),
                    Field::text('testimonial-info')
                ])
            ]);

            Metabox::make('Benefits Section', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('benefits-header'),
                Field::text('benefits-header-copy'),
                Field::infinite('benefit-item', [
                    Field::media('benefit-icon'),
                    Field::text('benefit-title'),
                    Field::text('benefit-copy')
                ])
            ]);

            Metabox::make('Benefits Carousel', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('section-header'),
                Field::text('section-copy'),
                Field::infinite('benefits', [
                    Field::media('icon'),
                    Field::text('name'),
                    Field::textarea('left-content'),
                    Field::textarea('right-content')
                ])
            ]);

            Metabox::make('Counters', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('people-count'),
                Field::text('vob-count')
            ]);

            break;

        case 'white-label-homepage-template':

            Metabox::make('Hero', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::text('hero-header'),
                Field::text('hero-copy')
            ]);

            Metabox::make('Testimonials', 'page', [
                'context'   => 'normal'
            ])->set([
                Field::infinite('testimonial-item', [
                    Field::media('testimonial-image'),
                    Field::text('testimonial-quote'),
                    Field::text('testimonial-info')
                ])
            ]);

            Metabox::make('Callout Section', 'page', [
                'context'   => 'normal'
            ])->set([
                
                Field::infinite('callout-item', [
                    Field::text('callout-header'),
                    Field::text('callout-body'),
                    Field::text('callout-link-text'),
                    Field::text('callout-link')
                ])
            ]);

        break;

    }
}