@extends('layouts.main')

@section('main')
  @loop
    <div class="container-fluid">
      <!-- Hero -->
      <section class="blue-gradient-background cta-hero-alternate row">
        <div class="find-my-benefits-content col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 ">
          <h1>{{ Meta::get(Loop::id(), $key = 'hero-header', $single = true) }}</h1>
          <p>{{ Meta::get(Loop::id(), $key = 'hero-copy', $single = true) }}</p>
          <div class="zip-code form-inline" ng-controller="zipCodeController">
            <input type="text" class="form-control" placeholder="Enter Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
            <button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>
            <p class="error-state" ng-class="{ 'error-state-valid': isValid}">Please enter a valid zipcode in the United States</p>
          </div>
        </div>
      </section>

      <!-- Testimonial -->
      @if(!empty($testimonials))
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
      @endif

      <div class="white-label-container">
        <div class="row white-label-section">
         @foreach($callouts as $key => $value)
          <div class="col-sm-6 col-xs-12">
            <h3>{{ $callouts[$key]["callout-header"] }}</h3>
            <p>{{ $callouts[$key]["callout-body"] }}</p>
            <a href="{{ $callouts[$key]['callout-link'] }}" class="btn btn-secondary">{{ $callouts[$key]['callout-link-text'] }}</a>
          </div>
         @endforeach
        </div> 
      </div>
    </div>
  @endloop
@stop
