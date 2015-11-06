=== Plugin Name ===
Contributors: sirzooro
Tags: seo, nofollow, noindex, bing, google, msn, yahoo, meta description, meta keywords, meta, title, robots, canonical, canonical url
Requires at least: 2.7
Tested up to: 2.9.9
Stable tag: 2.2.1

Fine tune your WordPress for SEO: rewrite title, add meta tags, canonical links and more. Out-of-the-box settings are a good starting point for blogs.

== Description ==

One of the biggest sources of traffic for your blog are Search Engines - mainly Google, Yahoo! and Bing (formerly MSN). Therefore it is crucial to optimize WordPress to make it SEO-friendly. Many things are already done in WordPress itself, but still there is a room for many improvements.

If you care about Search Engines and your position in search results, you should install this plugin. If you are a beginner, default settings will be good for you. If you are an advanced user, you have many options to fine-tune your blog.

Some of the plugin features are:

* Rewrite `<title>` tag to get most of it;
* Add Meta Keywords, Meta Description and Meta Robots tags to all blog pages;
* Use entered tags and descriptions for Meta Keywords and Meta Description tags, or generate them from content;
* Prevent Search Engines from indexing archive pages and feeds, in order to avoid Duplicate Content problem;
* Prevent Search Engines from using descriptions entered in DMOZ (ODP) or Yahoo! Directory as description for page;
* Add `<link rel="canonical">` to specify preferred URL for each page;
* Add `rel="nofollow"` to links in various places;
* Allows to enter custom meta keywords, description and robots for every post and page;
* Good default configuration for beginners and a lot of configuration options for advanced users (look for new 'Meta SEO Pack' menu);
* Full support for custom taxonomies;
* Custom filters - other plugins can integrate itself with Meta SEO Pack;

