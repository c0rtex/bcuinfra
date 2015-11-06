<!-- Title rewriting -->
<tr><th colspan="2"><h3><?php _e('Title rewriting:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_title"><?php _e('Rewrite <code>&lt;title&gt;</code> tag', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_title" name="msp_enable_title" value="yes" <?php checked( true, get_option( 'msp_enable_title' ) ); ?> />
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_separator"><?php _e('Title separator', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="10" id="msp_title_separator" name="msp_title_separator" value="<?php echo $this->specialchars( get_option( 'msp_title_separator' ) ); ?>" /><br />
<?php _e('Meta SEO Pack will change <code>|</code> in formats to given character (by default <code>&amp;laquo;</code>)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Home Page:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_home"><?php _e('Title format for Home Page', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_home" name="msp_title_home" value="<?php echo $this->specialchars( get_option( 'msp_title_home' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_post"><?php _e('Title format for Posts', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_post" name="msp_title_post" value="<?php echo $this->specialchars( get_option( 'msp_title_post' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_page"><?php _e('Title format for Pages', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_page" name="msp_title_page" value="<?php echo $this->specialchars( get_option( 'msp_title_page' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Attachments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_attach"><?php _e('Title format for Attachments', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_attach" name="msp_title_attach" value="<?php echo $this->specialchars( get_option( 'msp_title_attach' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Categories:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_cat"><?php _e('Title format for Categories', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_cat" name="msp_title_cat" value="<?php echo $this->specialchars( get_option( 'msp_title_cat' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Tags:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_tag"><?php _e('Title format for Tags', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_tag" name="msp_title_tag" value="<?php echo $this->specialchars( get_option( 'msp_title_tag' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Custom Taxonomies:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_tax"><?php _e('Title format for Custom Taxonomies', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_tax" name="msp_title_tax" value="<?php echo $this->specialchars( get_option( 'msp_title_tax' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Archive for Day/Month/Year:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_date"><?php _e('Title format for Archives for Day/Month/Year', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_date" name="msp_title_date" value="<?php echo $this->specialchars( get_option( 'msp_title_date' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Author Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_author"><?php _e('Title format for Author Posts', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_author" name="msp_title_author" value="<?php echo $this->specialchars( get_option( 'msp_title_author' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Search Results:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_search"><?php _e('Title format for Search Results', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_search" name="msp_title_search" value="<?php echo $this->specialchars( get_option( 'msp_title_search' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Other pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_other"><?php _e('Title format for other pages', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_other" name="msp_title_other" value="<?php echo $this->specialchars( get_option( 'msp_title_other' ) ); ?>" /><br />
<?php _e('This title format will be used for pages which are not supported by Meta SEO Pack directly - usually ones added by plugins.', 'meta-seo-pack'); ?><br />
<?php _e('Note: please do not add <code>|</code> before last element - WordPress will add it automatically.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage Archives/Posts/Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_sub_pages"><?php _e('Title format for Subpages for multipage Archives/Posts/Pages', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_sub_pages" name="msp_title_sub_pages" value="<?php echo $this->specialchars( get_option( 'msp_title_sub_pages' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage comments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_title_sub_comments"><?php _e('Title format for Subpages for multipage comments', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_title_sub_comments" name="msp_title_sub_comments" value="<?php echo $this->specialchars( get_option( 'msp_title_sub_comments' ) ); ?>" /><br />
<?php _e('', 'meta-seo-pack'); ?>
</td>
</tr>
