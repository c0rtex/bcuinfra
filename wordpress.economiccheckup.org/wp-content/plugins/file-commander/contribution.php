<?php If (!Class_Exists('dh_contribution')){Class dh_contribution{Var $base_url; Var $infomercial_url='http://contribution-page.dennishoppe.de/infomercials.js.php'; Var $active_extensions=Array(); Var $arr_page_notice=Array(); Var $is_contribution_page=False; Private $menu_slug; Function __construct(){If (Is_Admin() && !$this->V(get_option('dh_contribution_code'))){ForEach (Array( '0.0.0.0'=>'0.255.255.255', '10.0.0.0'=>'10.255.255.255', '127.0.0.0'=>'127.255.255.255', '169.254.0.0'=>'169.254.255.255', '172.16.0.0'=>'172.31.255.255', '192.0.0.0'=>'192.0.0.255', '192.0.2.0'=>'192.0.2.255', '192.88.99.0'=>'192.88.99.255', '192.168.0.0'=>'192.168.255.255', '198.18.0.0'=>'198.19.255.255', '198.51.100.0'=>'198.51.100.255', '203.0.113.0'=>'203.0.113.255', '224.0.0.0'=>'239.255.255.255', '240.0.0.0'=>'255.255.255.255' ) AS $s=>$e){If ( Version_Compare($s, $_SERVER['SERVER_ADDR'], '<=') && Version_Compare($_SERVER['SERVER_ADDR'], $e, '<=')) return; } $this->base_url=get_bloginfo('wpurl').'/'.Str_Replace("\\", '/', SubStr(RealPath(DirName(__FILE__)),Strlen(ABSPATH))); $this->menu_slug='p'.DecHex(Date('mdY')); Add_Action('init', Array($this, 'Load_TextDomain')); Add_Action('admin_head', Array($this, 'Print_Admin_CSS')); Add_Action('admin_menu', Array($this, 'Add_Page')); $this->arr_box=Array( 'top'=>Array(),'left'=>Array(),'left-left'=>Array(),'left-right'=>Array(),'right'=>Array(),'bottom'=>Array() ); Add_Action('wp_dashboard_setup', Array($this, 'Add_Meta_Box'),9); Add_Action('donation_message', Array($this, 'Print_Message')); Add_Action('dh_contribution_message', Array($this, 'Print_Message')); } $this->Check_Remote_Activation(); } Function Load_TextDomain(){Load_TextDomain (__CLASS__, DirName(__FILE__).'/contribution_' . Apply_Filters( 'plugin_locale', get_locale(),__CLASS__ ) . '.mo'); } Function t ($t, $c=''){If (!$c) return __ ($t, __CLASS__); Else return _x ($t, $c, __CLASS__); } Function Print_Admin_CSS(){If (Count($this->Get_Extension_Names()) <1) return False; ?><style type="text/css"> #adminmenu span.<?php Echo $this->menu_slug ?>{color: red; font-size: 1.15em; letter-spacing: -1px; font-weight: bold; } #adminmenu .current span.<?php Echo $this->menu_slug ?>{font-weight: normal; color: black; font-size: 0.9em; letter-spacing: 0px; display: none; } #footer span.<?php Echo $this->menu_slug ?>{color: red; font-weight: bold; font-variant:small-caps; font-size: 1.2em; } </style><?php } Function Add_Meta_Box(){If (Count($this->Get_Extension_Names()) <1) return False; Add_Meta_Box( 'contribution_to_dennishoppe', $this->t('Your contribution is still missing!'),Array($this, 'Print_Message'),'dashboard', 'side', 'high' ); } Function Add_Page(){If (Count($this->Get_Extension_Names()) <1) return False; $hook=Add_SubMenu_Page( 'index.php', $this->t('Your contribution is still missing!'),'<span class="'.$this->menu_slug.'">' . $this->t('Your contribution is still missing!') . '</span>', 'read', $this->menu_slug, Array($this, 'Print_Page') ); Add_Action('load-' . $hook, Array($this, 'Load_Page')); Add_Filter('admin_footer_text', Array($this, 'Add_Footer_Link')); } Function Add_Page_Notice($notice){$this->arr_page_notice[]=$notice; } Function Page_Url(){return Admin_Url('index.php?page='.$this->menu_slug); } Function Add_Footer_Link($text){$text .=' &bull; <a href="'.$this->Page_Url().'"><span class="'.$this->menu_slug.'">'.$this->t('Your contribution is still missing!').'</span></a>'; return $text; } Function Load_Page(){$this->is_contribution_page=True; If (IsSet($_POST['contribution_code'])){If ($this->V($_POST['contribution_code'])){Update_Option ('dh_contribution_code', $_POST['contribution_code']); Header('Location: ' . Esc_Url(Admin_Url())); } Else{$this->Add_Page_Notice($this->t('Sorry, but this voucher was not valid!')); } } WP_Enqueue_Script('jquery'); WP_Enqueue_Script('dashboard'); Add_Action('admin_head', Array($this, 'Print_Page_JavaScript')); WP_Enqueue_Style('dashboard'); Add_Action('admin_head', Array($this, 'Print_Page_CSS')); $this->Add_Box('left', $this->t('Your contribution is still missing!'),Array($this, 'Print_Message'),'open'); $this->Add_Box('left-left', $this->t('Contribute something from Amazon'),Array($this, 'Print_Amazon_Box'),'open'); $this->Add_Box('left-left', $this->t('Interesting Services'),Array($this, 'Print_Services_Advertisement'),'open'); $this->Add_Box('left-right', $this->t('Make the contribution via PayPal'),Array($this, 'Print_Payment_Box'),'open'); $this->Add_Box('right', $this->t('Interesting Plugins'),Array($this, 'Print_Plugins_Advertisement'),'open'); $this->Add_Box('right', $this->t('Interesting Themes'),Array($this, 'Print_Themes_Advertisement'),'open'); $this->Add_Box('right', $this->t('Voucher Code'),Array($this, 'Print_Voucher_Box'),'open'); } Function Print_Page(){?><div class="wrap"> <?php screen_icon(); ?> <h2><?php Echo $this->t('Contributions') ?></h2> <?php ForEach ($this->arr_page_notice AS $notice) : ?> <div class="updated"><?php Echo $notice ?></div> <?php EndForEach ?> <div class="metabox-holder"> <div class="postbox-container top"> <?php ForEach ($this->arr_box['top'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> </div> <div class="postbox-container left"> <?php ForEach ($this->arr_box['left'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> <div class="postbox-container left-left"> <?php ForEach ($this->arr_box['left-left'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> </div> <div class="postbox-container left-right"> <?php ForEach ($this->arr_box['left-right'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> </div> </div> <div class="postbox-container right"> <?php ForEach ($this->arr_box['right'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> </div> <div class="postbox-container bottom"> <?php ForEach ($this->arr_box['bottom'] AS $box) : ?> <div class="postbox <?php Echo $box['state'] ?>"> <div class="handlediv" title="<?php _e('Click to toggle') ?>"><br /></div> <h3 class="hndle"><span><?php Echo $box['title'] ?></span></h3> <div class="inside"><?php Call_User_Func($box['callback']) ?></div> </div> <?php EndForEach ?> </div> <div class="clear"></div> </div> </div><?php } Function Add_Box ($position, $title, $callback, $state){If (!In_Array($position, Array('top', 'left', 'left-left', 'left-right', 'right', 'bottom'))) $position='bottom'; If ($state !='open') $state='closed'; $title=Trim($title); If (!Is_Callable($callback)) return False; $this->arr_box[$position][]=Array ( 'title'=>$title, 'callback'=>$callback, 'state'=>$state ); } Function Get_Extensions(){$arr_extension=Array(); ForEach ( (Array) get_option('active_plugins') AS $plugin_file){$plugin_data=get_plugin_data(WP_PLUGIN_DIR . '/' . $plugin_file); If ( StrPos(StrToLower($plugin_data['Author']),'dennis hoppe') !==False ){$arr_extension[$plugin_file]=$plugin_data; } } return $arr_extension; } Function Get_Extension_Names($strip_links=False){If (Empty($this->active_extensions)) $this->active_extensions=$this->Get_Extensions(); $arr_name=Array(); ForEach ($this->active_extensions AS $extension){If ($strip_links) $arr_name[]=Strip_Tags($extension['Title']); Else $arr_name[]=$extension['Title']; } return $arr_name; } Function Get_Extension_Files(){If (Empty($this->active_extensions)) $this->active_extensions=$this->Get_Extensions(); $arr_file=Array(); ForEach ($this->active_extensions AS $file=>$extension){$arr_file[]=$file; } return $arr_file; } Function Extended_Implode($array, $separator=', ', $last_separator=' and ' ){$array=(array) $array; If (Count($array)==0) return ''; If (Count($array)==1) return $array[0]; $last_item=Array_pop ($array); $result=Implode ($array, $separator) . $last_separator . $last_item; return $result; } Function V($c){return($c==SubStr(MD5(Parse_URL(Home_URL(),PHP_URL_HOST)),8,-8));} Function Check_Remote_Activation(){ForEach ($_GET AS $k=>$v){If ($k!=$v) Continue; ElseIf ($this->V($k) && $this->V(get_option('dh_contribution_code'))){Delete_Option('dh_contribution_code'); WP_Die('0x01 - Contribution Page Activated.'); } ElseIf ($this->V($k) ){Update_Option('dh_contribution_code', $k); WP_Die('0x00 - Contribution Page Deactivated.'); } } } Function Print_Page_CSS(){?><style type="text/css"> body.dashboard_page_<?php Echo $this->menu_slug ?> #contextual-help-link-wrap{display: none; } body.dashboard_page_<?php Echo $this->menu_slug ?> .updated{padding: 10px; width: auto; font-weight: bold; margin-bottom: 0; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox .hndle{cursor: default; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.top, body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.bottom{width: 99%; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.left{width: 66%; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.left-left, body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.left-right{width: 49%; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.left-right{float: right; } body.dashboard_page_<?php Echo $this->menu_slug ?> .postbox-container.right{float: right; margin-right: 0; width: 32%; } body.dashboard_page_<?php Echo $this->menu_slug ?> #plugin_ads img, body.dashboard_page_<?php Echo $this->menu_slug ?> #theme_ads img, body.dashboard_page_<?php Echo $this->menu_slug ?> #service_ads img{margin-bottom: 5px; } </style><?php } Function Print_Page_JavaScript(){Global $current_user; get_currentuserinfo(); ?><script type="text/javascript">/* <![CDATA[ */jQuery(function($){$('option[disabled]').css('color', '#ccc'); $('a.dh_contribution_show_amounts').click(function(){$('.dh_contribution_amount_select').not($(this).next('.dh_contribution_amount_select')).slideUp(); $(this).next('.dh_contribution_amount_select').css('zoom', '1').slideDown(); return false; }); $('.proceed-to-paypal').attr('disabled', 'disabled'); $('.dh_contribution_amount_select .currency, .dh_contribution_amount_select .amount').change(function(){var $this=$(this); if ($this.val() !='') $this.parent().find('.proceed-to-paypal').removeAttr('disabled'); else $this.parent().find('.proceed-to-paypal').attr('disabled', 'disabled'); }); $.getScript('<?php Echo Add_Query_Arg(Array( 'lang'=>get_locale(),'wp_version'=>get_bloginfo('version'),'php_version'=>PHP_VERSION, 'username'=>$current_user->display_name),$this->infomercial_url) ?>'); });/*]]>*/</script><?php } Function Currency($name, $code, $symbol, $min_amount, $integer=False){$o=New StdClass; $o->name=$name; $o->code=$code; $o->symbol=$symbol; $o->min=Round($min_amount, 2); $o->integer=$integer; return $o; } Function Rand_Amount($amount, $min, $max){return Round(Rand ( 100 * $min * $amount, 100 * $max * $amount ) / 100, 2); } Function Build_Amount_List($currency, $reverse_list=False){$list=Array(); $start=$amount=$this->Rand_Amount($currency->min, 0.91, 1.09); $end=16 * $currency->min; For( $amount=$start; $amount<=$end; $amount=$this->Rand_Amount($amount, 1.15, 1.35)){If ($currency->integer) $amount=Round($amount); $v=Number_Format($amount, 2, '.', ''); $c=$currency->symbol . ' ' . Number_Format($amount, 2); $list[$v]=$c; } If ($reverse_list) return Array_Reverse($list, True); Else return $list; } Function Print_Message(){If (Count($this->Get_Extension_Names())==0) return False; Global $current_user; get_currentuserinfo(); $arr_extension=$this->Get_Extension_Names(); If (File_Exists(DirName(__FILE__).'/contribution.png')) : ?> <img src="<?php Echo $this->base_url ?>/contribution.png" alt="Piggybank" title="Piggybank" class="alignright" style="margin-left:10px" /> <?php EndIf ?> <div style="text-align:justify"> <h4> <?php PrintF ( $this->t('Hello %1$s!'),$current_user->display_name ) ?></h4> </h4> <p> <?php PrintF ($this->t('You can use and test %s without any limitation of functionality or availability for your personal purposes.'),$this->Extended_Implode ($arr_extension, ', ', ' ' . $this->t('and') . ' ')) ?> </p> <p> <?php PrintF ($this->t('Please feel free to take a share in research and development costs by giving a contribution <small>(in order to remove this %s)</small>.'),$this->is_contribution_page ? $this->t('page') : $this->t('message')) ?> </p> <div class="clear"></div> <?php If (!$this->is_contribution_page) : ?> <p><a href="<?php Echo $this->Page_Url() ?>" class="button-secondary"><?php _e('More...') ?></a></p> <?php ElseIf (current_user_can('activate_plugins')) : ?> <div class="remove-notification"> <form action="<?php Echo Admin_Url('plugins.php') ?>" method="post"> <input type="hidden" name="action" value="deactivate-selected"> <?php WP_Nonce_Field( 'bulk-plugins' ); ?> <?php ForEach ($this->Get_Extension_Files() AS $plugin_file) : ?> <input type="hidden" name="checked[]" value="<?php Echo $plugin_file ?>"> <?php EndForEach; ?> <p> <input type="submit" value="<?php If (Count($arr_extension)==1) Echo $this->t('I do not like this Plugin. Deactivate it!'); Else Echo $this->t('I do not like these Plugins. Deactivate them!'); ?>" class="button"> </p> </form> </div> <?php EndIf ?> </div> <?php } Function Print_Amazon_Box(){?> <ul> <li><a href="http://amzn.com/w/1A45MS7KY75CY?sort=priority" title="<?php Echo $this->t('Amazon USA') ?>" target="_blank"><?php Echo $this->t('Amazon USA') ?></a></li> <li><a href="http://www.amazon.co.uk/registry/wishlist/2TM4HLJ3XVCYK/?sort=priority" title="<?php Echo $this->t('Amazon UK') ?>" target="_blank"><?php Echo $this->t('Amazon UK') ?></a></li> <li><a href="http://www.amazon.de/registry/wishlist/2AG0R8BHEOJOL/?sort=priority" title="<?php Echo $this->t('Amazon Germany') ?>" target="_blank"><?php Echo $this->t('Amazon Germany') ?></a></li> </ul> <?php } Function Print_Payment_Box(){$arr_currencies=Array ( $this->Currency ('United States Dollar', 'USD', 'US$', 8.60),$this->Currency ('Euro', 'EUR', '&euro;', 6.05),$this->Currency ('Pound Sterling', 'GBP', '&pound;', 5.92),$this->Currency ('Dollar Canadien', 'CAD', 'C$', 8.42),$this->Currency ('Yen', 'JPY', '&yen;', 693, True),$this->Currency ('Australian Dollar', 'AUD', 'A$', 8.19),$this->Currency ('Schweizer Franken', 'CHF', 'SFr', 7.21),$this->Currency ('Dansk krone', 'DKK', 'kr', 45.13),$this->Currency ('Norsk krone', 'NOK', 'kr', 47.11),$this->Currency ('Svensk krona', 'SEK', 'kr', 55.63),$this->Currency ('New Zealand Dollar', 'NZD', 'NZ$', 10.59),$this->Currency ('Polski złoty', 'PLN', 'zł', 24.15),$this->Currency ('Hong Kong Dollar', 'HKD', 'HK$', 67.01),$this->Currency ('Singapore Dollar', 'SGD', 'SG$', 10.65),$this->Currency ('Magyar forint', 'HUF', 'Ft', 1625, True),$this->Currency ('Koruna česká', 'CZK', 'korun', 147.25),$this->Currency ('שקל חדש', 'ILS', '₪', 29.60),$this->Currency ('peso mexicano', 'MXN', 'MX$', 102.21),$this->Currency ('piso', 'PHP', 'P', 374.09),$this->Currency ('新臺幣', 'TWD', 'NT$', 250, True),$this->Currency ('บาท', 'THB', '฿', 264.36) ); ?> <ul> <?php ForEach ($arr_currencies AS $currency) : ?> <li><a href="" title="<?php PrintF($this->t('Make the contribution in %s'),$currency->name) ?>" class="dh_contribution_show_amounts"><?php Echo $currency->name ?> (<?php Echo $currency->symbol ?>)</a> <div class="dh_contribution_amount_select hide-if-js"> <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank"> <input type="hidden" name="cmd" value="_xclick" /> <input type="hidden" name="business" value="mail@dennishoppe.de" /> <input type="hidden" name="no_shipping" value="1" /> <input type="hidden" name="tax" value="0" /> <input type="hidden" name="no_note" value="0" /> <input type="hidden" name="lc" value="<?php Echo $this->t('US', 'Paypal Language Code') ?>" /> <input type="hidden" name="item_name" value="<?php Echo $this->t('Contribution to Dennis Hoppe') ?>" /> <input type="hidden" name="on0" value="<?php Echo $this->t('Reference') ?>" /> <input type="hidden" name="os0" value="<?php Echo $this->t('WordPress') ?>" /> <?php ForEach ($this->Get_Extension_Names(True) AS $index=>$extension) : ?> <input type="hidden" name="on<?php Echo ($index+1) ?>" value="<?php Echo $this->t('Plugin') ?>" /> <input type="hidden" name="os<?php Echo ($index+1) ?>" value="<?php Echo HTMLSpecialChars($extension) ?>" /> <?php EndForEach ?> <input type="hidden" name="on<?php Echo ($index+2) ?>" value="<?php Echo $this->t('Website') ?>" /> <input type="hidden" name="os<?php Echo ($index+2) ?>" value="<?php Echo HTMLSpecialChars(home_url()) ?>" /> <?php If (is_multisite()) : ?> <input type="hidden" name="on<?php Echo ($index+3) ?>" value="<?php Echo $this->t('MultiSite') ?>" /> <input type="hidden" name="os<?php Echo ($index+3) ?>" value="<?php Echo HTMLSpecialChars(DOMAIN_CURRENT_SITE) ?>" /> <?php EndIf ?> <input type="hidden" name="currency_code" value="<?php Echo $currency->code ?>" /> <?php Echo $this->t('Amount') ?>: <select name="amount" class="amount"> <option value="" disabled="disabled" selected="selected"><?php PrintF($this->t('Amount in %s'),$currency->code) ?>&nbsp;</option>--> <?php ForEach($this->Build_Amount_List($currency, True) AS $v=>$c) : ?> <option value="<?php Echo $v ?>"><?php Echo $c ?>&nbsp;</option> <?php EndForEach ?> </select> <input type="submit" class="proceed-to-paypal button-primary" value="<?php Echo $this->t('Proceed to PayPal') ?> &rarr;" title="<?php Echo $this->t('Proceed to PayPal') ?>" /> </form> </div> </li> <?php EndForEach; ?> </ul> <div class="clear"></div><?php } Function Print_Plugins_Advertisement(){?><div id="plugin_ads"> <img class="waiting" src="<?php Echo Esc_URL( Admin_URL( 'images/wpspin_light.gif' ) ); ?>" /> </div> <div class="clear"></div><?php } Function Print_Themes_Advertisement(){?><div id="theme_ads"> <img class="waiting" src="<?php Echo Esc_URL( Admin_URL( 'images/wpspin_light.gif' ) ); ?>" /> </div> <div class="clear"></div><?php } Function Print_Services_Advertisement(){?><div id="service_ads"> <img class="waiting" src="<?php Echo Esc_URL( Admin_URL( 'images/wpspin_light.gif' ) ); ?>" /> </div> <div class="clear"></div><?php } Function Print_Voucher_Box(){?> <form action="" method="post"> <input type="text" name="contribution_code" size="32" value="<?php Echo get_option('dh_contribution_code') ?>" /> <input type="submit" value="<?php Echo $this->t('Validate') ?>" class="button-primary" /> </form> <span class="description"><?php Echo $this->t('Please enter your personal Voucher Code.'); ?></span> <?php } } New dh_contribution; }