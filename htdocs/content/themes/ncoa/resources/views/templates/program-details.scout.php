@extends('layouts.main')

@section('main')
	<div class="container fact-sheet-alt">
		<a href="/results" class="btn-link"><i class="fa fa-chevron-left" aria-hidden="true"></i>Back to Resource Library</a>
		<h1>Program Details</h1>
		<div class="card">
			<div class="card-nested row">
				<div class="col-md-9">
					<div class="fact-sheet-icon-hdr">
		          		<span class="icon-block-healthcare pull-left"></span>
			          	<div class="pull-left">
			            	<div class="fact-sheets-header fact-sheets-top-header">Health</div>
			            	<div class="fact-sheets-header fact-sheets-bottom-header">Medicaid</div>
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
					<a href="https://www.program.gov" class="btn-link btn-underline">https://www.program.gov</a>
					<p>Medicaid is a health insurance program paid for by the Federal and state governments. The program helps make health care affordable for people who are elderly, disabled, and/or blind. Medicaid pays for medical services such as:</p>
					<ul>
						<li>visits to healthcare providers (including physician and nurse practitioners)</li>
						<li>inpatient and outpatient hospital services</li>
						<li>prescription drug coverage (only available in certain cases)</li>
						<li>lab tests</li>
						<li>x-rays</li>
						<li>medical transportation</li>
						<li>nursing home care</li>
						<li>home health services</li>
						<li>family planning services</li>
					</ul>
					<p>To get program benefits, you should go to a healthcare provider that participates in the Medicaid program.</p>

					<h3 class="bold">Am I Eligible?</h3>
					<p>Start our questionnaire to determine if you are eligible to apply for Medicaid and other programs by entering your ZIP code below.</p>
					<div class="zip-code-container">
						<h3>ZIP Code</h3>
						<div class="zip-code form-inline" ng-controller="zipCodeController">
							<input type="text" class="form-control" aria-label="Zipcode" placeholder="Enter Zip Code" ng-model="zipcode" ng-required="true" ng-pattern="regPattern" />
							<button ng-click="findZip(zipcode)" class="btn btn-primary">Find My Benefits</button>
							<p class="error-state" ng-cloak ng-class="{ 'error-state-valid': isValid}">Please enter a valid zipcode in the United States</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-12">
					<div class="results-options">
			          <span class="fact-sheets-know">Did You Know?</span>
			          Over <span class="fact-sheets-emphasis">50,000 people</span> are receiving benefits from Medicaid today!
			        </div>
				</div>
			</div>
		</div>
	</div>
@stop
