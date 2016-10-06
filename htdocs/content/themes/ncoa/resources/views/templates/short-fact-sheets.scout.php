@extends($layout)

@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container">
    <header class="visible-print-block print-header">
        <img src="/content/themes/ncoa/resources/assets/images/BCU-logo.svg" alt="National Council on Aging: Benefits Checkup" class="pull-left print-logo">
        <div class="pull-right"><span>www.benefitscheckup.org</span></div>
        <div class="clearfix"></div>
        <hr class="fact-sheets-hr">
    </header>

    <div class="card-header">
        <a href="javascript:history.back()" class="btn-link btn-back">Back to Results</a>
        <h1>Fact Sheet</h1>
    </div>

    <div class="card">
        <div class="card-nested">
            <!-- Desktop -->
            <div class="row">
                <div class="col-md-9 hidden-xs hidden-sm">
                    <!-- Views -->
                    <div>
                        <span class="icon-block pull-left">
                            <?php 
                                  echo wp_get_attachment_image(Meta::get(Loop::id(), $key = 'fact-sheet-category-icon', $single = true), 'full') 
                                ?>
                        </span>
                        <div class="pull-left">
                            <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                            <div class="fact-sheets-header fact-sheets-bottom-header">{{ Loop::title() }}</div>
                        </div>
                        <div class="fact-sheets-icon-block pull-left">
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-print"></span>
                                Print
                            </a>
                            <span class="fact-sheets-spacer"></span>
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-download"></span>
                                Save
                            </a>
                            <span class="fact-sheets-spacer"></span>
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-envelope-o"></span>
                                Email
                            </a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <hr class="fact-sheets-hr" />

                    <div id="factsheetContent">
                        {{ Loop::content() }}
                    </div>

                    @if($is_alt)
                    {{ Meta::get(Loop::id(), $key = 'requirement-info-alt', $single = true) }}
                    @endif

                    @if(!$is_alt)
                    <hr class="fact-sheets-hr" />
                    <h3 class="bold-h3">How do I get more information?</h3>
                    <p>
                        If you would like more information and to find out if you meet the program guidelines, please answer a few more questions.
                    </p>
                    <complete-questionnaire/>
                    <!--<a ng-hide="prescreenAnswered" href="/find-my-benefits" class="btn btn-primary">Start Questionnaire</a>
                    <a ng-show="prescreenAnswered" ng-click="completeFQ()" class="btn btn-primary">Complete Full Questionnaire</a>-->
                    <hr class="fact-sheets-hr" />

                    <!--{{ Meta::get(Loop::id(), $key = 'requirement-info', $single = true) }}-->

                    <h3 class="bold-h3">What Youll Need...</h3>
                    <ul class="fact-sheets-list">
                        @foreach($required_materials as $ekey => $evalue)
                        <li><a href="" data-toggle="popover" data-html="true" data-content="{{$evalue->description}}">{{$evalue->title}}</a></li>
                        @endforeach
                    </ul>
                    @endif
                </div>

                <div class="col-md-3 hidden-xs hidden-sm">
                    @if(strlen(Meta::get(Loop::id(), $key = 'body-copy', $single = true))>0)
                    <div class="results-options">
                        <span class="fact-sheets-know fact-sheets-side-header">{{ Meta::get(Loop::id(), $key = 'title', $single = true) }}</span>
                        <br />
                        {{ Meta::get(Loop::id(), $key = 'body-copy', $single = true) }}
                    </div>
                    @endif
                </div>

                <!-- Mobile -->
                <div class="col-xs-12 hidden-md hidden-lg">
                    <div>
                        <span class="icon-block-healthcare pull-left"></span>
                        <div class="pull-left">
                            <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                            <div class="fact-sheets-header fact-sheets-bottom-header">{{ Loop::title() }}</div>
                        </div>
                        <div class="clearfix"></div>
                        <hr class="fact-sheets-hr" />
                        <div class="fact-sheets-icon-block pull-left">
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-print"></span>
                                Print
                            </a>
                            <span class="fact-sheets-spacer"></span>
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-floppy-o"></span>
                                Save
                            </a>
                            <span class="fact-sheets-spacer"></span>
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-envelope-o"></span>
                                Email
                            </a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <hr class="fact-sheets-hr" />
                    <div class="mobile-padding">
                        {{ Loop::content() }}

                        <div class="results-options fact-sheet-options">
                            <div class="fact-sheets-know-container">
                                <span class="fact-sheets-know fact-sheets-side-header">{{ Meta::get(Loop::id(), $key = 'title', $single = true) }}</span>
                                <br />
                                {{ Meta::get(Loop::id(), $key = 'body-copy', $single = true) }}
                            </div>
                        </div>

                        @if($is_alt)
                        {{ Meta::get(Loop::id(), $key = 'requirement-info-alt', $single = true) }}
                        @endif

                        @if(!$is_alt)

                        <div>
                            <a href="{{ Meta::get(Loop::id(), $key = 'program-url', $single = true) }}" target="_new" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">{{ Meta::get(Loop::id(), $key = 'program-title', $single = true) }}</a>
                        </div>

                        <hr class="fact-sheets-hr" />

                        {{ Meta::get(Loop::id(), $key = 'requirement-info', $single = true) }}

                        <div class="fact-sheets-main-apply mobile-padding">
                            <a href="{{ Meta::get(Loop::id(), $key = 'button-url', $single = true) }}" class="btn btn-primary fact-sheets-main-mobile">{{ Meta::get(Loop::id(), $key = 'button-title', $single = true) }}</a>
                        </div>

                        <div class="mobile-padding">
                            <a href="{{ Meta::get(Loop::id(), $key = 'english-url', $single = true) }}" class="btn btn-link fact-sheets-link">
                                <span class="fa fa-file fact-sheets-icon"></span>
                                {{ Meta::get(Loop::id(), $key = 'english-title', $single = true) }}
                            </a>
                            <span class="fact-sheets-bar">|</span>
                            <a href="{{ Meta::get(Loop::id(), $key = 'spanish-url', $single = true) }}" class="btn btn-link fact-sheets-link">
                                <span class="fa fa-file fact-sheets-icon"></span>
                                {{ Meta::get(Loop::id(), $key = 'spanish-title', $single = true) }}
                            </a>
                            <span class="fact-sheets-bar">|</span>
                            <a href="{{ Meta::get(Loop::id(), $key = 'more-languages-url', $single = true) }}" class="btn btn-link fact-sheet-button-fwd fact-sheets-link">
                                {{ Meta::get(Loop::id(), $key = 'more-languages', $single = true) }}
                            </a>
                        </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
        <!-- <h3 class="fact-sheets-bottom">
          <a ui-sref="questionnaire.results" class="btn btn-link btn-back fact-sheets-side-link">Back to Results</a>
        </h3> -->
    </div>
    @endquery
    </div>
    @stop
