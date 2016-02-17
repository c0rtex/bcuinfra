<div class="span12">
    <?php
    $dataBridge = "false";
    if (isset($_GET['databridge'])) {
        $dataBridge = $_GET['databridge'];
    }

    if ($dataBridge == "true") {

        $screeningID = $_GET['screeningID'];
        echo "<br/>";
        echo "<b>Unique ID: " . $screeningID . "</b>";
        echo "<br/>";
    }
    ?>


    <h2>Start Making the Most of Your Money!</h2>
    <p>
        Answer 23 simple questions, and you will get a personal report with tips on
        money management and budgeting, staying healthy, and protecting your financial
        information. All recommendations are designed to meet the unique needs of
        seniors.
        <a data-toggle="modal" role="button" href="#gettingstarted"
           href="/wp-content/uploads/2013/07/ECU-ChecklistV2.pdf">Before you start, see a list of information you will
            need</a>.
    </p>
</div>


<div style="background-color:#ffffff; color:#333333; width:100%; padding:25px;" id="liheap_tip">
    <div style="background-color:#ffffff; color:#333333; width:400px;">
        <p align="center" class="text1"><strong>Low Income Home Energy Assistance Program (LIHEAP)</strong></p>
        <p align="center" class="text1">LIHEAP is a federal program.  Your state may call LIHEAP by a different program name.  To find your state LIHEAP program name, see the list below.</p>
    </div>
    <TABLE align="center" style="background-color:#ffffff; color:#333333; font-size:14px;" width="400" border="1" cellpadding="1" class="text1">
        <b>
            <tr><td><b>State</b></td> <td><b>LIHEAP Program Names</b> </td></tr>
            <tr><td>AK	</td><td>Heating Assistance Program (HAP) </td></tr>
            <tr><td>AL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>AR	</td><td>Home Energy Assistance Program </td></tr>
            <tr><td>AZ	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>CA	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
            <tr><td>CO	</td><td>Low Income Energy Assistance Program (LEAP) </td></tr>
            <tr><td>CT	</td><td>Connecticut Energy Assistance Program (CEAP) </td></tr>
            <tr><td>DC	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>DE	</td><td>Delaware Energy Assistance Program (DEAP) </td></tr>
            <tr><td>FL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>GA	</td><td>Regular Energy Assistance Program </td></tr>
            <tr><td>HI	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>IA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>ID	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>IL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>IN	</td><td>Energy Assistance Program </td></tr>
            <tr><td>KS	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
            <tr><td>KY	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>LA	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
            <tr><td>MA	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
            <tr><td>MD	</td><td>Maryland Energy Assistance Program (MEAP) </td></tr>
            <tr><td>ME	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>MI	</td><td>Home Heating Credit/LIHEAP </td></tr>
            <tr><td>MN	</td><td>Energy Assistance Program (EAP) </td></tr>
            <tr><td>MO	</td><td>Low Income Home Energy Assistance Program </td></tr>
            <tr><td>MS	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>MT	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
            <tr><td>NC	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
            <tr><td>ND	</td><td>Heating Assistance or Low-Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>NE	</td><td>Low Income Energy Assistance Program </td></tr>
            <tr><td>NH	</td><td>Fuel Assistance Program </td></tr>
            <tr><td>NJ	</td><td>Home Energy Assistance </td></tr>
            <tr><td>NM	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>NV	</td><td>Energy Assistance Program (EAP) </td></tr>
            <tr><td>NY	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
            <tr><td>OH	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
            <tr><td>OK	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>OR	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
            <tr><td>PA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>RI	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>SC	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>SD	</td><td>The Low Income Energy Assistance Program (LIEAP) </td></tr>
            <tr><td>TN	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>TX	</td><td>Comprehensive Energy Assistance Program (CEAP) </td></tr>
            <tr><td>UT	</td><td>Home Energy Assistance Target (HEAT) </td></tr>
            <tr><td>VA	</td><td>Energy Assistance </td></tr>
            <tr><td>VT	</td><td>Fuel Assistance Program </td></tr>
            <tr><td>WA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
            <tr><td>WI	</td><td>Wisconsin Home Energy Assistance Program (WHEAP) </td></tr>
            <tr><td>WV	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
            <tr><td>WY	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
        </B>
    </TABLE>
    <table border="0" cellpadding="0" width="400" class="text1">
        <TR>
            <TD ALIGN="center" height="38" valign="middle">
                <INPUT style="font-weight:bold;" class="button" TYPE="button" VALUE="Close" ONCLICK="window.close();">
            </TD>
        </TR>
    </table>
