@extends($layout)
@section('main')
@query(['post_type' => 'fact-sheets', 'posts_per_page' => 3, 'name' => $page_slug])

<div class="container short-fact-sheet">
    <header class="visible-print-block print-header">
        <img src="/content/themes/ncoa/resources/assets/images/BCU-logo.svg" alt="National Council on Aging: Benefits Checkup" class="pull-left print-logo">
        <div class="pull-right"><span>www.benefitscheckup.org</span></div>
        <div class="clearfix"></div>
        <hr class="fact-sheets-hr">
    </header>

    <div class="card-header">
        <a href="javascript:history.back()" class="btn-link btn-back">Back</a>

    </div>

    <div class="card">
        <div class="card-nested">
            <!-- Desktop -->
            <div class="row">
                <div class="col-xs-12 col-md-9">
                    <!-- Views -->
                    <div>
                        <span class="icon-block pull-left">
                            {{
                                wp_get_attachment_image(Meta::get(Loop::id(), $key = 'fact-sheet-category-icon', $single = true), 'full', array('title' => 'Loop::id()'))
                            }}
                        </span>
                        <div class="pull-left">
                            <div class="fact-sheets-header fact-sheets-top-header">{{ Meta::get(Loop::id(), $key = 'fact-sheet-category', $single = true) }}</div>
                            <div class="fact-sheets-header fact-sheets-bottom-header"><h1>{{ Loop::title() }}</h1></div>
                        </div>
                        <div class="fact-sheets-icon-block pull-left">
                            <a target="_blank" href="{{ Loop::link() }}?{{ @$_SERVER['QUERY_STRING'] }}&short=y&print=y" class="fact-sheet-header-icon">
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
                    <h3 class="bold-h3 text-light-blue">Find out if you’re eligible for this program</h3>
                    <p>
                        Answer a few more questions to ﬁnd out if you are eligible for this program. You will get a personal report with more information on these programs and detailed information on how to apply.  
                    </p>
                    <complete-questionnaire/>
                    <!--<a ng-hide="prescreenAnswered" href="/find-my-benefits" class="btn btn-primary">Start Questionnaire</a>
                    <a ng-show="prescreenAnswered" ng-click="completeFQ()" class="btn btn-primary">Complete Full Questionnaire</a>-->
                    

                    <!--{{ Meta::get(Loop::id(), $key = 'requirement-info', $single = true) }}-->
                    @endif
                </div>

                <div class="col-xs-12 col-md-3">
                    <?php
                     $programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true));
                    ?>
		    <?php $snap_findstores_url = trim(Meta::get(Loop::id(), $key = 'find_stores_to_use_debit_card_in_english_and_spanish', $single = true)); ?>
		    <?php $snap_bcu_url = trim(Meta::get(Loop::id(), $key = 'find_out_if_youre_eligible', $single = true)); ?>

                    @if(strlen(Meta::get(Loop::id(), $key = 'body-copy', $single = true))>0)
                    <div class="results-options">
                        <span class="fact-sheets-know fact-sheets-side-header">{{ Meta::get(Loop::id(), $key = 'title', $single = true) }}</span>
                        <br />
                        {{ Meta::get(Loop::id(), $key = 'body-copy', $single = true) }}
                    </div>
                    @endif

                    @if(!empty($programUrl))
                    <div class="results-options">
                        <span class="fact-sheets-side-header">Quick Links</span>
                        <br />
                        <?php
                          if (strpos($programUrl,'http') !== 0) $programUrl = 'http://'.$programUrl;
                        ?>
                        <a target="_blank" href="{{ $programUrl }}" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">
                          <span style="white-space: pre-line">Program Website</span>
                        </a>

                    @endif
		    @if (!empty($snap_findstores_url))
                        </br>
                        <a target="_blank" href="<?php echo $snap_findstores_url; ?>" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">
                          <span style="white-space: pre-line">Find Stores to Use Debit Card</span>
                        </a>
                    @endif
		    @if (!empty($snap_bcu_url))
                        </br>
                        <a target="_blank" href="<?php echo $snap_bcu_url; ?>" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">
                          <span style="white-space: pre-line">Find Out If You're Eligible</span>
                        </a>
                    @endif

                    @if (!empty($snap_findstores_url)) 
                    <div class="results-options feedback-box">
                        <span class="fact-sheets-side-header">Please Give Us Some Feedback</span>
                        <div class="fact-sheets-side-subheader">How likely are you to apply for this program?</div>
                        <div class="survey-answers">
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/P7B8JRK">Very Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/P9Q2Q7W">Somewhat Likely</a>
	                        <a target="_blank" class="btn btn-secondary" href="https://www.surveymonkey.com/r/P9VX39M">Not Likely</a>
                        </div>
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
    </div>
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
