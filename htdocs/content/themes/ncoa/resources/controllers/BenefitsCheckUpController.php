<?php

class BenefitsCheckUpController extends BaseController
{
    /**
     * Returns the home page.
     *
     * @return Response
     */
    public function index()
    {
        $constants = Config::get('constants');

        $programs_default_languages = array();
        // @TODO: Post IDs should not be hard-coded...
        $programs_default_language_posts_ids = array(
            'bcuqc_category_income' => 12179,
            'bcuqc_category_nutrition' => 12173,
            'bcuqc_category_education' => 12137,
            'bcuqc_category_discounts' => 12131,
            'bcuqc_category_employment' => 12149,
            'bcuqc_category_utility' => 12167,
            'bcuqc_category_medicaid' => 12191,
            'bcuqc_category_rx' => 12185,
            'bcuqc_category_property_taxrelief' => 12161,
            'bcuqc_category_veteran' => 12155,
            'bcuqc_category_other_assistance' => 12125,
            'bcuqc_category_transportation' => 12143
        );

        foreach ($programs_default_language_posts_ids as $code => $post_id) {
            $post = get_post($post_id);

            $programs_default_languages[$code] = $post->post_content;
        }
        $programs_default_languages = json_encode($programs_default_languages);

        return View::make('templates.benefitscheckup', [
            'webServiceUrl' => $constants['WEB_SERVICE_URL'],
            'defaultLangs' => $programs_default_languages
        ]);
    }

}