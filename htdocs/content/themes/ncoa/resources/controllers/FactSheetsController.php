<?php

use Dompdf\Dompdf;
use Dompdf\Options;

class FactSheetsController extends BaseController
{
    /**
     * Returns the home page.
     *
     * @return Response
     */
    public function index($post, $query)
    {

        $retVal = "";

        if (isset($_REQUEST['pdf'])) {
            $retVal = View::make("templates.print-fact-sheet-cover-page", [])->render();
        }

        $retVal = $retVal.$this->render_page($query->query["name"],isset($_REQUEST['pdf']));

        if (array_key_exists('slugs', $_REQUEST)) {
            $slugs = explode(";",$_REQUEST['slugs']);

            foreach($slugs as $slug) {
                $retVal = $retVal.$this->render_page("factsheet_".$slug,true);
            }
        }

        if (isset($_REQUEST['pdf'])) {
            // instantiate and use the dompdf class
            $options = new Options();
            $options->set('isRemoteEnabled', TRUE);
            $options->set('compress',1);
            $options->set('isPhpEnabled', TRUE);
            $dompdf = new Dompdf($options);
            $dompdf->loadHtml($retVal);
            // Render the HTML as PDF
            $dompdf->render();

            // Output the generated PDF to Browser
            $dompdf->stream('BenefitsCheckUp Report');
        }
        else {
            return $retVal;
        }

    }

    public function render_page($fact_sheet_slug, $on_new_page = false) {

        // Detect if SNAP or PAP page
        $is_snap = (strstr($_SERVER['REQUEST_URI'], '_snap_')) ? true : false;
        $is_pap = (strstr($_SERVER['REQUEST_URI'], 'rxco_')) ? true : false;

        $key_benefits_program_codes = array();
        $key_benefits_program_codes['expanded_mdcd']['codes'] = array(
            'medicaid_ak_expanded_medicaid',
            'medicaid_ar_expanded_medicaid',
            'medicaid_az_expanded_medicaid',
            'medicaid_ca_expanded_medicaid',
            'medicaid_co_expanded_medicaid',
            'medicaid_ct_expanded_medicaid',
            'medicaid_dc_expanded_medicaid',
            'medicaid_de_expanded_medicaid',
            'medicaid_hi_expanded_medicaid',
            'medicaid_ia_expanded_medicaid',
            'medicaid_il_expanded_medicaid',
            'medicaid_in_expanded_medicaid',
            'medicaid_ky_expanded_medicaid',
            'medicaid_la_expanded_medicaid',
            'medicaid_ma_expanded_medicaid',
            'medicaid_md_expanded_medicaid',
            'medicaid_mi_expanded_medicaid',
            'medicaid_mn_expanded_medicaid',
            'medicaid_mt_expanded_medicaid',
            'medicaid_nd_expanded_medicaid',
            'medicaid_nh_expanded_medicaid',
            'medicaid_nj_expanded_medicaid',
            'medicaid_nm_expanded_medicaid',
            'medicaid_nv_expanded_medicaid',
            'medicaid_ny_expanded_medicaid',
            'medicaid_oh_expanded_medicaid',
            'medicaid_or_expanded_medicaid',
            'medicaid_pa_expanded_medicaid',
            'medicaid_ri_expanded_medicaid',
            'medicaid_vt_expanded_medicaid',
            'medicaid_wa_expanded_medicaid',
            'medicaid_wv_expanded_medicaid',
        );
        $key_benefits_program_codes['expanded_mdcd']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/M8VFFSD',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/M8VTDDH',
            'not_likely' => 'https://www.surveymonkey.com/r/M8VP7FX',
        );

