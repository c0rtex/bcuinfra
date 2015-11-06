<!-- Meta description -->
<tr><th colspan="2"><h3><?php _e('Meta Description tag:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_description"><?php _e('Add <code>&lt;meta name=&quot;description&quot;&gt;</code> tag', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_description" name="msp_enable_description" value="yes" <?php checked( true, get_option( 'msp_enable_description' ) ); ?> />
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Home Page:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_home"><?php _e('Home page description', 'meta-seo-pack'); ?>:</label>
</th>
<td>
<textarea rows="3" cols="57" id="msp_description_home" name="msp_description_home"><?php echo esc_html( get_option( 'msp_description_home' ) ); ?></textarea><br /><?php _e('You can use <code>%blog_name%</code> as a placeholder for Blog Name, and <code>%blog_desc%</code> for Blog Description (Tagline).', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_gen_from_post"><?php _e('Generate description from post', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_gen_from_post" name="msp_description_gen_from_post" value="yes" <?php checked( true, get_option( 'msp_description_gen_from_post' ) ); ?> /><br /><?php _e('Generate value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag from post excerpt (if entered) or post content', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_gen_from_page"><?php _e('Generate description from page', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_gen_from_page" name="msp_description_gen_from_page" value="yes" <?php checked( true, get_option( 'msp_description_gen_from_page' ) ); ?> /><br /><?php _e('Generate value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag from page content', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Attachments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_use_attach_desc"><?php _e('Use attachment description', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_use_attach_desc" name="msp_description_use_attach_desc" value="yes" <?php checked( true, get_option( 'msp_description_use_attach_desc' ) ); ?> /><br /><?php _e('Use attachment description as value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Categories:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_use_cat_desc"><?php _e('Use category description', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_use_cat_desc" name="msp_description_use_cat_desc" value="yes" <?php checked( true, get_option( 'msp_description_use_cat_desc' ) ); ?> /><br /><?php _e('Use category description as value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Tags:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_use_tag_desc"><?php _e('Use tag description', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_use_tag_desc" name="msp_description_use_tag_desc" value="yes" <?php checked( true, get_option( 'msp_description_use_tag_desc' ) ); ?> /><br /><?php _e('Use tag description as value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Custom Taxonomies:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_use_tax_desc"><?php _e('Use taxonomy item description', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_description_use_tax_desc" name="msp_description_use_tax_desc" value="yes" <?php checked( true, get_option( 'msp_description_use_tax_desc' ) ); ?> /><br /><?php _e('Use taxonomy item description as value for <code>&lt;meta name=&quot;description&quot;&gt;</code> tag', 'meta-seo-pack'); ?>
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
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Search Results:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage Archives/Posts/Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_paged_format"><?php _e('Multi-paged description format', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_description_paged_format" name="msp_description_paged_format" value="<?php echo esc_attr( get_option( 'msp_description_paged_format' ) ); ?>" /><br />
<?php _e('Subsequent pages of post archives and post/page content should have different descriptions in order to avoid duplicated description problem. Use <code>%description%</code> as a placeholder for generated description, and <code>%n%</code> for page number.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Subpages for multipage comments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_description_paged_comments_format"><?php _e('Multi-paged description format for comments', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="text" size="70" id="msp_description_paged_comments_format" name="msp_description_paged_comments_format" value="<?php echo esc_attr( get_option( 'msp_description_paged_comments_format' ) ); ?>" /><br />
<?php _e('Similar to option above, but for comment pages. Use <code>%description%</code> and <code>%n%</code> here too.', 'meta-seo-pack'); ?>
</td>
</tr>
