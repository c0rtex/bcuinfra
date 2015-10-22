<?php

	
	function shebang_send_alerts(){
		$dom = date('j');
		$dow = date('N');
		shebang_send_alert('daily');
		if ($dow == 2 || $dow == '2'){
			shebang_send_alert('weekly');
		}
		if ($dom == 15 || $dom == '15'){
			shebang_send_alert('monthly');
		}
	}

	function shebang_send_alert($freq){
		$emails = shebang_get_email_recps($freq);
		$headers_array = array(
						"From: SquaredAway Alerts <alerts@squaredaway.bc.edu>",
						"Content-Type: text/html"
		);
	
		foreach($emails as $email){
			if ($email->email){
				$pi = get_post_info($email->treatment);
				$headers = implode("\r\n", $headers_array) . "\r\n";
				$subj = 'Reminder about ' . $pi->post_title;
				$sent = wp_mail($email->email, $subj, ($email->content), $headers);
				echo 'Sent '.$subj.' to '.$email->email . ', success? ' .$sent;
			}
		}
		unset($email);
	}
	
	function shebang_get_email_recps($freq){
		$query = "SELECT * FROM shebang_emails WHERE freq = '$freq'";
		$result = mysql_query($query);
		$emails = array();
		while($row = mysql_fetch_object($result)){
			$row->content = shebang_compose_alert('http://'.$_SERVER['HTTP_HOST'], $row->treatment, $row->email);
			$emails[] = $row;
		}
		return $emails;
	}
	
	function shebang_compose_alert($server, $planner_slug, $mail){
		$pi = get_post_info($planner_slug.'-email');
		echo $planner_slug.'-email';
		$planner_url = $server . '/'. $pi->path;
		$planner = get_post_info($planner_slug);
		$action_plan = get_last_slide($planner->ID);
		$action_plan = get_post_info($action_plan->ID);
		$unsubscribe = $server . '/unsubscribe';
		$theme_abs_path = $server . '/wp-content/themes/shebang/';
		$copy = 'stuff';
		if ($pi->post_content){
			$copy = $pi->post_content;
		}
		
		$head = "<!DOCTYPE PUBLIC '-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'><html><head><meta content='text/html; charset=utf-8' http-equiv='Content-Type' /><title>SquaredAway Alert</title><!--general stylesheet--><style type='text/css'>p { padding: 0; margin: 0; }; h1, h2, h3, h4, h5, p, li, td { font-family: Helvetica, Arial, sans-serif; }; td { vertical-align:top;}; ul, ol { margin: 0; padding: 0} .content-item h2 { margin: 0; padding-bottom: 5px; font-size: 22px; font-family: Georgia; font-style: italic; font-weight: lighter; color: #853938 !important; } .content-item p { text-align:left; font-size: 12px; line-height: 21px; margin-bottom: 16px; color: #524e47;} .content-item li { margin-left: 25px;  font-size: 12px; line-height: 25px; color: #524e47;} .toc a{ font-size: 11px; font-weight: bold; color: #8d4544;}</style></head>";
		$body = "<body marginheight='0' topmargin='0' marginwidth='0' leftmargin='0' background='".$theme_abs_path."/_images/noise-bg-email.gif' style='margin: 0px; background-color: #f0f0f0; background-image: url('".$theme_abs_path."/_images/noise-bg-email.gif'); background-repeat: repeat-y no-repeat; background-position: top center;' bgcolor='#f0f0f0'><table cellspacing='0' border='0' cellpadding='0' width='100%' align='center' style='margin: 0px;'>";
		$header = "<tbody><tr valign='top'><td valign='top' background='".$theme_abs_path."/_images/noise-bg-email.gif' style='background-image: url('".$theme_abs_path."/_images/noise-bg-email.gif'); background-repeat: repeat-y no-repeat; background-position: top center;'><!--container--><table cellspacing='0' border='0' cellpadding='0' align='center' width='640' style='margin: auto;'><tbody><tr><td><a href='http://www.squaredaway.com'><img src='".$theme_abs_path."/_images/sqa-logo-email.gif' alt='Squared Away logo' style='margin: auto; width:641px; height:125px;' width='641' height='125' align='center' /></a></td></tr></tbody></table>";

		$main = "<table cellspacing='0' cellpadding='0' border='0' align='center' width='641' bgcolor='#ffffff' style='background-color:#ffffff;'><tbody><tr><td width='9' background='".$theme_abs_path."/_images/email-shadow-l.gif' style='background-color: transparent; background-image: url('".$theme_abs_path."/_images/email-shadow-l.gif'); background-repeat: repeat-y no-repeat; background-position: top center;'></td><td valign='top' border='0' style='border: none; '><table cellspacing='0' cellpadding='0' border='0' align='center' style='padding-bottom: 13px;'><tbody><tr><td valign='top' width='621' style='padding:40px 40px 10px 40px;'> <h1 style='margin: 0; font-size: 28px; color:#464d56 !important;'><singleline label='Title'>".$pi->title."</singleline></h1></td></tr></tbody></table>";
		$content = "<table cellspacing='0' cellpadding='0' border='0' align='center' width='597' style='padding-bottom: 20px;'><tbody><tr><td valign='top'><table cellspacing='0' cellpadding='0' border='0' align='center' width='551' style=''><tbody><tr><td valign='top' style='padding-top: 10px; padding-bottom: 19px;' width=621><repeater><table cellspacing='0' cellpadding='0' border='0' align='center' class='content-item'><tbody><tr><td valign='top' style='padding-top: 10px; padding-bottom: 19px;'><multiline label='Description'><p>".$copy."</p></multiline></td><tr>
<td><a href='".$action_plan->permalink."' style='display: block; margin: auto; width: 195px; height: 38px;' align='center'><img src='".$theme_abs_path."/_images/btn-action-email.gif' alt='Go To Your Action Plan' style='width:195px; height:38px;' width='195' height='38' /></a></td></tr></tbody></table></repeater></td></tr></tbody></table></td></tr></tbody></table><!--/content--></td><td width='9' background='".$theme_abs_path."/_images/email-shadow-r.gif' style='background-color: transparent; background-image: url('".$theme_abs_path."/_images/email-shadow-r.gif'); background-repeat: repeat-y no-repeat; background-position: top center;'></td></tr></tbody></table><!--/container--></td></tr></tbody>";
		$footer = "<table cellspacing='0' cellpadding='0' border='0' align='center' width='640' height='77'><tbody><tr><td valign='top' width='640' height='8' background='".$theme_abs_path."/_images/email-shadow-b.gif' style='background-color: transparent; background-image: url('".$theme_abs_path."/_images/email-shadow-b.gif'); background-repeat: repeat-x no-repeat; background-position: top center;'></td></tr><tr><td valign='middle' height='23' style='padding-top: 10px; padding-left: 16px; padding-right: 16px; vertical-align:middle !important;'><p style='margin:0; padding:0; color:#766d59; font-size: 12px;'><singleline label='Title'>You&#39;re receiving this email because you completed the planner <a href='".$server."/planners/".$planner_slug."' style='color:#1d78af; font-weight:bold; text-decoration:none;' >$planner->post_title</a>.</singleline></p></td></tr><tr><td valign='middle' height='23' style='padding-left: 16px; padding-right: 16px; vertical-align:middle !important;'><p style='margin:0; padding:0; color:#766d59; font-size: 12px;'>Not interested anymore? <a href='".$server."/unsubscribe?mail=".$mail."' style='color:#1d78af; font-size:12px; font-weight:bold; text-decoration:none;'>Unsubscribe</a>. Having trouble viewing this email? <a href='".$server."/unsubscribe?mail=".$mail."' style='color:#1d78af; font-size:12px; font-weight:bold; text-decoration:none;'>View it in your browser</a>.</p></td></tr><tr><td valign='top' height='10'></td></tr></tbody></table></table></body></html>";
		$r = $head . $body . $header . $main . $content .$footer;
		return $r;
	}

?>