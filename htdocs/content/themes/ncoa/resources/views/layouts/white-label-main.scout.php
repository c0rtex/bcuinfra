<!doctype html>
<html lang="en" ng-app="ncoa">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main-vendor.css">
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
    
    <script src="<?php echo themosis_assets() ?>/js/7683b69978.js"></script>
    <script src="<?php echo themosis_assets() ?>/js/js_libs/modernizr-custom.js"></script>
    <!-- Google Tag Manager -->
    <script>
      dataLayer = [
        { 'partner_id': '0', 'partner_name': '', 'subset_id': '0', 'state': '', }
      ];
    </script>


    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<!-- Google Tag Manager (noscript) -->
<noscript>
  <iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
          height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->


@if($_SESSION['partner_id']==58)
@include('partials.header-white-label')
@else
@include('partials.header')
@endif


<div class="page-wrapper">
    @yield('main')
</div>

<footer class="site-footer">
    @if($_SESSION['partner_id']==58)
    @include('partials.footer-alternate')
    @else
    @include('partials.footer')
    @endif
</footer>

<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/jquery.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/sizzle.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular-sanitize.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular-animate.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular-route.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular-ui-router.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular-local-storage.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/odometer.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/slick.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/loading-bar.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/jquery.quicksearch.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/jquery.multi-select.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/app.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/white-label.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/jquery.matchHeight-min.js"></script>
@yield('misc-scripts')

@if($nutrition)
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/snapmap.js"></script>
@endif

</body>
</html>