</div>

<div class="span12">
    <div class="span8">
        <?php
        //echo "QA".$QA;
        require_once('displaycontent.php');

        //$screening_id = $_GET['Screening_id'];

        if (isset($_POST['continue'])) {
            $continue = $_POST["continue"];
            if ($continue == 2) {
                require_once('processquestions.php');
            }
        }

        ?>

        <?php if ($dataBridge == "true") { ?>

            <script>

                //Lynna Cekova: data bridge, disabled inputs if an agency is viewing the page; currently commented out

                //$(document).ready(function() {
                //$("input").prop('disabled', true);
                //$("select").prop('disabled', true);
                //});

            </script>
        <?php } ?>


        <script>
            /*
             $(document).ready(function() {
             var sidebar = $('.sidebar-nav');
             sidebar.scrollToFixed({
             marginTop: $('.navbar').outerHeight(true) + 50,
             limit: $('#footer').offset().top - $(sidebar).outerHeight() - 53,
             zIndex: 999
             });
             });
             */


            $('#esiForm').bind('keypress keydown keyup', function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                }
            });

            function nextsection($section) {
                //var fname=prompt("Please enter your name:","Your name")
                //document.getElementById("msg").innerHTML="Greetings " + fname
                if ($section == 'basics') {
                    window.location.href = '#income'; //This will open Google in a new window.
                }
                else if ($section == 'income') {
                    window.location.href = '#employment';
                }
                else if ($section == 'employment') {
                    window.location.href = '#debt';
                }
                else if ($section == 'debt') {
                    window.location.href = '#housing';
                }
                else if ($section == 'housing') {
                    window.location.href = '#health';
                }
                else if ($section == 'health') {
                    window.location.href = '#interested';
                }
            }


            //Lynna Cekova, question code=mqc_health_insurance_cover_aep, taking care of the "None of the above" case

            $("#mqc_health_insurance_cover_aep :input").change(function () {


                if ($(this).attr("id") == "mqc_insurance_none_of_the_above") {
                    if ($('input:checkbox[name=mqc_insurance_none_of_the_above]:checked').val() == 'y') {


                        $("#mqc_health_insurance_cover_aep :input").each(function (index, element) {
                            if ($(this).attr("id") != "mqc_insurance_none_of_the_above") {
                                $(this).prop("checked", false);
                            }

                        })
                    }
                }
                else {

                    $('input:checkbox[name=mqc_insurance_none_of_the_above]').prop("checked", false);
                }
            })


            //Lynna Cekova. Q. 5 and 12 (state-specific), taking care of the "noneofabove" case


            $("#mqc_medicareadditional_aep :input").change(function () {


                if ($(this).attr("id") == "mqc_noneofabove") {
                    if ($('input:checkbox[name=mqc_noneofabove]:checked').val() == 'y') {


                        $("#mqc_medicareadditional_aep :input").each(function (index, element) {
                            if ($(this).attr("id") != "mqc_noneofabove") {
                                $(this).prop("checked", false);
                            }

                        })
                    }
                }
                else {

                    $('input:checkbox[name=mqc_noneofabove]').prop("checked", false);
                }
            })


        </script>
        <script src="/cf/ValidationFunctions.js"></script>
        <script src="/cf/scripts.js"></script>
        <form name="esiForm" id="esiForm"
            <?php
            if (QA == 0) {
                $subdomain = 'www';
                $esiprod = 1;
            } else {
                $subdomain = 'redesign';
                $esiprod = 0;
            }
            echo 'action="https://' . $subdomain . '.benefitscheckup.org/cf/esiprocess.cfm?esiprod=' . $esiprod . '"'; ?>
              method="post">
            <!-- Run the section generator script -->
            <?php require_once('section.php') ?>
            <div class="printButton">
                <?php

                //if ($dataBridge != "true") { //Lynna Cekova, commented out as per new requirements
                ?>
                <button class="btn btn-large btn btn-ga" data-gaCategory="economic-checkup"
                        data-gaAction="end-econimic-checkup" id="view_results" type="submit" value="View Your Report"><i
                        class="icon-chevron-right"></i><i class="icon-chevron-right"></i> View Your Report
                </button>
                <?php
                //}
                ?>
            </div>
            <div>
                <p><br/>When your results are displayed, you will see a link to send us comments about
                    how EconomicCheckUp has helped you. Please take a moment to provide us with
                    this information. The more we learn about how EconomicCheckUp helps you, the
                    better we will be able to serve you in the future.</p>
            </div>
    </div>

    <!--span8-->
    <div class="span4" style="margin-top: 60px; margin-left: 12px;">
        <div class="well sidebar-nav">
            <legend><i class="icon-file-alt "></i> Resources</legend>
            <ol class="nav nav-list">


                <li><a data-toggle="modal" role="button" href="#gettingstarted"><i class="icon-book "></i>Getting
                        Started </a></li>
                <li><a href="/wp-content/uploads/2014/11/EconomicCheckUp-Financial-Worksheet.pdf" target="_blank"> <i
                            class="icon-book "></i>Financial Worksheet</a></li>

                <li><a data-toggle="modal" role="button" target="_new"
                       href="/wp-content/uploads/2014/03/ECU-Printable-Assessment.pdf"><i class="icon-print"></i>Get
                        Printable Assessment </a></li>
            </ol>
            <br/>
            Don't understand a question? Click on the question mark symbol <i class="icon-question-sign icon-large"></i>
            next to the question for help.
        </div>
    </div> <!-- span12 -->
