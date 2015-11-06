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
        <link href="/cf/bootswatch/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>
<div class="white well" >
<?php 
$estimate = 0;
$db = mysqli_init();
if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
        die("Setting up ssl failed");
}

if(!$db->real_connect('172.31.33.35','esidtcssl','heDruca6','esidtc')){
        die("Failed to connect to db: " . mysqli_error());
}

// Select the database.
//mysqli_select_db('esidtc')
    //or die("Unable to select database: " . mysqli_error());
$query_getEstimate = "SELECT
		estimate
		FROM
		estimatesavings
		where session_id = '".$_GET['session_id']."'
		order by estimatesavings.date_time desc
		limit 1";
$doQuery    =    $db->prepare($query_getEstimate);
$result = $doQuery->execute();
 /* bind result variables */
    $doQuery ->bind_result($estimate);
    /* fetch value */
    $doQuery->fetch();



//print_r($_SESSION);
//print_r($_GET);
?>
<h4 style="font-family:arial;  color: #0082D1;" >Cost Savings Estimate: <?php if ($estimate == ''){ echo "$ _____";} else {echo $estimate;} ?></h4>
<p style="font-family:arial; color: #0082D1;" >Enter your Part D plan and your prescription drugs in the boxes below.</p>
                  <iframe name="picwellframe" frameborder="0" scrolling="no" width="475" height="400" src="https://ncoa.picwell.net/iframe?zip=<?php echo $_GET['zipcode']; ?>&session_id=<?php echo $_GET['session_id']; ?>"></iframe>
</div>
</body>
</html>