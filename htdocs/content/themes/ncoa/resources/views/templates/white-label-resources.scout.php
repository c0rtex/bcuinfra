@extends('layouts.white-label-main')

@section('main')
<script>
  window.webServiceUrl = '{{$webServiceUrl}}';
</script>
<div class="container resources" ng-controller="resourcesFormsController">
  <h1>Resources &amp; Forms</h1>
  <div class="card">
    <div class="card-nested">

      <h2 class="page-header">What can we help you find?</h2>

      <p>We have program fact sheets and over 600 application forms for programs that can help you pay for prescription drugs and other health-care costs, including state pharmacy programs, patient assistance programs, and your state's Medicaid and Medicare Savings Programs.</p>

<div class="resources-forms-tabs">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-tabs-label">Search by</li>
    <li role="presentation" class="active">
      <a href="#programcategory" aria-controls="programcategory" role="tab" data-toggle="tab">Program Category</a>
    </li>
    <li role="presentation">
      <a href="#drugname" aria-controls="drugname" role="tab" data-toggle="tab">Drug Name</a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="programcategory">

      <p>BenefitsCheckUp strives to maintain the most current database of programs and application forms possible. Select your search options below in order to get relevant program information  about benefits that are available in your state. <strong>You must select a state AND the category you are interested in.</strong></p>

      <div class="white-label-resources-category-form">
        <form class="" method="POST" accept-charset="UTF-8">   
          <div class="form-group">
            <label for="state-selection">Filter By State</label>
            <select class="form-control" name="state-selection" ng-change="selectState()" ng-model="values.state" id="white-label-resources-state">
              <option value="">-- choose an option --</option>
              @foreach ($states as $state_code => $state)
              <option value="{{ $state_code }}">{{ $state }}</option>
              @endforeach
            </select>
          </div>
          <div class="form-group form-item">
            <label for="state-selection">Filter By Category</label>
            <select class="form-control" name="category-selection" id="white-label-resources-category" ng-model="values.category" ng-disabled="disallowCategory()">
              <option value="">-- choose an option --</option>
              @foreach ($categories as $key => $category)
              <option value="{{ $key }}">{{ $category }}</option>
              @endforeach
            </select>
          </div>
          <div class="form-item">
            <button type="submit" class="btn btn-primary" id="white-label-resources-button" ng-disabled="disallowSearch()" ng-click="search()">Search</button>
          </div>
        </form>
      </div><!--/.white-label-resources-category-form-->

      <div class="resources-results">

        <h3>Available Programs</h3>
        <div class="sort-nav">
          <div class="sort-nav__label">Sort by name:</div>
          <div class="sort-nav__options">
            <a href="#" class="is-active">A-Z</a>
            <a href="#">Z-A</a>
          </div>
        </div>

        <ul>
          <li ng-repeat="result in results | orderBy: 'result.tag_name'">
            <h4>@{{result.prg_nm}}</h4>
            <p><a href="@{{result.string}}">@{{result.tag_name}}</a></p>
          </li>
        </ul>
        
        <!--<div class="ncoa-pagination-container"> 
          <ul class="ncoa-pagination">
            <li class="page-left"><a href="#" ng-click="showPage(currentPage-1)"><i class="fa fa-chevron-left" aria-hidden="true"></i></a></li>
            <li class="page-nums ng-binding">1 of 1</li>
            <li class="page-right"><a href="#" ng-click="showPage(currentPage+1)"><i class="fa fa-chevron-right" aria-hidden="true"></i></a></li>
          </ul>
        </div>-->
      </div>
    </div>
    <div role="tabpanel" class="tab-pane" id="drugname">

      <div class="drug-name-container">
        <p>Select the name of your medication then click “Add to My List.” If you clicked on a drug name by mistake, click it again to remove the blue highlight. After you click “Add to My List” the medication will appear on the list in the box on the right. To remove a medication from that list, select the name then click “Remove from My List.”</p>

        <div class="med-selector row">
          <div class="col-xs-12 add-list">

            <div class="ms-selectable">
              <p class="bold">Available Medications</p>
              <input type="text" class="form-control" autocomplete="off" placeholder="Search...">
              <ul class="ms-list" tab-index="-1">
                <li class="ms-elem-selectable" id="3242-selectable"><span>abacavir sulfate</span></li>
                <li class="ms-elem-selectable" id="3122992-selectable"><span>abacavir sulfate/lamivudine</span></li>
                <li class="ms-elem-selectable" id="3243-selectable"><span>abacavir sulfate/lamivudine/zidovudine</span></li>
              </ul>
              <button class="btn btn-secondary add">Add to My List</button>
            </div>

            <div class="ms-selection">
              <p class="bold">My Medication List</p>
              <ul class="ms-list" tab-index="-1">
                <li class="ms-elem-selection" id="3242-selection" style="display: none;"><span>abacavir sulfate</span></li>
                <li class="ms-elem-selection" id="3122992-selection" style="display: none;"><span>abacavir sulfate/lamivudine</span></li>
                <li class="ms-elem-selection" id="3243-selection" style="display: none;"><span>abacavir sulfate/lamivudine/zidovudine</span></li>
              </ul>
              <button class="btn btn-secondary remove" disabled>Remove from My List</button>
            </div>

          </div>
        </div>

        <div class="drug-name-container__btn">
          <a href="." class="btn btn-primary">Search</a>
        </div>
      </div><!--/.drug-name-container-->

    </div>
  </div>

</div>


    </div>
  </div>
</div><!--/.container-->
@stop
