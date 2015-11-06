<!DOCTYPE html>
<html <?php language_attributes(); ?>>
  <head>
        <meta charset="<?php bloginfo( 'charset' ); ?>">
        <title>EconomicCheckUp | Money Management for Seniors</title>
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
        <meta name="description" content="EconomicCheckUp's
money management and budgeting tools help seniors improve financial security.
Print a custom report to learn how you can meet your financial needs." />
        <meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
        <meta name="Copyright" content="Copyright NCOA 2013" />
        <meta name="google-site-verification" content="" />
        
        <link rel="apple-touch-icon" href="wp-content/themes/bcuwptheme/images/custom_icon.png"/>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
				<script type='text/javascript' src='https://www.benefitscheckup.org/cf/js/infinite-rotator.js'></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap-tooltip.js" type="text/javascript"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/js/scrolltofixed.js"></script>
       <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->
            <script src="<?php echo get_template_directory_uri(); ?>/application.js"></script>
            <script src="<?php echo get_template_directory_uri(); ?>/ecu.js"></script>
		<script src="https://www.benefitscheckup.org/cf/js/infinite-rotator.js" type="text/javascript"></script>
				
	 
				<link rel="stylesheet" href="https://www.benefitscheckup.org/cf/bootswatch/css/font-awesome.css">
        <link href="https://www.benefitscheckup.org/cf/bootswatch/bootstrap/css/style.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		
        <link href="https://www.benefitscheckup.org/cf/bootswatch/bootstrap/css/bootstrap_esi.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/bcuwptheme/style-oesi.css"/>
        <!--[if IE 6]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie6.css" /><![endif]-->
        <!--[if IE 8]><link rel="stylesheet" type="text/css" href="wp-content/themes/bcuwptheme/css/ie8.css" /><![endif]-->
        <link href="https://www.benefitscheckup.org/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
				<link href="https://www.benefitscheckup.org/cf/bootstrap/css/pongos.css" rel="stylesheet">
           
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

    
      
	</head>
	<body data-spy="scroll" data-target=".sidebar-nav">
				
		<div class="container-fluid">
            <div id="header" class="row-fluid" style="height:0px;">
            	<div class="span12"><a href="http://www.ncoa.org" target="_blank"><img id="topbar" alt="National Council on Aging" title="National Council on Aging" src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"></a><BR></div>
         	</div>
            <div id="header" class="row-fluid">
                <div class="span5" >
                	<a href="/esi-home" class="block">                  <img src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" id="logo"/></a><br><BR>
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
                    <li id="esi-home" class="span2"><a class="<?php echo $_home; ?>" href="/esi-home">Home</a></li>
                    <li id="esi-spq" class="span2"><a href="/esi-questions" class="<?php echo $_spq; ?>">Get&nbsp;Started</a></li>
		    <li id="esi-help" class="span2"><a href="/esi-find-help" class="<?php echo $_help; ?>">Find&nbsp;Help</a></li>
                    <li id="esi-about" class="span2"><a href="/esi-about" class="<?php echo $_about; ?>">About Us</a></li>				
                    <li id="esi-news" class="span2"><a href="/esi-news" class="<?php echo $_news; ?>">News</a></li>
                    <li id="esi-donate" class="span2"><a href="https://www.ncoa.org/donate" class="" target="_blank">Donate</a></li>
                </ul>	
            </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">
			
<script type="text/javascript">     
	function PrintDiv() {    
    	var divToPrint = document.getElementById('printContent');
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
       	popupWin.document.write('<html><body onload="window.print()"><img id="logo" alt="EconomicCheckUp" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png"><BR />' + divToPrint.innerHTML + '</html>');
       	popupWin.document.close();
 	}
	function PrintDivCanvas(imgCanvas, imgCanvasCount) {    
    	var divToPrint = document.getElementById('printContent');
//console.log("In called func canvasImgCount: "+imgCanvasCount);
        if (imgCanvasCount == 1){  //avoiding repeated images
//$("#flot-placeholder").hide();
$("#flot-placeholder").append('<img src="'+imgCanvas+'"/>');
}
//document.getElementById('canvasImage').setAttribute('src',vara); 
//console.log("Canvas img printing: "+imgCanvas);
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
       	popupWin.document.write('<html><body onload="window.print()"><img id="logo" alt="EconomicCheckUp" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png"><BR />' + divToPrint.innerHTML + '</html>');
       	popupWin.document.close();
 	}

</script>
