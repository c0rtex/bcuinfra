<?php

class SponsorsModel
{

    /**
     * Return a list of all published posts.
     * 
     * @return array
    */
    public static function all()
    {   
        $query = new WP_Query([
            'post_type'         => 'ncoa-sponsors',
            'posts_per_page'    => -1,
            'post_status'       => 'publish',
            'orderby'=> 'title', 
            'order' => 'ASC'
        ]);

        return $query->get_posts();
    }


    /**
     * Return a list of all Featued Sponosrs
     * 
     * @return array
    */
    public static function queryFeaturedSponsors(){
        $query = new WP_Query([
            'post_type'         => 'ncoa-sponsors',
            'posts_per_page'    => -1,
            'post_status'       => 'publish',
            'meta_query'        => array(
                                        array(
                                            'key' => 'featured',
                                            'value' => '0'
                                        )
                                    ),
            'orderby'=> 'title', 
            'order' => 'ASC'
        ]);

        return $query->get_posts();
    }

    /**
     * Return a list of all Non Featued Sponosrs by their menu order in WP Admin
     * 
     * @return array
    */

    public static function queryNonFeaturedSponosrs(){
        $query = new WP_Query([
            'post_type'         => 'ncoa-sponsors',
            'posts_per_page'    => -1,
            'meta_query'        => array(
                                        array(
                                            'key' => 'featured',
                                            'value' => 'a:0:{}'  // This is how WP is inserting non checked values :(
                                        )
                                    ),
            'orderby'           => 'menu_order',
            'order'             => 'ASC'
        ]);

        return $query->get_posts();
    }

    
}

?>
