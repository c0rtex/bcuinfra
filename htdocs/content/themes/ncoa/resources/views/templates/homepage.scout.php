@extends('layouts.main')

@section('main')
	@loop
			<!-- Hero -->
			<section class="hero find-my-benefits cta-hero">
				<div class="container">
					<div class="row">

						<div class="find-my-benefits-content col-xs-12 col-sm-12 col-md-6 col-lg-6 ">
							<h1>{{ $headline }}</h1>
							<form ng-submit="findZip(zipcode)" ng-controller="zipCodeController">
							<div class="zip-code form-inline">
								<input type="text" class="form-control" placeholder="Enter Your Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
								<button ng-click="findZip(zipcode)" class="btn btn-primary">Get Started</button>
								<p class="error-state" ng-cloak ng-show="isZipInvalid"><strong>Error!</strong> Please enter a valid zip code in the United States.</p>
							</div>
							</form>
						</div>

            <div class="testimonial-carousel col-xs-12 col-sm-12 col-md-6 col-lg-6 hide" testimonial-carousel>
              @foreach($testimonials as $key => $value)
                <figure class="testimonial col-xs-12">
                  {{
                    wp_get_attachment_image($testimonials[$key]["testimonial-image"], 'full', false,
                    array('title' => get_the_title($testimonials[$key]["testimonial-image"])))
                  }}

                    <figcaption>
                      @if($key == 1)
                        <h4>Caroline, Chicago, IL</h4>
                      @elseif($key == 2)
                        <h4>Greg, Charleston, SC</h4>
                      @else
                        <h4>Sharell & Tom, Phoenix, AZ</h4>
                      @endif
                      <p>{{ $testimonials[$key]["testimonial-quote"] }}</p>
                      <span class="name-age">{{ $testimonials[$key]["testimonial-info"] }}</span>
                    </figcaption>
                </figure>
              @endforeach
            </div>


					</div>
				</div>
			</section>

      <section>
        <div class="container">
          <div class="row">
            <div class="home-benefit-counter col-xs-12">
            <p>Join the <strong>5,710,578</strong> people who have discovered <span><strong>$19.1</strong> billion in benefits</span></p>
            </div>
          </div>
        </div>
      </section>

			<!-- Benefits Slider -->
			<section class="container">
				<div class="row">
					<div class="col-xs-12">
						@include('partials.benefits-slider',[
							'benefitsItems' => $benefits
						])
					</div>
				</div>
			</section>

			<!-- Better Way to Find -->
			<section class="better-way-benefits">
				<div class="container">
					<div class="row">
						<div class="better-way-benefits-header col-xs-12">
							<h2>{{ Meta::get(Loop::id(), $key = 'benefits-header', $single = true) }}</h2>
							<p>{{ Meta::get(Loop::id(), $key = 'benefits-header-copy', $single = true) }}</p>
						</div>
						@foreach($betterwaysection as $key => $value)
							<div class="benefits-item col-xs-12 col-sm-4">
								<h4 class="title-icon">
									{{
										wp_get_attachment_image($betterwaysection[$key]["benefit-icon"], 'full', false,
											array('title' => get_the_title($betterwaysection[$key]["benefit-icon"])))
									}}
									{{ $betterwaysection[$key]["benefit-title"] }}
								</h4>
								<p>{{ $betterwaysection[$key]["benefit-copy"] }}</p>
							</div>
						@endforeach
					</div>
				</div>
			</section>

			<!-- Find My Benefits -->
			<section class="cta-full blue-background">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 ">
							<h5>Find out what benefits may be available in your area.</h5>
							<div class="zip-code form-inline" ng-controller="zipCodeController">
								<input type="text" class="form-control" placeholder="Enter Your Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
								<button ng-click="findZip(zipcode)" class="btn btn-primary">Get Started</button>
								<p class="error-state" ng-cloak ng-show="isZipInvalid"><strong>Error!</strong> Please enter a valid zip code in the United States.</p>
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- Sponsors -->
			<section class="our-sponsors container">
				<div class="row ncoa-carousel">
					<h2>Our Sponsors</h2>
					<div class="col-xs-12">
						<div class="ncoa-carousel-container" ncoa-carousel>
							@foreach($sponsors as $key => $value)
								<div class="item">
									@if(Meta::get($value->ID, $key = 'sponsor-url', $single = true) != "")
										<a href="{{ Meta::get($value->ID, $key = 'sponsor-url', $single = true) }}" target="_blank">
											{{
												get_the_post_thumbnail($value->ID, 'full',
													array('title' => get_the_title($value->ID)))
											}}
										</a>
									@else
										{{
											get_the_post_thumbnail($value->ID, 'full',
												array('title' => get_the_title($value->ID)))
										}}
									@endif
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
				</div>
			</section>

			<!-- Connected -->
			<section class="connected-cta container">
				<div class="row">
					<div class="col-xs-12">
						<div class="connected-container">
							<div class="stay-connected col-xs-12 col-sm-6 col-md-6">
								<h3>Stay Connected</h3>
								<p>Receive emails about how to stay healthy, secure, and independent</p>
								<a href="http://go.ncoa.org/BCUsignup" class="btn btn-tertiary">Sign Up for Enews</a>
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
					</div>
				</div>
			</section>
	@endloop
@stop
