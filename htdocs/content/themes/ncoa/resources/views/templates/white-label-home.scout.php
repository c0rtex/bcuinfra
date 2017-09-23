@extends('layouts.white-label-main')

@section('main')
  @loop
    <section class="hero hero--blue">
      <div class="container">
        <div class="row">
          <div class="hero__header">
            <h1>Find and enroll in public and private benefits programs</h1>
            <p>Answer a few questions to quickly find the benefits you deserve.</p>
          </div><!--/.hero__header-->
          <div class="hero__form">
            <form ng-submit="findZip(zipcode)" ng-controller="zipCodeController" class="ng-pristine ng-scope ng-invalid ng-invalid-required ng-valid-pattern">
              <div class="zip-code form-inline">
                <input type="text" class="form-control ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required ng-valid-pattern" placeholder="Enter Your Zip Code" aria-label="Zipcode" ng-model="zipcode" ng-required="true" required="required">
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
                        <a href="/medicare-rx-extra-help-application-start/" class="program-highlight__icon-wrap">
                          <img src="../content/uploads/2016/05/category_medicine.svg" class="attachment-full size-full" alt="Medicine Pills" title="Medicine Pills">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Medicare Rx Extra Help</h2>
                      <div class="program-highlight__excerpt">
                        <p>If you have limited income and resources, you may be able to get help paying for your prescription drugs.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <a class="btn btn-secondary" href="/medicare-rx-extra-help-application-start/">Get Started</a>
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
                        <p>Need help paying for food? Find the program where you live, get an application and apply today.</p>
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
                          <img src="../content/uploads/2016/05/category_health.svg" class="attachment-full size-full" alt="Doctor Symbol" title="Doctor Symbol">
                        </a>
                      </div>
                      <h2 class="program-highlight__title">Key Benefits</h2>
                      <div class="program-highlight__excerpt">
                        <p>Screen for our core benefit programs.</p>
                      </div>
                    </div>
                    <div class="program-highlights__btn">
                      <a class="btn btn-secondary" href="/find-my-benefits/?subset_id=57">Get Started</a>
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
                      <a href="." class="program-highlight__icon-wrap">
                        <img src="../content/uploads/2016/05/category_medicine.svg" class="attachment-full size-full" alt="Medicine Pills" title="Medicine Pills">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Medicare Rx Extra Help</h2>
                    <div class="program-highlight__excerpt">
                      <p>If you have limited income and resources, you may be able to get help paying for your prescription drugs.</p>
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
                        <img src="../content/uploads/2016/05/category_food-1.svg" class="attachment-full size-full" alt="Basket of Food" title="Basket of Food">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Food & Nutrition</h2>
                    <div class="program-highlight__excerpt">
                      <p>Need help paying for food? Find the program where you live, get an application and apply today.</p>
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
                        <img src="../content/uploads/2016/05/category_health.svg" class="attachment-full size-full" alt="Doctor Symbol" title="Doctor Symbol">
                      </a>
                    </div>
                    <h2 class="program-highlight__title">Key Benefits</h2>
                    <div class="program-highlight__excerpt">
                      <p>Screen for our core benefit programs.</p>
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
            <p><strong>REMINDER:</strong> The annual open enrollment period for Medicare Part D is October 15th through December 7th.
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
                  <li><a href=".">Medicare forms</a></li>
                  <li><a href=".">Patient Assistance forms</a></li>
                  <li><a href=".">State Rx forms</a></li>
                  <li><a href=".">Medicaid forms</a></li>
                  <li><a href=".">Bayer Patient Assistance Program</a></li>
                  <li><a href=".">Rx Outreach - English</a></li>
                </ul>
              </section><!--/.shortcuts-->
            </div>
            <div class="grid-1-to-2__2">
              <div class="blog">
                <h3>From the NCOA Blog</h3>
                <ul>
                  <li>
                    <div class="blog-teaser">
                      <a href=".">
                        <div class="blog-teaser__img">
                          <img src="../content/themes/ncoa/resources/assets/images/blog_1.png" alt="" />
                        </div>
                        <div class="blog-teaser__text">
                          <h4>Straight Talk for Seniors: FY18 Budget & Funding for Senior Programs</h4>
                          <div>7.24.2017</div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="blog-teaser">
                      <a href=".">
                        <div class="blog-teaser__img">
                          <img src="../content/themes/ncoa/resources/assets/images/blog_2.png" alt="" />
                        </div>
                        <div class="blog-teaser__text">
                          <h4>Thinking About When You'll Claim Social Security Benefits is Time Well Spent</h4>
                          <div>7.20.2017</div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="blog-teaser">
                      <a href=".">
                        <div class="blog-teaser__img">
                          <img src="../content/themes/ncoa/resources/assets/images/blog_3.png" alt="" />
                        </div>
                        <div class="blog-teaser__text">
                          <h4>It's Time to Change the Story of Aging</h4>
                          <div>7.6.2017</div>
                        </div>
                      </a>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  @endloop
@stop
