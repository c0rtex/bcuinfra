<!doctype html>
<html <?php language_attributes(); ?>>

<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>" />
	<meta name="language" content="en-US" />
	<meta name="lang" content="en" />
	<meta name="description" content="BenefitsCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
	<meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
	<meta name="Copyright" content="Copyright NCOA 2011" />
	<!-- Speaking of Google, don't forget to set your site up: http://google.com/webmasters -->	
	<meta name="google-site-verification" content="" />

	<!-- This is the traditional favicon.
		 - size: 16x16 or 32x32
		 - transparency is OK
		 - see wikipedia for info on broswer support: http://mky.be/favicon/ -->	
<link rel="shortcut icon" href="/favicon.ico"/>
	<!-- The is the icon for iOS's Web Clip.
		 - size: 57x57 for older iPhones, 72x72 for iPads, 114x114 for iPhone4's retina display (IMHO, just go ahead and use the biggest one)
		 - To prevent iOS from applying its styles to the icon name it thusly: apple-touch-icon-precomposed.png
		 - Transparency is not recommended (iOS will put a black BG behind the icon) -->
	<link rel="apple-touch-icon" href="wp-content/themes/bcuwptheme/images/custom_icon.png"/>
	<link rel="stylesheet" type="text/css" media="all" href="https://www.benefitscheckup.org/wp-content/themes/bcuwptheme/style.css" /> 
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie6.css" /><![endif]-->
	<!--[if IE 7]>
<style>
#feature_paragraph
{
	width: 375px !important;
}
DIV.col2 H2
{
	margin: 20px 0px 0px -15px !important;
}
DIV#home_away
{
	margin: 0px 0px 0px -15px;
}
TABLE.snapTable
{
	margin-top: 20px !important;
}
.helpButton {
    background: url("images/buttons/helpTip-bg.png") repeat-x scroll 0 0 #FFFFFF;
    border: 2px solid #999999;
    border-radius: 14px 14px 14px 14px;
	behavior:url(/cf/border-radius.htc);
    color: #1F419B !important;
    font-weight: 700;
    margin-left: 2px;
    padding: 0 4px;
}
</style>
<![endif]-->
	<!--[if IE 8]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie8.css" /><![endif]-->

<script type="text/javascript">
/*
CSS Browser Selector v0.4.0 (Nov 02, 2010)
Rafael Lima (http://rafael.adm.br)
http://rafael.adm.br/css_browser_selector
License: http://creativecommons.org/licenses/by/2.5/
Contributors: http://rafael.adm.br/css_browser_selector#contributors
*/
function css_browser_selector(u){var ua=u.toLowerCase(),is=function(t){return ua.indexOf(t)>-1},g='gecko',w='webkit',s='safari',o='opera',m='mobile',h=document.documentElement,b=[(!(/opera|webtv/i.test(ua))&&/msie\s(\d)/.test(ua))?('ie ie'+RegExp.$1):is('firefox/2')?g+' ff2':is('firefox/3.5')?g+' ff3 ff3_5':is('firefox/3.6')?g+' ff3 ff3_6':is('firefox/3')?g+' ff3':is('gecko/')?g:is('opera')?o+(/version\/(\d+)/.test(ua)?' '+o+RegExp.$1:(/opera(\s|\/)(\d+)/.test(ua)?' '+o+RegExp.$2:'')):is('konqueror')?'konqueror':is('blackberry')?m+' blackberry':is('android')?m+' android':is('chrome')?w+' chrome':is('iron')?w+' iron':is('applewebkit/')?w+' '+s+(/version\/(\d+)/.test(ua)?' '+s+RegExp.$1:''):is('mozilla/')?g:'',is('j2me')?m+' j2me':is('iphone')?m+' iphone':is('ipod')?m+' ipod':is('ipad')?m+' ipad':is('mac')?'mac':is('darwin')?'mac':is('webtv')?'webtv':is('win')?'win'+(is('windows nt 6.0')?' vista':''):is('freebsd')?'freebsd':(is('x11')||is('linux'))?'linux':'','js']; c = b.join(' '); h.className += ' '+c; return c;}; css_browser_selector(navigator.userAgent);
</script>

