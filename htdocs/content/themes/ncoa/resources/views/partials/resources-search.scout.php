
{{ Form::open('resources/results', 'post', false, [
  'name' => 'form',
	'class' => 'form-inline row',
  'novalidate' => ""
  ]) 
}}

<script>
	window.category="{{{isset($category) ? $category : ''}}}";
	window.state="{{{isset($state) ? $state : ''}}}";
</script>

<div ncoa-form>
	<div class="form-group col-md-4">
    	<label for="search-programs">Search Programs</label>
	    <input type="text" class="form-control" ng-model="$root.prg_nm_filter" id="search-programs" placeholder="Enter Keyword">
	</div>
	<div class="form-group col-md-3 col-lg-3">
  	<label for="search-programs">Search Categories</label>
  	<select name="category" ng-model="category" class="form-control" required>
        <option value="">-- Select --</option>
	  		@foreach($categories as $key => $value)
			    <option value="{{ $key }}">{{ $value }}</option>
		    @endforeach
		</select>
	</div>
	<div class="form-group col-md-3">
  	<label for="search-states">Search States</label>
  	<select name="state" ng-model="state" class="form-control" required>
      <option value="">-- Select --</option>
  		@foreach($states as $key => $value)
		    <option value="{{ $key }}">{{ $value }}</option>
	    @endforeach
    </select>
	</div>
	<div class="form-group col-md-2">
		<button class="btn btn-primary" ng-click="processForm(form, $event)">Find</button>
	</div>
	<div class="col-xs-6 error-state-form" ng-show="error">
		<div class="cta-red">
			<strong>Error!</strong> Please choose a category or state.
		</div>
	</div>
</div>
{{ Form::close() }}