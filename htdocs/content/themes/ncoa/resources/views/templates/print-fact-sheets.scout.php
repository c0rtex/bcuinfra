<?php $programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true)); ?>
@extends('layouts.print')

@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container">
    <header class="visible-print-block print-header">
        <img src="/content/themes/ncoa/resources/assets/images/BCU-logo.svg" alt="National Council on Aging: Benefits Checkup" class="pull-left print-logo">
        <div class="pull-right"><span>www.benefitscheckup.org</span></div>
        <div class="clearfix"></div>
        <hr class="fact-sheets-hr">
    </header>


    <script>



    </script>

    <div class="card-header">
        <h1>Fact Sheet</h1>
    </div>

    <div class="card">
        <div class="card-nested">
            <!-- Desktop -->
            <div class="row">
                <div class="col-md-12 hidden-xs hidden-sm">
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

                    {{-- Meta::get(Loop::id(), $key = 'requirement-info', $single = true) --}}




                    <!--<hr class="fact-sheets-hr" />-->

                    <h3 class="bold-h3">
                        Frequently Asked Questions
                    </h3>
                    <div>

                        @if(!empty($faqs_list))
                        @foreach($faqs_list as $key => $value)
                            @if(strpos($value["answer"], 'entrypoints'))
                            @if(!empty($entry_points))
                            <?php $entryPointValue= $value ?>
                            @endif
                            @else
                            @if($value["answer"] === 'documents_needed')
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">{{ $value["question"] }}</h3>
                                </div>
                                <div class="panel-body">
                                    <ul class="fact-sheets-list">
                                        @if (empty($required_materials))
                                        <li>There are no required materials needed for this program.</li>
                                        @else
                                        @foreach($required_materials as $ekey => $evalue)
                                        <li><a href="" data-toggle="popover" data-html="true" class="popover-rm" data-content="{{$evalue->description}}">{{$evalue->title}}</a></li>
                                        @endforeach
                                        <script type="text/javascript-lazy">$('.popover-rm').popover();</script>
                                        @endif
                                    </ul>
                                </div>
                            </div>
                            @else
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">{{ $value["question"] }}</h3>
                                </div>
                                <div class="panel-body">
                                    <p>
                                        {{ $value["answer"] }}
                                    </p>
                                </div>
                            </div>
                            @endif
                            @endif
                        @endforeach
                        @endif
                        @if(!empty($entryPointValue))
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">{{ $entryPointValue["question"] }}</h3>
                            </div>
                            <div class="panel-body">
                                @foreach($entry_points as $ekey => $evalue)
                                <p>
                                    {{ $evalue->print_name }}
                                </p>
                                @endforeach
                            </div>
                        </div>
                        @endif
                        @if(!empty($becs))
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Who can help me to apply?</h3>
                            </div>
                            <div class="panel-body">
                                <p>
                                    A Benefits Enrollment Center (BEC) can offer personal, one-on-one assistance to apply for this program. With support from NCOA, the BEC can help you apply for and enroll in all of the benefits you may be missing out on. The following BEC is available to help you.
                                </p>
                                @foreach($becs as $ekey => $evalue)
                                <p>
                                    {{ $evalue->print_name }}
                                </p>
                                @endforeach
                            </div>
                        </div>
                        @endif
                    </div>
                    @endif
                </div>

                <div class="col-md-3 hidden-xs hidden-sm">
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

                        <hr class="fact-sheets-hr" />

                        <h3 class="mobile-padding bold-h3">
                            Frequently Asked Questions
                        </h3>
                        <div>
                            @foreach($faqs_list as $key => $value)
                            <section slide-down class="program program-no-icon">
                                <div class="program-header"><span>{{ $value["question"] }}</span></div>
                                <div class="programs-container program-p">
                                    <p>
                                        {{ $value["answer"] }}
                                    </p>
                                </div>
                            </section>
                            @endforeach
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

    <script type="text/javascript">

        jQuery(document).ready(function () {
            //Lynna Cekova: click to call
            var countrycodes = "1"
            var delimiters = "-|\\.|—|–|&nbsp;"
            var phonedef = "\\+?(?:(?:(?:" + countrycodes + ")(?:\\s|" + delimiters + ")?)?\\(?[2-9]\\d{2}\\)?(?:\\s|" + delimiters + ")?[2-9]\\d{2}(?:" + delimiters + ")?[0-9a-z]{4})"
            var spechars = new RegExp("([- \(\)\.:]|\\s|" + delimiters + ")","gi") //Special characters to be removed from the link
            var phonereg = new RegExp("(Fax:)?((^|[^0-9])(href=[\"']tel:)?((?:" + phonedef + ")[\"'][^>]*?>)?(" + phonedef + ")($|[^0-9]))","gi")

            //Created by Jon Meck at LunaMetrics.com - Version 1.0
            // http://www.lunametrics.com/blog/2014/01/16/phone-numbers-clickable-trackable-mobile-devices-javascript-google-tag-manager/

            function ReplacePhoneNumbers(oldhtml) {
                if (!oldhtml) { return; }
                var newhtml = oldhtml.replace("/href=['']callto:/gi",'href="tel:');
                newhtml = newhtml.replace(phonereg, function ($0, $1, $2, $3, $4, $5, $6, $7) {
                    if ($4) return $2;
                    else if ($5) return $3+$5+$6+$7;
                    else if ($1)  return $1+$2;
                    else return $3+"<a href='tel:"+$6.replace(spechars,"")+"' onclick=\"_gaq.push(['_trackEvent','Phone Call Tracking','Click/Touch']);\" >"+$6+"</a>"+$7; });
                return newhtml;
            }

            $("#factsheetContent").html(ReplacePhoneNumbers($("#factsheetContent").html()));
            $(".program-p").each(function(p) {
                $(this).html(ReplacePhoneNumbers($(this).html()));
            });
        });

    </script>
    @endquery
    @stop
