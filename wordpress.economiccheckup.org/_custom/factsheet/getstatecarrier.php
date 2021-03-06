<?php
if (isset($_GET["subset_id"])){
$subsetID = htmlspecialchars($_GET["subset_id"]);
}
else {
 $subsetID = 79;
}
require_once('_custom/soap_client.php');

$stateId = isset($_GET['state_id']) ? $_GET['state_id'] : '';

$otherIns = false; //there are non-AHN items

$stateQuery = $soapClient->getStateDetails($stateId);;
//$stateQuery = restructureWSArray($stateQuery);
$stateName = count($stateQuery) == 1 ? $stateQuery[0]['STATE_NAME'] : '';

$carrierQuery = $soapClient->getStateCarrier(1,$stateId,1,14);
//$carrierQuery = restructureWSArray($carrierQuery);
?>

<div id="printContent" class="span8">
    <section id="summary">
        <div class="body-header-wrapper">
            <h2><i class="icon-2x"></i> Health Insurance Carriers for <?php echo $stateName; ?></h2>
            <div class="body-header" style="z-index: 999; position: static; top: 251.5px;">
                <div class="body-header-inner"></div>
            </div>
            <div></div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
    </section>
    <section id="contact">
        <h3 align="center">
        Health insurance plans selling to Medicare beneficiaries in <?php echo $stateName;?> that are represented by Aon Retiree Health Exchange&#0153;
        </h3>
        <table class="table table-bordered table-striped table-hover">
            <thead>
            <tr>
                <th>Insurer Name</th>
                <th>Prescription Drug Plans</th>
                <th>Medicare Supplement Plan</th>
                <th>Medicare Advantage</th>
            </tr>
            </thead>
            <tbody>
            <?php
            foreach($carrierQuery as $key => $value) {
                if (isset($value['ISAHN'])) {
                    echo '<tr>';
                    echo '<td>' . $value['NAME'] . '</td>';
                    echo '<td>' . (isset($value['HAVEPDP']) ? '<center><i class="icon-fixed-width"></i></center>' : '') . '</td>';
                    echo '<td>' . (isset($value['HAVEMSP']) ? '<center><i class="icon-fixed-width"></i></center>' : '') . '</td>';
                    echo '<td>' . (isset($value['HAVEMA']) ? '<center><i class="icon-fixed-width"></i></center>' : '') . '</td>';
                    echo '</tr>';
                }
              else {

                $otherIns = true;
              }
            }
echo '
            </tbody>
        </table>
    </section>
';
if ($otherIns == true){
echo '

    <section id="other">
        <h3 align="center">Other highly-rated health insurance plans* sold in
'.$stateName;
}

      

if ($otherIns == true){
echo '
 
that are not represented by Aon Retiree Health Exchange&#0153;</h3>

        <h5>(*Note: These are insurance plans that received overall star quality ratings of 4.5 or 5 from the U.S. Center for Medicare and Medicaid Services and/or one of the top three sellers in your state for 2015.)</h5>

        <table class="table table-bordered table-striped table-hover">
            <thead>
            <tr>
                <th>Insurer Name</th>
                <th>Prescription Drug Plans</th>
                <th>Medicare Advantage</th>
            </tr>
            </thead>
            <tbody>
';
}
            foreach($carrierQuery as $key => $value) {
                if (empty($value['ISAHN'])) {
                    echo '<tr>';
                    echo '<td>' . $value['NAME'] . ' <a href="#key_'.$key.'">(Contact Info)</a></td>';
                    echo '<td>' . (isset($value['HAVEPDP']) ? '<center><i class="icon-fixed-width"></i></center>' : '') . '</td>';
                    echo '<td>' . (isset($value['HAVEMA']) ? '<center><i class="icon-fixed-width"></i></center>' : '') . '</td>';
                    echo '</tr>';
                }
            }
if ($otherIns == true){
echo '
            </tbody>
        </table>
    </section>
';
}

    foreach($carrierQuery as $key => $value) {
        if (empty($value['ISAHN'])) {
    ?>
    <section id="<?php echo 'key_'.$key;?>">
        <h3>
        <font color="#000000"><?php echo $value['NAME'].' Contact Information';?></font>
        </h3>
    </section>
    <table class="table table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>Phone Number</th>
            <th>URL</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="carrierPhone">
                <?php
                echo $value['PHONE_NEW'];
                if (isset($value['PHONE_EXISTING']) && ($value['PHONE_EXISTING'] != '') ) {
                        $phoneExisting = preg_replace('/\s+/', '', $value['PHONE_EXISTING']);
if ($phoneExisting != ''){
		echo ' (new clients)<br/>';
                    echo $value['PHONE_EXISTING'].' (existing clients)';
}
                }
                ?>
            </td>
            <td class="carrierSite"><a href="<?php echo $value['WEBSITE'];?>" target="_blank"><?php echo $value['WEBSITE'];?></a></td>
        </tr>
        </tbody>
    </table>
    <?php }} ?>
    <h4 align="center">Please note: The plan information listed on this page may only be offered in certain counties in your state.</h4>
</div>


<div class="span3">
    <div class="well whitewell sidebar-nav" style="z-index: 999; position: static; width: 220px; top: 191px;">
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#contact"><i class="icon-fixed-width"></i>Aon Retiree Health Exchange&#0153;</a></li>
            <li><a href="#other"><i class="icon-user-md"></i>Other Health Plans</a></li>
            <li></li>
            <li></li>
        </ol>
    </div>
</div>



<?php
function echoAsTD($data) {
    echo '<td>';
    echo $data;
    echo '</td>';
}

function echoAsTDCB($data) {
    echo '<td>';
    if ($data) {
        echo '<center><em class="icon-fixed-width">Yes</em></center>';
    }
    echo '</td>';
}

?>
