@extends('layouts.main')

@section('main')
  @loop

  <div class="page-wrapper">

<script>
	window.webServiceUrl = 'http://leviathantech.com:8500';
	window.defaultLangsFull = JSON.parse('{"bcuqc_category_income":"Thank you for taking the time to answer these questions. At this time, there are no income assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_nutrition":"Thank you for taking the time to answer these questions. At this time, there are no nutrition assistance or food\/meal supplement programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_education":"Thank you for taking the time to answer these questions. At this time, there are no education programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_discounts":"Thank you for taking the time to answer these questions. At this time, there are no discount programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_employment":"Thank you for taking the time to answer these questions. At this time, there are no employment assistance or volunteer programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_utility":"Thank you for taking the time to answer these questions. At this time, there are no housing or utilities programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_medicaid":"Thank you for taking the time to answer these questions. At this time, there are no health care programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_rx":"Thank you for taking the time to answer these questions. At this time, there are no medication or patient assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_property_taxrelief":"Thank you for taking the time to answer these questions. At this time, there are no property tax relief or other tax relief programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_veteran":"Thank you for taking the time to answer these questions. At this time, there are no veteran programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_other_assistance":"Thank you for taking the time to answer these questions. At this time, there are no counseling, information, legal, advocacy, or other assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_transportation":"Thank you for taking the time to answer these questions. At this time, there are no transportation programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis."}');
	window.defaultLangsPre = JSON.parse('{"bcuqc_category_income":"Thank you for taking the time to answer these questions. At this time, there are no income assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_nutrition":"Thank you for taking the time to answer these questions. At this time, there are no nutrition assistance or food\/meal supplement programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_education":"Thank you for taking the time to answer these questions. At this time, there are no education programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_discounts":"Thank you for taking the time to answer these questions. At this time, there are no discount programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_employment":"Thank you for taking the time to answer these questions. At this time, there are no employment assistance or volunteer programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_utility":"Thank you for taking the time to answer these questions. At this time, there are no housing or utilities programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_medicaid":"Thank you for taking the time to answer these questions. At this time, there are no health care programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.However, you should keep going to the full questionnaire. By answering a few more questions, we can better compare your situation in more detail with the programs we have in our database. Therefore, you could be eligible for programs that were initially not available to you. This is the case because many benefit programs have complex rules that provide various disregards and by giving us a just a little more information, we can be more concise in determining your eligibility for these programs. For example, many states have programs for people who have a disability and are working, or for people who have very high medical expenses. These programs could not be fully evaluated in the quick screening that you just completed. ","bcuqc_category_rx":"Thank you for taking the time to answer these questions. At this time, there are no medication or patient assistance programs available that match the information you provided.However, you should keep going to the full questionnaire. By answering a few more questions, we can better compare your situation in more detail with the programs we have in our database. Therefore, you could be eligible for programs that were initially not available to you. This is the case because many benefit programs have complex rules that provide various disregards and by giving us a just a little more information, we can be more concise in determining your eligibility for these programs. In addition, there are certain programs that can provide assistance depending on the medication you take and you can only get this benefit if you keep going.","bcuqc_category_property_taxrelief":"Thank you for taking the time to answer these questions. At this time, there are no property tax relief or other tax relief programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_veteran":"Thank you for taking the time to answer these questions. At this time, there are no veteran programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_other_assistance":"Thank you for taking the time to answer these questions. At this time, there are no counseling, information, legal, advocacy, or other assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.","bcuqc_category_transportation":"Thank you for taking the time to answer these questions. At this time, there are no transportation programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis."}');
	if (window.name == '') {
		window.name = '1497039557.2612';
	}
</script>

<!-- <div ng-view></div> -->
<div class="container">
	<!-- uiView: --><div ui-view="" class="ng-scope"><h1 class="ng-scope">Find My Benefits</h1>
