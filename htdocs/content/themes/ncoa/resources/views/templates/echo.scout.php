@extends('layouts.main')

@section('main')
<div class="container resources">
  <h1>Find My Benefits</h1>
  <div class="card">
    <div class="card-nested">
      <button class="btn btn-link btn-back btn-no-padding" ng-click="switchPage(prev)">Back to Your Results</button>
      <h2 class="page-header">Print Your Benefit Report</h2>
      <button ng-click="goScreening()" class="btn btn-primary">Print Your Benefit Report</button>
      <br/><br/>
      
      <h2>Benefit Program(s) Selected to Print in Your Report</h2>

      <div class="benefits-print-options">

        <div class="print-controls">
          <span id="print-page-select-all" class="print-control" ng-click="selectAll()">Select All</span>
          <span>|</span>
          <span id="print-page-deselect-all" class="print-control" ng-click="deselectAll()">Clear</span>
        </div>

        <div class="benefits-print-options-checkboxes">

          <div class="benefits-category">
            <h3>Medication Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_1" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_1">
                <span></span>
                Medicare Prescription Drug Coverage for People with Limited Incomes and Resources
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

          <div class="benefits-category">
            <h3>Healthcare Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_2" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_2">
                <span></span>
                Medicaid
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_3" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_3">
                <span></span>
                Medicaid Spend-down Program
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_4" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_4">
                <span></span>
                EyeCare America's Online Referral Center
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_5" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_5">
                <span></span>
                Medicare Savings Programs
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_6" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_6">
                <span></span>
                Health Centers for Primary Health Care and Dental Services
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

          <div class="benefits-category">
            <h3>Income Assistance Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_7" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_7">
                <span></span>
                Supplemental Security Income
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

          <div class="benefits-category">
            <h3>Food and Nutrition Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_71" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_71">
                <span></span>
                Elderly Nutrition Program - Home Delivered Meals
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

          <div class="benefits-category">
            <h3>Housing and Utilities Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_72" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_72">
                <span></span>
                National Flood Insurance Program (NFIP)
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_73" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_73">
                <span></span>
                Neighbor to Neighbor Program
              </label>
            </div><!--/.checkbox-->

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_74" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_74">
                <span></span>
                Weatherization Assistance Program
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

          <div class="benefits-category">
            <h3>Tax Relief Benefit</h3>

            <div class="checkbox ng-scope">
              <input type="checkbox" id="example_75" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
              <label for="example_75">
                <span></span>
                Real Estate Tax Relief for Elderly and Disabled
              </label>
            </div><!--/.checkbox-->
          </div><!--/.benefits-category-->

        </div><!--/.benefits-print-options-checkboxes-->

        <div class="advanced-print-options accordian-wrap">
          <h2 class="accordian-trigger">Advanced Print Options</h2>
          <p>Additional options to further customize your report.</p>

          <div class="accordian-content" style="display: none;">
            <div class="print-controls">
              <span id="print-page-select-all-advanced" class="print-control" ng-click="selectAllAdvanced()">Select All</span>
              <span>|</span>
              <span id="print-page-deselect-all-advanced" class="print-control" ng-click="deselectAllAdvanced()">Clear</span>
            </div>

            <div class="advanced-print-options-checkboxes">

              <div class="benefits-category">
                <h3>Report Sections to Include</h3>

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_8" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_8">
                    <span></span>
                    Cover Page and Introduction
                  </label>
                </div><!--/.checkbox-->

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_9" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_9">
                    <span></span>
                    Table of Contents (PDF version only)
                  </label>
                </div><!--/.checkbox-->

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_10" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_10">
                    <span></span>
                    Additional Information
                  </label>
                </div><!--/.checkbox-->
              </div><!--/.benefits-category-->

              <div class="benefits-category">
                <h3>Report Formatting</h3>

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_11" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_11">
                    <span></span>
                    Insert Page Breaks Between Sections and Programs (PDF version only)
                  </label>
                </div><!--/.checkbox-->
              </div><!--/.benefits-category-->

              <div class="benefits-category">
                <h3>Program Information to Include</h3>

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_12" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_12">
                    <span></span>
                    Program Descriptions
                  </label>
                </div><!--/.checkbox-->

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_13" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_13">
                    <span></span>
                    Local Office Locations
                  </label>
                </div><!--/.checkbox-->

                <div class="checkbox ng-scope">
                  <input type="checkbox" id="example_14" class="ng-untouched ng-valid ng-valid-required ng-not-empty ng-dirty ng-valid-parse">
                  <label for="example_14">
                    <span></span>
                    Materials to have Available when Applying
                  </label>
                </div><!--/.checkbox-->
              </div><!--/.benefits-category-->

            </div><!--/.advanced-print-options-categories-->
          </div><!--/.accordian-content-->
        </div><!--/.advanced-print-options-->
        <button ng-click="goScreening()" class="btn btn-primary">Print Your Benefit Report</button>
      </div><!--/.benefits-print-options-->

    </div><!--/.card-nested-->
  </div><!--/.card-->

  <button class="btn btn-link btn-back btn-no-padding btn-margin-bottom" ng-click="switchPage(prev)">Back to Your Results</button>

</div><!--/.container-->
@stop
