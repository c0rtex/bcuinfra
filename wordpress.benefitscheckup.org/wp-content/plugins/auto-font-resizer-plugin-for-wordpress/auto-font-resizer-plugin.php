<?php
/*
 * Plugin Name: Auto Font Resizer Plugin
 * Version: 1.0
 * Plugin URI: http://wordpress.org/extend/plugins/auto-font-resizer-plugin-for-wordpress/
 * Description: With Auto Font Resizer you can enable your Wordpress blog/website with auto generated famous implementation of buttons A+ and A-, which alter the font size on your sites with very large texts or make it smaller. This plugin can be used to increase the accessibility of sites, helping people who have visual problems to see content better. It makes use of JQuery plugin by Fred Vanelli.
 * Author: Sunento Agustiar Wu
 * Author URI: http://vivociti.com/content/view/92/53/
 * License: GNU/GPL http://www.gnu.org/copyleft/gpl.html
 */
class auto_font_resizer extends WP_Widget
{
	/**
	* Declares the auto_font_resizer class.
	*
	*/
	function auto_font_resizer(){
		$widget_ops = array('classname' => 'widget_auto_font_resizer', 'description' => __( "With Auto Font Resizer you can enable your Wordpress blog/website with auto generated famous implementation of buttons A+ and A-, which alter the font size on your sites with very large texts or make it smaller. This plugin can be used to increase the accessibility of sites, helping people who have visual problems to see content better.") );
		$control_ops = array('width' => 320, 'height' => 300);
		$this->WP_Widget('auto_font_resizer', __('Auto Font Resizer'), $widget_ops, $control_ops);
	}
	
	/**
	* Displays the Widget
	*
	*/
	function widget($args, $instance){
		extract($args);
		$title = apply_filters('widget_title', empty($instance['title']) ? 'Auto Font Resizer' : $instance['title']);
		
		$applyToClassGroup = empty($instance['applyToClassGroup']) ? 'body' : $instance['applyToClassGroup'];
		$buttonType = empty($instance['buttonType']) ? 'image' : $instance['buttonType'];
		$creditYes = empty($instance['creditYes']) ? 'no' : $instance['creditYes'];

		
		
		# Before the widget
		echo $before_widget;
		
		# The title
		if ( $title )
			echo $before_title . $title . $after_title;
	
		$img_live_dir = 'http://vivociti.com/images/plus2x2.gif';
		$html = "<a href=\"http://vivociti.com/component/option,com_remository/Itemid,40/func,select/id,19/\" title=\"Get Font Resizer Plugin From VivoCiti.com\" target=\"_blank\"><img src=\"$img_live_dir\" border=\"0\"/></a>"; 
		$html2 = "";
		$siteurl = get_option('siteurl');
		$img_url = $siteurl . '/wp-content/plugins/' . basename(dirname(__FILE__)) . '/images/';
		switch ($buttonType) {
			case 'image' :
				$html2 .= '<a class="jfontsize-button" id="jfontsize-m" href="#"><img src="' . $img_url . 'btnMinus.jpg" alt="Decrease font size" /></a>';
				$html2 .= '<a class="jfontsize-button" id="jfontsize-d" href="#"><img src="' . $img_url . 'btnDefault.jpg" alt="Default font size" /></a>';
				$html2 .= '<a class="jfontsize-button" id="jfontsize-p" href="#"><img src="' . $img_url . 'btnPlus.jpg" alt="Increase font size" /></a>';
				break;
			case 'text' :
				$html2 .= '<a class="jfontsize-button" id="jfontsize-m" href="#">A-</a>';
				$html2 .= '<a class="jfontsize-button" id="jfontsize-d" href="#">A</a>';
				$html2 .= '<a class="jfontsize-button" id="jfontsize-p" href="#">A+</a>';
				break;			
		}		
		
	if ($creditYes == "no") {
            $html2 .= $html;
        }
	echo $html2;
	?>
	<script type="text/javascript" language="javascript">
	$('<?php echo $applyToClassGroup;?>').jfontsize({
		btnMinusClasseId: '#jfontsize-m',
		btnDefaultClasseId: '#jfontsize-d',
		btnPlusClasseId: '#jfontsize-p'
	});
	</script>
<?php
	//end of creditOn is yes

		# After the widget
		echo $after_widget;
	}
	
	/**
	* Saves the widgets settings.
	*
	*/
	function update($new_instance, $old_instance){
	
		$applyToClassGroup = empty($instance['applyToClassGroup']) ? 'body' : $instance['applyToClassGroup'];
		$buttonType = empty($instance['buttonType']) ? 'image' : $instance['buttonType'];
		$creditYes = empty($instance['creditYes']) ? 'no' : $instance['creditYes'];
		
		
		$instance = $old_instance;
		$instance['title'] = strip_tags(stripslashes($new_instance['title']));
		$instance['applyToClassGroup'] = strip_tags(stripslashes($new_instance['applyToClassGroup']));
		$instance['buttonType'] = strip_tags(stripslashes($new_instance['buttonType']));
		$instance['creditYes'] = strip_tags(stripslashes($new_instance['creditYes']));
		
		$instance['applyToClassGroup'] = strip_tags(stripslashes($new_instance['applyToClassGroup']));
		$instance['buttonType'] = strip_tags(stripslashes($new_instance['buttonType']));
		$instance['creditYes'] = strip_tags(stripslashes($new_instance['creditYes']));
	
	return $instance;
	}
	