<div class="card questionnaire ng-scope">
  <div class="card-nested">
    <div breadcrumb="" class="breadcrumbs ng-hide" ng-hide="hideBreadCrumbs"><div class="crumb-trails">
	<div class="btn-group btn-breadcrumb" ng-class="currentState">
		<!-- ngRepeat: page in pages --><div ng-repeat="page in pages" class="bc-text btn btn-default ng-scope">
			<span data-title="Basics" data-index="1"><i class="glyphicon glyphicon-ok"></i></span>
		</div><!-- end ngRepeat: page in pages --><div ng-repeat="page in pages" class="bc-text btn btn-default ng-scope">
			<span data-title="Health" data-index="2"><i class="glyphicon glyphicon-ok"></i></span>
		</div><!-- end ngRepeat: page in pages --><div ng-repeat="page in pages" class="bc-text btn btn-default ng-scope">
			<span data-title="Household" data-index="3"><i class="glyphicon glyphicon-ok"></i></span>
		</div><!-- end ngRepeat: page in pages --><div ng-repeat="page in pages" class="bc-text btn btn-default ng-scope">
			<span data-title="Finances" data-index="4"><i class="glyphicon glyphicon-ok"></i></span>
		</div><!-- end ngRepeat: page in pages --><div ng-repeat="page in pages" class="bc-text btn btn-default ng-scope">
			<span data-title="Results" data-index="5"><i class="glyphicon glyphicon-ok"></i></span>
		</div><!-- end ngRepeat: page in pages -->
    </div>
</div></div>
    <div class="row">
      <div class="col-xs-12 col-md-9">
        <!-- Views -->
        <!-- uiView: --><div ui-view="" class="ng-scope"><header class="visible-print-block print-header ng-scope">
	<img src="/content/themes/ncoa/resources/assets/images/BCU-logo.svg" alt="National Council on Aging: Benefits Checkup" class="pull-left print-logo">
	<div class="pull-right"><span>www.benefitscheckup.org</span></div>
	<div class="clearfix"></div>
	<hr class="fact-sheets-hr">
</header>
<!--Results-->
<div class="results card-panel ng-scope">
	<h2 class="page-header">Congratulations! Here are your results.</h2>
	<div class="results-tally">
		<!-- ngIf: foundCount == 1 -->
		<!-- ngIf: foundCount > 1 || foundCount == 0 --><span ng-if="foundCount > 1 || foundCount == 0" class="ng-scope">There are</span><!-- end ngIf: foundCount > 1 || foundCount == 0 -->
		<span class="odometer odometer-auto-theme"><div class="odometer-inside"><span class="odometer-digit"><span class="odometer-digit-spacer">8</span><span class="odometer-digit-inner"><span class="odometer-ribbon"><span class="odometer-ribbon-inner"><span class="odometer-value">1</span></span></span></span></span><span class="odometer-digit"><span class="odometer-digit-spacer">8</span><span class="odometer-digit-inner"><span class="odometer-ribbon"><span class="odometer-ribbon-inner"><span class="odometer-value">5</span></span></span></span></span></div></span>
		<!-- ngIf: foundCount == 1 -->
		<!-- ngIf: foundCount > 1 || foundCount == 0 --><span ng-if="foundCount > 1 || foundCount == 0" class="ng-scope"><strong>benefit programs</strong> that may be right for you.</span><!-- end ngIf: foundCount > 1 || foundCount == 0 -->
	</div>

		<p>Based on the information you provided, you may be eligible for these programs or may be interested in getting more information about them. Select a category to learn more:</p>

    <div class="mb-30">
      <button class="btn btn-primary" data-toggle="modal" data-target="#print-modal">Print Your Benefit Report</button>
      <span class="small-text">You have the option to choose what to print in the sections below.</span>
    </div>


		<div class="more-benefits">
      <div class="program-toggle-controls">
        <div class="program-expand-all">Expand All</div>
        <span>|</span>
        <div class="program-collapse-all">Collapse All</div>
      </div>
			<!-- ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program active" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg" width="55" height="55" alt="Medication" title="Medication" src="/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg">
        <!-- ngIf: found_program.count==1 --><span ng-if="found_program.count==1" class="ng-binding ng-scope">Medication Benefits: 1 Program</span><!-- end ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0" style="display: block;">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">FamilyWize Prescription Savings Program</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li style="height: 100%;">
                <div class="programs-checkbox-wrapper" style="
    position: relative;
    top: 0;
