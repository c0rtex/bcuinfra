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
        /*$home_url = home_url();
        $fact_sheet_url = home_url($_SERVER['REDIRECT_URL']);
        $to = 'ctxuser@gmail.com';
        $subject = 'BenefitsCheckUp Fact Sheet';
        $body = <<<EOT
    Thank you for using BenefitsCheckUp to help you find programs that you may be eligible for or interested in getting information about. Here is a link to the program fact sheet you requested should be emailed to you:

    {$fact_sheet_url}

    BenefitsCheckUp constantly updates the database with new information for existing programs and adds new programs on a regular basis. Please feel free to use the BenefitsCheckUp site at any time.
    {$home_url}

    Have a wonderful day!
    BenefitsCheckUp Team
    EOT;

        wp_mail( $to, $subject, $body );*/

        $fact_sheet_slug = $query->query["name"];

        $program_code = Meta::get($query->queried_object_id, 'program_code');

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

            $return = View::make($template, [
                'page_slug' => $fact_sheet_slug,
                'app_forms_uri' => $constants['APPLICATION_FORMS_URL'],
                'layout' => $layout,
                'required_materials' => $requiredMaterials,
                'is_alt' => false
            ])->render();

            if (isset($_REQUEST['pdf'])) {
                // instantiate and use the dompdf class
                $options = new Options();
                $options->set('isRemoteEnabled', TRUE);
                $dompdf = new Dompdf($options);
                $dompdf->loadHtml($return);

                // Render the HTML as PDF
                $dompdf->render();

                // Output the generated PDF to Browser
                $dompdf->stream('Fact Sheet - ' . $post->post_title);
            }
            else {
                return $return;
            }

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

            $return = View::make($template, [
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

            if (isset($_REQUEST['pdf'])) {
                // instantiate and use the dompdf class
                $options = new Options();
                $options->set('isRemoteEnabled', TRUE);
                $dompdf = new Dompdf($options);
                $dompdf->loadHtml($return);

                // Render the HTML as PDF
                $dompdf->render();

                // Output the generated PDF to Browser
                $dompdf->stream('Fact Sheet - ' . $post->post_title);
            }
            else {
                return $return;
            }

        }
    }

}