@extends('layouts.style')

@section('main')



<!--Colors-->
<section class="row">
	<div class="colors">
		<span class="col-sm-1 col-md-1 brand-blue"></span>
		<span class="col-sm-1 col-md-1 brand-yellow"></span>
		<span class="col-sm-1 col-md-1 brand-light-blue"></span>
		<span class="col-sm-1 col-md-1 brand-orange"></span>
		<span class="col-sm-1 col-md-1 brand-red"></span>
		<span class="col-sm-1 col-md-1 brand-light-green"></span>
		<span class="col-sm-1 col-md-1 brand-dark-green"></span>
		<span class="col-sm-1 col-md-1 brand-purple"></span>
		<span class="col-sm-1 col-md-1 brand-charcoal"></span>
		<span class="col-sm-1 col-md-1 brand-light-grey"></span>
	</div>
</section>

<section class="row">
	<div>
		<h1>Page Title</h1>
		<h4 class="bold">Step Indicator: Part 1 or 3</h4>
		<h2>Subtitle</h2>	
	
		<div class="bold">Body Copy</div>
		<p>Medicaid is a health insurance program paid for by the Federal and state governments. The program helps make health care affordable <a href="#">inline link</a> who are elderly, disabled, and/or blind. Medicaid pays for teh medical services such as:</p>
		<ul>
			<li>bullet example</li>
			<li>bullet example</li>
			<li>bullet example</li>
		</ul>
	</div>
	
</section>

<!--Buttons-->
<section class="row buttons">	
	<p>
		<span>INITIAL</span>
		<button class="btn btn-primary" href="#" role="button">Primary Button</button>
		<button class="btn btn-secondary" href="#" role="button">Secondary Button</button>
		<button class="btn btn-tertiary" href="#" role="button">Tertiary Button</button>
	</p>
	<p class="hover">
		<span>Hover</span>
		<button class="btn btn-primary" href="#" role="button">Primary Button</button>
		<button class="btn btn-secondary" href="#" role="button">Secondary Button</button>
		<button class="btn btn-tertiary" href="#" role="button">Tertiary Button</button>
	</p>

	
			
	<div class="btn-group" role="group" aria-label="Montly Income?">
		<button type="button" class="btn btn-default">Option 1</button>
		<button type="button" class="btn btn-default active">Option 2</button>
		<button type="button" class="btn btn-default hover">Option 3</button>
		<button type="button" class="btn btn-default">Option 4</button>
	</div>


	<div class="panels">
		<section>
			<span>INITIAL</span>
			<div class="icon-panel">
			    <div class="icon-panel-content">
			      <div class="icon-wrapper">
			        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg">
			      </div>
			      <div class="icon-panel-selector-label">
			        <div class="label-inner ng-binding">Medication</div>
			      </div>
			    </div>
		  	</div>
	  	</section>
		
		<section>
		  	<span>Selected</span>
		  	<div class="icon-panel checked">
			    <div class="icon-panel-content">
			      <div class="icon-wrapper">
			        <img ng-src="/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg">
			      </div>
			      <div class="icon-panel-selector-label">
			        <div class="label-inner ng-binding">Medication</div>
			      </div>
			    </div>
		  	</div>
	  	</section>

	  	<section>
	  		<span>Disabled</span>
	  		<button class="btn" disabled>Disabled</button>
	  	</section>
  	</div>
	

	<div class="program-slide-down col-md-9">
		<section class="program medicine" slide-down>
			<div class="program-header hover-shade"><span>Medication Benefits: 3 Programs</span></div>
			<div class="programs-container" style="display: block;">
				<ul class="programs">
					<li>
						<h4>Program Name</h4>
						<p>Short description of program here. Short description of program here. Short description of program here.</p>
					</li>
					<li>
						<a ui-sref="fact-sheets" class="btn-link" href="#/fact-sheets">Learn More and Apply</a>
					</li>
				</ul>
				<ul class="programs">
					<li>
						<h4>Program Name</h4>
						<p>Short description of program here. Short description of program here. Short description of program here.</p>
					</li>
					<li>
						<a href="#" class="btn-link">Learn More and Apply</a>
					</li>
				</ul>
				<ul class="programs">
					<li>
						<h4>Program Name</h4>
						<p>Short description of program here. Short description of program here. Short description of program here.</p>
					</li>
					<li>
						<a ui-sref="fact-sheets" class="btn-link" href="#/fact-sheets">Learn More and Apply</a>
					</li>
				</ul>
			</div>
		</section>
	</div>
	
	
		