        $key_benefits_program_codes['mdcd']['codes'] = array(
            'medicaid_ak_medicaid',
            'medicaid_al_medicaid',
            'medicaid_ar_medicaid',
            'medicaid_az_medicaid_ahcccs',
            'medicaid_ca_medicaid_medi_cal',
            'medicaid_co_medicaid',
            'medicaid_ct_medicaid',
            'medicaid_dc_medicaid',
            'medicaid_de_medicaid',
            'medicaid_fl_medicaid',
            'medicaid_ga_medicaid',
            'medicaid_hi_medicaid',
            'medicaid_ia_medicaid',
            'medicaid_id_medicaid',
            'medicaid_il_medicaid',
            'medicaid_in_medicaid',
            'medicaid_ks_medicaid',
            'medicaid_ky_medicaid',
            'medicaid_la_medicaid',
            'medicaid_ma_medicaid_masshealth',
            'medicaid_md_medicaid',
            'medicaid_me_medicaid_mainecare',
            'medicaid_mi_medicaid',
            'medicaid_mn_medicaid',
            'medicaid_mo_medicaid',
            'medicaid_ms_medicaid',
            'medicaid_mt_medicaid',
            'medicaid_nc_medicaid',
            'medicaid_nd_medicaid',
            'medicaid_ne_medicaid',
            'medicaid_nh_medicaid',
            'medicaid_nj_medicaid',
            'medicaid_nm_medicaid',
            'medicaid_nv_medicaid',
            'medicaid_ny_medicaid',
            'medicaid_oh_medicaid',
            'medicaid_ok_medicaid',
            'medicaid_or_medicaid',
            'medicaid_pa_medicaid',
            'medicaid_ri_medicaid',
            'medicaid_sc_medicaid',
            'medicaid_sd_medicaid',
            'medicaid_tn_medicaid_tenncare',
            'medicaid_tx_medicaid',
            'medicaid_ut_medicaid',
            'medicaid_va_medicaid',
            'medicaid_vt_medicaid',
            'medicaid_wa_medicaid',
            'medicaid_wi_medicaid',
            'medicaid_wv_medicaid',
            'medicaid_wy_medicaid',
        );
        $key_benefits_program_codes['mdcd']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/RHGGCR9',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/RHBDG9J',
            'not_likely' => 'https://www.surveymonkey.com/r/RHBTFN7',
        );

        $key_benefits_program_codes['msp']['codes'] = array(
            'health_fd_msp_qmb',
            'health_fd_msp_slmb',
            'health_fd_msp_qi',
            'health_ct_msp_almb',
            'health_az_mcs_qmb',
            'health_az_mcs_slmb',
            'health_az_mcs_qi',
        );
        $key_benefits_program_codes['msp']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/RHHRTKR',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/RHH5ZFF',
            'not_likely' => 'https://www.surveymonkey.com/r/RHP7QZL',
        );

        $key_benefits_program_codes['lis']['codes'] = array('rxgov_fd_medicare_lis');
        $key_benefits_program_codes['lis']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/RHFHNGS',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/RH3STF8',
            'not_likely' => 'https://www.surveymonkey.com/r/RH3BRVH',
        );

        $key_benefits_program_codes['liheap']['codes'] = array('utility_fd_liheap');
        $key_benefits_program_codes['liheap']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/RHZPWBG',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/RH5KZ87',
            'not_likely' => 'https://www.surveymonkey.com/r/RH5RC3C',
        );

        $key_benefits_program_codes['ssi']['codes'] = array(
            'income_fd_ssi',
            'income_ak_ssi',
            'income_ca_ssi',
            'income_co_ssi',
            'income_ct_ssi',
            'income_hi_ssi',
            'income_ia_ssi',
            'income_id_ssi',
            'income_ma_ssi',
            'income_me_ssi',
            'income_mi_ssi',
            'income_mn_ssi',
            'income_mt_ssi',
            'income_ne_ssi',
            'income_nh_ssi',
            'income_nj_ssi',
            'income_nv_ssi',
            'income_ny_ssi',
            'income_ok_ssi',
            'income_or_ssi',
            'income_pa_ssi',
            'income_ri_ssi',
            'income_sd_ssi',
            'income_ut_ssi',
            'income_vt_ssi',
            'income_wa_ssi',
            'income_wi_ssi',
        );
        $key_benefits_program_codes['ssi']['survey'] = array(
            'very_likely' => 'https://www.surveymonkey.com/r/RH6VY2W',
            'somewhat_likely' => 'https://www.surveymonkey.com/r/RHZLLNB',
            'not_likely' => 'https://www.surveymonkey.com/r/RH6MN5X',
        );

        $key_benefits_program = false;
        foreach ($key_benefits_program_codes as $index => $categories) {
            foreach ($categories['codes'] as $key => $code) {
                if (strstr($_SERVER['REQUEST_URI'], $code)) {
                    $key_benefits_program['survey_links'] = $categories['survey'];
                    break 2;
                }
            }
        }

        // Should we display the 'Find Out if Elegible' link?
        if (array_key_exists('elegible', $_REQUEST)) {
            $elegible = $_REQUEST['elegible'];
        } else {
            $elegible = 'y';
        }

        $query = new WP_Query(['post_type' => 'fact-sheets', 'name' => $fact_sheet_slug]);

        $program_code = substr($fact_sheet_slug, 10);

        $constants = Config::get('constants');

        if (array_key_exists('state', $_REQUEST)) {
            $program_state = $_REQUEST['state'];
        } else {
            $program_state = Meta::get($query->queried_object_id, 'program_state_id');
        }

        $requiredMaterials = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/materials/required/forProgram/'.$program_code)->send();
        $requiredMaterials = json_decode($requiredMaterials->body);

        if (array_key_exists("short_layout",$_REQUEST)) {
            $layout = "layouts.short";
        } else {
            $layout = "layouts.main";
        }

        if (array_key_exists('short',$_REQUEST)) {

            $template = 'templates.short-fact-sheets';

            if (isset($_REQUEST['pdf']) || isset($_REQUEST['print'])) {
                $template = 'templates.print-short-fact-sheets';
            }

            return View::make($template, [
                'on_new_page' => $on_new_page,
                'page_slug' => $fact_sheet_slug,
                'app_forms_uri' => $constants['APPLICATION_FORMS_URL'],
                'layout' => $layout,
                'required_materials' => $requiredMaterials,
                'is_alt' => false,
                'is_snap' => $is_snap,
                'is_pap' => $is_pap,
                'elegible' => $elegible,
                'key_benefits_program' => $key_benefits_program
            ])->render();

        } else {

            if (array_key_exists('zipcode',$_REQUEST)) {
                $zipcode = $_REQUEST['zipcode'];
            } else {
                $zipcode = '';
            }

            $entryPoints = \Httpful\Request::get($constants['WEB_SERVICE_URL'] . '/rest/backend/entryPoints/forProgram/' . $program_code.'?zipcode='.$zipcode)->send();

            $entryPoints = json_decode($entryPoints->body);

            $appForms = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/forms/appForms/forProgram/'.$program_code.'/?stateId='.$program_state)->send();

            $appForms = json_decode($appForms->body);

            $becs = \Httpful\Request::get($constants['WEB_SERVICE_URL'] . '/rest/backend/entryPoints/becs/'.$zipcode)->send();

            $becs = json_decode($becs->body);

            $faqsList = Meta::get(Loop::id(), $key = 'faqs-list', $single = true);

            $template = 'templates.fact-sheets';

            if (isset($_REQUEST['pdf']) || isset($_REQUEST['print'])) {
                $template = 'templates.print-fact-sheets';
            }

            return View::make($template, [
                'on_new_page' => $on_new_page,
                'page_slug' => $fact_sheet_slug,
                'entry_points' => $entryPoints,
                'layout' => $layout,
                'app_forms' => $appForms,
                'app_forms_uri' => $constants['APPLICATION_FORMS_URL'],
                'required_materials' => $requiredMaterials,
                'faqs_list' => $faqsList,
                'becs' => $becs,
                'is_alt' => false,
                'is_snap' => $is_snap,
                'is_pap' => $is_pap,
                'elegible' => $elegible,
                'key_benefits_program' => $key_benefits_program
            ])->render();
        }
    }

}