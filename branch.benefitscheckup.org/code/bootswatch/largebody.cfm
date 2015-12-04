<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>EconomicCheckUp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

		<script src="../bootstrap/js/jquery.js"></script>
        	<script type="text/javascript" src="/cf/josh/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/cf/josh/js/jquery.validate.js"></script>
		<script type="text/javascript" src="/cf/josh/bootstrap/js/bootstrap.js"></script>
		<script type="text/javascript" src="/cf/josh/js/scrolltofixed.js"></script>
    		<script src="/cf/josh/bootstrap/js/application.js"></script>
<cfinclude template="stylesheet_switch.cfm">
		<link rel="stylesheet" href="css/font-awesome.css">
		<link href="/cf/josh/css/style.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		

    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="bootstrap/js/html5shiv.js"></script>
    <![endif]-->

  <script>
  $(document).ready(function(){
    $("#commentForm").validate();
  });
  </script>
  </head>

  <body data-spy="scroll" data-target=".sidebar-nav">
		<script>
		$(document).ready(function() {
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
		});

		</script>
    
		<div id="header" class="row">
		  <div class="span5"><br>
			  <a href="http://www.ncoa.org/enhance-economic-security/economic-security-Initiative/" target="_new" class="block">
				<img src="/cf/josh/images/ecocheck.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" />
			</a><br>
		</div>
		 <div class="span7"><br>
			<p style="width:400px;" align="left">Since 2010, we have helped seniors living near or
in poverty find benefits, jobs, support, and more.</p><br>
		  </div>
		  
		</div><!--end header -->




<div class="navbar ">
   <div class="navbar-inner">
     <div class="main-nav">
       <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
       </a>
       <a class="brand" href="../">Bootswatch</a>
       <div class="nav-collapse collapse" id="main-menu">
        <ul class="nav" id="main-menu-left">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Style Preview <b class="caret"></b></a>
            <ul class="dropdown-menu" id="swatch-menu">
              <li><a href="bootswatch.cfm?style=default">Default</a></li>
              <li class="divider"></li>
		<li><a href="bootswatch.cfm?style=esi">Esi</a></li>
              <li><a href="bootswatch.cfm?style=amelia">Amelia</a></li>
              <li><a href="bootswatch.cfm?style=cerulean">Cerulean</a></li>
              <li><a href="bootswatch.cfm?style=cosmo">Cosmo</a></li>
              <li><a href="bootswatch.cfm?style=cyborg">Cyborg</a></li>
              <li><a href="bootswatch.cfm?style=journal">Journal</a></li>
              <li><a href="bootswatch.cfm?style=readable">Readable</a></li>
              <li><a href="bootswatch.cfm?style=simplex">Simplex</a></li>
              <li><a href="bootswatch.cfm?style=slate">Slate</a></li>
              <li><a href="bootswatch.cfm?style=spacelab">Spacelab</a></li>
              <li><a href="bootswatch.cfm?style=spruce">Spruce</a></li>
              <li><a href="bootswatch.cfm?style=superhero">Superhero</a></li>
              <li><a href="bootswatch.cfm?style=united">United</a></li>
            </ul>
          </li>
          <li class="dropdown" id="preview-menu">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Single Page Questionnaire <b class="caret"></b></a>
            <ul class="dropdown-menu" id="questionnaire-menu">
              <li><a href="/cf/bootswatch/largebody.cfm?style=default">Default</a></li>
              <li class="divider"></li>
		<li><a href="/cf/bootswatch/largebody.cfm?style=esi">ESI</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=amelia">Amelia</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cerulean">Cerulean</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cosmo">Cosmo</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cyborg">Cyborg</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=journal">Journal</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=readable">Readable</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=simplex">Simplex</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=slate">Slate</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=spacelab">Spacelab</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=spruce">Spruce</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=superhero">Superhero</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=united">United</a></li>

            </ul>
          </li>
	  <li class="dropdown" id="preview-menu">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#"> Wide Layout <b class="caret"></b></a>
            <ul class="dropdown-menu" id="questionnaire-menu">
              <li><a href="/cf/bootswatch/largebody.cfm?style=default">Default</a></li>
              <li class="divider"></li>
		<li><a href="/cf/bootswatch/largebody.cfm?style=esi">ESI</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=amelia">Amelia</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cerulean">Cerulean</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cosmo">Cosmo</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=cyborg">Cyborg</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=journal">Journal</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=readable">Readable</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=simplex">Simplex</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=slate">Slate</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=spacelab">Spacelab</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=spruce">Spruce</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=superhero">Superhero</a></li>
              <li><a href="/cf/bootswatch/largebody.cfm?style=united">United</a></li>

            </ul>
          </li>
	   <li><a rel="tooltip"  href="#icons" title="Some Example Icons from Font Awesome." >View Sample Icons <i class="icon-share-alt"></i></a></li>
        </ul>
      
       </div>
     </div>
   </div>
 </div>

    <div > 
	    <div class="row">   
		
	      <div class="span12">  

                      <section id="instructions">  	
							<div class="body-header-wrapper">	<h2><i class="icon-head "></i> Heading </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
			  <div class="">
				<h4></h4>
	  		      
	          </div>
               <div class="">
						      <form class="well">
					        <fieldset>
					          <legend>Subheading...details....</legend>
					          <div class="clearfix">
					            <label for="xlInput">Some Text details here.</label>
					           
					          </div><!-- /clearfix -->
	        				</fieldset>
                            </form>
                      </div>
         
            </section>


            	       </div> <!--span7-->
	
	       
       </div><!-- /row -->
    </div> <!-- /container -->
  </body>
</html>