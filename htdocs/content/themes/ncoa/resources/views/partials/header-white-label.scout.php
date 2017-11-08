<script>
    window.isPLPage = true;
</script>
<header class="container-fluid">
    <section class="container">
        <div class="clearfix">
            <span class="pull-left header-logo {{{ (Option::get('global-settings', 'whitelabel') == '0') ? 'white-label' : '' }}}">
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
                <span class="header-logo-two">
                    @if(Option::get('global-settings', 'whitelabel') == '0')
                        <a href="https://www.ncoa.org/centerforbenefits/" target="_blank" class="whitelabel-logo">
                        {{
                            wp_get_attachment_image(Option::get('global-settings', 'whitelabel-logo'), 'full', false,
                                array('title' => get_the_title(Option::get('global-settings', 'whitelabel-logo')),
                                'width' => Option::get('global-settings', 'white-label-logo-width'),
                                'height' => Option::get('global-settings', 'white-label-logo-height'),
                                'title' => 'Center for Benefits Access',
                            ))
                        }}
                        </a>
                    @endif
                </span>
            </span><!--/.header-logo-->
            @if($loggedin)
                <nav id="utility-nav" class="pull-right utility-nav hidden-xs">
                    <ul>
                        <li class="@if($partnerlogin)current-menu-item current_page_item @endif">
                            <a href="/partner-login/">Login</a>
                        </li>
                        <li class="@if($grantees)current-menu-item current_page_item @endif">
                            <a href="/grantees">Grantees</a>
                        </li>
                        <li class="@if($resources)current-menu-item current_page_item @endif">
                            <a href="/resources-forms">Resources &amp; Forms</a>
                        </li>
                    </ul>
                </nav>
            @endif
        </div><!--/.clearfix-->
        @if($loggedin)
            <div class="clearfix">
                <nav class="navbar navbar-default">
                    <div>
                        <div class="navbar-header">
                            <div class="navbar-toggle-wrap">
                              <button type="button" class="navbar-toggle collapsed pull-left" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                  <span class="sr-only">Toggle navigation</span>
                                  <span class="icon-bar"></span>
                                  <span class="icon-bar"></span>
                                  <span class="icon-bar"></span>
                              </button>
                              <span class="menu-text visible-xs-inline-block" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">Menu</span>
                            </div>
                            <text-size-changer class="pull-right visible-xs-inline-block" min="18" mid="20" max="24" unit="px"></text-size-changer>
                        </div>


                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                            <div class="menu-primarynav-container">
                                <ul id="menu-primarynav" class="nav navbar-nav">
                                    <li class="menu-item @if($home) current-menu-item current_page_item @endif">
                                        <a href="/">Home</a>
                                    </li>
                                    <li class="menu-item @if($questionnaire)current-menu-item current_page_item @endif">
                                        <a href="/find-my-benefits/?subset_id=100">Find Benefits</a>
                                    </li>
                                    <li class="menu-item @if($medicarerx)current-menu-item current_page_item @endif">
                                        <a href="/medicare-rx-extra-help-application-intro-page/">Medicare Rx Extra Help</a>
                                    </li>
                                    <li class="menu-item @if($nutrition)current-menu-item current_page_item @endif">
                                        <a href="/resources/snap/">Food & Nutrition</a>
                                    </li>
                                </ul>
                            </div>

                            @if($loggedin)
                                <nav id="utility-nav" class="utility-nav">
                                    <ul>
                                        <li class="@if($partnerlogin)current-menu-item current_page_item @endif">
                                            <a href="/partner-login//">Partner Login</a>
                                        </li>
                                        <li class="@if($grantees)current-menu-item current_page_item @endif">
                                            <a href="/grantees">Grantees</a>
                                        </li>
                                        <li class="@if($resources)current-menu-item current_page_item @endif">
                                            <a href="/resources-forms">Resources & Forms</a>
                                        </li>
                                    </ul>
                                </nav>
                            @endif

                            <text-size-changer class="pull-right hidden-xs" min="18" mid="20" max="24" unit="px"></text-size-changer>
                        </div><!-- /.navbar-collapse -->
                    </div>
                </nav>
            @endif
        </div>
    </section>
</header>