">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/rxcard_fd_familywize_rx_savings/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program active" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_health.svg" width="55" height="55" alt="Health Care" title="Health Care" src="/content/themes/ncoa/resources/assets/images/categories/category_health.svg">
        <!-- ngIf: found_program.count==1 --><span ng-if="found_program.count==1" class="ng-binding ng-scope">Health Care Benefits: 1 Program</span><!-- end ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0" style="display: block;">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">VA's Health Care System</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/health_fd_va_health_care_system/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_income.svg" width="55" height="55" alt="Income Assistance" title="Income Assistance" src="/content/themes/ncoa/resources/assets/images/categories/category_income.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Income Assistance Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no income assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_food.svg" width="55" height="55" alt="Food &amp; Nutrition" title="Food &amp; Nutrition" src="/content/themes/ncoa/resources/assets/images/categories/category_food.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Food &amp; Nutrition Benefits: 5 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Elderly Nutrition Program - Congregate or Group Meals</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/foodsupp_fd_congregate_group/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Elderly Nutrition Program - Home Delivered Meals</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/foodsupp_fd_home_delivered_meal/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Commodity Supplemental Food Program (CSFP)</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/foodsupp_la_commodity_supp/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Senior Farmers' Market Nutrition Program</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/foodsupp_fd_sfmnp/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">The Emergency Food Assistance Program (TEFAP)</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/foodsupp_la_tefap/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_housing.svg" width="55" height="55" alt="Housing &amp; Utilities" title="Housing &amp; Utilities" src="/content/themes/ncoa/resources/assets/images/categories/category_housing.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Housing &amp; Utilities Benefits: 4 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Weatherization Assistance Program</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/utility_fd_weatherization_assist/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Lifeline</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/utility_fd_lifeline_link_up/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">SafeLink Wireless®</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/utility_la_safelink_wireless/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Assurance Wireless®</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/utility_la_assurance_wireless/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg" width="55" height="55" alt="Tax Relief" title="Tax Relief" src="/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg">
        <!-- ngIf: found_program.count==1 --><span ng-if="found_program.count==1" class="ng-binding ng-scope">Tax Relief Benefits: 1 Program</span><!-- end ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Retirement Income Exemption from Taxation</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/taxrelief_la_annual_retire_incom/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg" width="55" height="55" alt="Veterans" title="Veterans" src="/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Veterans Benefits: 3 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 --><div class="programs-container ng-scope" ng-if="found_program.count>0">
        <!-- ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Veterans' Home Loans</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/veteran_fd_veterans_home_loans/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">State Benefits for Veterans</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/veteran_la_veterans_affairs/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs --><ul class="programs ng-scope" ng-repeat="program in found_program.programs">
            <li>
                <h4 ng-bind-html="program.name_display | unsafe" class="ng-binding">Veterans Choice Program</h4>

                <div-program-desc program_code="program.code" class="ng-isolate-scope">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div-program-desc>
            </li>
            <li>
                <div class="programs-checkbox-wrapper">
                  <div class="checkbox">
                    <input type="checkbox" ng-value="y" name="" id="" ng-model="questionnaire.request.basics[receive.id]" class="ng-pristine ng-untouched ng-valid ng-empty">
                    <label for="" class="ng-binding"><span></span></label>
                  </div>
                  <span>Print in report</span>
                </div>

                <button ui-sref="fact-sheets({programCode:program.code,stateId:stateId,zipcode:zipcode,short:short,elegible:elegible})" class="btn btn-secondary btn-get-info" href="#/fact-sheets/veteran_fd_choice_program/LA/n/70119/n">Learn How to Apply</button>
            </li>
        </ul><!-- end ngRepeat: program in found_program.programs -->
    </div><!-- end ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_employment.svg" width="55" height="55" alt="Employment" title="Employment" src="/content/themes/ncoa/resources/assets/images/categories/category_employment.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Employment Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no employment assistance or volunteer programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg" width="55" height="55" alt="Transportation" title="Transportation" src="/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Transportation Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no transportation programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_education.svg" width="55" height="55" alt="Education" title="Education" src="/content/themes/ncoa/resources/assets/images/categories/category_education.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Education Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no education programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg" width="55" height="55" alt="Discount" title="Discount" src="/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Discount Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no discount programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><span ng-repeat="found_program in found_programs | orderBy:'sort'" class="ng-scope">
				<div-programs-categorye short="n" found_program="found_program" elegible="n" class="ng-isolate-scope"><!-- Temporary Echo&Co duplicate for testing program category design on final restults page -->

