<!doctype html>
<html lang="en" ng-app="styleGuide">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
	
	<div class="page-wrapper container">
		<div class="card">
			<div class="card-nested">
				<header>
					<img src="{{themosis_assets() }}/images/BCU-logo.svg" style="width: 320px" />
				</header>
				@yield('main')
			</div>
		</div>
	</div>
	<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/libs.js"></script>
	<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/styleguide.js"></script>
	<script src="<?php echo themosis_assets() ?>/js/7683b69978.js"></script>
</body>
</html>