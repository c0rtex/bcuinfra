<?php

class BaseController extends Controller
{
    /**
     * Setup the layout used by the controller.
     *
     * @return void
     */
    protected function setupLayout()
    {
        if (!is_null($this->layout))
        {
            $this->layout = Pronto::make($this->layout);
        }

        // Register a new body class.
        add_filter('body_class', array($this, 'bodyClass'));

        // Ensure global assets are added.
        $this->registerGlobalAssets();
    }

    /**
     * Adds the page or post slug to the body
     *
     * @return void
     */
    public function bodyClass($classes)
    {
        // Grab the current post and add the slug.
        global $post;
        if (isset($post)) {
            $classes[] = $post->post_type . '-' . $post->post_name;
        }

        return $classes;
    }

    /**
     * Registers global assets to the controllers.
     *
     * @return void.
     */
    protected function registerGlobalAssets()
    {
        // Asset::add('styles', 'css/main.css', false, false, 'all');
        // Asset::add('ncoa-libs', 'js/libs.js', false, false, true);
        // Asset::add('ncoa-main', 'js/app.js', array('ncoa-libs'), false, true);
    }
} 