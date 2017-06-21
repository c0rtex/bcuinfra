<!doctype html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main-vendor.css">
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
    <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/print.css">
</head>
<body>

<div class="page-wrapper">
  @yield('main')
</div>

<script type='text/php'>

  $pdf->page_script('
    $font = $fontMetrics->get_font("helvetica");
    $size = 8;
    $color = array(0.266666667, 0.266666667, 0.266666667);
    $y = $pdf->get_height() - 26;
    $x = $pdf->get_width() - 16 - $fontMetrics->get_text_width("1/1", $font, $size);
    $x2 = $pdf->get_width() - 580 - $fontMetrics->get_text_width("1/1", $font, $size);
    $current_page = $PAGE_NUM-1;
    if ($PAGE_NUM > 1) {
      $pdf->text($x, $y, "$current_page", $font, $size, $color);
      $pdf->text($x2, $y, "Your BenefitsCheckUp Report", $font, $size, $color);
    }
  ');


</script>

<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/jquery.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/sizzle.min.js"></script>
<script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/angular.min.js"></script>
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

</body>
</html>