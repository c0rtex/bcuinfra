<!doctype html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
  <style type="text/css">
    body {
      background-color: #ffffff;
      font-family: 'Open Sans', sans-serif !important;
    }
    footer {
      margin-bottom: 20px;
    }
    .faq {
      margin-bottom: 10px;
    }
    .footer {
      width: 100%;
      position: fixed;
      font-size: 15px;
      text-align: center;
      bottom: 0px;
    }
    .pagenum:after {
      content: counter(page);
    }
  </style>

  <script type="text/javascript" src="<?php echo themosis_assets() ?>/js/js_libs/bootstrap.min.js"></script>
</head>
<body>

@if (isset($_REQUEST['pdf']))
<div class="footer">
  <p>
    Copyright {{date('Y')}} National Council on Aging. All Rights Reserved - Page <span class="pagenum"></span>
  </p>
</div>
@endif

<div class="page-wrapper">
  @yield('main')
</div>

</body>
</html>