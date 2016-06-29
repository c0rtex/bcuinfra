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
				</div>

				<div class="grey-background card-row">
					<h3>{{ Meta::get(Loop::id(), $key = 'program-headline', $single = true) }}</h3>
					<p>{{ Meta::get(Loop::id(), $key = 'program-body', $single = true) }}</p>
					<div class="bene-container">
						@foreach($programs as $key => $value)
							<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
								<div class="bene-panel">
							      	<div class="icon-wrapper">
							        	<img src="<?php echo wp_get_attachment_image_src($programs[$key]["program-icon"])[0] ?>" /> 
							      	</div>
							      	<div class="benefits-selector-label">
							        	<div class="label-inner">
							        		{{ $programs[$key]["program-title"] }}
							        		<a href="{{ $programs[$key]["program-link"] }}" class="btn-link">Learn More</a>
							        	</div>
							      	</div>
								</div>
							</div>
						@endforeach
					</div>			 				
				</div>

				<div class="grey-background card-row">
					<h3>{{ Meta::get(Loop::id(), $key = 'categories-headline', $single = true) }}</h3>
					<p>{{ Meta::get(Loop::id(), $key = 'categories-body', $single = true) }}</p>
					<div class="bene-container">
						@foreach($keycategories as $key => $value)
						
							<div class="benefits-selector-checkbox">
							    <div class="benefits-selector-checkbox-content">
						      		<div class="icon-wrapper">
							        	<img src="<?php echo wp_get_attachment_image_src($keycategories[$key]["category-icon"])[0] ?>">
							      	</div>
							      	<div class="benefits-selector-label">
							        	<div class="label-inner ng-binding">{{ $keycategories[$key]["category-title"] }}</div>
							      	</div>
							    </div>
						  	</div>
					  	
						@endforeach
				  	</div>
				</div>
			</div>
		</div>
	</div>
@stop