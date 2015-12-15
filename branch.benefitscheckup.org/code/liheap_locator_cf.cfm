<!---cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0>	
	<cfset SESSION.application_id = 3>
	<cfset SESSION.program_id = 150>
	<cfparam name='SESSION.programcategory_id' default='0'>
	<cfparam name='URL.partner_id' default='0'>
	
	<cfscript>
		//log page views in to database
		application.udf.logPageViews();
	</cfscript>
	
	<cfparam name="zipCode" default="">
	<cfparam name="county_id" default="">
	<cfparam name="showmap" default="0">
	<cfparam name="showOffices" default="0">
	<cfparam name="error1" default="0">
	<cfparam name="zipSearch" default="0">
	<cfparam name="mapWidth" default="674">
	<cfparam name="mapHeight" default="554">
		
	<cfif trim(zipCode) IS NOT "" OR zipSearch IS 1>
	
		<cf_validateZip zipcode="#zipCode#" var="zipValidation">
		
		<cfif zipValidation IS TRUE>
			<script>
				$(document).ready(function(){
					$('DIV#snapLink').show();	
					$("DIV.entry_point").each(function (i) {
				    	//hide elements greater than 10 in the index
				        if (i > 9) {
				            $(this).hide();
				        }
				        if (i < 9) {
				            $(this).show();
				        }
				    });
					
					numberOfEntrypoints = $("DIV.entry_point").length;
		
					if (numberOfEntrypoints > 10) {
						$('#viewMore').show();
						$('#viewPrevious').hide();
					}
					
					$('DIV#msg').css('margin-bottom','-20px');
					$('DIV#msg').text('');
					
				});
			</script>	
			<cfquery name="findZip" datasource="#application.dbSrc#">
				SELECT state_map_code2 
				FROM zip z
				LEFT JOIN state s ON s.state_id = z.state_id
				WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#left(zipCode, 5)#">
			</cfquery>
		
			<cfset mapWidth = 474>
			<cfset mapHeight = 354>	
			
			<style>
			DIV#flash_map
			{
				float: left !important;
				margin-left: -150px !important;
				margin-top: 45px !important;
				margin-right: 20px;
			}
			</style>
		
			<cfset showmap = findZip.state_map_code2>
		<cfelse>
			<cfset showmap = 0>
			<cfset showmap = 0>
			<cfset error1 = 1>
	
		</cfif>
	</cfif>
	
	<style type="text/css">
	#for-further-information {
		font-family:verdana,arial,helvetica,sans-serif;
		font-size:0.8em;
		margin:0 0 12px;
		padding:0;
	}
	
	</style>
	
	<script type="text/javascript">
	
	<cfif error1 IS 1>
		alert('Please enter a valid zip code.');
	</cfif>
	
	function hideOffices() {
		$("#zipCode").val("");			
		$("#zipCodeError").remove();	
		//$("DIV#officeCol").css("background-color", "#FFF");
		//$("DIV#officeCol").width(0); 	
		//$("DIV#officeCol").css("padding", "0px");	
		//$("#offices").css("background-color", "#FFF");
		//$("#offices").css("padding", "0px");		
		$("#offices").hide();
		//$("#flashMap").width(730).height(500); 		
		//$(".introText").css("padding-right", "0px");
		//$("DIV.introText p").css("margin-right","0px");	
		$('#language_country_map').show();
		$('#language_state_map').hide();
		$('#language_office_map').hide();	
		//$("#language_country_map, #locatorTitle").width(730); 		
		//$("#locatorTitle").css("text-align", "center");	
		$('DIV#snapLink').hide();
		$('#viewMore').hide();
		$('#viewPrevious').hide();
	}
	
	function showOffices(url) {
		$('#viewMore').hide();
		$('#viewPrevious').hide();
		$("#zipCode").val("");			
		//$("#flashMap").width(474).height(354); 		
		$('#offices').toggle();
		//$("#locatorTitle").css("text-align", "left");		
		//$(".introText").css("padding-right", "10px");			
		//$("#language_country_map, #locatorTitle").width(474); 		
		$('#language_country_map').hide();
		$('#language_state_map').hide();
		$('#language_office_map').show();
		$('DIV#snapLink').show();	
	
		$('#offices').replaceWith('<div id="offices"><h4>Loading Office(s)</h4><p><img src="img/loading.gif"></p></div>');
		//$("#offices").css("width", "238px");		
		
		//$("DIV#officeCol").css("background-color", "#CCCCCC");				
		//$("DIV#officeCol").css("width", "254px");
	
	
		$("#offices").load(url, function() {
		//$("#offices").css("background-color", "#CCCCCC");	
		//$("DIV#officeCol").css("background-color", "#CCCCCC");	
		//$('DIV#msg').css('margin-bottom','-20px');
		$('DIV#msg').text('');		
			
		$("DIV.entry_point").each(function (i) {
	    	//hide elements greater than 10 in the index
	        if (i > 9) {
	            $(this).hide();
	        }
	        if (i < 9) {
	            $(this).show();
	        }
	    });
		
		numberOfEntrypoints = $("DIV.entry_point").length;
		
		if (numberOfEntrypoints > 10) {
			$('#viewMore').show();
			$('#viewPrevious').hide();
		}
			
		});
	}
	
	function backClick() {
		$("#zipCode").val("");			
		$('#language_country_map').hide();
		$('#language_state_map').show();
		$('#language_office_map').hide();	
	
	}
	
	function stateText() {
		$("#zipCode").val("");			
		$('#language_country_map').hide();
		$('#language_state_map').show();
		$('#language_office_map').hide();	
		$("#language_state_map").css("width", "730px");		
	
	}
	//functions to hide/show first ten entry points and then paginate next ten entry points
	function hideNextTen() {
	    $("DIV.entry_point").each(function (i) {
	    //hide elements greater than 10 in the index
	        if (i >= 9) {
	            $(this).hide();
	        }
	        if (i <= 9) {
	            $(this).show();
	        }
	    });
		$('#viewMore').show();
		$('#viewPrevious').hide();
	}
	
	function showNextTen() {
	    $("DIV.entry_point").each(function (i) {
	    //show elements greater than 10 in the index
	        if (i <= 10) {
	            $(this).hide();
	        }
	        if (i >= 10) {
	            $(this).show();
	        }
	    });
		$('#viewMore').hide();
		$('#viewPrevious').show();
		
	}
	
		var message = "Print this Page";
	
		function printpage() {
			window.print();  
			return false;
		}
		
		
	$(document).ready(function() {
	   
	    $('a#viewMore').click(function(){
	        $('html, body').animate({scrollTop:0}, 'fast');
	        return false;
	    });
		
	    $('a#viewPrevious').click(function(){
	        $('html, body').animate({scrollTop:0}, 'fast');
	        return false;
	    });
	});	
	</script>
	
	
	
	<cfoutput>
	<script src="js/AC_RunActiveContent.js" type="text/javascript"></script>
	
	<cf_displayText group="site" code="site_liheap_locator_main_title" var="site_liheap_locator_main_title_country">
	<cf_displayText group="site" code="site_liheap_locator_main_title" var="site_liheap_locator_main_title_state">
	<cf_displayText group="site" code="site_liheap_locator_office_title" var="site_liheap_locator_office_title">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_country_map" var="site_liheap_locator_intro_language_country_map">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_state_map" var="site_liheap_locator_intro_language_state_page">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_office_page" var="site_liheap_locator_intro_language_office_page">
	
	
		<!---<h1>#site_liheap_locator_main_title_country#</h1>
		<p>
		#site_liheap_locator_intro_language_country_map#
		</p>
		
		<h1>#site_liheap_locator_main_title_state#</h1>
		<p>
		#site_liheap_locator_intro_language_state_page#
		</p>
		--->
	
		<h1 align="center">#site_liheap_locator_office_title#</h1>
			<p>#site_liheap_locator_intro_language_office_page#</p>
	
		<div id="snapLink" style="display:none; margin-bottom:10px; float:right; margin-right: 50px;">
			<a class="snapLink" onclick="printpage();" href="##">
				<img hspace="0" border="0" vspace="0" 
					title="Print this Page" alt="Print this Page" src="/cf/img/print_this_page.gif"></a>
		</div>
	
			<form action="liheap_locator.cfm?zipSearch=1&partner_id=<cfoutput>#URL.partner_id#</cfoutput>" method="post">
			<div id="zip_code_search">
				<p class="strong float_left">Enter Your Zip Code: </p>
					<p class="float_left">
						<input class="zip_code_input" style="margin-top:-5px" type="text" size="10" maxlength="5" value="<cfif error1 IS NOT 1>#zipCode#</cfif>" name="zipCode" id="zipCode">
						<input id="search_button" style="margin-top:-5px" type="submit" value="Search" />
					</p>
					
					
					
				<div id="flash_map">
					<script type="text/javascript">
					AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','#mapWidth#','height','#mapHeight#','id','flashMap','align','middle','src','us_city_map/golden_usa_external?xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','us_city_map/golden_usa_external','flashvars','xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#' ); //end AC code
					</script>
					
					<noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
					<param name="allowScriptAccess" value="sameDomain" />
					<param name="movie" value="us_city_map/golden_usa_external.swf" />
					<PARAM NAME=FlashVars VALUE="xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#">
					<param name="quality" value="high" />
					<param name="wmode" value="transparent" />
					<param name="bgcolor" value="##ffffff" />
					<embed src="us_city_map/golden_usa_external.swf?xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#&partner_id=#URL.partner_id#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
					</object></noscript>
				
				</div>
					
					<div id="officeCol" <cfif showOffices IS 1>style="display:none;"</cfif>>
	
						<div id="offices">
						
						<cfif showMap GT 0>
							
							<cfparam name="attributes.zip" default="#left(zipCode, 5)#">
							<cfparam name="attributes.program_id" default="150">
							
							<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" zipcode="#attributes.zip#" limit="20" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" google="true">
							
							<h4>LIHEAP Office(s):</h4>			
							
							<cfoutput>
							<p>#outstr#</p>
							</cfoutput>
							
						<cfelseif county_id IS NOT "">
							
							<cfquery name="findCounty" datasource="#application.dbSrc#">
							SELECT *
							FROM county
							WHERE county_id = <cfqueryparam value="#county_id#">
							</cfquery>
							
							<cfparam name="attributes.county_id" default="#county_id#">
							<cfparam name="attributes.program_id" default="150">
	
							<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" county_id="#attributes.county_id#" limit="20" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" proximityOverride="county" google="true">
							
							
							<h4>The following office(s) serves your area:</h4>		
							<cfoutput>
							<p>#outstr#</p>
							</cfoutput>
						
						</cfif>
					</div>
	
					<div>
						<a href='##' onClick='showNextTen();return false;' style='display:none;' id='viewMore'>View More Offices</a>
						<a href='##' onClick='hideNextTen();return false;' style='display:none;' id='viewPrevious'>View Previous Offices</a>
					</div>
				</div>
							
			</div>
			</form>
	
	</cfoutput>

