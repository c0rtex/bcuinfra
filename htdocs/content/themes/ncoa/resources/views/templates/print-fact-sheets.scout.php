<?php $programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true)); ?>
@extends('layouts.print')

@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container">
        <h1>Fact Sheet</h1>

            <!-- Desktop -->
            <div class="row">
                <div class="col-md-12 hidden-xs hidden-sm">
                    <!-- Views -->
                    <div>
                            <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                            <div class="fact-sheets-header fact-sheets-bottom-header">{{ Loop::title() }}</div>
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
                            <div class="faq">
                                <h3>{{ $value["question"] }}</h3>
                                <div>
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
                            <div class="faq">
                                <h3>{{ $value["question"] }}</h3>
                                <div>
                                    <p>{{ $value["answer"] }}</p>
                                </div>
                            </div>
                            @endif
                            @endif
                        @endforeach
                        @endif
                        @if(!empty($entryPointValue))
                        <div class="faq">
                            <h3>{{ $entryPointValue["question"] }}</h3>
                            <div>
                                @foreach($entry_points as $ekey => $evalue)
                                <p>
                                    {{ $evalue->print_name }}
                                </p>
                                @endforeach
                            </div>
                        </div>
                        @endif
                        @if(!empty($becs))
                        <div class="faq">
                            <h3>Who can help me to apply?</h3>
                            <div>
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
            </div>
    @endquery
    @stop
