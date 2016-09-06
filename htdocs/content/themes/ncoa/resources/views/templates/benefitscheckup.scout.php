@extends('layouts.main')

@section('main')

<script>
	window.webServiceUrl = '{{$webServiceUrl}}';
</script>
	
	<!-- <div ng-view></div> -->
	<div class="container">
		<div ui-view></div>
	</div>
	
@stop