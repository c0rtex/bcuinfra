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
					<a tabindex="2" href="http://go.ncoa.org/BCUsignup" class="btn btn-purple">Sign Up for Enews</a>

				<span><a tabindex="3" href="http://www.ncoa.org"><img width="150px" src="{{themosis_assets()}}/images/ncoa-logo.png" class="ncoaLogo" alt="National Council on Aging" /></a></span>

				</div>
			@endif
		</div>


		<nav class="navbar navbar-default">
		  <div>
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
	      		<button type="button" class="navbar-toggle collapsed pull-left" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        	<span class="sr-only">Toggle navigation</span>
		        	<span class="icon-bar"></span>
		        	<span class="icon-bar"></span>
		        	<span class="icon-bar"></span>
		      	</button>
		      	<span class="menu-text visible-xs-inline-block" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">Menu</span>

				<text-size-changer class="pull-right visible-xs-inline-block" min="18" mid="20" max="24" unit="px"></text-size-changer>

		    </div>


		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      		<?php
					wp_nav_menu(
						array(
							'theme_location' 	=> 'primary-menu',
							'menu'				=> 'PrimaryNav',
							'menu_class'		=> 'nav navbar-nav',
							'depth'				=> '-1'
						)
					);
				?>

				<div class="header-cta hidden-lg hidden-md hidden-sm">
					<a href="http://go.ncoa.org/BCUsignup" class="btn btn-purple">Sign Up for Enews</a>
				</div>
		      	<text-size-changer class="pull-right hidden-xs" min="18" mid="20" max="24" unit="px"></text-size-changer>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
	</section>
</header>