<section class="program" slide-down="">
    <div class="program-header hover-shade">

        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg" width="55" height="55" alt="Other Assistance" title="Other Assistance" src="/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg">
        <!-- ngIf: found_program.count==1 -->
        <!-- ngIf: found_program.count>1 || found_program.count==0 --><span ng-if="found_program.count>1 || found_program.count==0" class="ng-binding ng-scope">
            Other Assistance Benefits: 0 Programs
        </span><!-- end ngIf: found_program.count>1 || found_program.count==0 -->

    </div>
    <!-- ngIf: found_program.count>0 -->
    <!-- ngIf: found_program.count<1 --><div class="programs-container ng-scope" ng-if="found_program.count<1">
        <div class="programs">
            <!-- ngIf: short=='n' --><p ng-if="short=='n'" class="ng-binding ng-scope">Thank you for taking the time to answer these questions. At this time, there are no counseling, information, legal, advocacy, or other assistance programs available that match the information you provided. Please try again at a later date as we update our database with new programs on a regular basis.</p><!-- end ngIf: short=='n' -->
            <!-- ngIf: short=='y' -->
        </div>
    </div><!-- end ngIf: found_program.count<1 -->
</section>
</div-programs-categorye>
			</span><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' -->
		</div>

    <button class="btn btn-primary" data-toggle="modal" data-target="#print-modal">Print Your Benefit Report</button>
	</span><!-- end ngIf: found_programs.length>0 -->
</div>
</div>
      </div>

      <!-- Profile Section-->
      <!-- ngIf: isResults --><div ng-if="isResults" class="col-xs-12 col-md-3 profile-section ng-scope" profile=""><!--<div class="results-options" ng-show="programs_calculated">
  <ul class="result-options-list">
    <li data-toggle="modal" data-target="#print-modal"><span class="fa fa-print"></span>Print Results</li>
    <li data-toggle="modal" data-target="#save-modal"><span class="fa fa-floppy-o"></span>Save Results</li>
    <li data-toggle="modal" data-target="#email-modal"><span class="fa fa-envelope-o"></span>Email Results</li>
  </ul>
</div>-->

<section class="prescreen-profile">
  <img src="/content/themes/ncoa/resources/assets/images/prescreen/Prescreen_profile.svg" alt="Profile Image" class="profile-image">
  <p>Search Details</p>
</section>
<section>
  <ul class="profile-list">
    <li class="ng-binding"><strong>Location: </strong>New Orleans, LA 70119</li>
    <li class="ng-binding"><strong>Relationship to You: </strong>Spouse</li>
    <li class="ng-binding"><strong>Date of Birth: </strong>April 1951</li>
    <li class="ng-binding"><strong>Marital status: </strong>Married Living Separately</li>
    <li class="ng-binding"><strong>Veteran: </strong>Yes</li>
    <li class="categoreis"><strong>Benefits Categories: </strong>
      <!-- ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' --><!-- ngIf: !is_full_q --><!-- end ngRepeat: benefit in screenData.benefits_categories | orderBy:'sort' -->
      <!-- ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Medication</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Health Care</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Income Assistance</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Food &amp; Nutrition</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Housing &amp; Utilities</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Tax Relief</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Veterans</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Employment</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Transportation</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Education</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Discount</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' --><!-- ngIf: is_full_q --><span ng-if="is_full_q" ng-repeat="found_program in found_programs_categories | orderBy:'sort'" class="ng-binding ng-scope">Other Assistance</span><!-- end ngIf: is_full_q --><!-- end ngRepeat: found_program in found_programs_categories | orderBy:'sort' -->
    </li>
  </ul>
