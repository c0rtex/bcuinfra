<!-- Canonical URL tag -->
<tr><th colspan="2"><h3><?php _e('Canonical URLs:', 'meta-seo-pack'); ?></h3></th></tr>

<tr>
<th scope="row" style="text-align:right; vertical-align:top;">
<label for="msp_enable_canonical"><?php _e('Add <code>&lt;link rel=&quot;canonical&quot;&gt;</code> tag', 'meta-seo-pack'); ?>: </label>
</th>
<td>
<input type="checkbox" id="msp_enable_canonical" name="msp_enable_canonical" value="yes" <?php checked( true, get_option( 'msp_enable_canonical' ) ); ?> />
</td>
</tr>
