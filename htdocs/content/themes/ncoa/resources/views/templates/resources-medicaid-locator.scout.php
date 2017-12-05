@extends('layouts.main')

@section('main')
<script>
  window.webServiceUrl = '{{$webServiceUrl}}';
  if (window.name == '') {
    window.name = '{{microtime(true)}}';
  }
</script>

<span id="map-tip"></span>
<div class="container fact-sheet-alt">
  <div class="page-top-headline">
    <a href="/resources" class="btn-link"><i class="fa fa-chevron-left" aria-hidden="true"></i>Back</a>
    <h1>Program Details</h1>
  </div>
  <div class="card">
    <div class="card-nested row">
      <div class="col-xs-12">
        <div class="fact-sheet-icon-hdr">
        	<span class="icon-block-food pull-left"></span>
          <div class="pull-left">
            <div class="fact-sheets-header fact-sheets-top-header"><h2>Food &amp; Nutrition</h2></div>
            <div class="fact-sheets-header fact-sheets-bottom-header"></div>
          </div>
        </div>
      </div>

      <div class="col-md-9">
        <h3 class="bold">Please type your zip code to determine your closest office</h3>
        <div ng-controller="mapZipLocator">
        	<form name="zipformlocator" ng-submit="submit()">
        		<p><input type="text" placeholder="Zip Code" name="zipcodelocator" ng-model="zip" ng-pattern='/^(\d{5}(-\d{4})?|[A-Z]\d[A-Z] *\d[A-Z]\d)$/'/>
        		<small id="error-zip"  ng-model="errorZip" class="hide alert-danger">@{{ errorZip }}</small></p>
        		<button ng-click="submit()" type="button" id="zipbuton" class="btn btn-default">Search</button>

        	</form>
        </div>
      </div>
      <div class="col-md-3 col-sm-12">
        <div class="results-options">
          <span class="fact-sheets-know">Did You Know?</span>
          <span class="fact-sheets-emphasis">Millions of people</span> in the United States are receiving benefits from SNAP today!
        </div>

        
      </div>

      <div class="col-xs-12">
        @include('partials.counties-map')
      </div>
    </div>
  </div>
</div>
@stop

