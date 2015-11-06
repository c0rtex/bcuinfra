<?php

/*

Plugin Name: Post Page Associator
Plugin URI: http://dennishoppe.de/wordpress-plugins/post-page-associator
Description: The Post-Page-Associator enables you to attach posts to a page.
Version: 1.3.22
Author: Dennis Hoppe
Author URI: http://DennisHoppe.de

*/


// Plugin Class
If (!Class_Exists('wp_plugin_post_page_associator')){
Class wp_plugin_post_page_associator {
  var $base_url;
  var $the_current_post;

  Function __construct(){
    // Read base
    $this->base_url = get_bloginfo('wpurl').'/'.Str_Replace("\\", '/', SubStr(RealPath(DirName(__FILE__)), Strlen(ABSPATH)));

    // Get ready to translate
    Add_Action('init', Array($this, 'Load_TextDomain'));

    // This Plugin supports post thumbnails
    Add_Theme_Support('post-thumbnails');

    // Hooks & Filters
    If (Is_Admin()){
      WP_Enqueue_Style ( 'ppa-admin-style', $this->base_url . '/admin.css');
      Add_Action ('admin_menu', Array($this, 'Add_Options_Page'));
      Add_Action ('add_meta_boxes', Array($this, 'Add_Meta_Box'));
      Add_Action ('save_post', Array($this, 'Save_Meta_Box'));
      Add_Filter ('admin_footer_text', Array($this, 'Marketing_Footer'));
    }
    Else {
      Add_Shortcode ('associated_posts', Array($this, 'shortcode'));
      Add_Filter ('the_content', Array($this, 'filter_content'), 9);
      Add_Action ('wp_print_styles', Array($this, 'Enqueue_Template_Style'));
    }
    
    // Add to GLOBALS
    $GLOBALS[__CLASS__] = $this;
  }
  
  Function Load_TextDomain(){
    $locale = Apply_Filters( 'plugin_locale', get_locale(), __CLASS__ );
    Load_TextDomain (__CLASS__, DirName(__FILE__).'/language/' . $locale . '.mo');
  }
  
  Function t ($text, $context = ''){
    // Translates the string $text with context $context
    If ($context == '')
      return Translate ($text, __CLASS__);
    Else
      return Translate_With_GetText_Context ($text, $context, __CLASS__);
  }
  
  Function Add_Options_Page (){
    add_submenu_page(
      'options-general.php',
      $this->t('Associated Posts Settings'),
      $this->t('Associated Posts'),
      'manage_options',
      __CLASS__,
      Array($this, 'Print_Options_Page')
    );
  }

  Function Print_Options_Page(){
    ?><div class="wrap">
      <?php screen_icon(); ?>
      <h2><?php Echo $this->t('Associated Posts') ?></h2>
      
      <form method="post" action="">
        
        <?php If ($this->Save_Options()) : ?>
          <div id="message" class="updated fade"><p><strong><?php _e('Settings saved.') ?></strong></p></div>
        <?php EndIf; ?>
        
        <?php Include DirName(__FILE__).'/options-page.php' ?>
        
        <div style="max-width:600px">
          <?php do_action('dh_contribution_message') ?>
        </div>
        
        <p class="submit">
          <input type="submit" name="Submit" class="button-primary" value="<?php _e('Save Changes') ?>" />
        </p>
      </form>

    </div><?php
  }
  
  Function Save_Options(){
    // If there is no post data we bail out
    If (Empty($_POST)) return False;
    
    // Save options
    Update_Option (__CLASS__, StripSlashes_Deep($_POST));
    
    // Everything is ok =)
    return True;
  }

  Function Get_Option($key = Null, $default = False){
    $arr_option = (Array) get_option(__CLASS__);
    If ($key == Null) return $arr_option;
    ElseIf (IsSet ($arr_option[$key])) return $arr_option[$key];
    Else return $default;
  }
  
  Function Add_Meta_Box(){
    ForEach ( (Array) get_post_types(Array('public' => True, 'show_ui' => True), 'objects') AS $post_type ){
      If ($post_type->name == 'page'){
        // Add Meta box to pages
        Add_Meta_Box(
          __CLASS__,
          $this->t('Associate posts with this page'),
          Array($this, 'Print_Meta_Box'),
          'page',
          'normal',
          'default'
        );
      }
      ElseIf(!$this->get_option('hide_premium_banner')){
        // Add Marketing Meta box custom post types
        Add_Meta_Box(
          __CLASS__,
          $this->t('Associated Posts'),
          Array($this, 'Print_Marketing_Meta_Box'),
          $post_type->name,
          'side',
          'low'
        );
      }
    }
  }

  Function Print_Meta_Box(){ Include DirName(__FILE__).'/meta-box.php'; }

  Function Find_Templates(){
    $arr_template = Array_Merge (
      (Array) Glob ( DirName(__FILE__) . '/templates/*.php' ),
      (Array) Glob ( DirName(__FILE__) . '/templates/*/*.php' ),

      (Array) Glob ( get_stylesheet_directory() . '/*.php' ),
      (Array) Glob ( get_stylesheet_directory() . '/*/*.php' ),

      is_child_theme() ? (Array) Glob ( get_template_directory() . '/*.php' ) : Array(),
      is_child_theme() ? (Array) Glob ( get_template_directory() . '/*/*.php' ) : Array(),

      (Array) Glob ( WP_CONTENT_DIR . '/ppa-templates/*.php' ),
      (Array) Glob ( WP_CONTENT_DIR . '/ppa-templates/*/*.php' )
    );
    
    // Filter to add template files - you can use this filter to add template files to the user interface
    $arr_template = (Array) Apply_Filters('associated_posts_template_files', $arr_template);
    
    // Check if there template files
    If (Empty($arr_template)) return False;
    
    $arr_result = Array();
    $arr_sort = Array();
    ForEach ($arr_template AS $index => $template_file){
      // Check file
      If (!$template_file || !Is_File ($template_file) || !Is_Readable($template_file)) Continue;
      
      // Read meta data from the template
      $arr_properties = get_file_data ($template_file, Array(
        'name' => 'PPA Template',
        'description' => 'Description',
        'author' => 'Author',
        'author_uri' => 'Author URI',
        'author_email' => 'Author E-Mail',
        'version' => 'Version'
      ));
      
      // Check if there is a name for this template
      If ( Empty($arr_properties['name']) && BaseName($template_file) != 'associated-posts.php' ) Continue;
      
      // Add to the result array
      $arr_result[RealPath($template_file)] = $arr_properties;
      $arr_sort[RealPath($template_file)] = $arr_properties['name'];
    }
    Array_MultiSort($arr_sort, $arr_result);
    
    return $arr_result;
  }
  
  Function Get_Default_Template(){
    $template_file = RealPath(Get_Query_Template( 'associated-posts' ));
    If (!Is_File($template_file))
      $template_file = RealPath(DirName(__FILE__) . '/templates/title-excerpt-thumbnail.php');
    return $template_file;
  }

  
  Function Field_Name($option_name){
    return __CLASS__ . '[' . $option_name . ']';
  }

  Function Save_Meta_Box($post_id){
    // If this is an autosave we dont care
    If ( Defined('DOING_AUTOSAVE') && DOING_AUTOSAVE ) return;
    
    // Check if this request came from the edit page section
    If (!IsSet($_POST[ __CLASS__ ])) return False;
    
    // Delete old data
    delete_post_meta($post_id, '_wp_plugin_associate_posts_and_pages');
    
    // Meta data
    $arr_options = (Array) $_POST[ __CLASS__ ];
    
    // Check if the user want to attach posts
    If ( !Empty($arr_options) &&
         !( Empty($arr_options['category']) &&
            Empty($arr_options['tag']) &&
            Empty($arr_options['author']) &&
            Empty($arr_options['post'])
         )
       )
    {
      update_post_meta ($post_id, '_' . __CLASS__, $arr_options);    
    }
    Else {
      delete_post_meta ($post_id, '_' . __CLASS__ );
    }
    
  }

  Function Enqueue_Template_Style(){
    // Find the template
    $association_data = $this->get_association_data();
    $template_file = $association_data['template'];
    If (!Is_File($template_file)) $template_file = $this->get_default_template();
    
    // If there is no style sheet we bail out
    If (!Is_File(DirName($template_file) . '/' .  BaseName($template_file, '.php') . '.css'))
      return False;    
    
    // Locate the URL of the style sheet
    $style_sheet = get_bloginfo('wpurl') . '/' .
                   Str_Replace("\\", '/', SubStr(RealPath(DirName($template_file)), Strlen(ABSPATH))) . '/' .
                   BaseName($template_file, '.php') . '.css';

    // run the filter for the template file
    $style_sheet = Apply_Filters('associated_posts_style_sheet', $style_sheet);
    
    // Print the stylesheet link
    If ($style_sheet) WP_Enqueue_Style('ppa-template', $style_sheet);
  }

  Function Shortcode($attr = Null){
    // Convert $attr to an array
    // $attr = (Array) $attr;

    // Print the posts
    return $this->render_associated_posts();    
  }
  
  Function Render_Associated_Posts(){
    // Get the association settings
    If (!$meta = $this->get_association_data())
      return False;
    Else
      $template_file = $meta['template'];
    
    // Uses filter
    $template_file = Apply_Filters('associated_posts_template', $template_file);
    
    // If there is no valid template file we bail out
    If (!Is_File($template_file)) $template_file = $this->get_default_template();
    
    // Look whats the current post
    If (Is_Object($GLOBALS['post'])) $this->the_current_post = clone $GLOBALS['post'];
    
    // Use the template
    Ob_Start();
    Include $template_file;
    $result = Ob_Get_Contents();
    Ob_End_Clean();
    
    // Restore post data
    If (Is_Object($this->the_current_post)) $GLOBALS['post'] = clone $this->the_current_post;
    Unset ($this->the_current_post);
    Setup_PostData($GLOBALS['post']);
    
    // return code
    return $result;
  }
  
  Function Get_Association_Data($post_id = Null){
    // Get the post id
    If ($post_id == Null && Is_Object($GLOBALS['post']))
      $post_id = $GLOBALS['post']->ID;
    ElseIf ($post_id == Null && !Is_Object($GLOBALS['post']))
      return False;
    
    // Read the meta data
    $meta = Array_Merge(
      Array(
        'category_select_mode' => 'or_one',
        'category' => Array(),
        'tag_select_mode' => 'or_one',
        'tag' => Array(),
        'author_select_mode' => 'or',
        'author' => Array(),
        'post' => Array(),
        'post_limit' => '',
        'order_by' => 'date',
        'order' => 'ASC',
        'template' => self::get_default_template()
      ),
      (Array) get_post_meta($post_id, '_wp_plugin_associate_posts_and_pages', True), // Deprecated
      (Array) get_post_meta($post_id, '_' . __CLASS__, True)
    );

    // Check if there are assoication meta data
    If ( Empty($meta['category']) &&
         Empty($meta['tag']) &&
         Empty($meta['author']) &&
         Empty($meta['post'])
       )
      Return False;
    Else
      Return $meta;  
  }

  Function Get_Associated_Posts ($post_id = Null){
    // If there is no post_id we try to ready it
    If ($post_id == Null) $post_id = get_the_id();
    
    // If there is even no post_id we bail out
    If (!$post_id) return False;
    
    // read the associated category
    If (!$association = self::get_association_data($post_id))
      return False;
    
    // Filter posts
    $arr_post_category = Array();
    $arr_post_tag = Array();
    $arr_post_author = Array();
    $arr_post = Array();
    
    // By Category
    If (!Empty($association['category']))
      If ($association['category_select_mode'] == 'or_one' || $association['category_select_mode'] == 'and_one')
        $arr_post_category = self::get_post_ids_by_category($association['category'], 'or');
      ElseIf ($association['category_select_mode'] == 'or_all' || $association['category_select_mode'] == 'and_all')
        $arr_post_category = self::get_post_ids_by_category($association['category'], 'and');
    
    // By Tag
    If (!Empty($association['tag']))
      If ($association['tag_select_mode'] == 'or_one' || $association['tag_select_mode'] == 'and_one')
        $arr_post_tag = self::get_post_ids_by_tag($association['tag'], 'or');
      ElseIf ($association['tag_select_mode'] == 'or_all' || $association['tag_select_mode'] == 'and_all')
        $arr_post_tag = self::get_post_ids_by_tag($association['tag'], 'and');

    // By Author
    If (!Empty($association['author']))
      If ($association['author_select_mode'] == 'or' || $association['author_select_mode'] == 'and')
        $arr_post_author = self::get_post_ids_by_author($association['author']);


    // Add to the selected posts
    // Add Categories
    If ($association['category_select_mode'] == 'or_one' || $association['category_select_mode'] == 'or_all')
      $arr_post = Array_Merge ($arr_post, $arr_post_category);
    
    // Add Tags  
    If ($association['tag_select_mode'] == 'or_one' || $association['tag_select_mode'] == 'or_all')
      $arr_post = Array_Merge ($arr_post, $arr_post_tag);

    // Add Author
    If ($association['author_select_mode'] == 'or')
      $arr_post = Array_Merge ($arr_post, $arr_post_author);
      

    // Filter the selected posts 
    // Filter Categories
    If ($association['category_select_mode'] == 'and_one' || $association['category_select_mode'] == 'and_all')
      $arr_post = Array_Intersect ($arr_post, $arr_post_category);

    // Filter Tags
    If ($association['tag_select_mode'] == 'and_one' || $association['tag_select_mode'] == 'and_all')
      $arr_post = Array_Intersect ($arr_post, $arr_post_tag);

    // Filter Author
    If ($association['author_select_mode'] == 'and')
      $arr_post = Array_Intersect ($arr_post, $arr_post_author);
      
    // Add the additional posts
    $arr_post = Array_Merge ($arr_post, (Array) $association['post']);
    
    // There are no posts we have to care about
    If (Empty($arr_post)) return False;

    Return New WP_Query(Array(
      'post__in' => $arr_post,
      'posts_per_page' => $association['post_limit'] == '' ? -1 : IntVal($association['post_limit']),
      'orderby' => $association['order_by'],
      'order' => $association['order'],
      'caller_get_posts' => 1, // for WP < 3.1
      'ignore_sticky_posts' => 1
    ));    
  }
  
  Function Get_Post_IDs_By_Category ($arr_category, $operator = 'OR'){
    $arr_category = (Array) $arr_category;
    $operator = StrToLower ($operator);
    $result = Array();
    
    // Get the posts
    If ($operator == 'or'){
      ForEach ($arr_category AS $category){
        $query = New WP_Query(Array(
          'post_type' => 'post',
          'post_status' => 'publish',
          'posts_per_page' => -1,
          'category__in' => $arr_category
        ));
        $result = Array_Merge ($result, self::extract_post_ids($query));
      }
      $result = Array_Unique ($result);
    }
    ElseIf ($operator == 'and'){
      $query = New WP_Query(Array(
        'post_type' => 'post',
        'post_status' => 'publish',
        'posts_per_page' => -1,
        'caller_get_posts' => 1, // for WP < 3.1
        'ignore_sticky_posts' => 1,
        'category__and' => $arr_category
      ));
      $result = self::extract_post_ids($query);
    }
    
    return $result;     
  }
  
  Function Get_Post_IDs_By_Tag ($arr_tag, $operator = 'OR'){
    $arr_tag = (Array) $arr_tag;
    $operator = StrToLower ($operator);
    $result = Array();
    
    // Get the posts
    If ($operator == 'or'){
      ForEach ($arr_tag AS $tag){
        $query = New WP_Query(Array(
          'post_type' => 'post',
          'post_status' => 'publish',
          'posts_per_page' => -1,
          'caller_get_posts' => 1, // for WP < 3.1
          'ignore_sticky_posts' => 1,
          'tag__in' => $arr_tag
        ));
        $result = Array_Merge ($result, self::extract_post_ids($query));
      }
      $result = Array_Unique ($result);
    }
    ElseIf ($operator == 'and'){
      $query = New WP_Query(Array(
        'post_type' => 'post',
        'post_status' => 'publish',
        'posts_per_page' => -1,
        'caller_get_posts' => 1, // for WP < 3.1
        'ignore_sticky_posts' => 1,
        'tag__and' => $arr_tag
      ));
      $result = self::extract_post_ids($query);
    }
    
    return $result;     
  }
  
  Function Get_Post_IDs_By_Author($arr_author_id){
    $arr_author_id = (Array) $arr_author_id;
    $result = Array();
    
    // Get all posts by these authors
    ForEach ($arr_author_id AS $author_id){
      $query = New WP_Query(Array(
        'post_type' => 'post',
        'post_status' => 'publish',
        'posts_per_page' => -1,
        'caller_get_posts' => 1, // for WP < 3.1
        'ignore_sticky_posts' => 1,
        'author' => $author_id
      ));
      $result = Array_Merge ($result, self::extract_post_ids($query));
    }
    
    // Clean the array
    return Array_Unique ($result);
  }
  
  Function Extract_Post_IDs($wp_query){
    $result = Array();
    
    If ($wp_query && Is_Array($wp_query->posts)){
    ForEach ($wp_query->posts AS $p)
      $result[] = $p->ID;
    }
    
    return $result;
  }
  
  Function Filter_Content($content){
    // Append the ShortCode to the Content
    If ( StrPos($content, '[associated_posts]') === False && // Avoid double inclusion of the ShortCode
         StrPos($content, '[associated_posts ') === False && // Without closing bracket to find ShortCodes with attributes
         Apply_Filters('associated_posts_auto_append', True) && // You can use this filter to control the auto append feature
         $this->get_option('posts_position') != 'none' && // User can disable the auto append feature
         !post_password_required() // The user isn't allowed to read this page/post
       ){
      
      // Add the ShortCode to the current content
      If ($this->get_option('posts_position') == 'top')
        Return "\r\n[associated_posts]\r\n" . $content;
      Else
        Return $content . "\r\n[associated_posts]\r\n";

    }
    Else
      // the shortcode is already in the content / the filter says no
      Return $content;
  }
  
  Function Get_Post_Thumbnail($post_id = Null, $size = 'thumbnail'){
    /* Return Value: An array containing:
         $image[0] => attachment id
         $image[1] => url
         $image[2] => width
         $image[3] => height
    */
    If ($post_id == Null) $post_id = get_the_id();
    
    If (Function_Exists('get_post_thumbnail_id') && $thumb_id = get_post_thumbnail_id($post_id) )
      return Array_Merge ( Array($thumb_id), (Array) wp_get_attachment_image_src($thumb_id, $size) );
    ElseIf ($arr_thumb = self::get_post_attached_image($post_id, 1, 'rand', $size))
      return $arr_thumb[0];
    Else
      return False;
  }

  Function Get_Post_Attached_Image($post_id = Null, $number = 1, $orderby = 'rand', $image_size = 'thumbnail'){
    If ($post_id == Null) $post_id = get_the_id();
    $number = IntVal ($number);
    $arr_attachment = get_posts (Array( 'post_parent'    => $post_id,
                                        'post_type'      => 'attachment',
                                        'numberposts'    => $number,
                                        'post_mime_type' => 'image',
                                        'orderby'        => $orderby ));
    
    // Check if there are attachments
    If (Empty($arr_attachment)) return False;
    
    // Convert the attachment objects to urls
    ForEach ($arr_attachment AS $index => $attachment){
      $arr_attachment[$index] = Array_Merge ( Array($attachment->ID), (Array) wp_get_attachment_image_src($attachment->ID, $image_size));
      /* Return Value: An array containing:
           $image[0] => attachment id
           $image[1] => url
           $image[2] => width
           $image[3] => height
      */
    }
    
    return $arr_attachment;
  }

  Function Get_Authors(){    
    $arr_author = Array();
    
    ForEach ( (Array) get_author_user_ids() AS $author_id)
      $arr_author[] = get_userdata( $author_id );
    
    If (Empty($arr_author))
      return False;
    Else
      return $arr_author;
  }
  
  Function Get_All_Posts(){
    $post_query = new WP_Query(Array(
      'post_type' => 'post',
      'posts_per_page' => -1,
      'post_status' => 'publish',
      'caller_get_posts' => 1, // for WP < 3.1
      'ignore_sticky_posts' => 1
    ));
    
    return $post_query->posts;
  }
  
  Function Print_Marketing_Meta_Box(){
    ?>
    <p><?php Echo $this->t('In the Pro-Version you can associate all types of posts with each other.') ?></p>
    <p align="center"><a href="http://wpplugins.com/plugin/247/associated-posts-pro/" target="_blank"><img src="<?php Echo $this->base_url ?>/premiumimage.png" alt="<?php Echo $this->t('Buy the Pro-Version') ?>" title="<?php Echo $this->t('Buy the Pro-Version') ?>" /></a></p>
    <?php
  }
  
  Function Marketing_Footer($text){
    return $text . ' | <a href="http://wpplugins.com/plugin/247/associated-posts-pro/" target="_blank">Associated Posts PRO!</a>';
  }

} /* End of Class */
New wp_plugin_post_page_associator();
Require_Once DirName(__FILE__).'/contribution.php';
} /* End of If-Class-Exists-Condition */

