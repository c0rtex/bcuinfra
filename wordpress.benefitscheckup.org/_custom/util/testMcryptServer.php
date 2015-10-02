<?php

$modes = mcrypt_list_modes();
$algorithms = mcrypt_list_algorithms();
foreach($algorithms as $cipher)
{
    echo "<h1 style=\"border-top:1px solid black;\">".$cipher."</h1>\n";
    foreach($modes as $mode)
    {
        echo "<h3>".$mode."</h3>\n";
        @$td = mcrypt_module_open(
            $cipher,
            '/usr/local/libmcrypt-2.5.8/modules/algorithms/',
            $mode,
            '/usr/local/libmcrypt-2.5.8/modules/modes/');
        @$key_size = mcrypt_enc_get_key_size($td);
        @$block_size = mcrypt_get_block_size($cipher,$mode);
        @$iv_size = mcrypt_get_iv_size($cipher, $mode);
        @mcrypt_module_close($td);
        echo "
        <pre> 
            key_size: ". ($key_size?$key_size:'n/a')
      ."    block_size: ". ($block_size?$block_size:'n/a')
      ."    iv_size: ". ($iv_size?$iv_size:'n/a')
      ."  </pre>\n";
        $td=NULL;
        $key_size=NULL;
        $block_size=NULL;
        $iv_size=NULL;
    }
}

?>
