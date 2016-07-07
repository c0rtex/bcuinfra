<?php

// Pradian Encryption Algorithm copyright (c) 2003, 2006 by William Shunn.
// This algorithm was designed independently of NCOA or its partners and subsidiaries,
// and does not fall under the definition of work for hire.  William Shunn licenses
// this implemention of Pradian Encryption to NCOA in perpetuity, free of charge.
// NCOA may not reassign this license or sell this code.

// Sample usage:
// To encrypt a plaintext string:  $myCiphertext = encryptString('Let\'s encrypt this sentence.');
// To decrypt a ciphertext string:  $myPlaintext = decryptString($myCiphertext);

// The functions encryptString and decryptString are the only functions you should use.
// The other functions are for internal use only.

// string getEncryptionKey(string $gekDelim)
// Returns an encryption key for use with other encryption functions.
// If $gekDelim is omitted, a delimiter is selected at random from the hardcoded base key.
// NOT FOR DIRECT USE.

function getEncryptionKey($gekDelim = '') {
	$gekKey = 'oetNglIYKha4F31xSOkibzL9sZq0yBWf78r2RmCJcjXQPudwTHv6DVnGA5pUME';
	if (strlen($gekDelim) == 1 && strpos($gekKey, $gekDelim) !== FALSE) {
		return str_replace($gekDelim, '', $gekKey);
	} else {
		$gekDelim = substr($gekKey, rand(0, strlen($gekKey) - 1), 1);
		return array (str_replace($gekDelim, '', $gekKey), $gekDelim);
	}
}

// string encryptNumber(int $enNum, string $enKey)
// Returns an encrypted integer for use with other encryption functions.
// If $enKey is omitted, a random key is generated.
// NOT FOR DIRECT USE.

function encryptNumber($enNum, $enKey = '') {
	if ($enKey == '') {
		$enKey = getEncryptionKey();
	}
	$enCodebase = strlen($enKey);
	$enCoded = '';
	$enPlace = 1;
	$enUnit = 1;
	while ($enNum >= $enUnit * $enCodebase) {
		$enPlace++;
		$enUnit *= $enCodebase;
	}
	for ($x = $enPlace; $x > 0; $x--) {
		$enDigit = (int)floor($enNum / $enUnit);
		$enCoded .= substr($enKey, $enDigit, 1);
		$enNum -= $enDigit * $enUnit;
		$enUnit /= $enCodebase;
	}
	return $enCoded;
}

// int decryptNumber(string $dnNum, string $dnKey)
// Returns a decrypted integer for use with other encryption functions.
// NOT FOR DIRECT USE.

function decryptNumber($dnNum, $dnKey) {
	$dnCodebase = strlen($dnKey);
	$dnUncoded = 0;
	$dnUnit = 1;
	for ($x = strlen($dnNum) - 1; $x >= 0; $x--) {
		$dnUncoded += strpos($dnKey, substr($dnNum, $x, 1)) * $dnUnit;
		$dnUnit *= $dnCodebase;
	}
	return $dnUncoded;
}

// string encryptString(string $esText)
// Given plaintext input, returns an encrypted string.

function encryptString($esText) {
	list ($esKey, $esDelim) = getEncryptionKey();
	$esNumKey = rand(1, 1024);
	$esCoded = $esDelim . encryptNumber($esNumKey, $esKey);
	for ($x = 0; $x < strlen($esText); $x++) {
		$esCoded .= $esDelim . encryptNumber(ord(substr($esText, $x, 1)) * $esNumKey, $esKey);
	}
	return $esCoded;
}

// string decryptString(string $dsText)
// Given ciphertext input, returns a decrypted string.

function decryptString($dsText) {
	$dsDelim = substr($dsText, 0, 1);
	$dsArray = explode($dsDelim, substr($dsText, 1));
	$dsKey = getEncryptionKey($dsDelim);
	$dsUncoded = '';
	for ($x = 0; $x < count($dsArray); $x++) {
		if ($x == 0) {
			$dsNumKey = decryptNumber($dsArray[$x], $dsKey);
		} else {
			$dsNum = decryptNumber($dsArray[$x], $dsKey);
			$dsUncoded .= chr($dsNum / $dsNumKey);
		}
	}
	return $dsUncoded;
}

?>