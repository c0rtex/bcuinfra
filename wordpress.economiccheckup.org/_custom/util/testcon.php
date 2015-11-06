<?php
$db = mysqli_init();

if (!$db) {
    die("mysqli_init failed");
}

if(!$db->ssl_set('/opt/bcu/etc/ssl/mysql/client-key.pem','/opt/bcu/etc/ssl/mysql/client-cert.pem', '/opt/bcu/etc/ssl/mysql/ca-cert.pem',NULL,NULL)){
        die("Setting up ssl failed");
}
else { echo '<p>ssl setup.</p>'; 
}

if(!$db->real_connect('192.168.10.16','esidtcssl','heDruca6','bcumigration')){
        die("Failed to connect to db: " . mysqli_error());
}
else { echo '<p>ssl setup and connection done.</p>'; 
}
 echo '<p>done</p>';
?>