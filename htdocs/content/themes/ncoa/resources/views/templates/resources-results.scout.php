@extends('layouts.main')

@section('main')
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
						 <li class="result-item">
				        	<a href="/results/snap" class="btn-link btn-underline">Medicaid</a>
				        	<p>Short description of program here. Short description of program. Short description of program here. Short description of program.</p>
				        </li>
						@for($i = 0; $i < 10; $i++)
					        <li class="result-item">
					        	<a href="/results/details" class="btn-link btn-underline">Program Name</a>
					        	<p>Short description of program here. Short description of program. Short description of program here. Short description of program.</p>
					        </li>
					    @endfor
					</ul>
				</div>
				<div class="ncoa-pagination-container">
					<ul class="ncoa-pagination">
						<li class="page-left"><a href="/resources/results/{{$page}}"><i class="fa fa-chevron-left" aria-hidden="true"></i></a></li>
						<li class="page-nums">{{$page}} of {{$total}}</li>
						<li class="page-right"><a href="/resources/results/{{$page + 1}}"><i class="fa fa-chevron-right" aria-hidden="true"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
@stop
