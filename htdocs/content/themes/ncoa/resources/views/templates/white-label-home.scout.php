@extends('layouts.white-label-main')

@section('main')
  @loop
    <section class="hero hero--blue">
      <div class="container">
        <div class="row">
          <div class="hero__header">
            <h1>Find and enroll in public and private benefit programs</h1>
            <p>Answer a few questions to quickly find benefits in your area</p>
          </div><!--/.hero__header-->
          <div class="hero__form">
            <form ng-submit="findZip(zipcode)" ng-controller="zipCodeController">
              <div class="zip-code form-inline">
                <input type="text" class="form-control" placeholder="Enter Your Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" required="required">
                <button ng-click="findZip(zipcode)" class="btn btn-primary">Get Started</button>
                <p class="error-state ng-hide" ng-show="isZipInvalid"><strong>Error!</strong> Please enter a valid zip code in the United States.</p>
              </div>
            </form>
          </div><!--/.hero__form-->
        </div><!--/.row-->
      </div><!--/.container-->
    </section><!--/.hero-->

    <section class="program-highlights">
      <div class="container">
        @if($home6)
          <div class="row program-highlights-carousel">
            <div class="col-xs-12">
              <div class="program-highlights-carousel-container">

                <div class="item">
                  <div class="program-highlight">
                    <div class="program-highlight__text">
                      <div class="program-highlight__icon">
                        <a href="/medicare-rx-extra-help-application-intro-page/" class="program-highlight__icon-wrap">
                          <img src="../content/uploads/2016/05/category_medicine.svg" class="attachment-full size-full" alt="Medicine Pills" title="Medicine Pills">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Medicare Rx Extra Help/LIS</h2>
                      <div class="program-highlight__excerpt">
                        <p>Apply now through Social Security for help paying for prescription drugs.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <a class="btn btn-secondary" href="/medicare-rx-extra-help-application-intro-page/">Get Started</a>
                    </div>
                  </div><!--/.program-highlight-->
                </div><!--/.item-->

                <div class="item">
                  <div class="program-highlight">
                    <div class="program-highlight__text">
                      <div class="program-highlight__icon">
                        <a href="/resources/snap/" class="program-highlight__icon-wrap">
                          <img src="../content/uploads/2016/05/category_food-1.svg" class="attachment-full size-full" alt="Basket of Food" title="Basket of Food">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Food &amp; Nutrition</h2>
                      <div class="program-highlight__excerpt">
                        <p>Find state SNAP programs, get application forms, and apply today.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <a class="btn btn-secondary" href="/resources/snap/">Get Started</a>
                    </div>
                  </div><!--/.program-highlight-->
                </div><!--/.item-->

                <div class="item">
                  <div class="program-highlight">
                    <div class="program-highlight__text">
                      <div class="program-highlight__icon">
                        <a href="/find-my-benefits/?subset_id=57" class="program-highlight__icon-wrap">
                          <img src="../content/themes/ncoa/resources/assets/images/category_keyBenefits.svg" class="attachment-full size-full" alt="Doctor Symbol" title="Doctor Symbol">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Key Benefits</h2>
                      <div class="program-highlight__excerpt">
                        <p>Quickly find core benefits that pay for medications, health care, food, and more.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <a class="btn btn-secondary" href="/find-my-benefits/?subset_id=57">Get Started</a>
                    </div>
                  </div><!--/.program-highlight-->
                </div><!--/.item-->

                <div class="item">
                  <div class="program-highlight">
                    <div class="program-highlight__text">
                      <div class="program-highlight__icon">
                        <a href="#" class="program-highlight__icon-wrap">
                          <img src="../content/uploads/2016/05/category_health.svg" class="attachment-full size-full" alt="Doctor Symbol" title="Doctor Symbol">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Medicaid Office Locator</h2>
                      <div class="program-highlight__excerpt">
                        <p>Quickly find local Medicaid office(s) by service area.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <span style="color: #1888de; font-weight: 700; font-size: 21px">Coming Soon!</span>
                    </div>
                  </div><!--/.program-highlight-->
                </div><!--/.item-->

              </div><!--.ncoa-carousel-container-->
              <div class="controls">
                <div class="count">
                  <span class="currItem"></span>
                  of
                  <span class="currTotal"></span>
                </div>
              </div><!--/.controls-->
            </div><!--/.col-xs-12-->
          </div><!--/.row-->
        @else
          <div class="row">
            <ul class="program-highlights__list">
              <li>
                <div class="program-highlight">
                  <div class="program-highlight__text">
                    <div class="program-highlight__icon">
                      <a href="/medicare-rx-extra-help-application-intro-page/" class="program-highlight__icon-wrap">
                        <img src="../content/uploads/2016/05/category_medicine.svg" class="attachment-full size-full" alt="Medicine Pills" title="Medicine Pills">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Medicare Rx Extra Help/LIS</h2>
                    <div class="program-highlight__excerpt">
                      <p>Apply now through Social Security for help paying for prescription drugs.</p>
                    </div>
                  </div>
                  <div class="program-highlights__btn">
                    <a class="btn btn-secondary" href="/medicare-rx-extra-help-application-intro-page/">Get Started</a>
                  </div>
                </div><!--/.program-highlight-->
              </li>
              <li>
                <div class="program-highlight">
                  <div class="program-highlight__text">
                    <div class="program-highlight__icon">
                      <a href="." class="program-highlight__icon-wrap">
                        <img src="../content/uploads/2016/05/category_food-1.svg" class="attachment-full size-full" alt="Basket of Food" title="Basket of Food">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Food & Nutrition</h2>
                    <div class="program-highlight__excerpt">
                      <p>Quickly find core benefits that pay for medications, health care, food, and more.</p>
                    </div>
                  </div>
                  <div class="program-highlights__btn">
                    <a class="btn btn-secondary" href=".">Get Started</a>
                  </div>
                </div><!--/.program-highlight-->
              </li>
              <li>
                <div class="program-highlight">
                  <div class="program-highlight__text">
                    <div class="program-highlight__icon">
                      <a href="." class="program-highlight__icon-wrap">
                        <img src="../content/themes/ncoa/resources/assets/images/category_keyBenefits.svg" class="attachment-full size-full" alt="Doctor Symbol" title="Doctor Symbol">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Key Benefits</h2>
                    <div class="program-highlight__excerpt">
                      <p>Quickly find core benefits that pay for medications, health care, food, and more.</p>
                    </div>
                  </div>
                  <div class="program-highlights__btn">
                    <a class="btn btn-secondary" href=".">Get Started</a>
                  </div>
                </div><!--/.program-highlight-->
              </li>
            </ul><!--/.program-highlights__list-->
          </div><!--/.row-->
        @endif
      </div><!--/.container-->
    </section><!--/.program-highlights-->

    <section class="reminder">
      <div class="container">
        <div class="row">
          <div class="reminder__text exclamation">
            <p><strong>REMINDER:</strong> The Medicare Annual Open Enrollment period is October 15th through December 7th. However, the Marketplace Open Enrollment period is November 1st through December 15th.
          </div><!--/.reminder__text-->
        </div><!--/.row-->
      </div><!--/.container-->
    </section><!--/.reminder-->

    <div class="white-bg">
      <div class="container">
        <div class="row">
          <div class="grid-1-to-2">
            <div class="grid-1-to-2__1">
              <section class="shortcuts">
                <h3>Shortcuts</h3>
                <ul>
                  <li><a href="https://www.ncoa.org/resources/benefits-enrollment-center-toolkit/" target="_blank">Benefits Enrollment Center (BEC) Toolkit </a></li>
                  <li><a href="https://www.ncoa.org/map/ncoa-map/"  target="_blank">Map of BEC Grantees</a></li>
                  <li><a href="https://www.ncoa.org/resources/bec-promising-practices-report/"  target="_blank">BEC Promising Practices Report</a></li>
                  <li><a href="https://www.ncoa.org/centerforbenefits/outreach-toolkit/"  target="_blank">Outreach Toolkit</a></li>
     
                </ul>
              </section><!--/.shortcuts-->
            </div>
            @if (!empty($posts))
            <div class="grid-1-to-2__2">
              <div class="blog">
                <h3>From the NCOA Blog</h3>
                <ul>
                  @foreach ($posts as $post)
                  <li>
                    <div class="blog-teaser">
                      @if (!empty($post->image))
                        <a target="_blank" href="{{ $post->link }}">
                          <div class="blog-teaser__img">
                            <img width="240" height="120" src="{{ $post->image }}" alt="" />
                          </div>
                          <div class="blog-teaser__text">
                            <h4>{{ $post->title }}</h4>
                            <div>{{ date('m.d.Y', $post->pubDate) }}</div>
                          </div>
                        </a>
                      @else
                        <a target="_blank" href="{{ $post->link }}">
                          <h4>{{ $post->title }}</h4>
                        </a>
                        <div>{{ date('m.d.Y', $post->pubDate) }}</div>
                      @endif
                    </div>
                  </li>
                  @endforeach
                </ul>
              </div>
            </div>
            @endif
          </div>
        </div>
      </div>
    </div>

  @endloop
@stop
