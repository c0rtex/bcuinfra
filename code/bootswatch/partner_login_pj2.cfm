<!DOCTYPE html>
<cfinclude template="mockupplheader_1.cfm">
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
    		<script src="/cf/bootswatch/bootstrap/js/application.js"></script>
	
	
   <link href="/cf/bootswatch/bootstrap/css/bootstrap_esi.min.css" rel="stylesheet"> 
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
    
		
		  </div></div>
		  
		
        
        <!--end header -->

</div>
        <div class="span11">
    <div class="row well">
      <section id="tables">
  <div class="page-header">
    <h1>Sign In!</h1>	
  </div>
  <table class="table table-bordered table-striped table-hover">
 <div class="table"
 <div class="row-fluid">   
	      <div class="span6 well">  
                      <section id="instructions">  	
							<div class="body-header-wrapper">	<h2><i class="icon-circle-arrow-right"></i> Partner Login </h2>	    
                            
                          
 
 <!--span8-->
	               
	      
</div>
 <tbody1>
 <form class="form-inline">
    <input type="text" class="input-small" placeholder="Email">
    <input type="password" class="input-small" placeholder="Password">
    <label class="checkbox">
    <input type="checkbox"> Remember me
    </label>
    <button type="submit" class="btn">Sign On</button>
    </form>
	<p>
  
  
  
  <button class="btn btn-small" type="button">Forgot Password?</button>
 </p>
 </tbody1>
					
	          </div>
               
	        
           
            	       </div>
                       
    
	    <!-- /row -->

</div>
  </body>
</html>