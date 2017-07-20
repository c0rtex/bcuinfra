<?php

class HomeController extends BaseController
{
    /**
     * Returns the home page.
     *
     * @return Response
     */
    public function index()
    {
        $constants = Config::get('constants');
        setlocale(LC_MONETARY, 'en_US');

        try {
            $people_count = number_format(\Httpful\Request::get($constants['WEB_SERVICE_URL'] . '/rest/backend/vob/countpeople')->send()->raw_body);
            $vob_count = $this->_thousandsCurrencyFormat(\Httpful\Request::get($constants['WEB_SERVICE_URL'] . '/rest/backend/vob/countvob')->send()->raw_body);

            update_post_meta(get_the_ID(), 'people-count', $people_count);
            update_post_meta(get_the_ID(), 'vob-count', $vob_count);
        } catch (Exception $e) {
            $people_count = Meta::get(get_the_ID(),'people-count',true);
            $vob_count = Meta::get(get_the_ID(),'vob-count',true);
        }

        // Replace {placeholder} in headline.
        $placeholders = array(
            '{people_count}' => $people_count,
            '{vob_count}' => '$' . $vob_count,
        );

        $headline = Meta::get(get_the_ID(), $key = 'headline', $single = true);
        foreach ($placeholders as $search => $replace) {
            $headline = str_replace($search, $replace, $headline);
        }

        $testimonials = Meta::get(get_the_ID(), $key = 'testimonial-item', $single = true);
        $betterwaysection = Meta::get(get_the_ID(), $key = 'benefit-item', $single = true);
        $benefits = Meta::get(get_the_ID(), $key = 'benefits', $single = true);

        return View::make('templates.homepage',[
            'webServiceUrl' => $constants['WEB_SERVICE_URL'],
            'sponsors' 				=> SponsorsModel::all(),
            'testimonials' 			=> $testimonials,
            'betterwaysection' 		=> $betterwaysection,
            'benefits'				=> $benefits,
            'headline'        => $headline
        ]);
    }

    /**
     * Convert number to string.
     *
     * @param $number
     * @return float|string
     */
    private function _thousandsCurrencyFormat($number) {
        $x = round($number);
        $x_number_format = number_format($x);
        $x_array = explode(',', $x_number_format);
        $x_parts = array('', 'million', 'billion', 'trillion');
        $x_count_parts = count($x_array) - 1;
        $x_display = $x;
        $x_display = $x_array[0] . ((int) $x_array[1][0] !== 0 ? '.' . $x_array[1][0] : '');
        $x_display .= ' ' . $x_parts[$x_count_parts - 1];
        return $x_display;
    }

    public function whiteLabelIndex()
    {
        $testimonials = Meta::get(get_the_ID(), $key = 'testimonial-item', $single = true);

        if(empty($testimonials[1]["testimonial-image"]))
            $testimonials = [];

        $callouts = Meta::get(get_the_ID(), $key = 'callout-item', $single = true);

        return View::make('templates.white-label-homepage',[
            'testimonials' 			=> $testimonials,
            'callouts'				=> $callouts
        ]);
    }

}
