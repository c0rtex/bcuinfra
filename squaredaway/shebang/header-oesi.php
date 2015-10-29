<!DOCTYPE html>
<html <?php language_attributes(); ?>>
  <head>
        <meta charset="<?php bloginfo( 'charset' ); ?>">
        <title>EconomicCheckUp</title>
        <?php
			/* 
			 * 	Add this to support sites with sites with threaded comments enabled.
			 */
			if ( is_singular() && get_option( 'thread_comments' ) )
				wp_enqueue_script( 'comment-reply' );
		
				//wp_head();
				wp_get_archives('type=monthly&format=link');
		?>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="language" content="en-US" />
        <meta name="lang" content="en" />
        <meta name="description" content="EconomicCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
        <meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
        <meta name="Copyright" content="Copyright NCOA 2013" />
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
	<script type='text/javascript' src='/cf/js/infinite-rotator.js'></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/js/jquery-latest.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap-tooltip.js" type="text/javascript"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/js/scrolltofixed.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/application.js"></script>
	<script type="text/javascript" src="https://redesign.benefitscheckup.org/CFIDE/scripts/cfform.js"></script>
	 
	 <link rel="stylesheet" href="/cf/bootswatch/css/font-awesome.css">
        <link href="/cf/bootswatch/bootstrap/css/style.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		
        <link href="/cf/bootswatch/bootstrap/css/bootstrap_esi.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>" /> -->
        <link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/bcuwptheme/style-oesi.css"/>
        <!--[if IE 6]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie6.css" /><![endif]-->
        <!--[if IE 8]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie8.css" /><![endif]-->
        <link href="/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
 	<link href="/cf/bootstrap/css/pongos.css" rel="stylesheet">
           
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="/wp-content/themes/bootswatch/bootstrap/js/html5shiv.js"></script>
        <![endif]-->
        
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
	<body data-spy="scroll" data-target=".sidebar-nav">
		<script>
			$(document).ready(function() {


	         //$("#select_esi_housingtype").change(); //manually fire the change so that the correct fields are shown after form validation





		  	var sidebar = $('.sidebar-nav');
		  	sidebar.scrollToFixed({
			marginTop: $('.navbar').outerHeight(true) + 50,
			zIndex: 999
		  	});
	
		  	var body_headers = $('.body-header');              
			body_headers.each(function(i) {
			var body_header = $(body_headers[i]);
			var next = body_headers[i + 1];
	
			body_header.scrollToFixed({
				marginTop: $('.navbar').outerHeight(true) ,
				limit: function() {
				var limit = 0;
				if (next) {
					limit = $(next).offset().top + $(this).outerHeight(true);
				} 
				return limit;
				},
					zIndex: 999
				});
			}); 
			
					
		   //hide questions first
			// Own home
			$('#cf_esi_estimatedvalue').hide();
			//$('#cf_esi_totaldebthouse').prev().hide();
			$('#cf_esi_totaldebthouse').hide();
			$('#label_esi_housingsituation').hide();
			$('#tr_esi_housingsituation').hide();
			$('#tr_esi_homeinsurance').hide();
			// Rent
			$('#tr_esi_rent').hide();
			$('#label_esi_rent').hide();	


		
//but show the previously selected type
var var_select_esi_housing_type = $("#select_esi_housingtype :selected").val();
change_housing_type(var_select_esi_housing_type);

//show the additional field for q1 if "Other" is selected

var var_select_esi_client= $("#select_esi_client :selected").val();

if (var_select_esi_client == '1360-other'){
  $("#tr_esi_other_specify").show();
}


	         $("#select_esi_housingtype").change(function(){

                        change_housing_type(this.value);
		   });

function change_housing_type (housing_type){
  //console.log("Housing type" + housing_type);

		  if(housing_type == '2488-esi_housingtype_rent')
			{
				//show rent questions and hide homeowner questions
				$('#tr_esi_rent').show();
				$('#label_esi_rent').show();
				$('#cf_esi_estimatedvalue').hide();
				//$('#tr_esi_totaldebthouse').prev().hide();
				$('#cf_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#label_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
		  else if(housing_type == '2487-esi_housingtype_own')
			{
				//hide rent questions and show homeowner questions
				$('#tr_esi_rent').hide();
				$('#label_esi_rent').hide();
				$('#cf_esi_estimatedvalue').show();
				//$('#tr_esi_totaldebthouse').prev().show();
				$('#cf_esi_totaldebthouse').show();
				$('#tr_esi_housingsituation').show();
				$('#label_esi_housingsituation').show();
				$('#tr_esi_homeinsurance').show();
			}
		  else 
			{
				//hide rent questions and hide homeowner questions
				$('#tr_esi_rent').hide();
				$('#label_esi_rent').hide();
				//$('#tr_esi_totaldebthouse').prev().hide();
				$('#cf_esi_estimatedvalue').hide();
				$('#cf_esi_totaldebthouse').hide();
				$('#tr_esi_housingsituation').hide();
				$('#label_esi_housingsituation').hide();
				$('#tr_esi_homeinsurance').hide();
			}
		}
		   });

		  

		</script>
		<div class="container-fluid">
            <div id="header" class="row-fluid" style="height:0px;">
            	<div class="span12"><a href="http://www.ncoa.org" target="_blank"><img id="topbar" alt="National Council on Aging" title="National Council on Aging" src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"></a><BR></div>
         	</div>
            <div id="header" class="row-fluid">
                <div class="span5" >
                	<a href="http://www.ncoa.org/enhance-economic-security/economic-security-Initiative/" target="_new" class="block">                  <img src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" id="logo"/></a><br><BR>
              	</div>
               	<div class="span7 statistics" id="logo" ><br>Since 2010, we’ve helped thousands of older adults find work, budget their money, and save on daily expenses.
                </div>
            </div><!--end header -->
            <?php 
			$_home = '';
			if ($_SERVER['REQUEST_URI']=='/esi-home/'){$_home = 'current_tab';}
			$_spq = '';
			if ($_SERVER['REQUEST_URI']=='/esi-questions/'){$_spq = 'current_tab';}
			$_help = '';
			if ($_SERVER['REQUEST_URI']=='/esi-find-help/'){$_help = 'current_tab';}
			$_about = '';
			if ($_SERVER['REQUEST_URI']=='/esi-about/'){$_about = 'current_tab';}
			$_news = '';
			if ($_SERVER['REQUEST_URI']=='/esi-news/'){$_news = 'current_tab';}
			
		?>

            <div id="main-nav" class="navbar row-fluid">
                <ul id="home-nav" class="row-fluid">
                    <li id="esi-home" class="span2"><a class="/esi-home" href="https:/redesign.benefitscheckup.org/esi-home">Home</a></li>
                    <li id="esi-spq" class="span2"><a href="https:/redesign.benefitscheckup.org/esi-questions" class="<?php echo $_spq; ?>">Get&nbsp;Started</a></li>
		    <li id="esi-help" class="span2"><a href="https:/redesign.benefitscheckup.org/esi-find-help" class="<?php echo $_help; ?>">Resources</a></li>
                    <li id="esi-about" class="span2"><a href="https:/redesign.benefitscheckup.org/esi-about" class="<?php echo $_about; ?>">About Us</a></li>				
                    <li id="esi-news" class="span2"><a href="https:/redesign.benefitscheckup.org/esi-news" class="<?php echo $_news; ?>">News</a></li>
                    <li id="esi-donate" class="span2"><a href="https://secure3.convio.net/ncoa/site/SPageServer?pagename=donationform" class="" target="_blank">Donate</a></li>
                </ul>	
            </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">
			<?php
				if ($_SERVER['REQUEST_URI'] == '/esi-home/'){
					echo "<div id='page' class='subpage layout-default'><div id='content' class='span12 main-content featured'>
<h2 class='feature'>Am I Making the Most of My Money?</h2>
<img src='/wp-content/uploads/2013/08/BCU-images_251x217_top.png' title='Women Smiling' alt='Women Smiling' class='alignright moveup'><h3>It’s easy to find out.</h3>
<p>Answer a few simple questions and learn how you can better manage your budget, save money, and set financial goals. It’s free, confidential, and from a trusted source--the nonprofit National Council on Aging.</p>
<div class='spacer'></div>
<a href='/esi-questions'><img src='/cf/bootstrap/css/images/getstarted.png' alt='Get Started Now'></a>

</div>";
				}
			?>
<script type="text/javascript">     
	function PrintDiv() {    
    	var divToPrint = document.getElementById('printContent');
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
       	popupWin.document.write('<html><body onload="window.print()"><img id="logo" alt="EconomicCheckUp" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" src="https://medicarequickcheck.benefitscheckup.org/cf/frmwelcome2.cfm?partner_id=14&subset_id=57"><BR />' + divToPrint.innerHTML + '</html>');
       	popupWin.document.close();
 	}
</script>
