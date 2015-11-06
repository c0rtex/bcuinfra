<!-- Meta robots -->
<tr><th colspan="2"><h3><?php _e('Meta Robots tag:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_robots"><?php _e('Add <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_robots" name="msp_enable_robots" value="yes" <?php checked( true, get_option( 'msp_enable_robots' ) ); ?> />
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noodp"><?php _e('Do not allow to use description from DMOZ (ODP)', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noodp" name="msp_robots_noodp" value="yes" <?php checked( true, get_option( 'msp_robots_noodp' ) ); ?> /><br /><?php _e('Do not allow search engines to use description from DMOZ (ODP) as page description (supported by Google, Yahoo! and Bing)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noydir"><?php _e('Do not allow to use description from Yahoo! Directory', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noydir" name="msp_robots_noydir" value="yes" <?php checked( true, get_option( 'msp_robots_noydir' ) ); ?> /><br /><?php _e('Do not allow search engines to use description from Yahoo! Directory as page description (supported by Yahoo! only)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Home Page:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_front_subpages"><?php _e('Do not index subpages of Front Page', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_front_subpages" name="msp_robots_noindex_front_subpages" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_front_subpages' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for subpages of Front Page (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Pages:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
&nbsp;
</th>
<td>
<?php _e('No extra configuration here (yet).', 'meta-seo-pack') ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Attachments:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_attach"><?php _e('Do not index attachments', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_attach" name="msp_robots_noindex_attach" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_attach' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for attachment pages (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Categories:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_cat"><?php _e('Do not index categories', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_cat" name="msp_robots_noindex_cat" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_cat' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for category pages (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Tags:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_tag"><?php _e('Do not index tags', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_tag" name="msp_robots_noindex_tag" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_tag' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for tag pages', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Custom Taxonomies:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_tax"><?php _e('Do not index custom taxonomies', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_tax" name="msp_robots_noindex_tax" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_tax' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for custom taxonomy pages', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Archive for Day/Month/Year:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_date"><?php _e('Do not index day/month/year archives', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_date" name="msp_robots_noindex_date" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_date' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for day/month/year archive page', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Author Posts:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_author"><?php _e('Do not index author posts page', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_author" name="msp_robots_noindex_author" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_author' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for author posts page', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Search Results:', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_search"><?php _e('Do not index search results', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_search" name="msp_robots_noindex_search" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_search' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for search results page', 'meta-seo-pack'); ?>
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
<label for="msp_robots_noindex_post_comments"><?php _e('Do not index subpages of multipage comments', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_post_comments" name="msp_robots_noindex_post_comments" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_post_comments' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag for subpages of multipage comments (not recommended)', 'meta-seo-pack'); ?>
</td>
</tr>

<tr><th colspan="2"><b>&raquo; <?php _e('Feeds (RSS, Atom, etc.):', 'meta-seo-pack'); ?></b></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_robots_noindex_feed"><?php _e('Do not index feeds', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_robots_noindex_feed" name="msp_robots_noindex_feed" value="yes" <?php checked( true, get_option( 'msp_robots_noindex_feed' ) ); ?> /><br /><?php _e('Add <code>noindex,follow</code> to <code>&lt;meta name=&quot;robots&quot;&gt;</code> tag and send as value of <code>X-Robots-Tag</code> HTTP Header for feeds (RSS, Atom, etc.)', 'meta-seo-pack'); ?>
</td>
</tr>
