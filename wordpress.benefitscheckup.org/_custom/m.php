<?php 
$conn = mysqli_init();
mysqli_ssl_set($conn, '/opt/bcu/etc/ssl/mysql/client-key.pem', '/opt/bcu/etc/ssl/mysql/client-cert.pem', NULL, NULL, NULL);
f (!mysqli_real_connect($conn, '192.168.10.42', 'wp_bcu_user', 'zqwrAJEK5m9E7e7B')) { die(); }
$res = mysqli_query($conn, 'SHOW STATUS like "Ssl_cipher"');
print_r(mysqli_fetch_row($res));
mysqli_close($conn);

?>
