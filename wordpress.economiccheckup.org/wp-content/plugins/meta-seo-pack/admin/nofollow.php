<!-- Nofollow -->
<tr><th colspan="2"><h3><?php _e('Nofollow Links:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_nofollow"><?php _e('Add <code>rel=&quot;nofollow&quot;</code> attribute to links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_nofollow" name="msp_enable_nofollow" value="yes" <?php checked( true, get_option( 'msp_enable_nofollow' ) ); ?> />
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Home Page:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_comment"><?php _e('Add to comments links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_comment" name="msp_nofollow_comment" value="yes" <?php checked( true, get_option( 'msp_nofollow_comment' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading directly to comments', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_more"><?php _e('Add to "Read More..." links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_more" name="msp_nofollow_more" value="yes" <?php checked( true, get_option( 'msp_nofollow_more' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to "Read More..." links', 'meta-seo-pack'); ?>
<br /><?php _e('<b>Note:</b> it will be added only when you display whole posts on your main page and archive pages, and use <code>&lt;!--more--&gt;</code> tag somewhere in post content to show initial fragment only.', 'meta-seo-pack'); ?>
<br /><?php _e('<b>Note 2:</b> when your Theme shows excerpts only on main page and archive pages, and you want to add <code>rel=&quot;nofollow&quot;</code> to &quot;Read More...&quot; links, you need to edit your theme manually.', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_page"><?php _e('Add to Pages links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_page" name="msp_nofollow_page" value="yes" <?php checked( true, get_option( 'msp_nofollow_page' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Pages (both from Theme and Pages Widget; not recommended)', 'meta-seo-pack'); ?>
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
<label for="msp_nofollow_cat_theme"><?php _e('Add to Categories links from Theme', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_cat_theme" name="msp_nofollow_cat_theme" value="yes" <?php checked( true, get_option( 'msp_nofollow_cat_theme' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Categories from Theme (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_cat_widget"><?php _e('Add to Categories links from Widget', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_cat_widget" name="msp_nofollow_cat_widget" value="yes" <?php checked( true, get_option( 'msp_nofollow_cat_widget' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Categories from Categories Widget (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Tags:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_tag_theme"><?php _e('Add to Tags links from Theme', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_tag_theme" name="msp_nofollow_tag_theme" value="yes" <?php checked( true, get_option( 'msp_nofollow_tag_theme' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Tags from Theme', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_tag_widget"><?php _e('Add to Tags links from Widget', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_tag_widget" name="msp_nofollow_tag_widget" value="yes" <?php checked( true, get_option( 'msp_nofollow_tag_widget' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Tags from Tag Cloud Widget', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Custom Taxonomies:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Archive for Day/Month/Year:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_archive"><?php _e('Add to Archive links from Widget', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_archive" name="msp_nofollow_archive" value="yes" <?php checked( true, get_option( 'msp_nofollow_archive' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to links leading to Day/Month/Year Archive pages from Archives Widget', 'meta-seo-pack'); ?>
<br /><?php _e('<b>Note:</b> this does not add <code>rel=&quot;nofollow&quot;</code> to links in the Calendar Widget (this is not supported by WordPress yet).', 'meta-seo-pack'); ?>
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

<tr><th colspan="2"><b>&raquo; <?php _e('Links to Admin section:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_backend"><?php _e('Add to Admin links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_backend" name="msp_nofollow_backend" value="yes" <?php checked( true, get_option( 'msp_nofollow_backend' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to Register/Login/Logout/Site Admin links', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Blogroll:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_nofollow_blogroll"><?php _e('Add to Blogroll links', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_nofollow_blogroll" name="msp_nofollow_blogroll" value="yes" <?php checked( true, get_option( 'msp_nofollow_blogroll' ) ); ?> /><br /><?php _e('Add <code>rel=&quot;nofollow&quot;</code> to Blogroll links', 'meta-seo-pack'); ?>
</td>
</tr>
