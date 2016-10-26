<!doctype html>
<html lang="en" ng-app="ncoa">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
	<link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">	
	<script src="<?php echo themosis_assets() ?>/js/7683b69978.js"></script>
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
	
	@include('partials.header')
	
	<div class="page-wrapper">
		@yield('main')
	</div>	
	
	<footer class="site-footer">
		@if(Option::get('global-settings', 'whitelabel') == '0')
			@include('partials.footer-alternate')
		@else
			@include('partials.footer')
		@endif
	</footer>

	<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/libs.js"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/app.js"></script>

	@yield('misc-scripts')

</body>
</html>