<cfelse--->

	<cfset SESSION.application_id = 3>
	<cfset SESSION.program_id = 150>
	<cfparam name='SESSION.programcategory_id' default='0'>
	<cfparam name='URL.partner_id' default='0'>
	
	<cfscript>
		//log page views in to database
		application.udf.logPageViews();
	</cfscript>
	
	<cfparam name="zipCode" default="">
	<cfparam name="county_id" default="">
	<cfparam name="showmap" default="0">
	<cfparam name="showOffices" default="0">
	<cfparam name="error1" default="0">
	<cfparam name="zipSearch" default="0">
	
	
	
	<cfif trim(zipCode) IS NOT "" OR zipSearch IS 1>
	
		<cf_validateZip zipcode="#zipCode#" var="zipValidation">
		
		<cfif zipValidation IS TRUE>
			<script>
				$(document).ready(function(){
					$('DIV#snapLink').show();	
					$("TABLE TR TD DIV.entry_point").each(function (i) {
				    	//hide elements greater than 10 in the index
				        if (i > 9) {
				            $(this).hide();
				        }
				        if (i < 9) {
				            $(this).show();
				        }
				    });
					
					numberOfEntrypoints = $("TABLE TR TD DIV.entry_point").length;
		
					if (numberOfEntrypoints > 10) {
						$('#viewMore').show();
						$('#viewPrevious').hide();
					}
					
					$('DIV#msg').css('margin-bottom','-20px');
					$('DIV#msg').text('');
					
				});
			</script>	
			<cfquery name="findZip" datasource="#application.dbSrc#">
				SELECT state_map_code2 
				FROM zip z
				LEFT JOIN state s ON s.state_id = z.state_id
				WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#left(zipCode, 5)#">
			</cfquery>
		
			<cfset showmap = findZip.state_map_code2>
		<cfelse>
			<cfset showmap = 0>
			<cfset showmap = 0>
			<cfset error1 = 1>
		</cfif>
	</cfif>
	
	<cfif showMap IS 0>
    	<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
        	<cfset mapWidth = 780>
            <cfset mapHeight = 534>	
        <cfelse>
			<cfset mapWidth = 730>
            <cfset mapHeight = 500>	
		</cfif>
    <cfelse>
    	<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
        	<cfset mapWidth = 524>
            <cfset mapHeight = 391>		
        <cfelse>
			<cfset mapWidth = 474>
            <cfset mapHeight = 354>	
		</cfif>
	</cfif>
	
	<style type="text/css">
	#for-further-information {
		font-family:verdana,arial,helvetica,sans-serif;
		font-size:0.8em;
		margin:0 0 12px;
		padding:0;
	}
	
	</style>
	
	<script type="text/javascript" src="/js/jquery.js"></script>
	
	<script type="text/javascript">
	
	<cfif error1 IS 1>
		alert('Please enter a valid zip code.');
	</cfif>
	
	<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
	function hideOffices() {
		$("#zipCode").val("");			
		$("#zipCodeError").remove();	
		$("#officeCol").css("background-color", "#FFF");
		$("#officeCol").width(0); 	
		$("#officeCol").css("padding", "0px");	
		$("#offices").css("background-color", "#FFF");
		$("#offices").css("padding", "0px");		
		$("#offices").hide();
		$("#flashMap").width(780).height(534); 		
		$(".introText").css("padding-right", "0px");
		$("DIV.introText p.text1").css("margin-right","0px");	
		$('#language_country_map').show();
		$('#language_state_map').hide();
		$('#language_office_map').hide();	
		$("#language_country_map, #locatorTitle").width(780); 		
		$("#locatorTitle").css("text-align", "center");	
		$('DIV#snapLink').hide();
		$('#viewMore').hide();
		//$('#viewPrevious').hide();
	}
	
	function showOffices(url) {
		$('#viewMore').hide();
		$('#viewPrevious').hide();
		$("#zipCode").val("");			
		$("#flashMap").width(524).height(391); 		
		$('#offices').toggle();
		$("#locatorTitle").css("text-align", "left");		
		$(".introText").css("padding-right", "10px");			
		$("#language_country_map, #locatorTitle").width(524); 		
		$('#language_country_map').hide();
		$('#language_state_map').hide();
		$('#language_office_map').show();
		$('DIV#snapLink').show();	
	
		$('#offices').replaceWith('<div id="offices" style="background: none repeat scroll 0 0 #FEF4DC; border-radius: 10px 10px 10px 10px; margin-bottom: 10px; padding: 10px 0 10px 10px; padding-left:8px; width:238px;"><h2 class="snapH2">Loading Office(s)</h2><p class="text1"><img src="/cf/img/loading.gif"></p></div>');
		$("#offices").css("width", "238px");		
		
		$("#officeCol").css("background-color", "#FEF4DC");				
		$("#officeCol").css("width", "254px");
	
	
		$("#offices").load(url, function() {
		$("#offices").css("background-color", "#FEF4DC");	
		$("#officeCol").css("border-radius", "10px 10px 10px 10px");	
		$("#officeCol").css("background-color", "#FEF4DC");	
		$('DIV#msg').css('margin-bottom','-20px');
		$('DIV#msg').text('');		
			
		$("TABLE TR TD DIV.entry_point").each(function (i) {
	    	//hide elements greater than 10 in the index
	        if (i > 9) {
	           $(this).hide();
	        }
	        if (i < 9) {
	            $(this).show();
	        }
	    });
		
		numberOfEntrypoints = $("TABLE TR TD DIV.entry_point").length;
		
		if (numberOfEntrypoints > 10) {
			$('#viewMore').show();
			//$('#viewPrevious').hide();
		}
			
		});
	}
	<cfelse>
	function hideOffices() {
		$("#zipCode").val("");			
		$("#zipCodeError").remove();	
		$("#officeCol").css("background-color", "#FFF");
		$("#officeCol").width(0); 	
		$("#officeCol").css("padding", "0px");	
		$("#offices").css("background-color", "#FFF");
		$("#offices").css("padding", "0px");		
		$("#offices").hide();
		$("#flashMap").width(730).height(500); 		
		$(".introText").css("padding-right", "0px");
		$("DIV.introText p.text1").css("margin-right","0px");	
		$('#language_country_map').show();
		$('#language_state_map').hide();
		$('#language_office_map').hide();	
		$("#language_country_map, #locatorTitle").width(730); 		
		$("#locatorTitle").css("text-align", "center");	
		$('DIV#snapLink').hide();
		$('#viewMore').hide();
		//$('#viewPrevious').hide();
	}
	
	function showOffices(url) {
		$('#viewMore').hide();
		$('#viewPrevious').hide();
		$("#zipCode").val("");			
		$("#flashMap").width(474).height(354); 		
		$('#offices').toggle();
		$("#locatorTitle").css("text-align", "left");		
		$(".introText").css("padding-right", "10px");			
		$("#language_country_map, #locatorTitle").width(474); 		
		$('#language_country_map').hide();
		$('#language_state_map').hide();
		$('#language_office_map').show();
		$('DIV#snapLink').show();	
	
		$('#offices').replaceWith('<div id="offices" style="padding-left:8px; width:238px; background-color:#CCCCCC;"><h2 class="snapH2">Loading Office(s)</h2><p class="text1"><img src="/cf/img/loading.gif"></p></div>');
		$("#offices").css("width", "238px");		
		
		$("#officeCol").css("background-color", "#CCCCCC");				
		$("#officeCol").css("width", "254px");
	
	
		$("#offices").load(url, function() {
		$("#offices").css("background-color", "#CCCCCC");	
		$("#officeCol").css("background-color", "#CCCCCC");	
		$('DIV#msg').css('margin-bottom','-20px');
		$('DIV#msg').text('');		
			
		$("TABLE TR TD DIV.entry_point").each(function (i) {
	    	//hide elements greater than 10 in the index
	        if (i > 9) {
	           $(this).hide();
	        }
	        if (i < 9) {
	            $(this).show();
	        }
	    });
		
		numberOfEntrypoints = $("TABLE TR TD DIV.entry_point").length;
		
		if (numberOfEntrypoints > 10) {
			$('#viewMore').show();
			//$('#viewPrevious').hide();
		}
			
		});
	}
	</cfif>
	
	function backClick() {
		$("#zipCode").val("");			
		$('#language_country_map').hide();
		$('#language_state_map').show();
		$('#language_office_map').hide();	
	
	}
	
	<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
		function stateText() {
			$("#zipCode").val("");			
			$('#language_country_map').hide();
			$('#language_state_map').show();
			$('#language_office_map').hide();	
			$("#language_state_map").css("width", "780px");		
		}
	<cfelse>
		function stateText() {
			$("#zipCode").val("");			
			$('#language_country_map').hide();
			$('#language_state_map').show();
			$('#language_office_map').hide();	
			$("#language_state_map").css("width", "730px");		
		}
	</cfif>
	
	//functions to hide/show first ten entry points and then paginate next ten entry points
	function hideNextTen() {
	    $("TABLE TR TD DIV.entry_point").each(function (i) {
	    //hide elements greater than 10 in the index
	        if (i >= 9) {
	            $(this).hide();
	        }
	        if (i <= 9) {
	            $(this).show();
	        }
	    });
		$('#viewMore').show();
		$('#viewPrevious').hide();
	}
	
	function showNextTen() {
	    $("TABLE TR TD DIV.entry_point").each(function (i) {
	    //show elements greater than 10 in the index
	        //if (i <= 10) {
	            //$(this).hide();
	        //}
	        if (i >= 10) {
	            $(this).show();
	        }
	    });
		$('#viewMore').hide();
		//$('#viewPrevious').show();
		
	}
	
		var message = "Print this Page";
	
		function printpage() {
			window.print();  
			return false;
		}
		
		
	<!---$(document).ready(function() {
	   
	    $('a#viewMore').click(function(){
	        $('html, body').animate({scrollTop:0}, 'fast');
	        return false;
	    });
		
	    $('a#viewPrevious').click(function(){
	        $('html, body').animate({scrollTop:0}, 'fast');
	        return false;
	    });
	});--->	
	</script>
	
	
	
	<cfoutput>
	<script src="/cf/js/AC_RunActiveContent.js" type="text/javascript"></script>
	<div style="margin:5px 10px 10px;">
	
	<table cellpadding="0" cellspacing="0" border="0">
	<tr>
       	<td valign="top" style="width: #mapWidth#px;">
   	
	<!---cfif showmap GT 0--->
		<cfset alignHeader = "left">
	<!---cfelse>
		<cfset alignHeader = "center">
	</cfif--->
	
	<cf_displayText group="site" code="site_liheap_locator_main_title" var="site_liheap_locator_main_title_country">
	<cf_displayText group="site" code="site_liheap_locator_main_title" var="site_liheap_locator_main_title_state">
	<cf_displayText group="site" code="site_liheap_locator_office_title" var="site_liheap_locator_office_title">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_country_map" var="site_liheap_locator_intro_language_country_map">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_state_map" var="site_liheap_locator_intro_language_state_page">
	<cf_displayText group="site" code="site_liheap_locator_intro_language_office_page" var="site_liheap_locator_intro_language_office_page">
	
	
	<div class="introText" id="language_country_map" <cfif showmap GT 0>style="display:none;"</cfif>>
		<!--- Bug 5762 - Locators: Print this page with formatting --->
		<h1 id="locatorTitle" class="locatorH1" style="text-align:#alignHeader#; width:100%; margin-top:0px; padding-top:0px;">#site_liheap_locator_main_title_country#</h1>
		<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
		#site_liheap_locator_intro_language_country_map#
		</p>
	</div>
	
	
	<div class="introText" id="language_state_map" style="display:none; width:100%">
		<h1 id="locatorTitle" class="locatorH1" style="text-align:#alignHeader#; width:100%; margin-top:0px; padding-top:0px;">#site_liheap_locator_main_title_state#</h1>
		<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
	#site_liheap_locator_intro_language_state_page#
		</p>
	</div>
	</p>
	
	<div class="introText" id="language_office_map" <cfif showmap IS 0>style="display:none;"</cfif>>
		<div id="snapLink" style="display:none; margin-bottom:10px; margin-right:20px; float:right;">
			<a class="snapLink" onclick="printpage();" href="##"><img hspace="0" border="0" vspace="0" title="Print this Page" alt="Print this Page" src="/cf/img/print_this_page.gif"></a>
		</div>
		<h1 id="locatorTitle" class="locatorH1" style="text-align:#alignHeader#; width:100%; margin-top:0px; padding-top:0px;">#site_liheap_locator_office_title#</h1>
		<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
	#site_liheap_locator_intro_language_office_page#
		</p>
	</div>
	</p>
	
	<div class="search" style="margin-left:0px; margin-right:0px;">
	<form action="liheap_locator.cfm?zipSearch=1&partner_id=<cfoutput>#URL.partner_id#</cfoutput>" method="post">
	<p class="text1" style="margin-top:0px;">
    <table border="0" cellpadding="0px" cellspacing="10px">
    	<tr>
        	<td><strong>Enter Your Zip Code:</strong></td>
            <td><input type="text" size="10" maxlength="5" value="<cfif error1 IS NOT 1>#zipCode#</cfif>" name="zipCode" id="zipCode"></td>
            <td><input type="submit" value="Search"></td>
        </tr>
    </table>
	</p>
	
	</form>
	</div>
	<center>
    	<cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
			<script type="text/javascript">
                        AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','#mapWidth#','height','#mapHeight#','id','flashMap','align','middle','src','us_city_map/golden_usa_external?xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','us_city_map/golden_usa_external','flashvars','xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#' ); //end AC code
                        </script>
                        
                        <noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
                        <param name="allowScriptAccess" value="sameDomain" />
                        <param name="movie" value="us_city_map/golden_usa_external.swf" />
                        <PARAM NAME=FlashVars VALUE="xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#">
                        <param name="quality" value="high" />
                        <param name="wmode" value="transparent" />
                        <param name="bgcolor" value="##ffffff" />
                        <embed src="us_city_map/golden_usa_external.swf?xmlfile1=us_city_map/liheap_usa.xml&show_map=#showmap#&partner_id=#URL.partner_id#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
                        </object></noscript>
        <cfelse>
			<script type="text/javascript">
                    AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','#mapWidth#','height','#mapHeight#','id','flashMap','align','middle','src','us_city_map/golden_usa_external?xmlfile1=us_city_map/liheap_usa_pl.xml&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','us_city_map/golden_usa_external','flashvars','xmlfile1=us_city_map/liheap_usa_pl.xml&show_map=#showmap#' ); //end AC code
                    </script>
                    
                    <noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="movie" value="us_city_map/golden_usa_external.swf" />
                    <PARAM NAME=FlashVars VALUE="xmlfile1=us_city_map/liheap_usa_pl.xml&show_map=#showmap#">
                    <param name="quality" value="high" />
                    <param name="wmode" value="transparent" />
                    <param name="bgcolor" value="##ffffff" />
                    <embed src="us_city_map/golden_usa_external.swf?xmlfile1=us_city_map/liheap_usa_pl.xml&show_map=#showmap#&partner_id=#URL.partner_id#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
                    </object></noscript>
		</cfif>	
	</center>
	</td>
	
	<td  valign="top" id="officeCol" <cfif showMap GT 0><cfif session.partner_id EQ 0 or session.partner_id EQ 77>style="background: none repeat scroll 0 0 ##FEF4DC; border-radius: 10px 10px 10px 10px; margin-bottom: 10px; padding: 10px 0 10px 10px; padding-left:8px; width:238px;"<cfelse>style="padding-left:8px; width:238px; background-color:##CCCCCC;"</cfif></cfif><cfif showOffices IS 1>style="display:none;"</cfif>>
	
	<div id="offices">
	
	<cfif showMap GT 0>
		
		<cfparam name="attributes.zip" default="#left(zipCode, 5)#">
		<cfparam name="attributes.program_id" default="150">
		
		<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" zipcode="#attributes.zip#" limit="20" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" google="true">
		
	<h2 class="snapH2" style="margin:0px;">LIHEAP Office(s):</h2>			
		
		<cfoutput>
		<p class="text1">
		#outstr#
		</p>
		</cfoutput>
	<cfelseif county_id IS NOT "">
		
		<cfquery name="findCounty" datasource="#application.dbSrc#">
		SELECT *
		FROM county
		WHERE county_id = <cfqueryparam value="#county_id#">
	</cfquery>
		
		<cfparam name="attributes.county_id" default="#county_id#">
		<cfparam name="attributes.program_id" default="150">
		
	
		
		<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" county_id="#attributes.county_id#" limit="20" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" proximityOverride="county" google="true">
		
		
		
		<cfoutput>
		
		<h2 class="snapH2" style="margin:0px;">The following office(s) serves your area:</h2>		
		
		<p class="text1">
		#outstr#
		</p>
		</cfoutput>
	
	</cfif>
	</div>
		<div align='center' style='margin-top:20px; margin-bottom: 20px;'>
			<a href='##' onClick='showNextTen();return false;' style='display:none;' id='viewMore'>View All Offices</a>
			<!---<a href='##' onClick='hideNextTen();return false;' style='display:none;' id='viewPrevious'>View Previous Offices</a>--->
		</div>
	</td>
	
	
	</tr>
	</table>
	</div>
	</cfoutput>

<!---/cfif--->	
	
	
