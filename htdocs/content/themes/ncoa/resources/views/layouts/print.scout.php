<!doctype html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
  <style type="text/css">
    body {
      background-color: #ffffff;
      font-family: 'Open Sans', sans-serif !important;
    }
    .faq {
      margin-bottom: 10px;
    }
    .pagenum:after {
      content: counter(page);
    }
  </style>
</head>
<body>

<div class="page-wrapper">
  @yield('main')
</div>

<script type='text/php'>
  if (isset($pdf)) {
    $font = $fontMetrics->get_font('helvetica');
    $size = 10;
    $color = array(0.266666667, 0.266666667, 0.266666667);
    $y = $pdf->get_height() - 26;
    $x = $pdf->get_width() - 57 - $fontMetrics->get_text_width('1/1', $font, $size);
    $pdf->page_text($x, $y, 'Page {PAGE_NUM} of {PAGE_COUNT}', $font, $size, $color);
    $x2 = $pdf->get_width() - 580 - $fontMetrics->get_text_width('1/1', $font, $size);
    $pdf->page_text($x2, $y, 'Copyright ' . date('Y') . ' National Council on Aging. All Rights Reserved.', $font, $size, $color);
  }
</script>

</body>
</html>