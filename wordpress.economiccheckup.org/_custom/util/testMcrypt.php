<?php

$test = 'test';

echo "This is the sample user data: $test";
echo '<br/>';
$testEn = encrypt ($test, 'somepassword');
echo "This is what will be stored in the database after encryption: $testEn";
echo '<br/>';
$testDe = decrypt ($testEn, 'somepassword');
echo "This is the data stored above after being decrypted, using the same password: $testDe";

/*Based on code from an anonymous user at php.net:

These are two simple functions I built for 256-bit encryption/decryption with mcrypt.  I've decided to use MCRYPT_RIJNDAEL_128 because it's AES-compliant, and MCRYPT_MODE_CBC.  (ECB mode is inadequate for many purposes because it does not use an IV.)

This function stores a hash of the data to verify that the data was decrypted successfully, but this could be easily removed if necessary.

*/

function encrypt($decrypted, $password, $salt='!kQm*fF3pXe1Kbm%9') {
 // Build a 256-bit $key which is a SHA256 hash of $salt and $password.
 $key = hash('SHA256', $salt . $password, true);
 // Build $iv and $iv_base64.  We use a block size of 128 bits (AES compliant) and CBC mode.  (Note: ECB mode is inadequate as IV is not used.)
 srand(); $iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC), MCRYPT_RAND);
 if (strlen($iv_base64 = rtrim(base64_encode($iv), '=')) != 22) return false;
 // Encrypt $decrypted and an MD5 of $decrypted using $key.  MD5 is fine to use here because it's just to verify successful decryption.
 $encrypted = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $decrypted . md5($decrypted), MCRYPT_MODE_CBC, $iv));
 // We're done!
 return $iv_base64 . $encrypted;
 }

function decrypt($encrypted, $password, $salt='!kQm*fF3pXe1Kbm%9') {
 // Build a 256-bit $key which is a SHA256 hash of $salt and $password.
 $key = hash('SHA256', $salt . $password, true);
 // Retrieve $iv which is the first 22 characters plus ==, base64_decoded.
 $iv = base64_decode(substr($encrypted, 0, 22) . '==');
 // Remove $iv from $encrypted.
 $encrypted = substr($encrypted, 22);
 // Decrypt the data.  rtrim won't corrupt the data because the last 32 characters are the md5 hash; thus any \0 character has to be padding.
 $decrypted = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, base64_decode($encrypted), MCRYPT_MODE_CBC, $iv), "\0\4");
 // Retrieve $hash which is the last 32 characters of $decrypted.
 $hash = substr($decrypted, -32);
 // Remove the last 32 characters from $decrypted.
 $decrypted = substr($decrypted, 0, -32);
 // Integrity check.  If this fails, either the data is corrupted, or the password/salt was incorrect.
 if (md5($decrypted) != $hash) return false;
 // Yay!
 return $decrypted;
 }
?>
