<!doctype html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="<?php echo themosis_assets() ?>/css/main.css">
  <style type="text/css">
    body {
      background-color: #ffffff;
    }
    footer {
      margin-bottom: 20px;
    }
    .faq {
      margin-bottom: 10px;
    }
  </style>
</head>
<body>

<header>
  <section class="container">
    <div class="clearfix">
      <img src="<?php echo themosis_assets() ?>/images/BCU-logo.jpg" />
    </div>

  </section>
</header>

<div class="page-wrapper">
  @yield('main')
</div>

</body>
</html>