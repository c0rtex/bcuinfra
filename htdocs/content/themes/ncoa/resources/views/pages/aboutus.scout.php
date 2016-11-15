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
            {{
                wp_get_attachment_image($bodySection[$key]["body-item-icon"], 'full', false,
                  array(
                    'title' => get_the_title($bodySection[$key]["body-item-icon"]),
                    'class' => 'circle-img about-left-img'
                  )
                )
            }}

          </div>
          <div class="about-content col-md-8">
            <h2>{{ $bodySection[$key]["body-item-headline"] }}</h2>
            {{ $bodySection[$key]["body-item-copy"]  }}
          </div>
        </div>
      @else
        <div class="row about-section">
          <div class="col-md-4 about-mobile-column">
            {{
                wp_get_attachment_image($bodySection[$key]["body-item-icon"], 'full', false,
                  array(
                    'title' => get_the_title($bodySection[$key]["body-item-icon"]),
                    'class' => 'circle-img about-left-img'
                  )
                )
            }}
          </div>
          <div class="about-content col-md-8">
            <h2>{{ $bodySection[$key]["body-item-headline"]  }}</h2>
            {{ $bodySection[$key]["body-item-copy"]  }}
          </div>
          <div class="col-md-4 about-desktop-column">
            {{
                wp_get_attachment_image($bodySection[$key]["body-item-icon"], 'full', false,
                  array(
                    'title' => get_the_title($bodySection[$key]["body-item-icon"]),
                    'class' => 'circle-img about-left-img'
                  )
                )
            }}
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
              {{
                wp_get_attachment_image($worksSection[$key]["work-item-icon"], 'full', false,
                  array(
                    'title' => get_the_title($worksSection[$key]["work-item-icon"]),
                    'class' => 'about-us-step'
                  )
                )
              }}
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
        <h1>Discover your benefits today</h1>
          <div class="zip-code form-inline" ng-controller="zipCodeController">
            <input type="text" class="form-control" placeholder="Enter Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
            <button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>
            <p class="error-state" ng-cloak ng-show="isZipInvalid"><strong>Error!</strong> Please enter a valid zipcode in the United States</p>
          </div>
      </div>
    </div>

    <section class="connected-cta col-xs-12">
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
    </section>
  </div>
  @endloop
@stop
