@extends('layouts.main')

@section('main')
	<div class="container resources">
		<h1>{{ Meta::get(Loop::id(), $key = 'resources-headline', $single = true) }}</h1>	
		<div class="card">
			<div class="card-nested">
				<h2 class="page-header">{{ Meta::get(Loop::id(), $key = 'resources-subtitle', $single = true) }}</h2>
				<div class="grey-background card-row">
					<h3>{{ Meta::get(Loop::id(), $key = 'searchbox-headline', $single = true) }}</h3>
					<p>{{ Meta::get(Loop::id(), $key = 'searchbox-body', $single = true) }}</p>	
					@include('partials.resources-search')
					<div class="bene-container">
						@foreach($keycategories as $key => $value)
						
							<div class="benefits-selector-checkbox" ng-class="{checked: category == {{$keycategories[$key]['category-icon']}}}" ng-click="category = {{$keycategories[$key]['category-icon']}}">
							    <div class="benefits-selector-checkbox-content">
						      		<div class="icon-wrapper">
						      			{{
											wp_get_attachment_image($keycategories[$key]["category-icon"], 'full', false,
												array('title' => get_the_title($keycategories[$key]["category-icon"])))
						      			}}
							      	</div>
							      	<div class="benefits-selector-label">
							        	<div class="label-inner ng-binding">{{ $keycategories[$key]["category-title"] }}</div>
							      	</div>
							    </div>
						  	</div>
					  	
						@endforeach
				  	</div>
				</div>

				<div class="grey-background card-row">
					<h3>{{ Meta::get(Loop::id(), $key = 'program-headline', $single = true) }}</h3>
					<p>{{ Meta::get(Loop::id(), $key = 'program-body', $single = true) }}</p>
					<div id="selected-programs" class="bene-container">
						@foreach($programs as $key => $value)
<a href="{{ $programs[$key]["program-link"] }}" class="btn-link">
							<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
								<div class="bene-panel">
							      	<div class="icon-wrapper">
							      		{{
											wp_get_attachment_image($programs[$key]["program-icon"], 'full', false,
												array('title' => get_the_title($programs[$key]["program-icon"])))
						      			}}
							      	</div>
							      	<div class="benefits-selector-label">
							        	<div class="label-inner">
							        		{{ $programs[$key]["program-title"] }}
<div class="btn-link">
							        		Learn More
</div>
							        	</div>
							      	</div>
								</div>
							</div>
</a>
						@endforeach
					</div>			 				
				</div>

				
			</div>
		</div>
	</div>
@stop
