@extends('layouts.white-label-main')

@section('main')
<script>
  window.appFormsUrl = '{{$appFormsUri}}';
  window.webServiceUrl = '{{$webServiceUrl}}';
  window.drugsList = JSON.parse('{{$drugsList}}');
</script>
<div class="container resources" ng-controller="resourcesFormsController">
  <h1>Resources &amp; Forms</h1>
  <div class="card">
    <div class="card-nested">

      <h2 class="page-header">What can we help you find?</h2>

      <p>We have program fact sheets and over 1800 application forms for programs that can help you pay for food, prescription drugs, and other health care costs including: State Pharmaceutical Assistance Programs (SPAP), Patient Assistance Programs (PAP), and your state's Medicaid and Medicare Savings Programs (MSP).</p>

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

      <p>BenefitsCheckUp&reg; strives to maintain the most current database of programs and application forms possible. This resource gives you quick access to application forms and other helpful program information. Select your search options below to find benefits that are available in your state. <strong>You must select a state AND the category you are interested in.</strong></p>

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

      <div id="program-category-results" class="resources-results">

        <h3>Available Programs</h3>
        <!--<div ng-if="results.length > 0" class="sort-nav">
          <div class="sort-nav__label">Sort by name:</div>
          <div class="sort-nav__options">
            <a href="#" class="is-active">A-Z</a>
            <a href="#">Z-A</a>
          </div>
        </div>-->

        <ul ng-if="results.length > 0">
          <li ng-repeat="result in results | orderBy:'result.name'">
            <a ng-href="/fact-sheets/factsheet_@{{result.code}}?state=@{{values.state}}&short=n" target="_blank" class="btn-link btn-underline"><ng-label text="@{{result.prg_nm}}"></ng-label></a>
            <p>@{{result.prg_desc}}</p>
            <ul ng-if="result.forms.length > 0">
              <li ng-repeat="form in result.forms | limitTo:4">
                <a ng-if="result.forms.length <= 3 || !$last" ng-href="@{{formatUrl(form.url,form.type)}}" target="_blank">@{{form.caption}}</a>
                <a ng-if="result.forms.length > 3 && $last" data-toggle="modal" data-target="#applications-@{{result.code}}" href="">View Additional Applications</a>
              </li>
            </ul>

            <div ng-if="result.forms.length > 3" id="applications-@{{result.code}}" class="modal fade" role="dialog">
              <!-- View more dialog: @{{result.prg_nm}} -->
              <div class="modal-dialog">

                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Application Forms for @{{result.prg_nm}}</h4>
                  </div>
                  <div class="modal-body">
                    <div ng-repeat="form in result.forms">
                      <a href="@{{formatUrl(form.url,form.type)}}" target="_blank" class="btn btn-link fact-sheets-side-link">
                        <span style="white-space: pre-line">@{{form.caption}}</span>
                      </a><br />
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
              <!-- End view more dialog -->
            </div>

          </li>
        </ul>

        <div ng-if="results.length == 0">
          <p>No programs were found.</p>
        </div>
        
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
        <p>
          Many pharmaceutical companies offer assistance programs that can help you pay for your medications. However, not all prescription medications have assistance programs. Type the name of your medication in the search box or scroll up and down to browse the list below. Both generic and brand name medications are listed. 
        </p>
        <p>
          Select the name of your medication then click "Add to My List." If you clicked on a drug name by mistake, click it again to remove the blue highlight. After you click "Add to My List" the medication will appear on the list in the box on the right. To remove a medication from that list, select the name then click "Remove from My List."
        </p>

        <medication-selector-resources></medication-selector-resources>

        <div class="drug-name-container__btn">
          <a ng-click="searchDrugs()" class="btn btn-primary">Search</a>
        </div>
      </div><!--/.drug-name-container-->

      <div id="drugs-results" class="resources-results">

        <h3>Available Programs</h3>

        <ul ng-if="drugPrograms">
          <li ng-repeat="(key, value) in drugPrograms">
            <a target="_blank" ng-href="/fact-sheets/factsheet_@{{value.program.code}}/?short=n" class="btn-link btn-underline"><ng-label text="@{{value.program.prg_nm}}"></ng-label></a>
            <p>@{{value.program.prg_desc}}</p>
            <ul ng-if="value.program.forms.length > 0">
              <li ng-repeat="form in value.program.forms | limitTo:4">
                <a ng-if="value.program.forms.length <= 3 || !$last" ng-href="@{{formatUrl(form.url,form.type)}}" target="_blank">@{{form.caption}}</a>
                <a ng-if="value.program.forms.length > 3 && $last" data-toggle="modal" data-target="#drug-applications-@{{result.code}}" href="">View Additional Applications</a>
              </li>

              <div ng-if="value.program.forms.length > 3" id="drug-applications-@{{result.code}}" class="modal fade" role="dialog">
                <!-- View more dialog: @{{value.program.prg_nm}} -->
                <div class="modal-dialog">

                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                      <h4 class="modal-title">Application Forms for @{{value.program.prg_nm}}</h4>
                    </div>
                    <div class="modal-body">
                      <div ng-repeat="form in value.program.forms">
                        <a href="@{{formatUrl(form.url,form.type)}}" target="_blank" class="btn btn-link fact-sheets-side-link">
                          <span style="white-space: pre-line">@{{form.caption}}</span>
                        </a><br />
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
                <!-- End view more dialog -->
              </div>

            </ul>
            <h4>Associated Medication</h4>
            <ul class="associated-meds">
              <li ng-repeat="drug in value.drugs">@{{drug.display}} <em>(@{{drug.type}})</em></li>
            </ul>
          </li>
        </ul>

        <div ng-if="!drugPrograms">
          <p>No programs were found.</p>
        </div>
      </div>

    </div>
  </div>

</div>


    </div>
  </div>
</div><!--/.container-->
@stop
