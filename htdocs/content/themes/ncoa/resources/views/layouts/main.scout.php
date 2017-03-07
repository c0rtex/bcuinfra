<!doctype html>
<html lang="en" ng-app="ncoa">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
    <script src="<?php echo themosis_assets() ?>/js/7683b69978.js"></script>
    <?php wp_head(); ?>

    <script>(function (w, d, s, l, i) {
      w[l] = w[l] || [];
      w[l].push(
        { 'gtm.start': new Date().getTime(), event: 'gtm.js' }
      );
      var f = d.getElementsByTagName(s)[0],
        j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : '';
      j.async = true;
      j.src =
        '//www.googletagmanager.com/gtm.js?id=' + i + dl;
      f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', 'GTM-PHJ4LQ');</script>
</head>
<body <?php body_class(); ?>>
<noscript>
  <iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
          height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>

<script>
    dataLayer = [
        { 'partner_id': '0', 'partner_name': '', 'subset_id': '0', 'state': '', }
    ];
</script>

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