Detailed information about `<title>` rewriting and Meta Tags generation you can find in [FAQ](http://wordpress.org/extend/plugins/meta-seo-pack/faq/).

Available translations:

* English
* Polish (pl_PL) - done by me
* Dutch (nl_NL) - thanks [Rene](http://wpwebshop.com/)

[Changelog](http://wordpress.org/extend/plugins/meta-seo-pack/changelog/)

== Installation ==

1. Upload `meta-seo-pack` directory to the `/wp-content/plugins/` directory
1. Activate the plugin through the 'Plugins' menu in WordPress
1. Go to the 'Meta SEO Pack' menu and configure it if you want (you can also leave default configuration as-is if you are a beginner)
1. Enjoy :)

== Frequently Asked Questions ==

= How Meta SEO Pack rewrites `title` tag? =

Meta SEO Pack uses following title formats as a base for title of different pages (configurable):

* Home Page: `%blog_name%`
* Posts: `%title% | %categories% | %blog_name%`
* Pages: `%title% | %blog_name%`
* Attachments: `%title% | %categories% | %blog_name%`
* Categories: `%categories% | Categories | %blog_name%`
* Tags: `%tag% | Tags | %blog_name%`
* Custom Taxonomies: `%term_name% | %tax_label% | %blog_name%`
* Archive for Day/Month/Year: `Archive for %date% | %blog_name%`
* Author Posts: `%author_name% | Authors | %blog_name%`
* Search Results: `Search results for %search% | %blog_name%`
* Other pages: `%blog_title% | %blog_name%`

There are also extra rewriting rules for subsequent pages of archives, posts, pages and comments. This way you will avoid duplicate title problems (reported in Google Webmasters Tools):

* Subpages for multipage Archives/Posts/Pages: `%desc% - Page %n%`
* Subpages for multipage comments: `%desc% - Comments Page %n%`

Title formats with hardcoded english words are translatable, so you will not have to translate them (assuming there is a translation for your language).

= How Meta SEO Pack generates value for `meta keywords` tag? =

All pages uses configured Default keywords as value for `meta keywords` tag. Some of the pages also adds some extra keywords (configurable):

* Home Page: no extra keywords
* Posts: meta tags, tags, categories, custom taxonomies
* Pages: meta tags, custom taxonomies
* Attachments: no extra keywords
* Categories: category name and all parents
* Tags: tag name
* Custom Taxonomies: taxonomy name and taxonomy term name
* Archive for Day/Month/Year: no extra keywords
* Author Posts: author name
* Search Results: search term

Plugin does not add extra keywords for subpages.

= How Meta SEO Pack generates value for `meta description` tag? =

Meta SEO Pack either uses entered description, excerpt or generate it from content. This depends on page (configurable):

* Home Page: special description (by default it is set to `%blog_name% - %blog_desc%`)
* Posts: either use entered meta description, excerpt (if entered) or generate from post content (initial part)
* Pages: use entered meta description or generate it from page content (initial part)
* Attachments: attachment description
* Categories: use category description
* Tags: use tag description
* Custom Taxonomies: taxonomy term description
* Archive for Day/Month/Year: description is not added (yet)
* Author Posts: description is not added (yet)
* Search Results: description is not added (yet)

Description is also additionally changed for subsequent pages of archives, posts, pages and comments. This way you will avoid duplicate description problems (reported in Google Webmasters Tools):

* Subpages for multipage Archives/Posts/Pages: `%description% - page %n%`
* Subpages for multipage comments: `%description% - comments page %n%`

= How Meta SEO Pack generates value for `meta robots` tag? =

Meta SEO Pack adds `noindex,follow` as a value of `meta robots` for pages, in order to avoid Duplicate Content problem. `follow` is added to make sure you will keep link juice of links leading to noindexed pages. Here is the list of pages which can be noindexed (configurable):

* Home Page: subpages only
* Posts: comment subpages only
* Pages: no
* Attachments: yes
* Categories: yes
* Tags: yes
* Custom Taxonomies: yes
* Archive for Day/Month/Year: yes
* Author Posts: yes
* Search Results: yes

Meta SEO Pack can also add `noodp` and `noydir`, in order to prevent Search Engines from using descriptions entered in DMOZ (ODP) or Yahoo! Directory as description for page.

You can also enter your meta robots value for every Post and Page - when you do so, it will take precedence over default configuration. Meta SEO Pack will add `noodp` and `noydir` if you checked these options.

You can also noindex your feeds - Meta SEO Pack can both add `meta robots` tag to feeds and send `X-Robots-Tag` HTTP Header.

= How to remove footer added by Meta SEO Pack? =

This plugin is provided for free, so this footer is the only way I can get credit from happy users. Of course you can disable it - just go to the plugin Options page, scroll to the bottom, uncheck "Add link to Meta SEO Pack" and save options.

== Integration manual for plugin developers ==

= Filters usage in Meta SEO Pack =

Meta SEO Pack internally calls many filters. Some of them are internal WordPress filters (some parts of plugin code bases on core WordPress code), but there is also a group of plugin-specific filters. You can use them to integrate your plugin with Meta SEO Pack. Full list of them you can find below.

Meta SEO Pack uses two kinds of filters to get metadata information (title, keywords, etc.): ones named `msp_get_something` and `msp_something`. The former ones are called when Meta SEO Pack does not support particular page type - you can use them to return metadata for custom page types generated by your plugin. The latter ones are called to do postprocessing of metadata. By default plugin registers three default WordPress filters (`wptexturize`, `convert_chars` and `esc_html`) to postprocess title, keywords and description values.

= Filters for title rewriting =

* `msp_get_title_format` - filter called when Meta SEO Pack does not support some kind of pages internally. You can use it to return your title format (with `%name%` tags);
* `msp_get_title_data` - filter called just after `msp_get_title_format` filter, to get array of values, which later are used to replace `%name%` tags in title. Note: keys in arrays should be added without percent (`%`) marks;
* `msp_title` - postprocessing of title.

= Filters for meta keywords =

* `msp_get_keywords` - filter called when Meta SEO Pack does not support some kind of pages internally. You can use it to return your meta keywords;
* `msp_keywords` - postprocessing of meta keywords.

= Filters for meta description =

* `msp_get_description` - filter called when Meta SEO Pack does not support some kind of pages internally. You can use it to return your meta description;
* `msp_description` - postprocessing of meta description.

= Filters for meta robots =

* `msp_get_robots` - filter called when Meta SEO Pack does not support some kind of pages internally. You can use it to return your meta robots;
* `msp_robots` - postprocessing of meta robots.

= Filters for canonical URL =

* `msp_get_canonical` - filter called when Meta SEO Pack does not support some kind of pages internally. You can use it to return your canonical URL;
* `msp_canonical` - postprocessing of canonical URL.

= Other functions =

Meta SEO Pack exposes few functions too. You can use them in your plugin (or theme) too. Please use them instead of accessing class members and options directly - they may change in some version. On the other hand, functions listed here should not change.

* `msp_get_option` - get value of selected Meta SEO Pack options. Functions returns option value, or `false` if option name is not supported. You can query values of following options:
	* `rewrite_title` - `true` if title rewriting is enabled;
	* `add_keywords` - `true` if meta keywords are enabled;
	* `add_description` - `true` if meta description is enabled;
	* `add_robots` - `true` if meta robots are enabled;
	* `add_canonical` - `true` if canonical URLs are enabled.

= Examples =

*Integrate title generation*

Meta SEO Pack calls `wp_title()` function, so you can use `wp_title` filter to provide your title. Of course you can also take advantage of Meta SEO Pack integration - here is the code:
`
// Check if Meta SEO Pack is present and title rewriting is enabled
if ( function_exists( 'msp_get_option' ) && msp_get_option( 'rewrite_title' ) ) {
	// Register filters for Meta SEO Pack
	add_filter( 'msp_get_title_format', 'my_title_format' );
	add_filter( 'msp_get_title_data', 'my_title_data' );
} else {
	// Register default WordPress filter
	add_filter( 'wp_title', 'my_title', 10, 3 );
}

// Return title format
function my_title_format( $format ) {
	if ( this_is_my_page() ) {
		$format = '%f1% | %f2% | %blog_name%';
	}
	return $format;
}

// Return parameters for title format
function my_title_data( $data ) {
	if ( this_is_my_page() ) {
		$data['f1'] = 'Value 1';
		$data['f2'] = 'Value 2';
	}
	return $data;
}

// Return title for wp_title() function
function wp_title( $title, $sep, $seplocation ) {
	if ( this_is_my_page() ) {
		if ( $seplocation == 'right' ) {
			$title = "Value 1 $sep Value 2 $sep ";
		} else {
			$title = " $sep Value 2 $sep Value 1";
		}
	}
	return $title;
}
`

== Changelog ==

= 2.2.1 =
* Added Dutch translation (thanks Rene);
* Code cleanup

= 2.2 =
* Fix: custom taxonomy pages does not have term name in rewritten title;
* Changed default title format for custom Taxonomies to `%term_name% | %tax_label% | %blog_name%` (MSP should update your existing title format automatically to use `%term_name%` instead of `%tax_name%`);
* Allow to use custom taxonomies as keywords for posts and pages;
* Show warning when WordPress is configured to block search engines;
* Fix: strip non-registered shortcodes too from generated meta description

= 2.1.3 =
* Removed cannonical tag added by WP 2.9 (it is generated for posts, pages and attachments only)
* Updated to be compatible with WP 2.9.x

= 2.1.2 =
* Marked as compatible with WP 2.8.5

= 2.1.1 =
* Do not show post/page metadata in Custom Fields

= 2.1 =
* Added option to globally enable and disable `rel="nofollow"`;
* Allow to enter custom meta keywords, description and robots for every post and page;
* Added default title format for pages not supported by Meta SEO Pack yet (usually ones added by other plugins);
* Added "Integration manual for plugin developers" to the readme file

= 2.0 =
* Added options to add `rel="nofollow"` to various links;
* Added new menu, split single options page into multiple pages;
* Send Send X-Robots-Tag in WP 2.7 too;
* Optimised options initialisation

= 1.2 =
* Added option to add `rel="nofollow"` to links to admin section

= 1.1.2 =

* Added Polish translation

= 1.1.1 =

* Fixed catchable fatal error when getting post category

= 1.1 =
* Added options to configure title rewriting
* Fixed title rewriting for Custom Taxonomies
* Fixed fatal error when mbstring PHP extension is not loaded

= 1.0.1 =
* Make plugin compatible with WordPress 2.7 (may work with lower versions too)

= 1.0 =
* Initial version
