@extends('layouts.main')

@section('main')
	@loop
		<div class="container-fluid">
			<!-- Hero -->
			<section class="hero find-my-benefits cta-hero row">
				<div class="find-my-benefits-content col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 ">
					<h1>{{ Meta::get(Loop::id(), $key = 'headline', $single = true) }}</h1>
					<div class="zip-code form-inline" ng-controller="zipCodeController">
						<input type="text" class="form-control" placeholder="Enter ZIP Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
						<button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>
						<p class="error-state" ng-hide="isZipValid"><strong>Error!</strong> Please enter a valid zipcode in the United States</p>
					</div>
				</div>
			</section>

			<!-- Testimonial -->
			<section class="testimonials row">
				@foreach($testimonials as $key => $value)
					<figure class="testimonial col-xs-12 col-sm-4">
						<img src="<?php echo wp_get_attachment_image_src($testimonials[$key]["testimonial-image"], 'full')[0] ?>" />
						<figcaption>
							<p>"{{ $testimonials[$key]["testimonial-quote"] }}"</p>
							<span class="name-age">{{ $testimonials[$key]["testimonial-info"] }}</span>
						</figcaption>
					</figure>
				@endforeach
			</section>

			<!-- Benefits Slider -->
			<section class="row">
				@include('partials.benefits-slider',[
					'benefitsItems' => $benefits
				])
			</section>

			<!-- Better Way to Find -->
			<section class="better-way-benefits row">
				<div class="better-way-benefits-header col-xs-12">
					<h2>{{ Meta::get(Loop::id(), $key = 'benefits-header', $single = true) }}</h2>
					<p>{{ Meta::get(Loop::id(), $key = 'benefits-header-copy', $single = true) }}</p>
				</div>
				@foreach($betterwaysection as $key => $value)
					<div class="benefits-item col-xs-12 col-sm-4">
						<h4 class="title-icon" style="background-image: url(<?php echo wp_get_attachment_image_src($betterwaysection[$key]["benefit-icon"], 'full')[0] ?>)">{{ $betterwaysection[$key]["benefit-title"] }}</h4>
						<p>{{ $betterwaysection[$key]["benefit-copy"] }}</p>
					</div>
				@endforeach
			</section>

			<!-- Find My Benefits -->
			<section class="cta-full blue-gradient-background row">
				<div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 ">
					<h5>Find My Benefits</h5>
					<div class="zip-code form-inline" ng-controller="zipCodeController">
						<input type="text" class="form-control" placeholder="Enter ZIP Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
						<button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>						
					</div>
				</div>
			</section>

			<!-- Sponsors -->
			<section class="our-sponsors ncoa-carousel row">
				<h2>Our Sponsors</h2>
				<div class="col-xs-12 col-md-9 col-md-offset-2">
					<div class="ncoa-carousel-container" ncoa-carousel>
						@foreach($sponsors as $key => $value)
							<div class="item">
								<a href="{{ Meta::get($value->ID, $key = 'sponsor-url', $single = true) }}"><?php echo get_the_post_thumbnail($value->ID, 'full') ?></a>
							</div>
						@endforeach
					</div>
					<div class="controls">
						<div class="count">
							<span class="currItem"></span>
							of
							<span class="currTotal"></span>
						</div>

					</div>
					<a href="/sponsors" class="btn btn-link">View all <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
				</div>
			</section>

			<!-- Connected -->
			<section class="connected-cta col-xs-12">
				<div class="connected-container">
					<div class="stay-connected col-xs-12 col-sm-6 col-md-6">
						<h3>Stay Connected</h3>
						<p>Receive emails about how to stay healthy, secure, and independent.</p>
						<a href="#" class="btn btn-tertiary">Subscribe to Newsletter</a>
					</div>
					<div class="spread-the-word col-xs-12 col-sm-6 col-md-6">
						<h3>Spread the Word</h3>
						<p>Let others know about the benefits they could be receiving</p>
						<ul class="social-jewlery">
							<li><a href="#"><i class="fa fa-envelope" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
						</ul>
					</div>
				</div>
			</section>
		</div>
	@endloop
@stop