	/**
	* Creates the edit form for the widget.
	*
	*/
	function form($instance){
		//Defaults
		$instance = wp_parse_args( (array) $instance, array('title'=>'Font Resizer', 'applyToClassGroup'=>'body', 'buttonType'=>'image', 'creditYes'=>'yes') );
		
		
		$title = htmlspecialchars($instance['title']);		
		$applyToClassGroup = empty($instance['applyToClassGroup']) ? 'body' : $instance['applyToClassGroup'];
		$buttonType = empty($instance['buttonType']) ? 'image' : $instance['buttonType'];
		$creditYes = empty($instance['creditYes']) ? 'no' : $instance['creditYes'];
				
		# Output the options
		echo '<p style="text-align:right;"><label for="' . $this->get_field_name('title') . '">' . __('Title:') . ' <input style="width: 250px;" id="' . $this->get_field_id('title') . '" name="' . $this->get_field_name('title') . '" type="text" value="' . $title . '" /></label></p>';
		# Fill Button Style Selection
		echo '<p style="text-align:right;"><label for="' . $this->get_field_name('buttonType') . '">' . __('Button Style:') . ' <select name="' . $this->get_field_name('buttonType')  . '" id="' . $this->get_field_id('buttonType')  . '">"';
?>
		<option value="image" <?php if ($pluginDisplayType == 'image') echo 'selected="yes"'; ?> >Image</option>
		<option value="text" <?php if ($pluginDisplayType == 'text') echo 'selected="yes"'; ?> >Text</option>			 		
<?php
		echo '</select></label>';
		echo '<p style="text-align:left;"><i>Resize To: (Leave it be default if you are not familiar with JQuery. You can apply multi class name, selector here by changing default value here.)</i></p>';
		echo '<p style="text-align:right;"><label for="' . $this->get_field_name('applyToClassGroup') . '">' . __('Class/ID:') . ' <input style="width: 150px;" id="' . $this->get_field_id('applyToClassGroup') . '" name="' . $this->get_field_name('applyToClassGroup') . '" type="text" value="' . $applyToClassGroup . '" /></label></p>';
		# Fill Author Credit : option to select YEs or No 
		echo '<p style="text-align:right;"><label for="' . $this->get_field_name('creditYes') . '">' . __('Support Our Development by contributing money via PayPal at http://bit.ly/9Njzpo - No (Credit Author by small link)') . ' <select name="' . $this->get_field_name('creditYes')  . '" id="' . $this->get_field_id('creditYes')  . '">"';
?>
		<option value="yes" <?php if ($creditYes == 'yes') echo 'selected="yes"'; ?> >Yes</option>
		<option value="no" <?php if ($creditYes == 'no') echo 'selected="yes"'; ?> >No</option>			 
<?php
		echo '</select></label>';
		echo '<p style="text-align:left;"><a title="Join Us @Facebook" href="http://www.facebook.com/pages/VivoCiticom-Joomla-Wordpress-Blogger-Drupal-DNN-Community/119691288064264" target="_blank"><img src="http://vivociti.com/images/stories/facebook_16x16.png" border="0"></a>&nbsp;<a title="Follow Us @Twitter" href="http://twitter.com/vivociti" target="_blank"><img src="http://vivociti.com/images/stories/twitter_16x16.png" border="0"></a>&nbsp;<a title="Follow Us @Digg" href="http://digg.com/vivoc" target="_blank"><img src="http://vivociti.com/images/stories/digg_16x16.png" border="0"></a>&nbsp;<a title="Follow Us @StumbleUpon" href="http://www.stumbleupon.com/stumbler/vivociti/" target="_blank"><img src="http://vivociti.com/images/stories/stumbleupon_16x16.png" border="0"></a>&nbsp;<a title="Follow Our RSS" href="http://feeds2.feedburner.com/vivociti" target="_blank"><img src="http://vivociti.com/images/stories/feed_16x16.png" border="0"></a></p>';
		echo '<p/>';
		echo '<p style="text-align:left;">Our other Wordpress Widget you may like is:<br/>
		<ul>
		  <li><a title="Facebook Like Box" href="http://wordpress.org/extend/plugins/facebook-like-box-widget/" target="_blank">Popular Facebook Like Box</a></li>
		  <li><a title="Google +1 Button" href="http://wordpress.org/extend/plugins/google-1-recommend-button-for-wordpress/" target="_blank">Google +1 Button</a></li>
		  <li><a title="Twitter QR Code for Wordpress" href="http://wordpress.org/extend/plugins/twitter-qr-code-signatures/" target="_blank">Twitter QR Code Widget</a></li>
		  <li><a title="Twitter Signature for Wordpress" href="http://wordpress.org/extend/plugins/twitter-signature/" target="_blank">Twitter Signature for Wordpress</a></li>
		</ul></p>';
		
	
	} //end of form

}// END class
	
	/**
	* Register  widget.
	*
	* Calls 'widgets_init' action after widget has been registered.
	*/
	function auto_font_resizerInit() {
		
		wp_enqueue_style('my-style', '/wp-content/plugins/' . basename(dirname(__FILE__)) . '/jfontsize.css');
		wp_enqueue_script('my-fontresizer', '/wp-content/plugins/' . basename(dirname(__FILE__)) . '/jquery-1.5.js'); 
		wp_enqueue_script('my-fontresizer2', '/wp-content/plugins/' . basename(dirname(__FILE__))  . '/jquery.jfontsize-1.0.js'); 	
		register_widget('auto_font_resizer');
	}	
		
	
	add_action('widgets_init', 'auto_font_resizerInit');
	
		
?>