</div>
<input type="hidden" name="pgno" value="1">
<input type="hidden" name="qno" value="32">
<input type="hidden" name="aflist"
       value="o-esi_client,s-esi_other_specify,s-esi_zip,n-esi_birth_month,n-esi_birth_year,o-esi_marital,o-esi_gender,o-esi_ethnicity,y-esi_healthdisability,o-esi_chroniccondition,o-esi_ratehealth,o-esi_depression,y-esi_enrolledmedicare,o-esi_medicaresupplement,y-esi_counselor,y-esi_rxhelp,o-esi_housingtype,n-esi_estimatedvalue,n-esi_totaldebthouse,o-esi_housingsituation,y-esi_homeinsurance,y-esi_behind_in_rent,y-esi_moving_save_money,o-esi_rent,c-esi_seekingemployment_usehelp,c-esi_seekingemployment_refresher,c-esi_seekingemployment_skillsassessment,c-esi_seekingemployment_techhelp,c-esi_interest_aps,c-esi_interest_budgeting,c-esi_interest_legal,c-esi_interest_bank,c-esi_interest_protect,c-esi_interest_coupon,c-esi_interest_tax,c-esi_interest_moving,c-esi_interest_pension,c-esi_retire_planner,c-esi_retire_ins,c-esi_retire_will,c-esi_retire_poa,c-esi_retire_resources,o-esi_basicneeds,s-esi_incomesupport,c-receive_msp,c-receive_lis,c-fdstmp_receive,c-liheap_receive,c-med_receive,c-receive_propertytax,n-receive_msp_amount,n-receive_lis_amount,n-receive_snap_amount,n-receive_liheap_amount,n-receive_medicaid_amount,n-receive_property_tax_amount,n-esi_outofpocket,n-esi_food,n-esi_healthmonthly,n-esi_transportation,n-esi_other_expenses,n-esi_debtestimate,c-esi_debtscenarios_creditlimit,c-esi_debtscenarios_minimum,c-esi_debtscenarios_creditors,c-esi_debtscenarios_bankruptcy,y-esi_helpbalancing,i-s_income_pri_retire,i-sp_income_pri_retire,i-s_sp_income_pri_retire_simple,i-hh_income_pri_retire_simple,i-s_income_dividends,i-sp_income_dividends,i-s_sp_income_dividends_simple,i-hh_income_dividends_simple,i-s_income_ssi,i-sp_income_ssi,i-s_sp_income_ssi_simple,i-hh_income_ssi_simple,i-s_income_ss_disable,i-sp_income_ss_disable,i-s_sp_income_ss_disable_simple,i-hh_income_ss_disable_simple,i-s_income_ss_retire,i-sp_income_ss_retire,i-s_sp_income_ss_retire_simple,i-hh_income_ss_retire_simple,i-s_income_rr_ben,i-sp_income_rr_ben,i-s_sp_income_rr_ben_simple,i-hh_income_rr_ben_simple,i-s_income_vet_ben,i-sp_income_vet_ben,i-s_sp_income_vet_ben_simple,i-hh_income_vet_ben_simple,i-s_income_unemploy,i-sp_income_unemploy,i-s_sp_income_unemploy_simple,i-hh_income_unemploy_simple,i-s_income_tanf,i-sp_income_tanf,i-s_sp_income_tanf_simple,i-hh_income_tanf_simple,i-s_income_cash_assist,i-sp_income_cash_assist,i-s_sp_income_cash_assist_simple,i-hh_income_cash_assist_simple,i-s_income_other_nw,i-sp_income_other_nw,i-s_sp_income_other_nw_simple,i-hh_income_other_nw_simple,i-s_income_earned,i-sp_income_earned,i-s_sp_income_earned_simple,i-hh_income_earned_simple,i-s_income_scsep,i-sp_income_scsep,i-s_sp_income_scsep_simple,i-hh_income_scsep_simple,a-s_asset_cash,a-sp_asset_cash,a-s_sp_asset_cash_simple,a-hh_asset_cash_simple,a-s_asset_auto1,a-sp_asset_auto1,a-s_sp_asset_auto1_simple,a-hh_asset_auto1_simple,a-s_asset_auto2,a-sp_asset_auto2,a-s_sp_asset_auto2_simple,a-hh_asset_auto2_simple,a-s_asset_home,a-sp_asset_home,a-s_sp_asset_home_simple,a-hh_asset_home_simple,a-s_asset_retirement,a-sp_asset_retirement,a-s_sp_asset_retirement_simple,a-hh_asset_retirement_simple,a-s_asset_stocks,a-sp_asset_stocks,a-s_sp_asset_stocks_simple,a-hh_asset_stocks_simple,a-s_asset_life_cash,a-sp_asset_life_cash,a-s_sp_asset_life_cash_simple,a-hh_asset_life_cash_simple,a-s_asset_life_face,a-sp_asset_life_face,a-s_sp_asset_life_face_simple,a-hh_asset_life_face_simple,a-s_asset_revocable,a-sp_asset_revocable,a-s_sp_asset_revocable_simple,a-hh_asset_revocable_simple,a-s_asset_irrevocable,a-sp_asset_irrevocable,a-s_sp_asset_irrevocable_simple,a-hh_asset_irrevocable_simple,a-s_asset_other_a,a-sp_asset_other_a,a-s_sp_asset_other_a_simple,a-hh_asset_other_a_simple,c-ck_pri_retire,c-ck_dividends,c-ck_ssi,c-ck_ss_disable,c-ck_ss_retire,c-ck_rr_ben,c-ck_vet_ben,c-ck_unemployment,c-ck_unemploy,c-ck_tanf,c-ck_cash_assist,c-ck_other_nw,c-ck_earned,c-ck_cash,c-ck_auto1,c-ck_auto2,c-ck_home,c-ck_retirement,c-ck_stocks,c-ck_life_cash,c-ck_life_face,c-ck_revocable,c-ck_irrevocable,c-ck_other_a,c-esi_retire_money_management,c-esi_retire_retirement_planning,c-esi_retire_financial_prg_and_svcs,c-esi_retire_senior_tax_deductions,c-esi_retire_legal_concerns,c-ck_scsep,c-esi_retire_unclaimed_property">
<input type="hidden" name="page" value="20">
<input type="hidden" name="continue" value="2">

<?php
if (isset($_GET['screeningID'])) {
    echo '<input type="hidden" name="screeningID" value="' . $_GET['screeningID'] . '">';
}
?>
</form>
<div id="gettingstarted" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Getting Started"
     aria-hidden="true" style="display: none;">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i>
        </button>
        <div><h2>Getting Started</h2></div>
    </div>
    <div class="modal-body">
        <p>We have found that having the necessary information at your fingertips makes completing the questions easier.
            You will need to know the following about yourself or about the person you are helping:</p>
        <ul>
            <li>Zip code</li>
            <li>Date of birth</li>
            <li>Marital status</li>
            <li>Number of people in household</li>
            <li>Type of housing (own home, rental, etc.)</li>
            <li>Overall health status (excellent, very good, good, fair, poor)</li>
            <li>Estimates of current expenses (such as housing, food, health, transportation, debt payments, etc.)</li>
            <li>Estimates of current income and assets from all sources for self, spouse and others in the household
            </li>
            <li>Public benefits received (such as SNAP, Medicaid, etc.) and estimated amounts</li>
        </ul>
        </p>

        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        </div>
    </div>

