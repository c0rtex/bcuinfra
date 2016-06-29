{{ Form::open('resources/results', 'post', false, [
  'name' => 'form',
	'class' => 'form-inline row',
  'novalidate' => ""
  ]) 
}}
<div ncoa-form>
	<div class="form-group col-md-4">
    	<label for="search-programs">Search Programs</label>
	    <input type="text" class="form-control" id="search-programs" placeholder="Enter Keyword">
	</div>
	<div class="form-group col-md-3 col-lg-3">
  	<label for="search-programs">Search Categories</label>
  	<select name="categories" ng-model="resources.categories" class="form-control" required>
        <option value="">-- Select --</option>
	  		@foreach($categories as $key => $value)
			    <option value="{{ $value }}">{{ $value }}</option>
		    @endforeach
		</select>
	</div>
	<div class="form-group col-md-3">
  	<label for="search-states">Search States</label>
  	<select class="form-control" required>
      <option value="">-- Select --</option>
  		@foreach($states as $key => $value)
		    <option value="{{ $value }}">{{ $key }}</option>
	    @endforeach
    </select>
	</div>
	<div class="form-group col-md-2">
		<button class="btn btn-primary" ng-click="processForm(form, $event)">Find</button>
	</div>
	<div class="col-xs-6 error-state-form" ng-show="error">
		<div class="cta-red">
			<strong>Error!</strong> Please choose a category and state.
		</div>
	</div>
</div>
{{ Form::close() }}