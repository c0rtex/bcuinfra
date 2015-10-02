<!-- Meta keywords -->
<tr><th colspan="2"><h3><?php _e('Meta Keywords tag:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_keywords"><?php _e('Add <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_keywords" name="msp_enable_keywords" value="yes" <?php checked( true, get_option( 'msp_enable_keywords' ) ); ?> />
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_default_keywords"><?php _e('Default keywords', 'meta-seo-pack'); ?>:</label>
</th>
<td>
<textarea rows="2" cols="57" id="msp_default_keywords" name="msp_default_keywords"><?php echo esc_html( get_option( 'msp_default_keywords' ) ); ?></textarea><br />
<?php _e('Separate keywords with commas (e.g. <code>key1,key2,key3</code>).', 'meta-seo-pack'); ?><br /><?php _e('These keywords will be used everywhere. You can enable options below to add additional tags to the list.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Home Page:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('Meta SEO Pack uses default keywords for Home Page', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_post_tags"><?php _e('Add post tags', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_post_tags" name="msp_keywords_add_post_tags" value="yes" <?php checked( true, get_option( 'msp_keywords_add_post_tags' ) ); ?> /><br />
<?php _e('Check this to add post\'s tags to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Post.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_post_cats"><?php _e('Add post categories', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_post_cats" name="msp_keywords_add_post_cats" value="yes" <?php checked( true, get_option( 'msp_keywords_add_post_cats' ) ); ?> /><br />
<?php _e('Check this to add post\'s categories (and parent categories too) to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Post.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<?php _e('Add custom taxonomies', 'meta-seo-pack'); ?>:
</th>
<td>
<?php 
$selected_taxonomies = get_option( 'msp_keywords_add_post_taxes' );
$taxonomies = $this->get_taxonomies_for_type( 'post' );
if ( count( $taxonomies ) > 0 ) {
	foreach ( $taxonomies as $tax_name ) {
		$taxonomy = get_taxonomy( $tax_name );
?>
<label><input type="checkbox" id="msp_keywords_add_post_taxes_<?php print $tax_name; ?>" name="msp_keywords_add_post_taxes[]" value="<?php print $tax_name; ?>" <?php checked( true, in_array( $tax_name, $selected_taxonomies ) ); ?> /> <?php print $taxonomy->label; ?></label><br />
<?php } ?>
<?php _e('Check above boxes to add selected post\'s custom taxonomies terms to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Post.', 'meta-seo-pack'); ?>
<?php } else { ?>
<?php _e('No registered custom taxonomies for posts.', 'meta-seo-pack'); ?>
<?php } ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<?php _e('Add custom taxonomies', 'meta-seo-pack'); ?>:
</th>
<td>
<?php 
$selected_taxonomies = get_option( 'msp_keywords_add_page_taxes' );
$taxonomies = $this->get_taxonomies_for_type( 'page' );
if ( count( $taxonomies ) > 0 ) {
	foreach ( $taxonomies as $tax_name ) {
		$taxonomy = get_taxonomy( $tax_name );
?>
<label><input type="checkbox" id="msp_keywords_add_page_taxes_<?php print $tax_name; ?>" name="msp_keywords_add_page_taxes[]" value="<?php print $tax_name; ?>" <?php checked( true, in_array( $tax_name, $selected_taxonomies ) ); ?> /> <?php print $taxonomy->label; ?></label><br />
<?php } ?>
<?php _e('Check above boxes to add selected page\'s custom taxonomies terms to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Page.', 'meta-seo-pack'); ?>
<?php } else { ?>
<?php _e('No registered custom taxonomies for pages.', 'meta-seo-pack'); ?>
<?php } ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Attachments:', 'meta-seo-pack'); ?></b></th></tr>
<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Categories:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_cats"><?php _e('Add category name', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_cats" name="msp_keywords_add_cats" value="yes" <?php checked( true, get_option( 'msp_keywords_add_cats' ) ); ?> /><br />
<?php _e('Check this to add category name (and parent categories too) to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Category page.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Tags:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_tag"><?php _e('Add tag name', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_tag" name="msp_keywords_add_tag" value="yes" <?php checked( true, get_option( 'msp_keywords_add_tag' ) ); ?> /><br />
<?php _e('Check this to add tag name to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Tag page.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Custom Taxonomies:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_tax_name"><?php _e('Add taxonomy name', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_tax_name" name="msp_keywords_add_tax_name" value="yes" <?php checked( true, get_option( 'msp_keywords_add_tax_name' ) ); ?> /><br />
<?php _e('Check this to add taxonomy name to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Taxonomy page (custom taxonomies only).', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_tax_term"><?php _e('Add taxonomy term name', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_tax_term" name="msp_keywords_add_tax_term" value="yes" <?php checked( true, get_option( 'msp_keywords_add_tax_term' ) ); ?> /><br />
<?php _e('Check this to add taxonomy term name to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Taxonomy page (custom taxonomies only).', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Archive for Day/Month/Year:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>
<tr><th colspan="2"><b>&raquo; <?php _e('Author Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_author"><?php _e('Add author\'s display name', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_author" name="msp_keywords_add_author" value="yes" <?php checked( true, get_option( 'msp_keywords_add_author' ) ); ?> /><br />
<?php _e('Check this to add author\'s display name to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Author page.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Search Results:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_keywords_add_search"><?php _e('Add search query', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_keywords_add_search" name="msp_keywords_add_search" value="yes" <?php checked( true, get_option( 'msp_keywords_add_search' ) ); ?> /><br />
<?php _e('Check this to add search query to <code>&lt;meta name=&quot;keywords&quot;&gt;</code> tag for that Search page.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage Archives/Posts/Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage comments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>
