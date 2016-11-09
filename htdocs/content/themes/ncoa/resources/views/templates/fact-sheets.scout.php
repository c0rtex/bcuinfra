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


<script>



</script>

<div class="card-header">
  <a href="javascript:history.back()" class="btn-link btn-back">Back</a>
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

          <!--{{ Meta::get(Loop::id(), $key = 'requirement-info', $single = true) }}-->
<!--

        <h3 class="bold-h3">What You'll Need...</h3>
        <ul class="fact-sheets-list">
          @foreach($required_materials as $ekey => $evalue)

          <li><a href="" data-toggle="popover" data-html="true" data-content="{{$evalue->description}}">{{$evalue->title}}</a></li>
          @endforeach
        </ul>
-->




          <!--<hr class="fact-sheets-hr" />-->

          <h3 class="bold-h3">
            Frequently Asked Questions
          </h3>
          <div>

       @foreach(Meta::get(Loop::id(), $key = 'faqs-list', $single = true) as $key => $value)
            <section slide-down class="program program-no-icon">
              <div class="program-header"><span>{{ $value["question"] }}</span></div>
              @if(strpos($value["answer"], 'entrypoints'))
              @foreach($entry_points as $ekey => $evalue)
              <div class="programs-container program-p">
                <p>
                  {{ $evalue->print_name }}
                </p>
             </div>
              @endforeach
              @else
              @if($value["answer"] === 'documents_needed')
              <div class="programs-container program-p">
            <ul class="fact-sheets-list">
            @if (empty($required_materials))
                <li>There are no required materials needed for this program.</li>
            @else
                @foreach($required_materials as $ekey => $evalue)
                    <li><a href="" data-toggle="popover" data-html="true" class="popover-rm" data-content="{{$evalue->description}}">{{$evalue->title}}</a></li>
                @endforeach
                <script type="text/javascript-lazy">$('.popover-r').popover();</script>
          @endif
        </ul>

              </div>

              @else
              <div class="programs-container program-p">
                <p>
                  {{ $value["answer"] }}
                </p>
              </div>
              @endif
              @endif
            </section>
       @endforeach
            @if(!empty($becs))
            <section slide-down class="program program-no-icon">
                <div class="program-header"><span>Who Can Help Me Apply?</span></div>
                @foreach($becs as $ekey => $evalue)
                <div class="programs-container program-p">
                    <p>
                        {{ $evalue->print_name }}
                    </p>
                </div>
                @endforeach
            </section>
            @endif
          </div>
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
        @if(!$is_alt)
          <div class="results-options">
            <span class="fact-sheets-side-header">Quick Links</span>

<?php

$programUrl = trim(Meta::get(Loop::id(), $key = 'program-url', $single = true));

//if (!empty($programUrl)) {


foreach($app_forms as $ekey => $evalue){
if(strpos($evalue->url, 'http')===0){

echo '

<a href="'.$evalue->url.'" class="btn btn-primary fact-sheets-side-apply" target="_new">Apply Online</a>
';
break;
}
}
//}
?>

            @if ($app_forms)
            <?php $pos=1 ?>
            @foreach($app_forms as $ekey => $evalue)

            <?php $pos++ ?>


@if(strpos($evalue->url, 'http')===0)

           <!-- <a href="{{$evalue->url }}" target="_blank" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">
            <span style="white-space: pre-line">{{ $evalue->caption }}</span>-->
            <?php $pos-- ?> <!--showing and counting only non-online applications -->

            </a>
            @else
            <a target="_blank" href="{{ $app_forms_uri.$evalue->url }}" class="btn btn-link fact-sheets-side-link">
              <span class="fa fa-file fact-sheets-icon"></span>
              <span style="white-space: pre-line">{{ $evalue->caption }}</span>
            </a>
            @endif


            @if ($pos === 3)
<!-- Trigger the modal with a button -->
<a href data-toggle="modal" data-target="#myModal" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">See More</a>


@if (!empty($programUrl))
</br>

<a target="_blank" href="<?php echo $programUrl; ?>" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">Program Website</a>
@endif

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Application Forms</h4>
      </div>
      <div class="modal-body">



<?php break;?>

            @endif

            @endforeach

            @foreach($app_forms as $ekey => $evalue) <!--Lynna Cekova: starting the loop again in order to print all application forms in the modal, not just the remaining ones -->
            @if(strpos($evalue->url, 'http')===0)

            <a href="{{$evalue->url }}" target="_blank" class="btn btn-link fact-sheet-button-fwd fact-sheets-side-link">
            <span style="white-space: pre-line">{{ $evalue->caption }}</span>
            </a>
            @else
            <a target="_blank" href="{{ $app_forms_uri.$evalue->url }}" class="btn btn-link fact-sheets-side-link">
              <span class="fa fa-file fact-sheets-icon"></span>
              <span style="white-space: pre-line">{{ $evalue->caption }}</span>
            </a>
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


            @endif
            @endif


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

        <hr class="fact-sheets-hr" />

        <h3 class="mobile-padding bold-h3">
          Frequently Asked Questions
        </h3>
        <div>
          @foreach(Meta::get(Loop::id(), $key = 'faqs-list', $single = true) as $key => $value)
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
  var phonereg = new RegExp("((^|[^0-9])(href=[\"']tel:)?((?:" + phonedef + ")[\"'][^>]*?>)?(" + phonedef + ")($|[^0-9]))","gi")

  //Created by Jon Meck at LunaMetrics.com - Version 1.0
  // http://www.lunametrics.com/blog/2014/01/16/phone-numbers-clickable-trackable-mobile-devices-javascript-google-tag-manager/

  function ReplacePhoneNumbers(oldhtml) {
      if (!oldhtml) { return; }
      var newhtml = oldhtml.replace("/href=['']callto:/gi",'href="tel:');
      newhtml = newhtml.replace(phonereg, function ($0, $1, $2, $3, $4, $5, $6) {
          if ($3) return $1;
          else if ($4) return $2+$4+$5+$6;
          else return $2+"<a href='tel:"+$5.replace(spechars,"")+"' onclick=\"_gaq.push(['_trackEvent','Phone Call Tracking','Click/Touch']);\" >"+$5+"</a>"+$6; });
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