</section>

<!--<span data-toggle="modal" data-target="#details-modal" class="btn-link view-details" ng-show="showOptions">View all details <strong>&gt;</strong></span>-->

<div class="modal fade" id="print-modal" tabindex="-1" role="dialog" aria-labelledby="print-label" style="display: none;">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h1 class="modal-title modal-h1" id="print-label">
          Print My Results
        </h1>
      </div>
      <div class="modal-body">
        <div class="modal-tagline">
          <p>Select up to 10 benefit program fact sheets at a time that you would like to download and print.</p>
          <p><span id="print-modal-select-all" class="modal-inline bold" ng-click="selectAll()">Select All</span> /
            <span id="print-modal-deselect-all" class="modal-inline bold" ng-click="deselectAll()">Deselect All</span></p>
        </div>

        <div id="modalError" class="modal fade" tabindex="-1" role="dialog">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h3 class="modal-title">Print Report</h3>
              </div>
              <div class="modal-body">
                <!-- ngIf: noSlugs -->
                <!-- ngIf: limitReached -->
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" ng-click="closeErrorModal()">Close</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <section class="form-group checkbox-stacked program-list-print">
          <!-- ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Medication</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="rxcard_fd_familywize_rx_savings" id="rxcard_fd_familywize_rx_savings" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="rxcard_fd_familywize_rx_savings"><span></span><ng-label text="FamilyWize Prescription Savings Program" class="ng-isolate-scope">FamilyWize Prescription Savings Program</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Health Care</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="health_fd_va_health_care_system" id="health_fd_va_health_care_system" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="health_fd_va_health_care_system"><span></span><ng-label text="VA's Health Care System" class="ng-isolate-scope">VA's Health Care System</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Food &amp; Nutrition</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="foodsupp_fd_congregate_group" id="foodsupp_fd_congregate_group" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="foodsupp_fd_congregate_group"><span></span><ng-label text="Elderly Nutrition Program - Congregate or Group Meals" class="ng-isolate-scope">Elderly Nutrition Program - Congregate or Group Meals</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="foodsupp_fd_home_delivered_meal" id="foodsupp_fd_home_delivered_meal" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="foodsupp_fd_home_delivered_meal"><span></span><ng-label text="Elderly Nutrition Program - Home Delivered Meals" class="ng-isolate-scope">Elderly Nutrition Program - Home Delivered Meals</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="foodsupp_la_commodity_supp" id="foodsupp_la_commodity_supp" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="foodsupp_la_commodity_supp"><span></span><ng-label text="Commodity Supplemental Food Program (CSFP)" class="ng-isolate-scope">Commodity Supplemental Food Program (CSFP)</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="foodsupp_fd_sfmnp" id="foodsupp_fd_sfmnp" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="foodsupp_fd_sfmnp"><span></span><ng-label text="Senior Farmers' Market Nutrition Program" class="ng-isolate-scope">Senior Farmers' Market Nutrition Program</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="foodsupp_la_tefap" id="foodsupp_la_tefap" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="foodsupp_la_tefap"><span></span><ng-label text="The Emergency Food Assistance Program (TEFAP)" class="ng-isolate-scope">The Emergency Food Assistance Program (TEFAP)</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Housing &amp; Utilities</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="utility_fd_weatherization_assist" id="utility_fd_weatherization_assist" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="utility_fd_weatherization_assist"><span></span><ng-label text="Weatherization Assistance Program" class="ng-isolate-scope">Weatherization Assistance Program</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="utility_fd_lifeline_link_up" id="utility_fd_lifeline_link_up" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="utility_fd_lifeline_link_up"><span></span><ng-label text="Lifeline" class="ng-isolate-scope">Lifeline</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="utility_la_safelink_wireless" id="utility_la_safelink_wireless" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="utility_la_safelink_wireless"><span></span><ng-label text="SafeLink Wireless&amp;reg;" class="ng-isolate-scope">SafeLink Wireless®</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="utility_la_assurance_wireless" id="utility_la_assurance_wireless" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="utility_la_assurance_wireless"><span></span><ng-label text="Assurance Wireless&amp;reg;" class="ng-isolate-scope">Assurance Wireless®</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Tax Relief</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="taxrelief_la_annual_retire_incom" id="taxrelief_la_annual_retire_incom" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="taxrelief_la_annual_retire_incom"><span></span><ng-label text="Retirement Income Exemption from Taxation" class="ng-isolate-scope">Retirement Income Exemption from Taxation</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><div class="category ng-scope" ng-repeat="found_program in found_programs | orderBy:'sort'" ng-if="found_program.programs.length > 0">
            <h3 class="ng-binding">Veterans</h3>
            <!-- ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="veteran_fd_veterans_home_loans" id="veteran_fd_veterans_home_loans" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="veteran_fd_veterans_home_loans"><span></span><ng-label text="Veterans' Home Loans" class="ng-isolate-scope">Veterans' Home Loans</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="veteran_la_veterans_affairs" id="veteran_la_veterans_affairs" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="veteran_la_veterans_affairs"><span></span><ng-label text="State Benefits for Veterans" class="ng-isolate-scope">State Benefits for Veterans</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs --><div class="checkbox ng-scope" ng-repeat="program in found_program.programs">
              <input type="checkbox" ng-click="generatePrintUrl(true)" ng-model="slugs[program.code]" name="veteran_fd_choice_program" id="veteran_fd_choice_program" class="ng-pristine ng-untouched ng-valid ng-empty">
              <label for="veteran_fd_choice_program"><span></span><ng-label text="Veterans Choice Program" class="ng-isolate-scope">Veterans Choice Program</ng-label></label>
            </div><!-- end ngRepeat: program in found_program.programs -->
          </div><!-- end ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' --><!-- ngIf: found_program.programs.length > 0 --><!-- end ngRepeat: found_program in found_programs | orderBy:'sort' -->
        </section>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-link btn-underline pull-left" data-dismiss="modal">Cancel</button>
        <button type="button" ng-click="printReport()" class="btn btn-primary pull-right">Download and Print Report</button>
        <div class="clear-fix"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="save-modal" tabindex="-1" role="dialog" aria-labelledby="save-label">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title modal-h1" id="save-label">
          Save My Results
          <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </h1>
      </div>
      <div class="modal-body">
        <div class="modal-tagline">
          Select which Benefit Program Fact Sheets you would like to print. <span id="save-modal-select-all" class="modal-inline bold">Select All</span>
        </div>
        <section class="form-group checkbox-stacked">
          <div class="checkbox">
            <input type="checkbox" value="1" id="save-modal-cb-1" name="save-modal-cb-1">
            <label for="save-modal-cb-1"><span></span>Medicare</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="2" id="save-modal-cb-2" name="save-modal-cb-2">
            <label for="save-modal-cb-2"><span></span>Medicare Prescription Drug Plan (Part D)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="3" id="save-modal-cb-3" name="save-modal-cb-3">
            <label for="save-modal-cb-3"><span></span>Extra Help / LIS through Medicare Prescription Drug Coverage</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="4" id="save-modal-cb-4" name="save-modal-cb-4">
            <label for="save-modal-cb-4"><span></span>Medicaid</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="5" id="save-modal-cb-5" name="save-modal-cb-5">
            <label for="save-modal-cb-5"><span></span>Medicare Savings Programs (QMB, SLMB, or QI)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="6" id="save-modal-cb-6" name="save-modal-cb-6">
            <label for="save-modal-cb-6"><span></span>Supplemental Nutrition Assistance Program (SNAP)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="7" id="save-modal-cb-7" name="save-modal-cb-7">
            <label for="save-modal-cb-7"><span></span>Supplemental Security Income (SSI)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="8" id="save-modal-cb-8" name="save-modal-cb-8">
            <label for="save-modal-cb-8"><span></span>TRICARE</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="9" id="save-modal-cb-9" name="save-modal-cb-9">
            <label for="save-modal-cb-9"><span></span>Veteran's Health Care Benefits</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="10" id="save-modal-cb-10" name="save-modal-cb-10">
            <label for="save-modal-cb-10"><span></span>Low Income Home Energy Assistance Program (LIHEAP)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="11" id="save-modal-cb-11" name="save-modal-cb-11">
            <label for="save-modal-cb-11"><span></span>Public Housing</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="12" id="save-modal-cb-12" name="save-modal-cb-12">
            <label for="save-modal-cb-12"><span></span>Housing Choice Vouchers (Section 8)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="13" id="save-modal-cb-13" name="save-modal-cb-13">
            <label for="save-modal-cb-13"><span></span>Senior Community Service Employment Program (SCSEP)</label>
          </div>
        </section>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-link btn-underline pull-left" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary pull-right">Save Results</button>
        <div class="clear-fix"></div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
      $(document).ready(function () {
          $('#save-modal-select-all').click(function () {
              if ($('#save-modal-select-all').text() == 'Select All') {
                  $('#save-modal input').each(function () {
                      $(this).prop('checked', true);
                  });
                  $('#save-modal-select-all').text('Deselect All');
              } else {
                  $('#save-modal input').each(function () {
                      $(this).prop('checked', false);
                      $(this).removeProp('checked');
                  });
                  $('#save-modal-select-all').text('Select All');
              }
          });
      });
  </script>
