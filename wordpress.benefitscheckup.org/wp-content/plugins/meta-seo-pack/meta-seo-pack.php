<?php
/*
Plugin Name: Meta SEO Pack
Plugin URI: http://www.poradnik-webmastera.com/projekty/meta_seo_pack/
Description: Fine tune your WordPress blog for SEO: title rewriting, meta descriptions, tags, robots, canonical links and more.  Out-of-the-box settings are a good starting point for blogs.
Author: Daniel Frużyński
Version: 2.2.1
Author URI: http://www.poradnik-webmastera.com/
Text Domain: meta-seo-pack
*/

/*  Copyright 2009-2010  Daniel Frużyński  (email : daniel [A-T] poradnik-webmastera.com)

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

if ( !class_exists( 'MetaSeoPack' ) ) {

class MetaSeoPack {
	var $ob_level = -1;
	//var $title_separator = '|';
	var $title = '';
	var $in_head = false;
	var $in_body = false;
	var $has_mbstr = false;
	
	// Constructor
	function MetaSeoPack() {
		$this->has_mbstr = function_exists( 'mb_convert_case' );
		
		$this->register_options();
		
		// Initialize plugin
		add_action( 'init', array( &$this, 'init' ) );
		if ( is_admin() ) {
			add_action( 'admin_init', array( &$this, 'admin_init' ) );
			add_action( 'admin_menu', array( &$this, 'admin_menu' ) );
			add_action( 'save_post', array( &$this, 'save_post' ) );
			
			// Show warning when blog is not public
			if ( !get_option( 'blog_public' ) ) {
				add_action( 'admin_notices', array( &$this, 'show_private_blog_warning' ) );
			}
			
			return;
		}
		
		// Get the title separator
		//add_filter( 'wp_title', array( &$this, 'wp_title' ), 10, 2 );
		
		// Add extra meta tags, rewrite title
		add_action( 'template_redirect', array( &$this, 'template_redirect' ) );
		add_action( 'wp_head', array( &$this, 'wp_head' ) );
		
		// Remove <link rel="canonical"> added by WP 2.9+
		remove_action( 'wp_head', 'rel_canonical' );
		
		if ( get_option( 'msp_robots_noindex_feed' ) ) {
			// Add <meta robots> to feeds
			add_action( 'atom_head', array( &$this, 'feed_noindex' ) );
			add_action( 'comments_atom_head', array( &$this, 'feed_noindex' ) ); // WP 2.8+
			add_action( 'rdf_header', array( &$this, 'feed_noindex' ) );
			add_action( 'rss_head', array( &$this, 'feed_noindex' ) );
			add_action( 'rss2_head', array( &$this, 'feed_noindex' ) );
			add_action( 'commentsrss2_head', array( &$this, 'feed_noindex' ) );
			// Send X-Robots-Tag
			add_action( 'send_headers', array( &$this, 'feed_noindex_header' ) ); // WP 2.8+
		}
		
		// Footer
		if ( get_option( 'msp_add_footer_link' ) ) {
			add_action( 'wp_footer', array( &$this, 'wp_footer' ) );
		}
		
		// Nofollow links
		if ( get_option( 'msp_enable_nofollow' ) ) {
			// Link to Comments from Post list
			if ( get_option( 'msp_nofollow_comment' ) ) {
				add_filter( 'comments_popup_link_attributes', array( &$this, 'nofollow_attribute' ), 20 );
			}
			// 'More...' link
			if ( get_option( 'msp_nofollow_more' ) ) {
				add_filter( 'the_content_more_link', array( &$this, 'nofollow_link' ), 20 );
			}
			// Links to Pages from Theme and Pages Widget
			if ( get_option( 'msp_nofollow_page' ) ) {
				add_filter( 'wp_list_pages', array( &$this, 'nofollow_link' ), 20 );
			}
			// Links to Categories from Post list in Theme
			if ( get_option( 'msp_nofollow_cat_theme' ) ) {
				add_filter( 'the_category', array( &$this, 'nofollow_link' ), 20 );
			}
			// Links to Categories from Categories Widget
			if ( get_option( 'msp_nofollow_cat_widget' ) ) {
				add_filter( 'wp_list_categories', array( &$this, 'nofollow_link' ), 20 );
			}
			// Links to Tags from Theme
			if ( get_option( 'msp_nofollow_tag_theme' ) ) {
				add_filter( 'the_tags', array( &$this, 'nofollow_link' ), 20 );
			}
			// Links to Tags from Tag Cloud Widget
			if ( get_option( 'msp_nofollow_tag_widget' ) ) {
				add_filter( 'wp_tag_cloud', array( &$this, 'nofollow_link' ), 20 );
			}
			// Link to Custom Taxonomy (HACK!)
			// Does not work - URL is filtered before displaying
			// Needs update:
			// get_the_term_list() - works
			// get_the_taxonomies() - filters URL
			// Note: the_terms() has new the_terms filter in 2.9
			/*if ( true ) {
				add_filter( 'term_link', array( &$this, 'nofollow_url' ), 20 );
			}*/
			// TODO: Link to Author page - not supported yet
			// https://core.trac.wordpress.org/ticket/10691
			/*if ( false ) {
				add_filter( 'the_author_posts_link', array( &$this, 'nofollow_link' ), 20 );
			}*/
			// Link to Feed (HACK!)
			/*if ( false ) {
				add_filter( 'bloginfo_url', array( &$this, 'nofollow_feed_url' ), 20, 2 );
			}*/
			// Register/Login/Logout/Site Admin links
			if ( get_option( 'msp_nofollow_backend' ) ) {
				add_filter( 'register', array( &$this, 'nofollow_link' ), 20 );
				add_filter( 'loginout', array( &$this, 'nofollow_link' ), 20 );
			}
			// Blogroll
			if ( get_option( 'msp_nofollow_blogroll' ) ) {
				add_filter( 'wp_list_bookmarks', array( &$this, 'nofollow_link' ), 20 );
			}
			// Archives Widget
			if ( get_option( 'msp_nofollow_archive' ) ) {
				add_filter( 'get_archives_link', array( &$this, 'nofollow_link' ), 20 );
			}
			// TODO: Calendar - not supported yet
			// https://core.trac.wordpress.org/ticket/10575
			/*if ( false ) {
				add_filter( 'get_calendar', array( &$this, 'nofollow_link' ), 20 );
			}*/
			// TODO: RSS Widget - needs something like Calendar Widget; no support in core yet
			// TODO: Recent Posts Widget - no support in core yet
			// TODO: Recent Comments Widget - no support it core yet
		}
		
		// Register default WP filters for MSP hooks
		add_filter( 'msp_title', 'wptexturize', 100 );
		add_filter( 'msp_title', 'convert_chars', 100 );
		add_filter( 'msp_title', 'esc_html', 100 );

		add_filter( 'msp_keywords', 'wptexturize', 100 );
		add_filter( 'msp_keywords', 'convert_chars', 100 );
		add_filter( 'msp_keywords', 'esc_html', 100 );

		add_filter( 'msp_description', 'wptexturize', 100 );
		add_filter( 'msp_description', 'convert_chars', 100 );
		add_filter( 'msp_description', 'esc_html', 100 );
	}
	
	// Initialize plugin
	function init() {
		load_plugin_textdomain( 'meta-seo-pack', false, dirname( plugin_basename( __FILE__ ) ) . '/lang' );
	}
	
	// Add Admin menu option
	function admin_menu() {
		// Menu
		add_menu_page( 'Title Rewriting', 'Meta SEO Pack', 'manage_options', __FILE__, 
			array( &$this, 'options_panel_title' ), WP_PLUGIN_URL.'/meta-seo-pack/bricks.png' );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Title Rewriting', 'meta-seo-pack'), 
			__('Title Rewriting', 'meta-seo-pack'), 'manage_options', __FILE__, 
			array( &$this, 'options_panel_title' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Meta Keywords', 'meta-seo-pack'), 
			__('Meta Keywords', 'meta-seo-pack'), 'manage_options', 'msp-keywords', 
			array( &$this, 'options_panel_keywords' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Meta Description', 'meta-seo-pack'), 
			__('Meta Description', 'meta-seo-pack'), 'manage_options', 'msp-description', 
			array( &$this, 'options_panel_description' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Meta Robots', 'meta-seo-pack'), 
			__('Meta Robots', 'meta-seo-pack'), 'manage_options', 'msp-robots', 
			array( &$this, 'options_panel_robots' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Canonical URLs', 'meta-seo-pack'), 
			__('Canonical URLs', 'meta-seo-pack'), 'manage_options', 'msp-canonical', 
			array( &$this, 'options_panel_canonical' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Nofollow links', 'meta-seo-pack'), 
			__('Nofollow Links', 'meta-seo-pack'), 'manage_options', 'msp-nofollow', 
			array( &$this, 'options_panel_nofollow' ) );
		//add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Duplicate Content', 'meta-seo-pack'), 
		//	__('Duplicate Content', 'meta-seo-pack'), 'manage_options', 'msp-duplicate', 
		//	array( &$this, 'options_panel_duplicate' ) );
		add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Other Settings', 'meta-seo-pack'), 
			__('Other Settings', 'meta-seo-pack'), 'manage_options', 'msp-other', 
			array( &$this, 'options_panel_other' ) );
		//add_submenu_page( __FILE__, 'Meta SEO Pack: '.__('Robots.txt', 'meta-seo-pack'), 
		//	__('Robots.txt', 'meta-seo-pack'), 'manage_options', 'msp-robots_txt', 
		//	array( &$this, 'options_panel_robots_txt' ) );
		
		// Add metabox to edit post/page pages
		add_meta_box( 'msp_sectionid', 'Meta SEO Pack', array( &$this, 'post_metabox' ), 'post', 'normal', 'high' );
		add_meta_box( 'msp_sectionid', 'Meta SEO Pack', array( &$this, 'post_metabox' ), 'page', 'normal', 'high' );
	}
	
	/*// Get the title separator
	function wp_title( $title, $sep ) {
		$this->title_separator = $sep;
		return $title;
	}*/
	
	// Start output buffering to catch the head section and be able to rewrite <title> later
	function template_redirect() {
		$this->in_head = true;
		
		// TODO: register hooks to add rel="nofollow" to custom taxonomy links generated by get_the_term_list()
		// $term_links = apply_filters( "term_links-$taxonomy", $term_links );
		// add_filter( 'the_author_posts_link', array( &$this, 'nofollow_link' ), 20 );
		
		if ( !$this->should_rewrite_head() ) {
			return;
		}

		if ( !get_option( 'msp_enable_title' ) ) {
			return;
		}
		
		ob_start( array( &$this, 'ob_rewrite_title' ) );
		$this->ob_level = ob_get_level();
	}
	
	// Return true if plugin should do something in <head> section
	function should_rewrite_head() {
		return !( is_robots() || is_feed() || is_trackback() || is_404() || is_comments_popup() );
	}
	
	// Print extra meta tags
	function wp_head() {
		if ( !$this->should_rewrite_head() ) {
			$this->in_head = false;
			$this->in_body = true;
			return;
		}
		
		print "<!-- Meta SEO Pack BEGIN -->\n";

		global $wp_query;
		$obj = $wp_query->get_queried_object();
		
		// Debug only
		if ( defined( 'WP_DEBUG' ) && WP_DEBUG && !empty( $obj ) ) {
			//var_dump($obj); print "\n<hr />\n";
		}
		
		// Title
		if ( get_option( 'msp_enable_title' ) ) {
			// Get the new title. This must be done before ob_end_flush() call
			$this->title = $this->get_title( $obj );
			
			// If this is not true, another plugin is trying to buffer output too, 
			// so don't flush buffer in order to not spoil something.
			if ( ( $this->ob_level >= 0 ) && ( $this->ob_level == ob_get_level() ) ) {
				ob_end_flush();
			}
		}
		
		// Meta Keywords
		if ( get_option( 'msp_enable_keywords' ) ) {
			$keywords = $this->get_keywords( $obj );
			if ( ( $keywords !== false ) && ( $keywords != '' ) ) {
				print "<meta name=\"keywords\" content=\"$keywords\" />\n";
			}
		}
		
		// Meta Description
		if ( get_option( 'msp_enable_description' ) ) {
			$description = $this->get_description( $obj );
			if ( ( $description !== false ) && ( $description != '' ) ) {
				print "<meta name=\"description\" content=\"$description\" />\n";
			}
		}
		
		// Meta Robots
		if ( get_option( 'msp_enable_robots' ) ) {
			$robots = $this->get_robots( $obj );
			if ( ( $robots !== false ) && ( $robots != '' ) ) {
				print "<meta name=\"robots\" content=\"$robots\" />\n";
			}
		}
		
		// Canonical URL tag
		if ( get_option( 'msp_enable_canonical' ) ) {
			$canonical = $this->get_canonical( $obj );
			if ( ( $canonical !== false ) && ( $canonical != '' ) ) {
				print "<link rel=\"canonical\" href=\"$canonical\" />\n";
			}
		}
		
		print "<!-- Meta SEO Pack END -->\n";
		
		$this->in_head = false;
		$this->in_body = true;
	}
	
	// Rewrite the <title> tag
	function ob_rewrite_title( $buffer, $flags ) {
		$this->ob_level = -1;
		if ( ( $this->title !== false ) && ( $this->title != '' ) ) {
			$buffer = preg_replace( '#<title>.*?</title>#si', "<title>$this->title</title>", $buffer );
		}
		return $buffer;
	}
	
	// Get page title (for <title> tag)
	function get_title( $obj ) {
		$title = '';
		$format = '';
		$title_sep = get_option( 'msp_title_separator' );
		
		$data = array(
			'blog_name' => get_option( 'blogname' ),
			'blog_desc' => get_option( 'blogdescription' ),
			'blog_meta_desc' => get_option( 'msp_description_home' ),
			'blog_title' => wp_title( $title_sep, false, 'right' ),
		);
		
		if ( is_search() ) { // Search results
			$data['search'] = get_search_query();
			$format = get_option( 'msp_title_search' );
		} elseif ( is_tax() ) { // Taxonomy page
			$data['term_name'] = $obj->name;
			$data['term_slug'] = $obj->slug;
			$taxonomy = get_taxonomy( $obj->taxonomy );
			$data['tax_name'] = $taxonomy->name;
			$data['tax_label'] = $taxonomy->label;
			$format = get_option( 'msp_title_tax' );
		} elseif ( is_home() ) { // Home page
			$format = get_option( 'msp_title_home' );
		} elseif ( is_attachment() ) { // Attachment page
			$data['title'] = $obj->post_title;
			$cats = wp_get_post_categories( $obj->ID, array( 'fields' => 'ids' ) );
			$data['category'] = get_cat_name( $cats[0] );
			$data['categories'] = $this->get_category_parents( $cats[0], " $title_sep " );
			$data['categories'] = $this->uc_words( $data['categories'] );
			$format = get_option( 'msp_title_attach' );
		} elseif ( is_single() ) { // Post
			$data['title'] = $obj->post_title;
			$cats = wp_get_post_categories( $obj->ID, array( 'fields' => 'ids' ) );
			if ( count( $cats ) > 0 ) {
				$data['category'] = get_cat_name( $cats[0] );
				$data['categories'] = $this->get_category_parents( $cats[0], " $title_sep " );
				$data['categories'] = $this->uc_words( $data['categories'] );
			} else {
				$data['category'] = '';
				$data['categories'] = '';
			}
			$format = get_option( 'msp_title_post' );
		} elseif ( is_page() ) { // Page
			$data['title'] = $obj->post_title;
			$format = get_option( 'msp_title_page' );
		} elseif ( is_category() ) { // Category page
			$data['category'] = get_cat_name( $obj->term_id );
			$data['categories'] = $this->get_category_parents( $obj->term_id, " $title_sep " );
			$data['categories'] = $this->uc_words( $data['categories'] );
			$format = get_option( 'msp_title_cat' );
		} elseif ( is_tag() ) { // Tag page
			$data['tag'] = $obj->name;
			$format = get_option( 'msp_title_tag' );
		} elseif ( is_author() ) { // Author page
			$data['author_name'] = $obj->display_name;
			$format = get_option( 'msp_title_author' );
		} elseif ( is_date() ) { // Date page
			$m = get_query_var('m');
			$year = get_query_var('year');
			$month = get_query_var('monthnum');
			$day = get_query_var('day');
			if ( is_year() ) {
				if ( !empty($m) ) {
					$year = substr( $m, 0, 4 );
				}
				$date = mktime( 0, 0, 0, 1, 1, $year );
				$data['date'] = date_i18n( 'Y', $date );
			} elseif ( is_month() ) {
				if ( !empty($m) ) {
					$year = substr( $m, 0, 4 );
					$month = substr( $m, 4, 2 );
				}
				$date = mktime( 0, 0, 0, $month, 1, $year );
				$data['date'] = date_i18n( 'F, Y', $date );
			} elseif ( is_day() ) {
				if ( !empty($m) ) {
					$year = substr( $m, 0, 4 );
					$month = substr( $m, 4, 2 );
					$day = substr( $m, 6, 2 );
				}
				$date = mktime( 0, 0, 0, $month, $day, $year );
				$data['date'] = date_i18n( 'F jS, Y', $date );
			}
			$format = get_option( 'msp_title_date' );
		} else {
			$format = apply_filters( 'msp_get_title_format', get_option( 'msp_title_other' ) );
			$data = apply_filters( 'msp_get_title_data', $data );
		}
		
		if ( $format != '' ) {
			if ( $this->is_paged() ) {
				$format = str_replace( '%title%', $format, get_option( 'msp_title_sub_pages' ) );
				$data['n'] = $this->get_page_num();
			} elseif ( $this->is_paged( true ) ) {
				$format = str_replace( '%title%', $format, get_option( 'msp_title_sub_comments' ) );
				$data['n'] = $this->get_page_num( true );
			}
			
			$title = str_replace( '|', $title_sep, $format );
			
			foreach ( $data as $key => $val ) {
				$title = str_replace( "%$key%", $val, $title );
			}
		}
		
		return apply_filters( 'msp_title', $title );
	}
	
	// Get page keywords (for <meta keywords> tag)
	function get_keywords( $obj ) {
		$keywords = explode( ',', get_option( 'msp_default_keywords' ) );
		
		if ( is_search() ) { // Search results
			// Add search term
			if ( get_option( 'msp_keywords_add_search' ) ) {
				$search = get_search_query();
				$search = strtr( $search, ',', ' ' ); // Remove commas
				$keywords[] = $search;
			}
		} elseif ( is_tax() ) { // Taxonomy page
			// Add taxonomy name
			if ( get_option( 'msp_keywords_add_tax_name' ) ) {
				$taxonomy = get_taxonomy( $obj->taxonomy );
				//var_dump($taxonomy);
				if ( isset( $taxonomy->label ) ) {
					$keywords[] = $taxonomy->label;
				} else {
					$keywords[] = $taxonomy->name;
				}
			}
			// Add term name
			if ( get_option( 'msp_keywords_add_tax_term' ) ) {
				$keywords[] = $obj->name;
			}
		} elseif ( is_home() ) { // Home page
			// No extra tags
		} elseif ( is_attachment() ) { // Attachment page
			// No extra tags
			// TODO: add extra tags for attachments
		} elseif ( is_single() ) { // Post
			// Add custom meta tags
			$msp_keywords = get_post_meta( $obj->ID , '_msp_keywords', true );
			if ( $msp_keywords != '' ) {
				$keywords = array_merge( $keywords, explode( ',', $msp_keywords ) );
			}
			// Add tags
			if ( get_option( 'msp_keywords_add_post_tags' ) ) {
				$tags = wp_get_post_tags( $obj->ID, array( 'fields' => 'names' ) );
				$keywords = array_merge( $keywords, $tags );
			}
			// Add categories with all parents
			if ( get_option( 'msp_keywords_add_post_cats' ) ) {
				$cats = wp_get_post_categories( $obj->ID, array( 'fields' => 'ids' ) );
				foreach ( $cats as $cat ) {
					$parents = $this->get_category_parents( $cat );
					$keywords = array_merge( $keywords, $parents );
				}
			}
			// Add custom taxonomies
			$taxes = get_option( 'msp_keywords_add_post_taxes' );
			$tax_terms = $this->get_taxonomy_terms( $obj->ID, $taxes );
			$keywords = array_merge( $keywords, $tax_terms );
			// TODO: add extra tags for posts
		} elseif ( is_page() ) { // Page
			// Add custom meta tags
			$msp_keywords = get_post_meta( $obj->ID , '_msp_keywords', true );
			if ( $msp_keywords != '' ) {
				$keywords = array_merge( $keywords, explode( ',', $msp_keywords ) );
			}
			// Add custom taxonomies
			$taxes = get_option( 'msp_keywords_add_page_taxes' );
			$tax_terms = $this->get_taxonomy_terms( $obj->ID, $taxes );
			$keywords = array_merge( $keywords, $tax_terms );
			// TODO: add extra tags for pages
		} elseif ( is_category() ) { // Category page
			// Add category name and its parents
			if ( get_option( 'msp_keywords_add_cats' ) ) {
				$parents = $this->get_category_parents( $obj->term_id );
				$keywords = array_merge( $keywords, $parents );
			}
			// TODO: add extra tags for categories
		} elseif ( is_tag() ) { // Tag page
			// Add tag name
			if ( get_option( 'msp_keywords_add_tag' ) ) {
				$keywords[] = $obj->name;
			}
			// TODO: add extra tags for tags
		} elseif ( is_author() ) { // Author page
			if ( get_option( 'msp_keywords_add_author' ) ) {
				$keywords[] = $obj->display_name;
			}
			// TODO: add extra tags for author
		} elseif ( is_date() ) { // Date page
			// No extra tags
			// TODO: add extra tags for date (?)
		} else { // Other stuff
			$keywords = array_merge( $keywords, apply_filters( 'msp_get_keywords', array() ) );
		}
		
		$keywords = implode( ',', $this->get_unique_values( $keywords ) );
		
		return apply_filters( 'msp_keywords', $keywords );
	}
	
	// Get page description (for <meta description> tag
	function get_description( $obj ) {
		$description = '';
		
		if ( is_search() ) { // Search results
			// No description
			// TODO: add description for search page
		} elseif ( is_tax() ) { // Taxonomy page
			if ( get_option( 'msp_description_use_tax_desc' ) && ( $obj->description != '' ) ) {
				$description = trim( $obj->description );
			}
		} elseif ( is_home() ) { // Home page
			$description = get_option( 'msp_description_home' );
			if ( $description != '' ) {
				$description = str_replace( '%blog_name%', get_option( 'blogname' ), $description );
				$description = str_replace( '%blog_desc%', get_option( 'blogdescription' ), $description );
			}
		} elseif ( is_attachment() ) { // Attachment page
			if ( get_option( 'msp_description_use_attach_desc' ) ) {
				$description = $this->format_description( $obj->post_content );
				if ( $description == '' ) {
					$description = $this->format_description( $obj->post_excerpt );
				}
			}
		} elseif ( is_single() ) { // Post
			// Use meta description if present
			$description = get_post_meta( $obj->ID , '_msp_description', true );
			// Use post excerpt or generate from content
			if ( ( $description == '' ) && get_option( 'msp_description_gen_from_post' ) ) {
				$description = $this->format_description( $obj->post_excerpt );
				if ( $description == '' ) {
					$description = $this->format_description( $obj->post_content );
				}
			}
		} elseif ( is_page() ) { // Page
			$description = get_post_meta( $obj->ID , '_msp_description', true );
			// Generate from content
			if ( ( $description == '' ) && get_option( 'msp_description_gen_from_page' ) ) {
				$description = $this->format_description( $obj->post_content );
			}
		} elseif ( is_category() ) { // Category page
			if ( get_option( 'msp_description_use_cat_desc' ) && ( $obj->description != '' ) ) {
				$description = trim( $obj->description );
			}
		} elseif ( is_tag() ) { // Tag page
			if ( get_option( 'msp_description_use_tag_desc' ) && ( $obj->description != '' ) ) {
				$description = trim( $obj->description );
			}
		} elseif ( is_author() ) { // Author page
			// No description
			// TODO: add description for author page
		} elseif ( is_date() ) { // Date page
			// No description
			// TODO: add description for date page
		} else { // Other stuff
			$description = apply_filters( 'msp_get_description', $description );
		}
		
		// Update description for paginated content
		$format = '';
		$pagenum = $this->get_page_num( false ); // Paginated posts or content
		if ( $pagenum !== false ) {
			$format = get_option( 'msp_description_paged_format' );
		} else {
			$pagenum = $this->get_page_num( true ); // Paginated comments
			if ( $pagenum !== false ) { 
				$format = get_option( 'msp_description_paged_comments_format' );
			}
		}
		
		if ( ( $format != '' ) && ( $description != '' ) ) {
			$format = str_replace( '%n%', $pagenum, $format );
			$format = str_replace( '%description%', $description, $format );
			$description = $format;
		}
		
		return apply_filters( 'msp_description', $description );
	}
	
	// Get robots directive (for <meta robots> tag)
	function get_robots( $obj ) {
		$robots = array();
		
		if ( is_search() ) { // Search results
			if ( get_option( 'msp_robots_noindex_search' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_tax() ) { // Taxonomy page
			if ( get_option( 'msp_robots_noindex_tax' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_home() ) { // Home page
			if ( $this->is_paged() && get_option( 'msp_robots_noindex_front_subpages' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_attachment() ) { // Attachment page
			if ( get_option( 'msp_robots_noindex_attach' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_single() ) { // Post
			$msp_robots = get_post_meta( $obj->ID , '_msp_robots', true );
			if ( $msp_robots != '' ) {
				$robots[] = $msp_robots;
			} elseif ( $this->is_paged( true ) && get_option( 'msp_robots_noindex_post_comments' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_page() ) { // Page
			$msp_robots = get_post_meta( $obj->ID , '_msp_robots', true );
			if ( $msp_robots != '' ) {
				$robots[] = $msp_robots;
			}
		} elseif ( is_category() ) { // Category page
			if ( get_option( 'msp_robots_noindex_cat' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_tag() ) { // Tag page
			if ( get_option( 'msp_robots_noindex_tag' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_author() ) { // Author page
			if ( get_option( 'msp_robots_noindex_author' ) ) {
				$robots[] = 'noindex,follow';
			}
		} elseif ( is_date() ) { // Date page
			if ( get_option( 'msp_robots_noindex_date' ) ) {
				$robots[] = 'noindex,follow';
			}
		} else { // Other stuff
			$value = apply_filters( 'msp_get_robots', '' );
			if ( $value != '' ) {
				$robots[] = $value;
			}
		}
		
		if ( get_option( 'msp_robots_noodp' ) ) {
			$robots[] = 'noodp';
		}
		if ( get_option( 'msp_robots_noydir' ) ) {
			$robots[] = 'noydir';
		}
		
		$robots = implode( ',', $robots );
		
		return apply_filters( 'msp_robots', $robots );
	}
	
	// Get canonical URL (for <link rel="canonical">)
	function get_canonical( $obj ) {
		if ( is_robots() || is_feed() || is_trackback() || is_404() || is_comments_popup() ) {
			return false;
		}
		
		global $wp_rewrite;
		if ( is_object( $wp_rewrite ) && $wp_rewrite->using_permalinks() ) {
			$has_rewrite = true;
		} else {
			$has_rewrite = false;
		}
		
		$canonical = '';
		
		if ( is_home() ) { // Home page
			$canonical = trailingslashit( get_option( 'home' ) );
		} elseif ( is_search() ) { // Search results
			if ( $has_rewrite ) {
				$searchlink = $wp_rewrite->get_search_permastruct();
			} else {
				$searchlink = null;
			}
			
			$search = rawurlencode( get_search_query() );
			
			if ( empty ( $searchlink ) ) {
				$file = trailingslashit( get_option( 'home' ) );
				$canonical = $file . '?s=' . $search;
			} else {
				$searchlink = str_replace( '%search%', $search, $searchlink );
				$canonical = trailingslashit( get_option( 'home' ) ) . user_trailingslashit( $searchlink, 'category' );
			}
			$canonical = apply_filters( 'search_link', $canonical, $search );
		} elseif ( is_date() ) { // Date page
			$m = get_query_var('m');
			$year = get_query_var('year');
			$month = get_query_var('monthnum');
			$day = get_query_var('day');
			if ( is_year() ) {
				if ( !empty($m) ) {
					$canonical = get_year_link( substr( $m, 0, 4 ) );
				} else {
					$canonical = get_year_link( $year );
				}
			} elseif ( is_month() ) {
				if ( !empty($m) ) {
					$canonical = get_month_link( substr( $m, 0, 4 ), substr( $m, 4, 2 ) );
				} else {
					$canonical = get_month_link( $year, $month );
				}
			} elseif ( is_day() ) {
				if ( !empty($m) ) {
					$canonical = get_day_link( substr( $m, 0, 4 ), substr( $m, 4, 2 ), substr( $m, 6, 2 ) );
				} else {
					$canonical = get_day_link( $year, $month, $day );
				}
			}
		} else { // Pages where $obj should be set
			if ( !$obj ) {
				return false;
			}
			
			if ( is_tax() ) { // Taxonomy page
				$canonical = get_term_link( $obj, $obj->taxonomy );
			} elseif ( is_attachment() ) { // Attachment page
				$canonical = get_attachment_link( $obj->ID );
			} elseif ( is_single() || is_page() ) { // Post or page
				$canonical = get_permalink( $obj->ID );
			} elseif ( is_category() ) { // Category page
				$canonical = get_category_link( $obj->term_id );
			} elseif ( is_tag() ) { // Tag page
				$canonical = get_tag_link( $obj->term_id );
			} elseif ( is_author() ) { // Author page
				$canonical = get_author_posts_url( $obj->ID, $obj->user_nicename );
			} else { // Other stuff
				$canonical = apply_filters( 'msp_get_canonical', '', $has_rewrite );
			}
		}
		
		if ( $canonical != '' ) { // Add page numbers
			$canonical = $this->make_link_paged( $canonical, $has_rewrite );
		}
		
		return apply_filters( 'msp_canonical', $canonical, $has_rewrite );
	}
	
	// Add pagination part to the link
	function make_link_paged( $url, $has_rewrite ) {
		global $paged, /*$multipage,*/ $page, $cpage;
		
		if ( is_paged() && ( $paged > 1 ) ) { // Paginated post list
			if ( $has_rewrite ) {
				$pos = strpos( $url, '?' );
				if ( $pos !== false ) { // Special case for Taxonomy page
					$url = trailingslashit( substr( $url, 0, $pos) ) 
						. user_trailingslashit( 'page/'.$paged, 'paged' )
						. substr( $url, $pos );
				} else {
					$url = trailingslashit( $url ) . user_trailingslashit( 'page/'.$paged, 'paged' );
				}
			} else {
				$url = add_query_arg( 'paged', $paged, $url );
			}
			
			$url = apply_filters( 'get_pagenum_link', $url );
		} elseif ( /*$multipage &&*/ isset( $page ) && ( $page > 1 ) ) { // Paginated post/page
			// Commented part above does not work :(
			if ( $has_rewrite ) {
				$url = trailingslashit( $url ) . user_trailingslashit( $page, 'single_paged' );
			} else {
				$url = add_query_arg( 'page', $page, $url );
			}
		} elseif ( isset( $cpage ) ) { // Paginated comments
			if ( 'newest' == get_option('default_comments_page') ) {
				if ( $cpage != 0 ) {
					if ( $has_rewrite ) {
						$url = trailingslashit( $url ) . 'comment-page-'
							. user_trailingslashit( $cpage , 'commentpaged' );
					} else {
						$url = add_query_arg( 'cpage', $cpage, $url );
					}
				}
			} elseif ( $cpage > 1 ) {
				if ( $has_rewrite ) {
					$url = trailingslashit( $url ) . 'comment-page-'
						. user_trailingslashit( $cpage, 'commentpaged' );
				} else {
					$url = add_query_arg( 'cpage', $cpage, $url );
				}
			}
			
			$url = apply_filters( 'get_comments_pagenum_link', $url );
		}
		
		return $url;
	}
	
	// Return true if this is subsequent page of multi-paged content
	// Set param to true to check comments pages
	function is_paged( $comments = false ) {
		global $paged, /*$multipage,*/ $page, $cpage;
		
		if ( !$comments ) {
			if ( is_paged() && ( $paged > 1 ) ) { // Paginated post list
				return true;
			} elseif ( /*$multipage &&*/ isset( $page ) && ( $page > 1 ) ) { // Paginated post/page
				// Commented part above does not work :(
				return true;
			}
		} else { // $comments == true
			if ( isset( $cpage ) ) { // Paginated comments
				if ( 'newest' == get_option('default_comments_page') ) {
					if ( $cpage != 0 ) {
						return true;
					}
				} elseif ( $cpage > 1 ) {
					return true;
				}
			}
		}
		
		return false;
	}
	
	// Return page number if this is subsequent page of multi-paged content, or false otherwise
	// Set param to true to check comments pages
	function get_page_num( $comments = false ) {
		global $paged, /*$multipage,*/ $page, $cpage;
		
		if ( !$comments ) {
			if ( is_paged() && ( $paged > 1 ) ) { // Paginated post list
				return $paged;
			} elseif ( /*$multipage &&*/ isset( $page ) && ( $page > 1 ) ) { // Paginated post/page
				// Commented part above does not work :(
				return $page;
			}
		} else { // $comments == true
			if ( isset( $cpage ) ) { // Paginated comments
				if ( 'newest' == get_option('default_comments_page') ) {
					if ( $cpage != 0 ) {
						return $cpage;
					}
				} elseif ( $cpage > 1 ) {
					return $cpage;
				}
			}
		}
		
		return false;
	}
	
	// Prepare the value for meta description tag
	function format_description( $description ) {
		$max_len = 160; // Maximum description length
		
		$description = $this->strip_shortcodes( $description );
		$description = strip_tags( $description );
		$description = trim ( $description );
		$description = preg_replace( '/\s\s+/', ' ', $description );
		
		$len = strlen( $description );
		if ( $len > $max_len ) {
			if ( version_compare( PHP_VERSION, '5', '<' ) ) {
				$description = substr( $description, 0, $max_len + 1 );
				$pos = strrpos( $description, ' ' );
			} else {
				$pos = strrpos( $description, ' ', $max_len - $len );
			}
			
			if ( $pos !== false ) {
				$description = substr( $description, 0, $pos ) . '...';
			} else {
				// No spaces? Interesting...
				$description = substr( $description, 0, $max_len ) . '...';
			}
		}
		
		return $description;
	}
	
	// Add robots noindex,follow tag
	function feed_noindex() {
		echo '<meta xmlns="http://www.w3.org/1999/xhtml" name="robots" content="noindex,follow" />', "\n";
	}
	
	// Send X-Robots-Tag: noindex,follow header
	function feed_noindex_header( &$wp ) {
		if ( !empty( $wp->query_vars['feed'] ) ) {
			header( 'X-Robots-Tag: noindex,follow' );
		}
	}
	
	// Get parent categories and strip trailing separator
	function get_category_parents( $cat_id, $separator = null ) {
		$cats = get_category_parents( $cat_id, false, '@@@' );
		if ( is_wp_error( $cats ) ) { // Houston, we have a problem!
			// Try to return category name only
			$cat = get_category( $cat_id );
			if ( is_wp_error( $cat ) ) {
				return  '';
			} else {
				return $cat->cat_name;
			}
		}
		
		$cats = explode( '@@@', $cats );
		array_pop( $cats );
		$cats = array_reverse( $cats );
		if ( is_null( $separator ) ) {
			return $cats;
		} else {
			return implode( $separator, $cats );
		}
	}
	
	// Get taxonomy terms for given taxonomies and object ID
	function get_taxonomy_terms( $obj_ID, $taxonomies ) {
		$terms = array();
		
		foreach ( $taxonomies as $tax_name ) {
			if ( !is_taxonomy( $tax_name ) ) {
				continue;
			}
			
			if ( !is_taxonomy_hierarchical( $tax_name ) ) {
				$new_terms = wp_get_object_terms( $obj_ID, $tax_name, array( 'fields' => 'names' ) );
			} else { // hierarchical taxonomy
				// TODO: add support for hierarchical taxonomies
				$new_terms = wp_get_object_terms( $obj_ID, $tax_name, array( 'fields' => 'names' ) );
			}
			
			$terms = array_merge( $terms, $new_terms );
		}
		
		return $terms;
	}
	
	// Add footer link
	function wp_footer() {
		echo '<div id="metaseopack" style="text-align:center"><small>WordPress SEO fine-tune by <a href="http://www.poradnik-webmastera.com/projekty/meta_seo_pack/" target="_blank">Meta SEO Pack</a> from <a href="http://www.poradnik-webmastera.com/" target="_blank">Poradnik Webmastera</a></small></div>', "\n";
	}
	
	// Helper function for adding rel="nofollow" to links
	function nofollow_link_rx_callback( $matches ) {
		//var_dump($matches); die;
		$apos = false;
		$pos = strpos( $matches[0], 'rel="' );
		if ( $pos === false ) {
			$apos = true;
			$pos = strpos( $matches[0], 'rel=\'' );
		}
		if ( $pos === false ) { // rel="" is not added yet
			return str_replace( '<a ', '<a rel="nofollow" ', $matches[0] );
		}
		
		$pos += 5; // skip 'rel="'
		$pos2 = strpos( $matches[0], $apos ? '\'' : '"', $pos );
		if ( $pos2 !== false ) {
			$rel = substr( $matches[0], $pos, $pos2 - $pos );
		} else { // Something bad happened...
			$rel = substr( $matches[0], $pos );
		}
		
		if ( strpos( $rel, 'nofollow' ) !== false ) { // rel="nofollow" is already added
			return $matches[0];
		} else { // rel="" is added, but without nofollow
			return substr( $matches[0], 0, $pos ) . 'nofollow ' . substr( $matches[0], $pos );
		}
	}
	
	// Add rel=nofollow to HTML link (<a href=...>)
	// Note: multiple links with some extra html may be passed here
	function nofollow_link( $link ) {
		return preg_replace_callback( '#<a\s[^>]*\bhref=["\'][^>]*>#', 
			array( &$this, 'nofollow_link_rx_callback' ), $link );
	}
	
	// Add rel=nofollow attribute to attribute list
	function nofollow_attribute( $attrs ) {
		$apos = false;
		$pos = strpos( $attrs, 'rel="' );
		if ( $pos === false ) {
			$apos = true;
			$pos = strpos( $attrs, 'rel=\'' );
		}
		if ( $pos === false ) { // rel="" is not added yet
			return $attrs . ' rel="nofollow"';
		}
		
		$pos += 5; // skip 'rel="'
		$pos2 = strpos( $attrs, $apos ? '\'' : '"', $pos );
		if ( $pos2 !== false ) {
			$rel = substr( $attrs, $pos, $pos2 - $pos );
		} else { // Something bad happened...
			$rel = substr( $attrs, $pos );
		}
		
		if ( strpos( $rel, 'nofollow' ) !== false ) { // rel="nofollow" is already added
			return $attrs;
		} else { // rel="" is added, but without nofollow
			return substr( $attrs, 0, $pos ) . 'nofollow ' . substr( $attrs, $pos );
		}
	}
	
	// HACK: Add rel=nofollow to url (http://...)
	function nofollow_url( $url ) {
		if ( $this->in_body ) {
			return $url . '" rel="nofollow';
		}
		return $url;
	}
	
	// HACK: Add rel=nofollow to feed url (http://...)
	function nofollow_feed_url( $url, $what ) {
		$feed_hooks = array( 'rdf_url', 'rss_url', 'rss2_url', 'atom_url', 'comments_atom_url', 'comments_rss2_url' );
		if ( $this->in_body && in_array( $what, $feed_hooks ) ) {
			return $url . '" rel="nofollow';
		}
		return $url;
	}
	
	// Show meta box on edit post/page pages
	function post_metabox( $post ) {
		$keywords = get_post_meta( $post->ID , '_msp_keywords', true );
		$description = get_post_meta( $post->ID , '_msp_description', true );
		$robots = get_post_meta( $post->ID , '_msp_robots', true );
		// Fix for Meta SEO Pack 2.1 - hide meta values
		if ( empty( $keywords ) ) {
			$keywords = get_post_meta( $post->ID , 'msp_keywords', true );
			if ( !empty( $keywords ) ) {
				update_post_meta( $post->ID, '_msp_keywords', $keywords );
				delete_post_meta( $post->ID, 'msp_keywords' );
			}
		}
		if ( empty( $description ) ) {
			$description = get_post_meta( $post->ID , 'msp_description', true );
			if ( !empty( $keywords ) ) {
				update_post_meta( $post->ID, '_msp_description', $description );
				delete_post_meta( $post->ID, 'msp_description' );
			}
		}
		if ( empty( $robots ) ) {
			$robots = get_post_meta( $post->ID , 'msp_robots', true );
			if ( !empty( $robots ) ) {
				update_post_meta( $post->ID, '_msp_robots', $robots );
				delete_post_meta( $post->ID, 'msp_robots' );
			}
		}
?>
<!--  Use nonce for verification -->
<input type="hidden" name="msp_nonce" id="msp_nonce" value="<?php echo wp_create_nonce( plugin_basename(__FILE__) ); ?>" />

<!-- The actual fields for data entry -->
<table cellspacing="3" cellpadding="3">
<tr>
<th style="text-align:right;vertical-align:top;padding-top:3px">
	<label for="msp_description"><?php _e('Meta Description:', 'meta-seo-pack'); ?></label>
</td>
<td>
	<textarea name="msp_description" id="msp_description" rows="3" cols="63"><?php echo esc_html($description); ?></textarea><br />
	<p><?php _e('Text entered above will be used as a value for the <code>&lt;meta name=&quot;description&quot;&gt;</code> tag.', 'meta-seo-pack'); ?></p>
</td>
</tr>
<tr>
<th style="text-align:right;vertical-align:top;padding-top:3px">
	<label for="msp_keywords"><?php _e('Meta Keywords:', 'meta-seo-pack'); ?></label>
</td>
<td>
	<input type="text" name="msp_keywords" id="msp_keywords" size="75" value="<?php echo esc_attr($keywords); ?>" /><br />
	<p><?php _e('Text entered above will be used as a value for the <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag. Separate keywords with commas (e.g. <code>key1,key2,key3</code>).', 'meta-seo-pack'); ?></p>
</td>
</tr>
<tr>
<th style="text-align:right;vertical-align:top;padding-top:3px">
	<label for="msp_robots"><?php _e('Meta Robots:', 'meta-seo-pack'); ?></label>
</td>
<td>
	<input type="text" name="msp_robots" id="msp_robots" size="75" value="<?php echo esc_attr($robots); ?>" /><br />
	<p><?php _e('Text entered above will be used as a value for the <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag. It will override default <code>noindex,follow</code> settings. Meta SEO Pack will add <code>noodp</code> and <code>noydir</code> if you checked to use them.', 'meta-seo-pack'); ?></p>
</td>
</tr>
</table>
<?php
	}
	
	// Update post/page metadata
	function save_post( $post_id ) {
		// verify this came from the our screen and with proper authorisation,
		// because save_post can be triggered at other times		
		if ( !isset( $_POST['msp_nonce'] ) || !wp_verify_nonce( $_POST['msp_nonce'], plugin_basename(__FILE__) )) {
			return;
		}
		
		if ( 'page' == $_POST['post_type'] ) {
			if ( !current_user_can( 'edit_page', $post_id ) ) {
				return;
			}
		} else {
			if ( !current_user_can( 'edit_post', $post_id ) ) {
				return;
			}
		}
		
		// OK, we're authenticated: do the work now
		
		$keywords = isset( $_POST['msp_keywords'] ) ? trim( $_POST['msp_keywords'] ) : '';
		if ( $keywords != '' ) {
			update_post_meta( $post_id, '_msp_keywords', $keywords );
		} else {
			delete_post_meta( $post_id, '_msp_keywords' );
		}
		
		$description = isset( $_POST['msp_description'] ) ? trim( $_POST['msp_description'] ) : '';
		if ( $description != '' ) {
			update_post_meta( $post_id, '_msp_description', $description );
		} else {
			delete_post_meta( $post_id, '_msp_description' );
		}
		
		$robots = isset( $_POST['msp_robots'] ) ? trim( $_POST['msp_robots'] ) : '';
		if ( $robots != '' ) {
			update_post_meta( $post_id, '_msp_robots', $robots );
		} else {
			delete_post_meta( $post_id, '_msp_robots' );
		}
	}
	
	// Current Data version
	var $data_version = 4;
	// Options array
	var $options = null;
	
	// Get default values for options
	function init_options_array() {
		if ( is_null( $this->options ) ) {
			$this->options = array(
		// name, default, sanitization function, data version
		
		// Options for <title>
		'title' => array(
		array( 'msp_enable_title', true, array( null, 'sanitise_bool' ), 1 ), // Rewrite <title>
		array( 'msp_title_home', '%blog_name%', 'trim', 1 ), // Title format for Home Page
		array( 'msp_title_post', '%title% | %categories% | %blog_name%', 'trim', 1 ), // Title format for Posts
		array( 'msp_title_page', '%title% | %blog_name%', 'trim', 1 ), // Title format for Pages
		array( 'msp_title_attach', '%title% | %categories% | %blog_name%', 'trim', 1 ), // Title format for Attachments
		array( 'msp_title_cat', __('%categories% | Categories | %blog_name%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Categories
		array( 'msp_title_tag', __('%tag% | Tags | %blog_name%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Tags
		array( 'msp_title_tax', '%term_name% | %tax_label% | %blog_name%', 'trim', 1 ), // Title format for Custom Taxonomies
		array( 'msp_title_date', __('Archive for %date% | %blog_name%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Year/Month/Day pages
		array( 'msp_title_author', __('%author_name% | Authors | %blog_name%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Author pages
		array( 'msp_title_search', __('Search results for %search% | %blog_name%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Search
		array( 'msp_title_other', '%blog_title% %blog_name%', 'trim', 3 ), // Title format for pages not supported by Meta SEO Pack (without | - wp_title() adds it)
		array( 'msp_title_sub_pages', __('%title% - Page %n%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Subpages of multipage Archives/Posts/Pages
		array( 'msp_title_sub_comments', __('%title% - Comments Page %n%', 'meta-seo-pack'), 'trim', 1 ), // Title format for Subpages of multipage comments
		array( 'msp_title_separator', '&laquo;', 'trim', 1 ), // Title separator
		),
		
		// Options for <meta name="keywords">
		'keywords' => array(
		array( 'msp_enable_keywords', true, array( null, 'sanitise_bool' ), 1 ), // Use <meta keywords>
		array( 'msp_default_keywords', '', array( null, 'sanitise_comma_list' ), 1 ), // Default blog keywords
		array( 'msp_keywords_add_post_tags', true, array( null, 'sanitise_bool' ), 1 ), // Add post tags to post's meta tags
		array( 'msp_keywords_add_post_cats', true, array( null, 'sanitise_bool' ), 1 ), // Add post categories to post's meta tags
		array( 'msp_keywords_add_post_taxes', array(), array( null, 'sanitise_tax_array' ), 4 ), // Add post custom taxonomies to post's meta tags
		array( 'msp_keywords_add_page_taxes', array(), array( null, 'sanitise_tax_array' ), 4 ), // Add page custom taxonomies to page's meta tags
		array( 'msp_keywords_add_cats', true, array( null, 'sanitise_bool' ), 1 ), // Add category name to cat's meta tags
		array( 'msp_keywords_add_tag', true, array( null, 'sanitise_bool' ), 1 ), // Add tag name to tag's meta tags
		array( 'msp_keywords_add_tax_name', true, array( null, 'sanitise_bool' ), 1 ), // Add taxonomy name to tax's meta tags
		array( 'msp_keywords_add_tax_term', true, array( null, 'sanitise_bool' ), 1 ), // Add tax term name to tax's meta tags
		array( 'msp_keywords_add_author', true, array( null, 'sanitise_bool' ), 1 ), // Add author display name to author's meta tags
		array( 'msp_keywords_add_search', true, array( null, 'sanitise_bool' ), 1 ), // Add search query to search's meta tags
		),
		
		// Options for <meta name="description">
		'description' => array(
		array( 'msp_enable_description', true, array( null, 'sanitise_bool' ), 1 ), // Use <meta description>
		array( 'msp_description_home', '%blog_name% - %blog_desc%', 'trim', 1 ), // Default blog description
		array( 'msp_description_gen_from_post', true, array( null, 'sanitise_bool' ), 1 ), // Generate description from posts
		array( 'msp_description_gen_from_page', true, array( null, 'sanitise_bool' ), 1 ), // Generate description from pages
		array( 'msp_description_use_attach_desc', true, array( null, 'sanitise_bool' ), 1 ), // Use attachment description
		array( 'msp_description_use_cat_desc', true, array( null, 'sanitise_bool' ), 1 ), // Use category description
		array( 'msp_description_use_tag_desc', true, array( null, 'sanitise_bool' ), 1 ), // Use tag description
		array( 'msp_description_use_tax_desc', true, array( null, 'sanitise_bool' ), 1 ), // Use taxonomy item description
		
		array( 'msp_description_paged_format', __('%description% - page %n%', 'meta-seo-pack'), 'trim', 1 ), // Default paged description format
		array( 'msp_description_paged_comments_format', __('%description% - comments page %n%', 'meta-seo-pack'), 'trim', 1 ), // Default paged description format for comments
		),
		
		// Options for <meta name="robots">
		'robots' => array(
		array( 'msp_enable_robots', true, array( null, 'sanitise_bool' ), 1 ), // Use <meta robots>
		array( 'msp_robots_noodp', true, array( null, 'sanitise_bool' ), 1 ), // Add noodp to robots
		array( 'msp_robots_noydir', true, array( null, 'sanitise_bool' ), 1 ), // Add noydir to robots
		array( 'msp_robots_noindex_front_subpages', false, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for subpages of home page
		array( 'msp_robots_noindex_attach', false, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for attachments
		array( 'msp_robots_noindex_cat', false, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for categories
		array( 'msp_robots_noindex_tag', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for tags
		array( 'msp_robots_noindex_tax', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for custom taxonomies
		array( 'msp_robots_noindex_date', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for day/month/year archives
		array( 'msp_robots_noindex_author', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for authors
		array( 'msp_robots_noindex_search', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to robots for search results
		array( 'msp_robots_noindex_post_comments', false, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to subpages of post comments
		array( 'msp_robots_noindex_feed', true, array( null, 'sanitise_bool' ), 1 ), // Add noindex,follow to feeds and send X-Robots-Tag header
		//array( 'msp_default_robots', '', 'trim' ), // Default blog robots
		),
		
		// Options for canonical URLs
		'canonical' => array(
		array( 'msp_enable_canonical', true, array( null, 'sanitise_bool' ), 1 ), // Use <link rel="canonical">
		),
		
		// Nofollow links
		'nofollow' => array(
		array( 'msp_enable_nofollow', true, array( null, 'sanitise_bool' ), 3 ), // Use rel="nofollow"
		array( 'msp_nofollow_comment', true, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to link to Comments from Post list
		array( 'msp_nofollow_more', true, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to 'More...' link
		array( 'msp_nofollow_page', false, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links to Pages from Theme and Pages Widget
		array( 'msp_nofollow_cat_theme', false, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links to Categories from Post list in Theme
		array( 'msp_nofollow_cat_widget', false, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links to Categories from Categories Widget
		array( 'msp_nofollow_tag_theme', true, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links to Tags from Theme
		array( 'msp_nofollow_tag_widget', true, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links to Tags from Tag Cloud Widget
		array( 'msp_nofollow_archive', true, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to links in Archives Widget
		array( 'msp_nofollow_blogroll', false, array( null, 'sanitise_bool' ), 2 ), // Add nofollow to Blogroll Links
		array( 'msp_nofollow_backend', true, array( null, 'sanitise_bool' ), 1 ), // Add nofollow to Register/Login/Logout/Site Admin links
		),
		
		// Duplicate Content elimination
		/*'duplicate' => array(
		),*/
		
		// Other options
		'other' => array(
		array( 'msp_add_footer_link', true, array( null, 'sanitise_bool' ), 1 ), // Add link in footer
		),
		
		);
		}
	}
	
	// Add configuration options
	function register_options() {
		$this->init_options_array();
		if ( defined( 'WP_DEBUG' ) && WP_DEBUG ) {
			$data_version = 0; // Do not do the data version check in debug mode
		} else {
			$data_version = get_option( 'msp_data_version', 0 );
		}
		if ( $data_version < $this->data_version ) {
			// Register new options in DB
			foreach ( $this->options as $optgroup => $options ) {
				foreach ( $options as $option ) {
					if ( $option[3] > $data_version ) {
						add_option( $option[0], $option[1] );
					}
				}
			}
			
			// Do version-specific updates
			if ( $data_version <= 3 ) {
				// Fix: custom taxonomy pages has taxonomy slug in title instead of term name
				$msp_title_tax = get_option( 'msp_title_tax' );
				$msp_title_tax = str_replace( '%tax_name%', '%term_name%', $msp_title_tax );
				update_option( 'msp_title_tax', $msp_title_tax );
			}
			
			// Set or update data version in DB
			if ( $data_version == 0 ) {
				add_option( 'msp_data_version', $this->data_version );
			} else {
				update_option( 'msp_data_version', $this->data_version );
			}
		}
	}
	
	// Initialize plugin - admin part
	function admin_init() {
		$this->init_options_array();
		foreach ( $this->options as $optgroup => $options ) {
			$group_name = 'meta-seo-pack-' . $optgroup;
			foreach ( $options as $option ) {
				if ( is_array( $option[2] ) ) {
					$option[2][0] =& $this;
				}
				
				register_setting( $group_name, $option[0], $option[2] );
			}
		}
	}
	
	// Helper functions for options panels
	function show_options_panel( $options_group, $page_title ) {
		if ( !current_user_can('manage_options') ) {
			wp_die( 'Cheatin&#8217; uh?' );
		}
		
		$option_page = 'meta-seo-pack-'.$options_group;
		
		if ( isset($_GET['updated']) ) {
			$message = __('Configuration has been saved.', 'meta-seo-pack');
			echo '<div id="message" class="updated fade"><p>', $message, '</p></div>', "\n";
		}
?>
<div class="wrap">
<h2><?php echo $page_title; ?></h2>

<form name="dofollow" action="options.php" method="post">
<?php settings_fields( $option_page ); ?>
<table class="form-table">

<?php
$full_file = WP_PLUGIN_DIR.'/meta-seo-pack/admin/'.$options_group.'.php';
include $full_file;
?>

</table>

<p class="submit">
<input type="submit" name="Submit" value="<?php _e('Save settings', 'meta-seo-pack'); ?>" /> 
</p>

</form>
</div>
<?php
	}
	
	// Handle options panel for Title Rewriting
	function options_panel_title() {
		$this->show_options_panel( 'title', 'Meta SEO Pack: '.__('Title Rewriting', 'meta-seo-pack') );
	}
	
	// Handle options panel for Meta Keywords
	function options_panel_keywords() {
		$this->show_options_panel( 'keywords', 'Meta SEO Pack: '.__('Meta Keywords', 'meta-seo-pack') );
	}
	
	// Handle options panel for Meta Description
	function options_panel_description() {
		$this->show_options_panel( 'description', 'Meta SEO Pack: '.__('Meta Description', 'meta-seo-pack') );
	}
	
	// Handle options panel for Meta Robots
	function options_panel_robots() {
		$this->show_options_panel( 'robots', 'Meta SEO Pack: '.__('Meta Robots', 'meta-seo-pack') );
	}
	
	// Handle options panel for Canonical URLs
	function options_panel_canonical() {
		$this->show_options_panel( 'canonical', 'Meta SEO Pack: '.__('Canonical URLs', 'meta-seo-pack') );
	}
	
	// Handle options panel for Nofollow Links
	function options_panel_nofollow() {
		$this->show_options_panel( 'nofollow', 'Meta SEO Pack: '.__('Nofollow links', 'meta-seo-pack') );
	}
	
	// Handle options panel for Duplicate Content
	/*function options_panel_duplicate() {
		$this->show_options_panel( 'duplicate', 'Meta SEO Pack: '.__('Duplicate Content', 'meta-seo-pack') );
	}*/
	
	// Handle options panel for Other Settings
	function options_panel_other() {
		$this->show_options_panel( 'other', 'Meta SEO Pack: '.__('Other Settings', 'meta-seo-pack') );
	}
	
	// Handle options panel for robots.txt
	/*function options_panel_robots_txt() {
		$this->show_options_panel( 'robots_txt', 'Meta SEO Pack: '.__('Robots.txt', 'meta-seo-pack') );
	}*/
	
	// Return unique values only
	function get_unique_values( $values ) {
		$ret = array();
		foreach ( $values as $val ) {
			$val = trim( $val );
			if ( ( $val != '' ) && !in_array( $val, $ret ) ) {
				$ret[] = $val;
			}
		}
		return $ret;
	}
	
	// Sanitise function for boolean options
	function sanitise_bool( $value ) {
		return isset( $value ) && ( $value == 'yes' );
	}
	
	// Sanitise function for comma-separated lists
	// Note: it preserves unique values only
	function sanitise_comma_list( $value ) {
		$values = explode( ',', $value );
		return implode( ',', $this->get_unique_values( $values ) );
	}
	
	// Sanitise array of custom taxonomy names
	function sanitise_tax_array( $taxes ) {
		if ( !is_array( $taxes ) ) {
			return array();
		}
		
		$ret = array();
		foreach ( $taxes as $tax ) {
			if ( is_string( $tax ) && is_taxonomy( $tax ) ) {
				$ret[] = $tax;
			}
		}
		return $ret;
	}
	
	// Return string with first letter of each word uppercased
	function uc_words( $str ) {
		if ( $this->has_mbstr ) {
			return mb_convert_case( $str, MB_CASE_TITLE );
		} else {
			return ucwords( strtolower( $str ) );
		}
	}
	
	// Encode all HTML special chars, including HTML entities
	// (by default wp_specialchars passes entities as-is)
	function specialchars( $str ) {
		return wp_specialchars( $str, ENT_QUOTES, false, true );
	}
	
	// Get taxonomy types for given post type
	function get_taxonomies_for_type( $type, $exclude_default = true ) {
		$taxonomies = get_object_taxonomies( $type );
		if ( !$exclude_default ) {
			return $taxonomies;
		}
		
		$default_taxonomies = array( 'category', 'post_tag', 'link_category' );
		$ret = array();
		foreach ( $taxonomies as $tax ) {
			if ( !in_array( $tax, $default_taxonomies ) ) {
				$ret[] = $tax;
			}
		}
		return $ret;
	}
	
	// Strip shortcodes from text
	function strip_shortcodes( $text ) {
		// Regex copied from original strip_shortcodes() and changed to match any shortcode
		$pattern = '(.?)\[([^\]]+)\b(.*?)(?:(\/))?\](?:(.+?)\[\/\2\])?(.?)';
		return preg_replace( '/'.$pattern.'/s', '', $text );
	}
	
	// Show warning when WordPress is in Private Mode
	function show_private_blog_warning() {
		echo '<div id="notice" class="error"><p>';
		printf( __('<b>Meta SEO Pack Warning:</b> WordPress is configured to block search engines (like Google, Bing, Technorati) and archivers. Please go to the <a href="%s">Privacy Settings page</a> and change this - otherwise your blog will not be visible for them!', 'meta-seo-pack'), admin_url( 'options-privacy.php' ) );
		echo '</p></div>', "\n";
	}
} // End class

// Add functions from WP2.8 for previous WP versions
if ( !function_exists( 'esc_html' ) ) {
	function esc_html( $text ) {
		return wp_specialchars( $text );
	}
}

if ( !function_exists( 'esc_attr' ) ) {
	function esc_attr( $text ) {
		return attribute_escape( $text );
	}
}

$wp_meta_seo_pack = new MetaSeoPack();

// Function which allows to access internal Meta SEO Pack options
// Please do not access options directly - their names may change in the future!
function msp_get_option( $name ) {
	switch( $name ) {
		case 'rewrite_title':
			return get_option( 'msp_enable_title' );
		case 'add_keywords':
			return get_option( 'msp_enable_keywords' );
		case 'add_description':
			return get_option( 'msp_enable_description' );
		case 'add_robots':
			return get_option( 'msp_enable_robots' );
		case 'add_canonical':
			return get_option( 'msp_enable_canonical' );
		default:
			return false;
	}
}

} /* END */

?>