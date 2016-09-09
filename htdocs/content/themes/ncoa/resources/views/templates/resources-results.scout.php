@extends('layouts.main')

<script>
window.programs = {{$programs}};
</script>

@section('main')
	<div ncoa-programs>
	<div class="container resource-results-container">
		<a href="/results" class="btn-link back-chev"><i class="fa fa-chevron-left" aria-hidden="true"></i>Back to Resource Library</a>
		<h1 class="">Program Details</h1>
		<div class="card">
			<div class="card-nested">
				<h2 class="page-header">What can we help you find</h2>
				<div class="light-grey-background-rounded card-row">
					<h3>Search Benefit Program</h3>
					<p>Enter any search details, and we'll give you a list of relevant benefit programs.</p>
					@include('partials.resources-search')
				</div>

				<div class="search-results">
					<ul>
						<div ng-repeat="program in currentProgramsList | filter: {PRG_NM : $root.prg_nm_filter}">
							<li class="result-item">
				        		<a href="/fact-sheets/factsheet_@{{program.CODE}}" class="btn-link btn-underline">@{{program.PRG_NM}}</a>
				        		<p>@{{program.FORM_TAG_NAME}}</p>
				        	</li>
						</div>
					</ul>
				</div>
				<div class="ncoa-pagination-container">
					<ul class="ncoa-pagination">
						<li class="page-left"><a href="#" ng-click="showPage(currentPage-1)"><i class="fa fa-chevron-left" aria-hidden="true"></i></a></li>
						<li class="page-nums">@{{currentPage}} of @{{pageCount}}</li>
						<li class="page-right"><a href="#" ng-click="showPage(currentPage+1)"><i class="fa fa-chevron-right" aria-hidden="true"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	</div>
@stop
