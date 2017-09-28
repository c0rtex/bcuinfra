@extends('layouts.main')

<script>
window.programs = {{$programs}};
</script>

@section('main')
	<div ncoa-programs>
	<div class="container resource-results-container">
		<a href="/resources" class="btn-link back-chev"><i class="fa fa-chevron-left" aria-hidden="true"></i>Back</a>
		<h1 class="">Program Details</h1>
		<div class="card">
			<div class="card-nested">
				<h2 class="page-header">Here are your search results...</h2>
				<div class="light-grey-background-rounded card-row">
					<h3>Search Benefit Program</h3>
					<p>Enter any search details, and we'll give you a list of relevant benefit programs.</p>
					@include('partials.resources-search')
				</div>

				@if(strlen($programs) > 2)
				<div class="search-results">
					<ul>
						<div ng-repeat="program in currentProgramsList | filter: {PRG_NM : $root.prg_nm_filter}">
							<li class="result-item">
				        		<a ng-href="/fact-sheets/factsheet_@{{program.CODE}}?state={{$state}}&short=y" class="btn-link btn-underline"><ng-label text="@{{program.PRG_NM}}"></ng-label></a>
								<p><div-program-desc program_code="program.CODE"/></p>
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
				@else
				<div class="search-results">
					<p>There are no programs available for the options you selected. Please try another search criteria.</p>
				</div>
				@endif
			</div>
		</div>
	</div>
	</div>
@stop
