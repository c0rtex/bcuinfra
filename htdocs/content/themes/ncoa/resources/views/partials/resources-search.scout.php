
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
	
	<div class="form-group col-md-10">
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
<input type="hidden" name="category" value="@{{category}}">
{{ Form::close() }}