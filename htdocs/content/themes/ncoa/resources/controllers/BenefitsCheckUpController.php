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

        // @TODO: Post IDs should not be hard-coded...
        $programs_default_lang_full_posts_ids = array(
            'bcuqc_category_income' => 12179,
            'bcuqc_category_nutrition' => 12173,
            'bcuqc_category_education' => 12137,
            'bcuqc_category_discounts' => 12131,
            'bcuqc_category_employment' => 12149,
            'bcuqc_category_utility' => 12167,
            'bcuqc_category_medicaid' => 12185,
            'bcuqc_category_rx' => 12191,
            'bcuqc_category_property_taxrelief' => 12161,
            'bcuqc_category_veteran' => 12155,
            'bcuqc_category_other_assistance' => 12125,
            'bcuqc_category_transportation' => 12143
        );
        $programs_default_lang_pre_posts_ids = array(
            'bcuqc_category_income' => 13167,
            'bcuqc_category_nutrition' => 13161,
            'bcuqc_category_education' => 13125,
            'bcuqc_category_discounts' => 13119,
            'bcuqc_category_employment' => 13137,
            'bcuqc_category_utility' => 13155,
            'bcuqc_category_medicaid' => 13173,
            'bcuqc_category_rx' => 13179,
            'bcuqc_category_property_taxrelief' => 13149,
            'bcuqc_category_veteran' => 13143,
            'bcuqc_category_other_assistance' => 13113,
            'bcuqc_category_transportation' => 13131
        );

        foreach ($programs_default_lang_pre_posts_ids as $code => $post_id) {
            $post = get_post($post_id);
            $programs_default_langs_pre[$code] = strip_tags(preg_replace("/[\n\r]/", '', $post->post_content));
        }
        $programs_default_langs_pre = json_encode($programs_default_langs_pre);

        foreach ($programs_default_lang_full_posts_ids as $code => $post_id) {
            $post = get_post($post_id);
            $programs_default_langs_full[$code] = strip_tags(preg_replace("/[\n\r]/", '', $post->post_content));
        }
        $programs_default_langs_full = json_encode($programs_default_langs_full);

        return View::make('templates.benefitscheckup', [
            'webServiceUrl' => $constants['WEB_SERVICE_URL'],
            'defaultLangsFull' => $programs_default_langs_full,
            'defaultLangsPre' => $programs_default_langs_pre
        ]);
    }

}