<style>
/*
Breadcrumb hack for Chrome

.chrome div#breadcrumbs { margin: 0 0 -15px 242px !important; }
*/
/*
Breadcrumb hack for Safari

@media screen and (-webkit-min-device-pixel-ratio:0) {

#breadcrumbs
{
	margin: 0 0 -15px 94px !important;
}

}
.win.gecko #breadcrumbs
{
	margin: 0 0 -15px 225px;
}
.win.ie8 #breadcrumbs
{
	margin: 0 0 -15px 223px;
}
*/
.win.ie7 #wrapper
{
	margin-top:-15px;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet" type="text/css">
<script src="/cf/ValidationFunctions.js"></script>
<script src="/cf/scripts.js"></script>
<script src="/cf/textResize.js"></script>

<script type="text/javascript">
$(function() {
	$.get("https://www.benefitscheckup.org/cf/populateWPheader.cfm");
});
</script>

<title><?php bloginfo('name'); ?></title>

<?php
/* 
 * 	Add this to support sites with sites with threaded comments enabled.
 */
	if ( is_singular() && get_option( 'thread_comments' ) )
		wp_enqueue_script( 'comment-reply' );

	//wp_head();
	
	wp_get_archives('type=monthly&format=link');
?>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-2674020-2']);
  _gaq.push(['_setDomainName', 'benefitscheckup.org']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>

<body class="js">

<div id="wrapper">
	<div id="ada508">  
		<strong>Shortcut Navigation:</strong> 
		<ul> 
			<li><a href="#content" accesskey="p" title="Skip to page content">Page Content</a></li> 
			<li><a href="#topNav" accesskey="n" title="Skip to main navigation menu">Site Navigation</a></li>

			<li><a href="#search" accesskey="s" title="Skip to search">Search</a></li> 
			<li><a href="#footer" accesskey="f" title="Skip to footer (ctrl/alt + f)">Footer</a></li> 
		</ul> 
	</div> 
<!-- #ada508 shortcuts --> 
	
    <div id="header">
   
    	<h1><a target="_blank" href="http://www.ncoa.org"><img src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"  title="National Council on Aging" alt="National Council on Aging" id="topbar" /></a></h1>
       	<a href="/" class="block"><img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" /><!--<img src="/wp-content/uploads/2011/11/bcu_10th-anni-logo.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" />--></a>
	<p><?php $header_callout = $wpdb->get_row('SELECT post_content FROM wp_posts WHERE ID = 2185'); 
echo $header_callout->post_content;?></p>
       
        <div id="sponsors">
        	<h2>Special thanks to:</h2>
        	<!--<img src="/wp-content/themes/bcuwpthemeimages/logos/walmart.gif" alt="Walmart logo" />-->
        </div><!-- sponsors --> 
	<div style="align:center;position:absolute; bottom:0px; padding-left:10px; padding:5px 20px 5px 20px;text-align:center;"><font color="#ED1C24"><b>Superstorm Sandy:</b> If you live in an area that was affected by Superstorm Sandy,
you may be able to get help.</font>  <a href="/home/disaster-assistance">Find help now!</a></div>
    </div><!--end header -->
	
    
    <div id="main-nav">
    	<?php 
    		wp_nav_menu( 
    			array( 
    					'sort_column' => 'menu_order', 
    					'menu_class' => 'nav', 
    					'theme_location' => 'primary-menu' ) ); 
    	?> 
	
    </div><!--end main nav --> 
	
	<div id="breadcrumbs">
		<p>
			<?php
				if(function_exists('bcn_display'))
				{
				    bcn_display();
				}
			?>
		</p>
	</div><!--end breadcrumbs --> 
