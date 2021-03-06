<?php

/**
 * Class for managing AddThis script includes across all its plugins.
 */
Class AddThis_addjs{
    /**
    * var bool check to see if we have added our JS already.  Ensures that we don't add it twice
    */
    private $_js_added;

    private $_options;

    private $_cuid;

    var $pubid;
    
    var $jsToAdd;

    var $jsAfterAdd;

    var $atversion;

    var $productCode;

    const addjs_version = 1;

    /**
    *
    */
    public function __construct ($options){
        if ( did_action('addthis_addjs_created') !== 0){
            _doing_it_wrong( 'addthis_addjs', 'Only one instance of this class should be initialized.  Look for the $addthis_addjs global first',1 ); 
        }

        $this->productCode = ADDTHIS_PRODUCT_VERSION;

        // We haven't added our JS yet. Or at least better not have.
        $this->_js_added = false;

        $this->_options = $options;
        
        // Version of AddThis code to use
        if (is_array($options)) {
       		$this->atversion = array_key_exists('atversion_update_status', $options) && $options['atversion_update_status'] == ADDTHIS_ATVERSION_REVERTED ? $options['atversion'] : ADDTHIS_ATVERSION;
        }
        // set the cuid
        $base = get_option('home');
        $cuid = hash_hmac('md5', $base, 'addthis'); 
        $this->_cuid = $cuid;

        // If the footer option isn't set, check for it
        if (! isset($this->_options['wpfooter']) && current_user_can('manage_options'))
        {
            add_action('admin_init',array($this, 'update_wpfooter'));
        }

        $this->pubid = $this->getProfileId();

        // on theme swich, check for footer again
        add_action('switch_theme', array($this, 'switch_theme'),15);

        // In order for our wp_footer magic to work, we need to sometimes add our stuff 
        add_action('init', array($this, 'maybe_add_footer_comment'));


        // Footer
        if ( isset($this->_options['wpfooter']) && $this->_options['wpfooter'])
            add_action('wp_footer', array($this, 'output_script') );
        else
            add_filter('the_content', array($this, 'output_script_filter') );

        do_action('addthis_addjs_created');
    }

    function switch_theme(){
        $footer = $this->check_for_footer();
        $this->_options['wpfooter'] = $footer;
        update_option( 'addthis_settings', $this->_options); 
    }

    function output_script(){
        if ($this->_js_added != true)
        {
            $this->wrapJs();
            $this->addWidgetToJs();
            $this->addAfterToJs();
            echo $this->jsToAdd;
            $this->_js_added = true;
            $this->jsToAdd = false;
        } else {        	
        	 $this->addAfterToJs();
        	 echo $this->jsToAdd;
             $this->jsToAdd = false;
        }
    }

    function output_script_filter($content){
        if ($this->_js_added != true && ! is_admin() && ! is_feed() )
        {
            $this->wrapJs();
            $this->addWidgetToJs();
            $this->addAfterToJs();
            $content = $content . $this->jsToAdd;
            $this->_js_added = true;
        }
        return $content;
    }

    function wrapJs(){
        $this->jsToAdd .= "var addthis_for_wordpress = '".$this->productCode."';\n";
        $this->jsToAdd = '<script type="text/javascript">' . $this->jsToAdd . '</script>';
    }

    /* testing for wp_footer in a theme stuff */
    function update_wpfooter(){
        $footer = $this->check_for_footer();
        $options = $this->_options;
        $options['wpfooter'] = $footer;
        update_option( 'addthis_settings', $options); 
        $this->_options = $options;
    }

    function check_for_footer(){
        $url = home_url();
        $response = wp_remote_get( $url, array( 'sslverify' => false ) );
        $code = (int) wp_remote_retrieve_response_code( $response );
            if ( $code == 200 ) {
                $html = preg_replace( '/[   
                s]/', '', wp_remote_retrieve_body( $response ) );
                return (bool)( strstr( $html, '<!--wp_footer-->' ) );
            }
    }
    
    function maybe_add_footer_comment(){
            add_action( 'wp_footer', array($this, 'test_footer' ), 99999 ); // Some obscene priority, make sure we run last
    }
    
    /* END testing for wp_footer in a theme stuff */
    function addToScript($newData){
        $this->jsToAdd .= $newData;
    }
    
    function addAfterScript($newData){
    	if ( $this->_js_added != true )
        {
        	$this->jsAfterAdd .= $newData;
        } else {
        	$this->jsAfterAdd = $newData;
        }
    }

    function addWidgetToJs(){
        $addthis_settings_options = get_option('addthis_settings');
        $addthis_asynchronous_loading = (isset($addthis_settings_options['addthis_asynchronous_loading']))?$addthis_settings_options['addthis_asynchronous_loading']:false;
        if(isset($addthis_asynchronous_loading) && $addthis_asynchronous_loading) {
            $this->jsToAdd .= '<script type="text/javascript" src="//s7.addthis.com/js/'.$this->atversion.'/addthis_widget.js#pubid='. urlencode( $this->pubid ).'&async=1"></script>';
            //$this->jsToAdd .= '<script type="text/javascript" src="http://cache-dev.addthis.com/cachefly/js/300/addthis_widget.js&async=1"></script>';
            $this->jsToAdd .= '<script type="text/javascript">jQuery(document).ready(function($) { addthis.init(); }); </script>';
        } else {
            //$this->jsToAdd .= '<script type="text/javascript" src="http://cache-dev.addthis.com/cachefly/js/300/addthis_widget.js#pubid='. urlencode( $this->pubid ).'"></script>';
            $this->jsToAdd .= '<script type="text/javascript" src="//s7.addthis.com/js/'.$this->atversion.'/addthis_widget.js#pubid='. urlencode( $this->pubid ).'"></script>';
        }
    }

    function addAfterToJs(){
        if (! empty($this->jsAfterAdd)) {
            $this->jsToAdd .= '<script type="text/javascript">' . $this->jsAfterAdd . '</script>';
            $this->jsAfterAdd = NULL;
        }
    }

    function getProfileId(){
        return( isset( $this->_options['profile'] ) && ! empty($this->_options['profile']) )?  $this->_options['profile'] : null;
    }

    function setProfileId($profile){
        $this->_options['profile'] = sanitize_text_field($profile);
        update_option( 'addthis_settings', $this->_options); 
    }

    function test_footer(){
        echo '<!--wp_footer-->';
    }

    function getAtPluginPromoText(){
        // Included not to break the other plugins(smartlayer)
        if (! did_action('admin_init') && !  current_filter('admin_init'))
        {
            _doing_it_wrong('getAtPluginPromoText', 'This function should only be called on an admin page load and no earlier the admin_init', 1);
            return null;
        }
        return null;
    }
}