// It is really recommended to buy the Pro Version!
If (!Class_Exists('wp_widget_post_page_associator')){
Class wp_widget_post_page_associator Extends WP_Widget {
  var $base_url;

  Function __construct(){    
    // Setup the Widget data
    parent::__construct (
      False,
      $this->t('Post Page Associator'),
      Array('description' => $this->t('Could display the associated posts of the current page in the sidebar.'))
    );

    // Read base_url
    $this->base_url = get_bloginfo('wpurl').'/'.Str_Replace("\\", '/', SubStr(RealPath(DirName(__FILE__)), Strlen(ABSPATH)));
  }
  
  Function t($text){
    If (!Is_Object($GLOBALS['wp_plugin_post_page_associator'])) return $text;
    Else return $GLOBALS['wp_plugin_post_page_associator']->t($text);
  }

  Function Widget ($args, $options){}

  Function Form ($options){
    ?>
    <p><?php Echo $this->t('In the Pro-Version you can add a Widget to your sidebars which displays the associated posts of the current post or page.') ?></p>
    <p align="center"><a href="http://wpplugins.com/plugin/247/associated-posts-pro/" target="_blank"><img src="<?php Echo $this->base_url ?>/premiumimage.png" alt="<?php Echo $this->t('Buy the Pro-Version') ?>" title="<?php Echo $this->t('Buy the Pro-Version') ?>" /></a></p>
    <p>(<small><?php Echo $this->t('This Widget does not any output to the user.') ?></small>)</p>
    <?php
  }
  
  Function Update ($new_settings, $old_settings){}
  
}
Add_Action ('widgets_init', Create_Function ('','Register_Widget(\'wp_widget_post_page_associator\');') );
} /* End of If-Class-Exists-Condition */
/* End of File */