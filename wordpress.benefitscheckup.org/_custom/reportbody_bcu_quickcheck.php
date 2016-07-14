<div class="span8" id="printContent">
    <?php
    require_once('_custom/soap_client.php');
    //echo '<h3>testing</h3>';
    $summarytextPost = $soapClient->getWPPostByMetaTag('bcu_quickcheck_report_heading_overview');
    $summarytext = $summarytextPost[0]["POST_CONTENT"];
    $screeningID = $_GET['screeningID'];
    //echo "<br/>";
    //echo "<b>Unique ID: ".$screeningID."</b>";
    //echo "<br/>";


    ?>
    <h2 class="benefitsCheckUpTitle">BenefitsCheckUp Report</h2>
    <?php
    echo $summarytext;
    ?>
    <br/>
    </section>
    <?PHP
    require_once('report/report_calculations.php');
    //show income disclaimer for those selecting over 3000
	if (($income_exclusion == 'y') && ($total_exclusion > 0)) {
	echo '
	<section id="IncomeDisclaimer">  	
        <div class="body-header-wrapper">	<h2><i class="icon-money "> </i>'.$incomeDisclaimerTitle.'</h2>	       	
     	</div>
	<div id="incomedisclaimer" class="well cmxform">'.$incomeDisclaimer.'
	 
        </div>
 	</section>';
	}
    ?>
    <div>
<br/>
<a href="https://www.surveymonkey.com/r/BenefitsCheckUpFeedback" target="_blank">Please give us feedback on BenefitsCheckUp. Click here to complete a short satisfaction survey.</a> Thank you!
</div>
<br/>

    <div class="printButton printReport">
        <form><a data-toggle="modal" role="button" class="btn btn-large" href="#" onClick="javascript:PrintDiv();"><i
                    class="icon-print "></i> Print Your Report</a></form>
    </div>
</div> <!--span8-->
<div class="span4">
    <div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Sections</legend>
        <ol class="nav nav-list">
	    <?PHP
		
            foreach ($cats as $c => $row) {

                $cat_title = $row["CATEGORY_TITLE"];
                $sort_id = $row["SORT"];
                $cat_code = $row["CODE"];
                $programcategory_id = $row["PROGRAMCATEGORY_ID"];
                //echo $cat_code;
                if ($cat_code == 'veteran') {
                    $sectioncode = 'bcu_quickcheck_report_heading_veteran';
                    $iconcode = 'user';
                    $interested = 'bcuqc_category_veteran';
		    $inc_exclusion = 'n';
                } elseif ($cat_code == 'taxrelief') {
                    $sectioncode = 'bcu_quickcheck_report_heading_taxrelief';
                    $iconcode = 'building';
                    $interested = 'bcuqc_category_property_taxrelief';
		    $inc_exclusion = 'n';
                } elseif ($cat_code == 'foodsupp') {
                    $sectioncode = 'bcu_quickcheck_report_heading_foodsupp';
                    $iconcode = 'coffee';
                    $interested = 'bcuqc_category_foodsupp';
	            $inc_exclusion = 'y';
                } elseif ($cat_code == 'nutrition') {
                    $sectioncode = 'bcu_quickcheck_report_heading_nutrition';
                    $iconcode = 'heart';
                    $interested = 'bcuqc_category_nutrition';
	            $inc_exclusion = 'y';
                } elseif ($cat_code == 'rxgov') {
                    $sectioncode = 'bcu_quickcheck_report_heading_rx';
                    $iconcode = 'medkit';
                    $interested = 'bcuqc_category_rx';
		    $inc_exclusion = 'y';
                } elseif ($cat_code == 'medicaid') {
                    $sectioncode = 'bcu_quickcheck_report_heading_medicaid';
                    $iconcode = 'ambulance';
                    $interested = 'bcuqc_category_medicaid';
		    $inc_exclusion = 'y';
                } elseif ($cat_code == 'income') {
                    $sectioncode = 'bcu_quickcheck_report_heading_income';
                    $iconcode = 'money';
                    $interested = 'bcuqc_category_income';
		    $inc_exclusion = 'y';
                } elseif ($cat_code == 'utility') {
                    $sectioncode = 'bcu_quickcheck_report_heading_utility';
                    $iconcode = 'signal';
                    $interested = 'bcuqc_category_utility';
		    $inc_exclusion = 'y';
                }
                //echo $cat_code.$programcategory_id;
                //echo $sort_id;
                $thischecked = false;
                foreach ($fields as $f => $row) {
                    if (($row["ANSWERFIELD"] == $interested)&&($inc_exclusion != $income_exclusion)) {
                        $zip = $row["RESPONSE"];
                        //echo "field:".$interested;
                        $thischecked = true;
                    }


                }

                if ($thischecked == true) {
                    echo '<li id="leftnav_' . $interested . '" class=""><a href="#' . $interested . '"><i class="icon-' . $iconcode . ' "></i> ' . $cat_title . ' </a></li>';
                }
            }
	    if (($income_exclusion == 'y') && ($total_exclusion > 0)) {
                    echo '<li id="leftnav_incomedisclaimer" class=""><a href="#IncomeDisclaimer"><i class="icon-money "></i>'.$incomeDisclaimerTitle.'</a></li>';
                }
            ?>

        </ol>
        <BR>

        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="https://www.surveymonkey.com/r/BenefitsCheckUpFeedback" target="_blank"><i
                        class="icon-edit "></i> Send Us Your Feedback</a></li>
            <li><a data-toggle="modal" role="button" href="#" onClick="PrintDiv();"><i class="icon-print "></i>
                    Printable Report</a></li>
            <br/>
            <li><a data-toggle="modal" role="button" href="/cf/frmwelcome2.cfm?subset_id=0&partner_id=0&sc_partner_id=0"
                   target="_blank"><i class="icon-check "></i>Full BenefitsCheckUp Questionnaire</a></li>
        </ol>
    </div>
</div>
<div id="learnmore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Learn More" aria-hidden="true"
     style="display: none;">
    <div class="modal-header" style="border:none;">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i>
        </button>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
</div>
