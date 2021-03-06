﻿<!-- php the_meta(); -->
<?php 
$food_only_available = false;
$multi_program_available = false;
$fillable_available = false;
$snap_findstores_url = trim(Meta::get(Loop::id(), $key = 'find_stores_to_use_debit_card_in_english_and_spanish', $single = true)); ?>
<?php $snap_find_elegible = trim(Meta::get(Loop::id(), $key = 'find_out_if_youre_eligible', $single = true)); ?>
<?php $programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true)); ?>
<?php $fillable = '<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>'; ?>

@extends($layout)

@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container fact-sheet" ng-controller="shortFactSheetsController">
    <header class="visible-print-block print-header">
        <img src="/content/themes/ncoa/resources/assets/images/BCU-logo.svg" alt="National Council on Aging: Benefits Checkup" class="pull-left print-logo">
        <div class="pull-right"><span>www.benefitscheckup.org</span></div>
        <div class="clearfix"></div>
        <hr class="fact-sheets-hr">
    </header>

    <div class="card-header">
        <a ng-show="showBack()" href="javascript:history.back()" class="btn-link btn-back">Back</a>
    </div>

    <div class="card">
        <div class="card-nested">
            <div class="row">
                <!-- Desktop -->
                <div class="col-xs-12 col-md-9">
                    <!-- Views -->
                    <div>
                      <span class="icon-block pull-left">
                        <?php
                        echo wp_get_attachment_image(Meta::get(Loop::id(), $key = 'fact-sheet-category-icon', $single = true), 'full')
                        ?>
                      </span>
                        <div class="pull-left">
                        
                            <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                            <div class="fact-sheets-header fact-sheets-bottom-header"><h1>{{ Loop::title() }}</h1></div>
                        </div>
                        <div class="fact-sheets-icon-block pull-left">
                            <a target="_blank" href="{{ Loop::link() }}?{{ @$_SERVER['QUERY_STRING'] }}&print=y" class="fact-sheet-header-icon">
                                <span class="fa fa-print"></span>
                                Print
                            </a>
                            <span class="fact-sheets-spacer"></span>
                            <a href="{{ Loop::link() }}?{{ @$_SERVER['QUERY_STRING'] }}&pdf=y&download=y" class="fact-sheet-header-icon">
                                <span class="fa fa-download"></span>
                                Save
                            </a>
                            <!--<span class="fact-sheets-spacer"></span>
                            <a href="#" class="fact-sheet-header-icon">
                                <span class="fa fa-envelope-o"></span>
                                Email
                            </a>-->
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <hr class="fact-sheets-hr" />

                    <div id="factsheetContent">
                        {{ $post_content }}
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
                        <section slide-down class="program program-no-icon">
                            <div class="program-header"><span>{{ $value["question"] }}</span></div>
                            <div class="programs-container program-p">
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
                        </section>
                        @else
                        <section slide-down class="program program-no-icon">
                            <div class="program-header"><span>{{ $value["question"] }}</span></div>
                            @if ($is_feeding_america &&
                                trim(strtolower($value["question"])) == 'who should i contact?')
                            <div class="programs-container program-p">
                                <p><strong>{{ $feeding_america_office["full_name"] }}</strong><br />
                                  {{ $feeding_america_office["address"] }}<br />
                                  {{ $feeding_america_office["site"] }}</p>
                            </div>
                            @else
                            <div class="programs-container program-p">
                                <p>
                                    {{ $value["answer"] }}
                                </p>
                            </div>
                            @endif
                        </section>
                        @endif
                        @endif
                        @endforeach
                        @endif
                        @if(!empty($entryPointValue))
                        <section slide-down class="program program-no-icon">
                            <div class="program-header"><span>{{ $entryPointValue["question"] }}</span></div>
                            <div class="programs-container program-p">
                                @foreach($entry_points as $ekey => $evalue)
                                <p>
                                    {{ $evalue->print_name }}
                                </p>
                                @endforeach
                            </div>
                        </section>
                        @endif
                        @if(!empty($becs))
                        <section slide-down class="program program-no-icon">
                            <div class="program-header"><span>Who can help me to apply?</span></div>
                            <div class="programs-container program-p">
                                <p>
                                    A Benefits Enrollment Center (BEC) can offer personal, one-on-one assistance to apply for this program. With support from NCOA, the BEC can help you apply for and enroll in all of the benefits you may be missing out on. The following BEC or BECs are available to help you.
                                </p>
                                @foreach($becs as $ekey => $evalue)
                                <p>
                                    {{ $evalue->print_name }}
                                </p>
                                @endforeach
                            </div>
                        </section>
                        @endif
                    </div>
                    @endif
                </div>

                <div class="col-xs-12 col-md-3">
                    @if(Loop::id() == '7284')
                    <div style="margin: 20px 0">
                        <a href="{{ get_permalink(12464) }}" class="btn btn-primary btn-block">Espa&ntilde;ol</a>
                    </div>
                    @elseif(Loop::id() == '12464')
                    <div style="margin: 20px 0">
                        <a href="{{ get_permalink(7284) }}" class="btn btn-primary btn-block">Ingl&eacute;s</a>
                    </div>
                    @endif

                    @if(strlen(Meta::get(Loop::id(), $key = 'body-copy', $single = true))>0)
                    <div class="results-options">
                        <span class="fact-sheets-know fact-sheets-side-header">{{ Meta::get(Loop::id(), $key = 'title', $single = true) }}</span>
                        <br />
                        {{ Meta::get(Loop::id(), $key = 'body-copy', $single = true) }}
                    </div>
                    @endif

                    @if(!empty($app_forms) || !empty($programUrl))
                    <div class="results-options">
                        <span class="fact-sheets-side-header">Quick Links</span>

                        <?php
                        $food_only_available = false;
                        $multi_program_available = false;
                        $fillable_available = false;

                        foreach($app_forms as $ekey => $evalue){
                            if($evalue->type=='online'){
                                echo '<a href="/cf/form_redirect.cfm?id='.$evalue->id.'&tgtPartner=0&tgtorg_id=0&tgt='.$evalue->url.'" class="btn btn-primary fact-sheets-side-apply" target="_new">Apply Online</a>';

                                break;
                            }
                        }
                        ?>

                        <?php $pos=0 ?>
                        @foreach($app_forms as $ekey => $evalue)

                        <?php
                        // Any 'Multi-Programs' in the list?
                        if (strstr(strtolower($evalue->caption), 'multi-program')) {
                            $multi_program_available = true;
                        }

                        // Any 'Food Only' programs?
                        if (strstr(strtolower($evalue->caption), 'food only')) {
                            $food_only_available = true;
                        }

                        if ($evalue->type == 'fillable') {
                            $fillable_available = true;
                        }
                        ?>

                        <?php $isAdded = false?>
                        @if(($evalue->type!='online')&&($pos<2))
                        <?php $pos++ ?>
                        <?php $isAdded = true ?>
                        <a target="_blank" href="/cf/form_redirect.cfm?id={{$evalue->id}}&tgtPartner=0&tgtorg_id=0&tgt={{$app_forms_uri.$evalue->url}}" class="btn btn-link fact-sheets-side-link">
                            <span class="fa fa-file fact-sheets-icon"></span>
                            <span style="white-space: pre-line">{{ $evalue->caption }}</span> <?php ($evalue->type == 'fillable') ? print $fillable : ''; ?>
                        </a>
                        @endif

                        @if (($pos===2)&&($evalue->type!='online'))
                        <div id="myModal" class="modal fade" role="dialog">
                            <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Application Forms</h4>
                                    </div>
                                    <?php $modalNotEmpty = false; ?>
                                    <div class="modal-body">
                                        @if(!$isAdded)
                                        <?php $isAdded = true ?>
                                        @if(strpos($evalue->url, 'http')===0)

                                        <a href="{{$evalue->url }}" target="_blank" class="btn btn-link fact-sheets-side-link">
                                            <span style="white-space: pre-line">{{ $evalue->caption }}</span> <?php ($evalue->type == 'fillable') ? print $fillable : ''; ?>
                                        </a><br />
                                        <?php $modalNotEmpty = true; ?>
                                        @else
                                        <a target="_blank" href="/cf/form_redirect.cfm?id={{$evalue->id}}&tgtPartner=0&tgtorg_id=0&tgt={{ $app_forms_uri.$evalue->url }}" class="btn btn-link fact-sheets-side-link">

                                            <span class="fa fa-file fact-sheets-icon"></span>
                                            <span style="white-space: pre-line">{{ $evalue->caption }}</span> <?php ($evalue->type == 'fillable') ? print $fillable : ''; ?>
                                        </a><br />
                                        <?php $modalNotEmpty = true; ?>
                                        @endif
                                        @endif
                                        <?php $pos++ ?>
                                        @endif

                                        @if ($pos >= 3)

                                        <?php
                                        // Line added to print previous item (Application Form)
                                        $prev_vals = array_slice($app_forms, 0, $ekey);
                                        static $printed_prev = false;
                                        ?>

                                        @if(!$printed_prev)
                                            @foreach($prev_vals as $prev_ekey => $prev_evalue)
                                            @if($prev_evalue->type=='online')
                                                <a href="/cf/form_redirect.cfm?id={{ $prev_evalue->id }}&tgtPartner=0&tgtorg_id=0&tgt={{ $prev_evalue->url }}" class="btn btn-link fact-sheets-side-link" target="_new">
                                                    <span class="fa fa-file fact-sheets-icon"></span>
                                                    <span style="white-space: pre-line">{{ $prev_evalue->caption }}</span> <?php ($prev_evalue->type == 'fillable') ? print $fillable : ''; ?>
                                                </a><br />
                                            @elseif(strpos($prev_evalue->url, 'http')===0)
                                            <a href="{{$prev_evalue->url }}" target="_blank" class="btn btn-link fact-sheets-side-link">
                                                <span style="white-space: pre-line">{{ $prev_evalue->caption }}</span> <?php ($prev_evalue->type == 'fillable') ? print $fillable : ''; ?>
                                            </a><br />
                                            @else
                                            <a target="_blank" href="/cf/form_redirect.cfm?id={{$prev_evalue->id}}&tgtPartner=0&tgtorg_id=0&tgt={{ $app_forms_uri.$prev_evalue->url }}" class="btn btn-link fact-sheets-side-link">
                                                <span class="fa fa-file fact-sheets-icon"></span>
                                                <span style="white-space: pre-line">{{ $prev_evalue->caption }}</span> <?php ($prev_evalue->type == 'fillable') ? print $fillable : ''; ?>
                                            </a><br />
                                            @endif
                                            @endforeach
                                            <?php $printed_prev = true; ?>
                                        @endif

                                        @if(strpos($evalue->url, 'http')===0)

                                        <a href="{{$evalue->url }}" target="_blank" class="btn btn-link fact-sheets-side-link">
                                            <span style="white-space: pre-line">{{ $evalue->caption }}</span> <?php ($evalue->type == 'fillable') ? print $fillable : ''; ?>
                                        </a><br />
                                        <?php $modalNotEmpty = true; ?>
                                        @else
                                        <a target="_blank" href="/cf/form_redirect.cfm?id={{$evalue->id}}&tgtPartner=0&tgtorg_id=0&tgt={{ $app_forms_uri.$evalue->url }}" class="btn btn-link fact-sheets-side-link">
                                            <span class="fa fa-file fact-sheets-icon"></span>
                                            <span style="white-space: pre-line">{{ $evalue->caption }}</span> <?php ($evalue->type == 'fillable') ? print $fillable : ''; ?>
                                        </a><br />
                                        <?php $modalNotEmpty = true; ?>
                                        @endif
                                        @endif
                                        @endforeach

                                        @if ($pos >= 3)
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    </div>
                                </div>

                            </div>
                        </div>

                        @if ($modalNotEmpty == true)
                        <a href data-toggle="modal" data-target="#myModal" class="btn btn-link fact-sheets-side-link">
                          <span style="white-space: pre-line">See More</span>
                        </a>
                        @endif

                        @endif

                        @if (!empty($programUrl))
                        </br>
                        <a target="_blank" href="<?php echo $programUrl; ?>" class="btn btn-link fact-sheets-side-link">
                          <span style="white-space: pre-line">Program Website</span>
                        </a>
                        @endif

			            @if (!empty($snap_findstores_url))
                        </br>
                        <a target="_blank" href="<?php echo $snap_findstores_url; ?>" class="btn btn-link fact-sheets-side-link">
                          <span style="white-space: pre-line">Find Stores to Use Debit Card</span>
                        </a>
                        @endif

                        @if (($is_snap) && ($elegible != 'n') && !empty($snap_find_elegible))
                        </br>
                        <a href="/find-my-benefits/" class="btn btn-link fact-sheets-side-link">
                          <span style="white-space: pre-line">Find Out If You're Eligible</span>
                        </a>
                        @endif
			

                    </div>
                    @endif

                    @if ($food_only_available !== false || $multi_program_available !== false || $fillable_available !== false)
                    <div class="results-options">
                        <p><span class="fact-sheets-side-header">Definition(s)</span></p>
                        @if ($multi_program_available !== false)
                        <p>
                            <span><strong>Multi-Program Forms:</strong></span><br />
                            <span><em>This is to apply for more than one program at the same time.</em></span>
                        </p>
                        @endif
                        @if ($food_only_available !== false)
                        <p>
                            <span><strong>Food Only Forms:</strong></span><br />
                            <span><em>This is to apply for the SNAP/Food Stamp program only.</em></span>
                        </p>
                        @endif
                        @if ($fillable_available !== false)
                        <p>
                            <br /><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <em>This is for fillable forms.</em>
                        </p>
                        @endif
                    </div>
                    @endif

                    @if (!empty($snap_findstores_url) &&  (!empty($entryPointValue))) 
                    <div class="results-options feedback-box">
                        <span class="fact-sheets-side-header">Please Give Us Some Feedback</span>
                        <div class="fact-sheets-side-subheader">How likely are you to apply for this program?</div>
                        <div class="survey-answers">
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PS35M99">Very Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PRKNY78">Somewhat Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PR96HFK">Not Likely</a>
                        </div>
                    </div> 
		    @elseif (!empty($snap_findstores_url) ) 
                    <div class="results-options feedback-box">
                        <span class="fact-sheets-side-header">Please Give Us Some Feedback</span>
                        <div class="fact-sheets-side-subheader">How likely are you to apply for this program?</div>
                        <div class="survey-answers">
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PJHRX3H">Very Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PQ36G82">Somewhat Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/PQYHKCL">Not Likely</a>
                        </div>
                    </div> 
                    @endif

                    @if ($key_benefits_program !== false)
                    <div class="results-options feedback-box">
                        <span class="fact-sheets-side-header">Please Give Us Some Feedback</span>
                        <div class="fact-sheets-side-subheader">How likely are you to apply for this program?</div>
                        <div class="survey-answers">
                            <a target="_blank" class="btn btn-secondary" href="{{$key_benefits_program['survey_links']['very_likely']}}">Very Likely</a>
                            <a target="_blank" class="btn btn-secondary" href="{{$key_benefits_program['survey_links']['somewhat_likely']}}">Somewhat Likely</a>
                            <a target="_blank" class="btn btn-secondary" href="{{$key_benefits_program['survey_links']['not_likely']}}">Not Likely</a>
                        </div>
                    </div>
                    @endif
                </div>


            </div>
        </div>
        <!-- <h3 class="fact-sheets-bottom">
          <a ui-sref="questionnaire.results" class="btn btn-link btn-back fact-sheets-side-link">Back to Results</a>
        </h3> -->
    </div>
</div>


<script type="text/javascript">

    jQuery(document).ready(function () {
        //Lynna Cekova: click to call
        var countrycodes = "1"
        var delimiters = "-|\\.|�|�|&nbsp;"
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

@section('misc-scripts')
<script type="text/javascript">
    // Adjust font-size based on the number of characters in the heading
    $(function() {

        var $heading = $(".fact-sheets-header h1");

        var $numChars = $heading.text().length;

        if (($numChars > 45) && ($numChars < 70)) {
            $heading.css("font-size", "25px");
        }
        else if ($numChars > 70) {
            $heading.css("font-size", "19px");
        }
        else {
            $heading.css("font-size", "30px");
        }

    });
</script>
@stop