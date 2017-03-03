@extends('layouts.main')

@section('main')
	@loop
		<div class="container">
			<h1>{{ Loop::title() }}</h1>	
			<div class="card">
				<div class="card-nested row">
					 {{ Loop::content() }}
				</div>
			</div>
		</div>
	@endloop
@stop