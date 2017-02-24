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
        $retVal = $this->render_page($query->query["name"]);

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

        $query = new WP_Query(['post_type' => 'fact-sheets', 'name' => $fact_sheet_slug]);

        $program_code = substr($fact_sheet_slug,10);

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
                'is_alt' => false
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
                'is_alt' => false
            ])->render();
        }
    }

}