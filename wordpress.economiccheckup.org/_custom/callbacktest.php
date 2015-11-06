<html lang="en">
  <head>
		<script src="/cf/bootswatch/bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="/cf/bootswatch/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/jquery.validate.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/bootstrap.js"></script>
		<script src="/cf/bootswatch/bootstrap/js/bootstrap-tooltip.js" type="text/javascript"></script>
		<script type="text/javascript" src="/cf/bootswatch/js/scrolltofixed.js"></script>
    	<script src="/cf/bootswatch/bootstrap/js/application.js"></script>
		
		<link rel="stylesheet" href="/cf/bootswatch/css/font-awesome.css">
		
		<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		
        <!--- link href="/cf/bootswatch/bootstrap/css/bootstrap_mqc.css" rel="stylesheet" --->
        <link href="/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>
<script type="application/javascript">
       function getip(json) {
           alert(json.ip);
       }
$.getJSON("http://smart-ip.net/geoip-json?callback=?", function(data){
   alert(data.host);
});
 </script>
 <?php 
$randomnum = rand ( 1 , 3);
echo $randomnum;
if ( $randomnum  == 1) {
echo '
<li id="dfrads-widget-2" class="widget dfrads"><a href="/medicarequickcheck/" target="_blank"><img
src="/cf/img/mmm_widget_2.png" alt="Link to MedicareQuickCheck"
title="Link to MedicareQuickCheck"></a><br><br></li>
';
}
elseif ($randomnum  == 2) {
echo '
<li id="dfrads-widget-2" class="widget dfrads"><a href="/medicarequickcheck/" target="_blank"><img
src="https://redesign.benefitscheckup.org/wp-content/uploads/2013/10/mmm-quickcheck.gif" alt="Link to MedicareQuickCheck"
title="Link to MedicareQuickCheck"></a><br><br></li>
';
}
else {
echo '
<li id="dfrads-widget-2" class="widget dfrads"><a href="/medicarequickcheck/" target="_blank"><img
src="https://redesign.benefitscheckup.org/wp-content/uploads/2013/10/mmm_quickcheck2.gif" alt="Link to MedicareQuickCheck"
title="Link to MedicareQuickCheck"></a><br><br></li>
';
}
?> 
<script type="application/javascript" src="http://jsonip.appspot.com/?callback=getip">  </script>
<div class="white well" >

</div>
</body>
</html>