</section>

<!--Forms-->
<section class="row">
	<div class="col-md-6">
		<div class="form-group">
		    <label for="exampleInputEmail1">Example of an input with label? <button data-toggle="popover" data-trigger="focus" data-html="true" data-content="Why are we asking? This question is optional, and does not affect your results. Your answer will help us understand how best to reach people who can benefit from this service." data-placement="top" class="fa fa-question-circle" data-original-title="" title="" aria-hidden="true"></button></label>
		    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Name">
	  	</div>
		  	
	  	<div class="form-group">
	  		<label for="exampleInputFile">Label (Optional)</label>
		  	<select class="form-control">
		  		<option>Select</option>
		  		<option>1</option>
			  	<option>2</option>
			  	<option>3</option>
			  	<option>4</option>
			  	<option>5</option>
			</select>
		</div>			
	  	<!-- <div class="checkbox">
	    	<input type="checkbox" id="example-checkbox" name="example-checkbox">
	    	<label for="example-checkbox"><span></span>Check me out</label>
	  	</div>
	  	<div class="radio">
	    	<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
	    	<label for="optionsRadios1"><span></span>Option one is this and that&mdash;be sure to include why it's great</label>
		</div>
		<div class="radio">
		    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
		    <label for="optionsRadios2"><span></span>Option two can be something else and selecting it will deselect option one</label>
		</div>
		<div class="radio disabled">
		    <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3" disabled>
		    <label for="optionsRadios3"><span></span>Option three is disabled</label>
		</div> -->	
	</div>
	<br /><br />

	
	<div class="col-md-9 grouped-fields">
		<p>Grouped Fields Example</p>
		<div class="group-box">
			<div class="form-group">
			    <label for="exampleInputEmail1">Label</label>
			    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Placeholder Text">
		  	</div>
		  	<div class="form-group">
			    <label for="exampleInputEmail1">Label</label>
			    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Placeholder Text">
		  	</div>
	  	</div>
	</div>
	
	<div class="clearfix"></div>	
	
	<div class="col-md-3">
		<p>Check Group Label</p>
		<div class="radio disabled">
		    <input type="radio" name="optionsRadios3" id="optionsRadios1" value="option3">
		    <label for="optionsRadios3"><span></span>ON</label>
		</div>
		<div class="radio disabled">
		    <input type="radio" name="optionsRadios2" id="optionsRadios2" value="option3">
		    <label for="optionsRadios2"><span></span>OFF</label>
		</div>
	</div>

	<div class="col-md-3">
		<p>Radio Group Label</p>
		<div class="checkbox">
	    	<input type="checkbox" id="example-checkbox-1" name="example-checkbox-1">
	    	<label for="example-checkbox"><span></span>Check ON</label>
	  	</div>
	  	<div class="checkbox">
	    	<input type="checkbox" id="example-checkbox-2" name="example-checkbox-2">
	    	<label for="example-checkbox"><span></span>Check OFF</label>
	  	</div>
	</div>

	<div class="col-md-7 states">
		<div class="cta-green">
			<strong>Just a reminder:</strong> Answer all your questions as your .
		</div>

		<div class="cta-red">
			<strong>Just a reminder:</strong> Answer all your questions as your .
		</div>

		<div class="cta-yellow">
			<strong>Just a reminder:</strong> Answer all your questions as your .
		</div>
	</div>
</section>
@stop
