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
        return static::querySponsors();
    }

    public static function featured(){
        $featuredSponsors = array();
        $featured = static::querySponsors();        

        foreach ($featured as $key => $value) {
            $isFeatured = Meta::get($value->ID, $key = 'featured', $single = true);
            if(gettype($isFeatured) == "string")
               array_push($featuredSponsors, $value);
        }

        return $featuredSponsors;
    }

    public static function nonFeatured(){
        $nonfeaturedSponsors = array();
        $featured = static::querySponsors();        

        foreach ($featured as $key => $value) {
            $isFeatured = Meta::get($value->ID, $key = 'featured', $single = true);
            if(gettype($isFeatured) == "array")
               array_push($nonfeaturedSponsors, $value);
        }

        return $nonfeaturedSponsors;
    }

    private static function querySponsors(){
        $query = new WP_Query([
            'post_type'         => 'ncoa-sponsors',
            'posts_per_page'    => -1,
            'post_status'       => 'publish',
            'orderby'=> 'title', 
            'order' => 'ASC'
        ]);

        return $query->get_posts();
    }
}

?>
