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
          <div class="pull-left">
          	<span class="icon-block pull-left">
            	<img src="/content/uploads/2016/05/category_food-1.svg" class="attachment-full size-full" alt="Basket of Food">
            </span>
            <div class="fact-sheets-header fact-sheets-top-header">Food &amp; Nutrition</div>
            <div class="fact-sheets-header fact-sheets-bottom-header"><h1>Supplemental Nutrition Assistance Program (SNAP)</h1></div>
          </div>
        </div>
      </div>

      <div class="col-md-9">
        <p>The Supplemental Nutrition Assistance Program (SNAP) (the new name for the federal Food Stamp Program) helps low-income individuals and families buy the food they need for good health. Although SNAP is the national name, your state may use a different name.</p>
        <p>Use this map to learn more about SNAP and find application forms to apply for this benefit.</p>

        {{ Form::open('/resources/details', 'post', false, [
        'class' => 'form-inline state-selection'
        ])
        }}
        <p class="bold">Select your state from the map or list to find out more</p>
        <div class="form-group">
          <label class="sr-only" for="state-selection">Select State</label>
          <select class="form-control" name="state-selection" id="state-selection" ng-model="mapState" ng-change="stateChange()" state-selection>
            <option value="">-- Select --</option>
            @foreach($states as $fact_sheet_url => $value)
            <option value="{{ $fact_sheet_url }}">{{ $value }}</option>
            @endforeach
          </select>
        </div>
        <button type="submit" class="btn btn-primary">Continue</button>
        {{ Form::close() }}
      </div>
      <div class="col-md-3 col-sm-12">
        <div class="results-options">
          <span class="fact-sheets-know">Did You Know?</span>
          <span class="fact-sheets-emphasis">Millions of people</span> in the United States are receiving benefits from SNAP today!
        </div>
      </div>

      <div class="col-xs-12">
        @include('partials.map')
      </div>
    </div>
  </div>
</div>
@stop
@section('misc-scripts')
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/snapmap.js"></script>
@stop
