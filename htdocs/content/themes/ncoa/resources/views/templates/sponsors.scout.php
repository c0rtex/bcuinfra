@extends('layouts.main')

@section('main')
@loop
<div class="container-fluid sponsors-hero">
    <div class="row">
        <div class="col-xs-12 col-md-8 col-md-offset-2">
            <h1>{{ Meta::get(Loop::id(), $key = 'title', $single = true) }}</h1>
            <p>{{ Meta::get(Loop::id(), $key = 'body-copy', $single = true) }}</p>
        </div>
    </div>
</div>

<div class="container-fluid sponsors-gallery">
    <div class="row">
        <div class="container">
            <div class="row">
                <div class="sponsor-featured col-xs-12">
                    @foreach($featured as $key => $value)
                    <div class="featured-item">
                        <div class="col-sm-6 col-md-4 col-md-offset-2">
                            <a href="{{ Meta::get($value->ID, $key = 'sponsor-url', $single = true) }}" target="_blank">
                                        <span class="hidden-xs hidden-sm visible-md visible-lg">
										{{
											get_the_post_thumbnail($value->ID, 'full', array(
												'title' => get_the_title(get_post_thumbnail_id($value->ID))
											))
										}}
                                        </span>

                                <span class="hidden-md hidden-lg visible-xs visible-sm">
										{{
											get_the_post_thumbnail($value->ID, array(280, 135), array(
												'title' => get_the_title(get_post_thumbnail_id($value->ID))
											))
										}}
                                        </span>
                            </a>
                        </div>
                        <div class="col-md-5 featured-text">
                            <p>{{ $value->post_excerpt }}</p>
                        </div>
                    </div>
                    @endforeach
                </div>

                @foreach($sponsors as $key => $value)
                <div class="col-xs-12 col-sm-6 col-md-3 sponsor-items">
                    @if(Meta::get($value->ID, $key = 'sponsor-url', $single = true) != "")
                    <a href="{{ Meta::get($value->ID, $key = 'sponsor-url', $single = true) }}" target="_blank">
                        {{
                        get_the_post_thumbnail($value->ID, 'full', array(
                        'title' => get_the_title(get_post_thumbnail_id($value->ID))
                        ))
                        }}
                    </a>
                    @else
                    {{
                    get_the_post_thumbnail($value->ID, 'full',array(
                    'title' => get_the_title(get_post_thumbnail_id($value->ID))
                    ))
                    }}
                    @endif
                </div>
                @endforeach
            </div>
        </div>
    </div>
</div>
<div class="blue-gradient-background cta-full container-fluid">
    <h1>{{ Meta::get(Loop::id(), $key = 'cta-title', $single = true) }}</h1>
    <p>{{ Meta::get(Loop::id(), $key = 'cta-body-copy', $single = true) }}</p>
    <a href="https://www.ncoa.org/get-involved/?_ga=1.122751939.930424655.1455291130" target="_blank" class="btn btn-primary">{{ Meta::get(Loop::id(), $key = 'cta-button-text', $single = true) }}</a>

</div>
<section class="connected-cta container-fluid">
    <div class="connected-container">
        <div class="stay-connected col-xs-12 col-sm-6 col-md-6">
            <h3>Stay Connected</h3>
            <p>Receive emails about how to stay healthy, secure, and independent</p>
            <a href="http://go.ncoa.org/BCUsignup" class="btn btn-tertiary">Sign Up for News</a>
        </div>
        <div class="spread-the-word col-xs-12 col-sm-6 col-md-6">
            <h3>Spread the Word</h3>
            <p>Let others know about the benefits they could be receiving</p>
            <ul class="social-jewlery">
                <li><a href="https://www.ncoa.org/get-involved/contact-us/email/" title="Email"><i class="fa fa-envelope" aria-hidden="true"></i></a></li>
                <li><a href="https://www.facebook.com/NCOAging" title="Facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                <li><a href="https://twitter.com/NCOAging" title="Twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
            </ul>

        </div>
    </div>
</section>
@endloop
@stop