</div>

<div class="modal fade" id="email-modal" tabindex="-1" role="dialog" aria-labelledby="email-label">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title modal-h1" id="email-label">
          Email My Results
          <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </h1>
      </div>
      <div class="modal-body">
        <div class="modal-tagline">
          Select which Benefit Program Fact Sheets you would like to print. <span id="email-modal-select-all" class="modal-inline bold">Select All</span>
        </div>
        <section class="form-group checkbox-stacked">
          <div class="checkbox">
            <input type="checkbox" value="1" name="email-modal-cb-1" id="email-modal-cb-1">
            <label for="email-modal-cb-1"><span></span>Medicare</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="2" name="email-modal-cb-2" id="email-modal-cb-2">
            <label for="email-modal-cb-2"><span></span>Medicare Prescription Drug Plan (Part D)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="3" name="email-modal-cb-3" id="email-modal-cb-3">
            <label for="email-modal-cb-3"><span></span>Extra Help / LIS through Medicare Prescription Drug Coverage</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="4" name="email-modal-cb-4" id="email-modal-cb-4">
            <label for="email-modal-cb-4"><span></span>Medicaid</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="5" name="email-modal-cb-5" id="email-modal-cb-5">
            <label for="email-modal-cb-5"><span></span>Medicare Savings Programs (QMB, SLMB, or QI)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="6" name="email-modal-cb-6" id="email-modal-cb-6">
            <label for="email-modal-cb-6"><span></span>Supplemental Nutrition Assistance Program (SNAP)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="7" name="email-modal-cb-7" id="email-modal-cb-7">
            <label for="email-modal-cb-7"><span></span>Supplemental Security Income (SSI)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="8" name="email-modal-cb-8" id="email-modal-cb-8">
            <label for="email-modal-cb-8"><span></span>TRICARE</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="9" name="email-modal-cb-9" id="email-modal-cb-9">
            <label for="email-modal-cb-9"><span></span>Veteran's Health Care Benefits</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="10" name="email-modal-cb-10" id="email-modal-cb-10">
            <label for="email-modal-cb-10"><span></span>Low Income Home Energy Assistance Program (LIHEAP)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="11" name="email-modal-cb-11" id="email-modal-cb-11">
            <label for="email-modal-cb-11"><span></span>Public Housing</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="12" name="email-modal-cb-12" id="email-modal-cb-12">
            <label for="email-modal-cb-12"><span></span>Housing Choice Vouchers (Section 8)</label>
          </div>
          <div class="checkbox">
            <input type="checkbox" value="13" name="email-modal-cb-13" id="email-modal-cb-13">
            <label for="email-modal-cb-13"><span></span>Senior Community Service Employment Program (SCSEP)</label>
          </div>
        </section>
        <div class="form-group">
          <label for="email-address">Email address</label>
          <input type="email" class="form-control" id="email-address" placeholder="example@email.com">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-link btn-underline pull-left" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary pull-right">Continue</button>
        <div class="clear-fix"></div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
      $(document).ready(function () {
          $('#email-modal-select-all').click(function () {
              if ($('#email-modal-select-all').text() == 'Select All') {
                  $('#email-modal input').each(function () {
                      $(this).prop('checked', true);
                  });
                  $('#email-modal-select-all').text('Deselect All');
              } else {
                  $('#email-modal input').each(function () {
                      $(this).prop('checked', false);
                      $(this).removeProp('checked');
                  });
                  $('#email-modal-select-all').text('Select All');
              }
          });
      });
  </script>
