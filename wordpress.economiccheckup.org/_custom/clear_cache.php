<?php
$subsetId= $_REQUEST["subset_id"];
if($subsetId) {
    apc_store('CachedSoapClientRequests_'.$subsetId,array(),0);
    echo "cache for subset with id ".$subsetId." is cleared";
} else {
    apc_clear_cache("user");
    echo "cache is cleared";
}
?>