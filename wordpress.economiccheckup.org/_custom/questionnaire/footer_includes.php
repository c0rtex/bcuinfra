<?php
//header includes inserted here for each subset

//echo 'Gets to incude at all';

if ($subsetID == 72){ //MQC1

//echo 'Gets to subset incude at all';
           echo ' <script type="text/javascript" src="/wp-content/themes/bcuwptheme/mqc1.js"></script> ';
}

else if ($subsetID == 74){ //MQC2

           echo ' <script type="text/javascript" src="/wp-content/themes/bcuwptheme/mqc2.js"></script>';
}


else if ($subsetID == 75){ //MQC3

echo '           <script type="text/javascript" src="/wp-content/themes/bcuwptheme/mqc3.js"></script> ';
}
else if ($subsetID == 79){ //MQC3

echo '           <script type="text/javascript" src="/wp-content/themes/bcuwptheme/mqctriage.js"></script> ';
}

if ($triage == true){ //passed through the triage
echo '
<script type="text/javascript">

$("#mqc_medicare_enroll_situation").hide();

</script>

';

}

?>
<script type="text/javascript">
var axel = Math.random() + "";
var a = axel * 10000000000000;
document.write('<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=medic080;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
</script>
<noscript>
<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=medic080;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
</noscript>
<!-- End of DoubleClick Floodlight Tag: Please do not remove -->