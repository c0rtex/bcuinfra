<div class="benefits-container" benefits-slider>
	<div class="benefits-slider-container">
		<div class="benefits-slider-header">
			<h2>{{ Meta::get(Loop::id(), $key = 'section-header', $single = true) }}</h2>
			<p>{{ Meta::get(Loop::id(), $key = 'section-copy', $single = true) }}</p>
		</div>


		<div class="benefits-slider-circle-nav">
			@foreach($benefitsItems as $key => $value)
				<div>
					<div class="benefits-slider-icon-container">
						<div class="benefits-slider-icon {{{ ($key == 1) ? 'benefits-slider-active' : '' }}}">
							{{
								wp_get_attachment_image($benefitsItems[$key]["icon"], 'full', false,
								array('title' => get_the_title($benefitsItems[$key]["icon"]))) 
							}}
						</div>
					</div>
					<br>
					<span>{{ $benefitsItems[$key]["name"] }}</span>
				</div>
			@endforeach
		</div>
		<div class="benefits-slider-carousel">
			<div class="benefits-slider-arrow fa fa-2x fa-chevron-left"></div>
			<div class="benefits-slider-arrow fa fa-2x fa-chevron-right"></div>

			@foreach($benefitsItems as $key => $value)
				<div class="row {{{ ($key == 1) ? 'benefits-slider-active' : '' }}}">
					<div class="col-md-6 col-sm-12">
						<h3>
							{{
								wp_get_attachment_image($benefitsItems[$key]["icon"], 'full', false,
								array(
									'title' => get_the_title($benefitsItems[$key]["icon"]),
									'class' => 'benefits-slider-header-img'
								)) 
							}}

							{{ $benefitsItems[$key]["name"] }}
						</h3>
						{{ $benefitsItems[$key]["left-content"] }}
					</div>
					<div class="benefits-slider-divider col-md-6">
						{{ $benefitsItems[$key]["right-content"] }}
					</div>
				</div>
			@endforeach
		</div>
		<div class="benefits-slider-mobile-controls">
			<div class="benefits-slider-arrow fa fa-2x fa-chevron-left"></div>
			<div class="benefits-slider-index"></div>
			<div class="benefits-slider-arrow fa fa-2x fa-chevron-right"></div>
		</div>
	</div>
</div>
