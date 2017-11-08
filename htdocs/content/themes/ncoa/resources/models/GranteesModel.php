<?php

class GranteesModel {

    /**
     * Return a list of all published posts.
     *
     * @return array
     */
    public static function all()
    {
        $query = new WP_Query([
            'post_type' => 'grantees',
            'posts_per_page' => -1,
            'orderby'=> 'post_title',
            'order' => 'ASC'
        ]);

        $grantees = $query->get_posts();
        $states = json_decode(Config::get('constants')["US_STATES"],true);
        $retVal = array();
        foreach($grantees as $gr) {
            $post = GranteesModel::formatGrantee($gr);
            $state = $states[$post["state"]];

            if (!array_key_exists($state,$retVal)) {
                $retVal[$state] = array();
            }
            array_push($retVal[$state],$post);
        }
        ksort($retVal);
        return $retVal;
    }

    private static function formatGrantee($post) {
        $grantee = array();
        $grantee["name"] = $post->post_title;
        $post_meta = get_post_meta($post->ID);
        foreach($post_meta as $key=>$value) {
            $grantee[$key] = $value[0];
        }
        return $grantee;
    }

} 