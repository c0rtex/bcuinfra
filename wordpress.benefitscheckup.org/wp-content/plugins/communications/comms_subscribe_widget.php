<?php

require_once(ABSPATH . WPINC . '/class-phpmailer.php');
require_once(ABSPATH . WPINC . '/class-smtp.php');

function widget_comms_subscribe($args)
  {
  global $wpdb;
  extract($args);
  $options = get_option('widget_comms_subscribe');
  $title = empty($options['title']) ? __('Subscribe') : $options['title'];
  echo $before_widget;
  $full_title = $before_title . $title . $after_title;
  echo $full_title;
  if($_POST['emailaddress'] != null)
    {
    $data = $wpdb->get_results("SELECT id FROM `".$wpdb->prefix."comms` WHERE `email` = '".$wpdb->escape($_POST['emailaddress'])."' OR activation_key='" . $wpdb->escape($_POST['emailaddress']) . "' LIMIT 1",ARRAY_A);
    if($data == null) {
      $activation_key = "";
      $key_array = str_split(str_shuffle(str_replace(".","",str_replace("@","",$wpdb->escape($_POST['emailaddress'])))));
      foreach ($key_array as $key_character) {
      	if (strlen($activation_key) != 20) {
      		srand(time());
      		$activation_key .= $key_character . (rand()%9);
      	}
      }
      $pageURL = 'http';
	   if ($_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
	   $pageURL .= "://";
	   if ($_SERVER["SERVER_PORT"] != "80") {
	      $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
	   } else {
	      $pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
	   }
      
      $wpdb->query("INSERT INTO `".$wpdb->prefix."comms` (`activation_key`, `activated`, `email` , `subscribed`, `time` ) VALUES ('" . $activation_key . "', '0', '".$wpdb->escape($_POST['emailaddress'])."', '1', NOW( ));") ;
      
	  $mailer = new PHPMailer();
	  $mailer->IsMail(true);
      $mailer->IsHTML(true);
      $mailer->Host = get_option('comms_mail_host');
      $mailer->Mailer = "smtp";
      $mailer->From = get_option('comms_return_email');
      $mailer->FromName = bloginfo('name')." - Automated - Do Not Reply";
      $mailer->Subject = "Email Subscription Activation Required";
      $mailer->Body = "You recently added your email address to our subscription newletter at " . $pageURL . " and need to confirm your subscription.<br /><br />Please visit our site and enter your Activation code of " . $activation_key . " into the subscription field to activate your subscription."; 
      $mailer->AltBody= "You recently added your email address to our subscription newletter at " . $pageURL . " and need to confirm your subscription.<br /><br />Please visit our site and enter your Activation code of " . $activation_key . " into the subscription field to activate your subscription.";  
      $mailer->AddAddress($_POST['emailaddress'], "");  
      if(!$mailer->Send()) {
      	$message = "Message was not sent to ".$email['email']." because:<br />Mailer error: ".$mail->ErrorInfo."<br /><br />";
      } else {
      	$message = "<strong>Thank you for subscribing.  An activation key has been emailed for you to confirm your subscription.<strong><br /><br />";
      }
    } else {
    	foreach ($data as $activate_account) {
    		foreach ($activate_account as $account_id) {
      			$wpdb->query("UPDATE `".$wpdb->prefix."comms` set `activated`='1' where `id`=" . $account_id . ";") ;
      			$message = "<strong>Thank you for activating your subscription.</strong>";
      		}
      	}
    } 
    }
    
  if($_COOKIE['wp_comms_email'] == null)
    {
    $prevemail = $_POST['emailaddress'];
    }
    else
      {
      $prevemail = $_COOKIE['wp_comms_email'];
      }
  echo "
  $message
  <div class='subscribe_widget'>
    <form name='subscribe' method='POST' action='' >
      <input type='text' name='emailaddress' class='emailaddress' value='".$prevemail."' />
      <input type='submit' name='submit' value='Submit' class='subscribe' />
    </form>
  </div>
  ";
  echo $after_widget; 
  }

function widget_comms_subscribe_control()
  {
  $options = $newoptions = get_option('widget_comms_subscribe');
  if ( $_POST["comms_subscribe-submit"] ) {
          $newoptions['title'] = strip_tags(stripslashes($_POST["comms_subscribe-title"]));
  }
  if ( $options != $newoptions ) {
          $options = $newoptions;
          update_option('widget_comms_subscribe', $options);
  }
  $title = htmlspecialchars($options['title'], ENT_QUOTES);
  ?>
  <p><label for="comms_subscribe-title"><?php _e('Title:'); ?> <input style="width: 250px;" id="comms_subscribe-title" name="comms_subscribe-title" type="text" value="<?php echo $title; ?>" /></label></p>
  <input type="hidden" id="comms_subscribe-submit" name="comms_subscribe-submit" value="1" />
  <?php
  }

function widget_comms_subscribe_init()
  {
  if(function_exists('register_sidebar_widget'))
    {
    register_sidebar_widget('Communications Subscribe', 'widget_comms_subscribe');
    register_widget_control('Communications Subscribe', 'widget_comms_subscribe_control', 300, 90);
    }
    else
      {
      add_action('wp_meta', 'comms_subscribe');
      }
  return;
  }
?>