</div>

<div class="modal fade" id="details-modal" tabindex="-1" role="dialog" aria-labelledby="details-label">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title modal-h1" id="details-label">
          My Details
          <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </h1>
      </div>
      <div class="modal-body">

        <h2>Basics</h2>
        <hr>

        <div class="row">
          <div class="col-md-6">
            <ul>
              <li><span class="modal-section-title ng-binding">Location: New Orleans, LA 70119</span></li>
              <li><span class="modal-section-title ng-binding">Relationship to You: Spouse</span></li>
              <li><span class="modal-section-title ng-binding">Date of Birth: April 1951</span></li>
              <li><span class="modal-section-title ng-binding">Gross Monthly Income: </span></li>
            </ul>
          </div>
          <div class="col-md-6">
            <ul>
              <li><span class="modal-section-title ng-binding">Marital Status: Married Living Separately</span></li>
              <li><span class="modal-section-title ng-binding">Veteran: Yes</span></li>
              <li><span class="modal-section-title ng-binding">Categories: [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object], [object Object]</span></li>
            </ul>
          </div>
        </div>

        <h2>Health</h2>
        <hr>

        <div class="row">
          <div class="col-md-12">
            <ul>
              <li><span class="modal-section-title ng-binding">Chronic Conditions: </span></li>
              <li><span class="modal-section-title ng-binding">Your Medications: </span></li>
            </ul>
          </div>
        </div>

        <h2>Household</h2>
        <hr>

        <div class="row">
          <div class="col-md-12">
            <ul>
              <li><span class="modal-section-title ng-binding">People in Household: </span></li>
              <li><span class="modal-section-title ng-binding">People 60 years or Older: </span></li>
              <li><span class="modal-section-title ng-binding">People with a Disability: </span></li>
            </ul>
          </div>
        </div>

        <h2>Finances</h2>
        <hr>

        <div class="row">
          <div class="col-md-12">
            <ul>
              <li><span class="modal-section-title ng-binding">Your Total Assets: </span></li>
              <li><span class="modal-section-title ng-binding">Spouse's Total Assets: </span></li>
              <li><span class="modal-section-title ng-binding">Household's Total Assets: </span></li>
              <li><span class="modal-section-title ng-binding">Total Monthly Income: </span></li>
            </ul>
          </div>
        </div>

        <p>See something wrong?</p>
        <p>
          Editing your details may require you to fill out additional information.  If you need to edit your search, we recommend you <a href="#">start over</a>.
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary pull-right" data-dismiss="modal">Done</button>
        <div class="clear-fix"></div>
      </div>
    </div>
  </div>
</div>
</div><!-- end ngIf: isResults -->
      <!-- ngIf: !isResults -->
    </div>

  </div>
  <div class="btns-container clearfix" page-switch="">
    <button class="btn btn-link btn-back pull-left" ng-click="switchPage(prev)">Back</button>
  </div>
</div>
</div>
</div>

</div>
  @endloop
@stop
