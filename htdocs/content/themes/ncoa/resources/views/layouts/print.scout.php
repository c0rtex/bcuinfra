<!doctype html>
<html lang="en" ng-app="ncoa">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>

<header class="container-fluid">
	<section class="container">
		<div class="clearfix">
			<h1 class="pull-left header-logo {{{ (Option::get('global-settings', 'whitelabel') == '0') ? 'white-label' : '' }}}">
				<a tabindex="1" href="/" class="logo">
					{{
					wp_get_attachment_image(Option::get('global-settings', 'main-logo'), 'full', false,
					array(
					'title' => get_the_title(Option::get('global-settings', 'main-logo')),
					'width' => Option::get('global-settings', 'main-logo-width'),
					'height' => Option::get('global-settings', 'main-logo-height')
					))
					}}
				</a>
				@if(Option::get('global-settings', 'whitelabel') == '0')
				<a href="#" class="whitelabel-logo">
					{{
					wp_get_attachment_image(Option::get('global-settings', 'whitelabel-logo'), 'full', false,
					array('title' => get_the_title(Option::get('global-settings', 'whitelabel-logo'))))
					}}
				</a>
				@endif
			</h1>

			@if(Option::get('global-settings', 'showHeaderCTA') == '0')
			<div class="pull-right header-cta-ncoaLogo hidden-xs">
				<span><a tabindex="3" href="http://www.ncoa.org"><img width="150px" src="{{themosis_assets()}}/images/ncoa-logo.png" class="ncoaLogo" alt="National Council on Aging" /></a></span>
			</div>
			@endif
		</div>

	</section>
</header>


<div class="page-wrapper">
	@yield('main')
</div>

<footer class="site-footer">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="super-footer">
					<div class="super-footer-inner">
                    <span class="super-footer-copyright">
                        &copy; 2016 National Council on Aging. All rights reserved.
                    </span>
					</div>
					<hr />
				</div>
			</div>
		</div>
	</div>

</footer>

</body>
</html>