@extends('layouts.main')

@section('main')
  @loop
  <div class="about-us-banner-header" style="background-image: url({{$heroImage}})">
    <div class="about-us-banner-text-container">
      <h1 class="about-us-h1">
        {{ Meta::get(Loop::id(), $key = 'hero-headline', $single = true) }}
      </h1>
    </div>
  </div>

  <div class="container about-main">
    @foreach($bodySection as $key => $value)
      @if($key%2 == 1)
        <div class="row about-section">
          <div class="col-md-4">
            <img class="circle-img about-left-img" alt="placeholder" src="<?php echo wp_get_attachment_image_src($bodySection[$key]["body-item-icon"], 'full')[0] ?>" />
          </div>
          <div class="about-content col-md-8">
            <h2>{{ $bodySection[$key]["body-item-headline"] }}</h2>
            {{ $bodySection[$key]["body-item-copy"]  }}
          </div>
        </div>
      @else
        <div class="row about-section">
          <div class="col-md-4 about-mobile-column">
            <img class="circle-img" alt="placeholder" src="<?php echo wp_get_attachment_image_src($bodySection[$key]["body-item-icon"], 'full')[0] ?>" />
          </div>
          <div class="about-content col-md-8">
            <h2>{{ $bodySection[$key]["body-item-headline"]  }}</h2>
            {{ $bodySection[$key]["body-item-copy"]  }}
          </div>
          <div class="col-md-4 about-desktop-column">
            <img class="circle-img" alt="placeholder" src="<?php echo wp_get_attachment_image_src($bodySection[$key]["body-item-icon"], 'full')[0] ?>" />
          </div>
        </div>
      @endif
    @endforeach
  </div>


  <div class="fluid-container">
    <div class="about-how-works">
      <h2>{{ Meta::get(Loop::id(), $key = 'work-title', $single = true) }}</h2>
      <div class="row">
        @foreach($worksSection as $key => $value)
          <div class="col-md-4 about-step-section">
            <div>
              <img class="about-us-step" src="<?php echo wp_get_attachment_image_src($worksSection[$key]["work-item-icon"], 'full')[0] ?>">
              <h3>{{ $worksSection[$key]["work-item-headline"] }}</h3>
              <p>
                {{$worksSection[$key]["work-item-copy"]}}
              </p>
            </div>
          </div>
        @endforeach
      </div>
    </div>

    <div class="fluid-container">
      <div class="blue-background cta-full">
        <h1>Discover your benefits today.</h1>
          <div class="zip-code form-inline" ng-controller="zipCodeController">
            <input type="text" class="form-control" placeholder="Enter ZIP Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
            <button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>
          </div>
      </div>
    </div>

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
