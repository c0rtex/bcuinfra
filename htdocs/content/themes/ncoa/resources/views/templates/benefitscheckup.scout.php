@extends('layouts.main')

@section('main')

<script type="text/javascript">
	window.webServiceUrl = '{{$webServiceUrl}}';
	window.defaultLangsFull = JSON.parse('{{$defaultLangsFull}}');
  window.defaultLangsPre = JSON.parse('{{$defaultLangsPre}}');
	if (window.name == '') {
		window.name = '{{microtime(true)}}';
	}
</script>

<!-- <div ng-view></div> -->
<div class="container">
	<div ui-view></div>
</div>

@stop