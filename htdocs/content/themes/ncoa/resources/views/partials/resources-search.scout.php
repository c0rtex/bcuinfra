
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
		<button class="btn btn-primary" ng-disabled="state=='' || state==undefined || category==''" ng-click="processForm(form, $event)">Find</button>
	</div>
</div>
<input type="hidden" name="category" value="@{{category}}">
{{ Form::close() }}