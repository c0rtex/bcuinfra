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

<footer>
    <div class="container">
        <div class="row">
            <div class="col-sm-12 text-center">
                &copy; 2016 National Council on Aging. All rights reserved.
            </div>
        </div>
    </div>

</footer>

</body>
</html>