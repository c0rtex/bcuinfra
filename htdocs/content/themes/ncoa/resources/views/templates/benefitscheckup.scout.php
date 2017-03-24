@extends('layouts.main')

@section('main')

<script>
	window.webServiceUrl = '{{$webServiceUrl}}';
	window.defaultLangsFullScreen = JSON.parse('{{defaultLangsFullScreen}}');
	window.defaultLangsPreScreen = JSON.parse('{{defaultLangsPreScreen}}');
	if (window.name == '') {
		window.name = '{{microtime(true)}}';
	}
</script>
	
	<!-- <div ng-view></div> -->
	<div class="container">
		<div ui-view></div>
	</div>
	
@stop