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
		  
		</div><!--end header -->

<cfinclude template="testing_menu.cfm">

    <div class="container-fluid"> 
	    <div class="row-fluid">   
	      <div class="span8">  
                      <section id="instructions">  	
							<div class="body-header-wrapper">	<h2><i class="icon-book "></i> Instructions </h2>	
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
					          <legend>Completing the Questionnaire....</legend>
					          <div class="clearfix">
					            <label for="xlInput">You will receive the most complete results if you answer all questions. Click the help link if you need help answering a question. Please do not click your &quot;Back&quot; button while you are answering the questions, as your answers may not be saved.</label>
					           
					          </div><!-- /clearfix -->
	        				</fieldset>
                            </form>
                      </div>
         
            </section>
            
	        <section id="basicinfo"> 
							<div class="body-header-wrapper">	<h2><i class="icon-pencil "></i> Basic Info </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div  id="">
						  			
						      	  </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
					        <fieldset>
					          <legend>Section summary information goes here. </legend>
					          <div class="clearfix">
					            <label for="xlInput">1. Who are you completing this for? <a href="#" class="badge badge-info" data-toggle="popover" title="Please Note" data-content="If you are completing this for someone else, please answer all questions as if you are that person."> Please Note </a></label>
					            <div class="input">
					              <select name="normalSelect" id="normalSelect" class="required" >
					                <option>- Select -</option>
					                <option>Self</option>
					                <option>Spouse</option>
					                <option>Mother</option>
					                <option>Father</option>
                                    <option>Client</option>
                                    <option>Test Case</option>
                                    <option>Other</option>
					              </select>
                                  	
   
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="normalSelect">2. What is the main reason you are looking for help? <a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Even though you may have more than one reason you are looking for help, please choose only the main reason that you need help."><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					              <select name="normalSelect" id="normalSelect">
					                <option value="">- Select -</option>			
					<option value="2585-esi_financial"> I have money concerns </option>              
					<option value="2586-esi_employment"> I want help finding a job </option>            
					<option value="2587-esi_legal"> I want help with legal problems </option>            
					<option value="2588-esi_public_benefits"> I want to find programs to help with everyday costs </option>        
					<option value="2589-esi_housing"> I want help with housing </option>              
					<option value="2590-esi_aging_services"> I want information about aging services and providers </option>
                
					<option value="2591-esi_health"> I want information about health care services </option>
					<option value="2592-esi_other_reason_help"> Other </option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="normalSelect">3. What is your zip code?</label>
					            <div class="input">
					              <input name="zipcode" type="text" class="required" minlength="5" autocomplete="off" data-provide="typeahead"  data-source="'10021','10015','10037','56304','55305','12345','22345','32345','42345','60637','72123','80122','90211'" maxlength="5">
                                  
              
            
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="multiSelect">4. What is your month and year of birth?</label>
					            <div class="input">
                                <select name="month" id="month">
                                				<option value="">-- month --
			
				<option value="1"> Jan 
				<option value="2"> Feb 
				<option value="3"> Mar 
				<option value="4"> Apr 
				<option value="5"> May 
				<option value="6"> Jun 
				<option value="7"> Jul 
				<option value="8"> Aug 
				<option value="9"> Sep 
				<option value="10"> Oct 
				<option value="11"> Nov 
				<option value="12"> Dec 
                                
                                 </select>
					           <select name="year" id="year">	          			
                               	
				<option value="">-- year --
			
				<option value="1900">1900 
				<option value="1901">1901 
				<option value="1902">1902 
				<option value="1903">1903 
				<option value="1904">1904 
				<option value="1905">1905 
				<option value="1906">1906 
				<option value="1907">1907 
				<option value="1908">1908 
				<option value="1909">1909 
				<option value="1910">1910 
				<option value="1911">1911 
				<option value="1912">1912 
				<option value="1913">1913 
				<option value="1914">1914 
				<option value="1915">1915 
				<option value="1916">1916 
				<option value="1917">1917 
				<option value="1918">1918 
				<option value="1919">1919 
				<option value="1920">1920 
				<option value="1921">1921 
				<option value="1922">1922 
				<option value="1923">1923 
				<option value="1924">1924 
				<option value="1925">1925 
				<option value="1926">1926 
				<option value="1927">1927 
				<option value="1928">1928 
				<option value="1929">1929 
				<option value="1930">1930 
				<option value="1931">1931 
				<option value="1932">1932 
				<option value="1933">1933 
				<option value="1934">1934 
				<option value="1935">1935 
				<option value="1936">1936 
				<option value="1937">1937 
				<option value="1938">1938 
				<option value="1939">1939 
				<option value="1940">1940 
				<option value="1941">1941 
				<option value="1942">1942 
				<option value="1943">1943 
				<option value="1944">1944 
				<option value="1945">1945 
				<option value="1946">1946 
				<option value="1947">1947 
				<option value="1948">1948 
				<option value="1949">1949 
				<option value="1950">1950 
				<option value="1951">1951 
				<option value="1952">1952 
				<option value="1953">1953 
				<option value="1954">1954 
				<option value="1955">1955 
				<option value="1956">1956 
				<option value="1957">1957 
				<option value="1958">1958 
				<option value="1959">1959 
				<option value="1960">1960 
				<option value="1961">1961 
				<option value="1962">1962 
				<option value="1963">1963 
				<option value="1964">1964 
				<option value="1965">1965 
				<option value="1966">1966 
				<option value="1967">1967 
				<option value="1968">1968 
				<option value="1969">1969 
				<option value="1970">1970 
				<option value="1971">1971 
				<option value="1972">1972 
				<option value="1973">1973 
				<option value="1974">1974 
				<option value="1975">1975 
				<option value="1976">1976 
				<option value="1977">1977 
				<option value="1978">1978 
				<option value="1979">1979 
				<option value="1980">1980 
				<option value="1981">1981 
				<option value="1982">1982 
				<option value="1983">1983 
				<option value="1984">1984 
				<option value="1985">1985 
				<option value="1986">1986 
				<option value="1987">1987 
				<option value="1988">1988 
				<option value="1989">1989 
				<option value="1990">1990 
				<option value="1991">1991 
				<option value="1992">1992 
				<option value="1993">1993 
				<option value="1994">1994 
				<option value="1995">1995 
				<option value="1996">1996 
				<option value="1997">1997 
				<option value="1998">1998 
				<option value="1999">1999 
				<option value="2000">2000 
				<option value="2001">2001 
				<option value="2002">2002 
				<option value="2003">2003 
				<option value="2004">2004 
				<option value="2005">2005 
				<option value="2006">2006 
				<option value="2007">2007 
				<option value="2008">2008 
				<option value="2009">2009 
				<option value="2010">2010 
				<option value="2011">2011 
				<option value="2012">2012 
				<option value="2013">2013 
				
					
                
					              </select>
					            </div>
					          </div><!-- /clearfix -->		
                              <div class="clearfix">
					            <label for="normalSelect">5. What is your marital status?</label>
					            <div class="input">
					              <select class="medium" name="mediumSelect" id="mediumSelect">
					                <option value="">- Select -</option>
				
					<option value="6-single"> Single </option>
                
					<option value="4-married"> Married </option>
                
					<option value="1361-married_living_sep"> Married Living Separately </option>
                
					<option value="2477-esi_living_with_partner"> Living With Partner </option>
                
					<option value="5-divorced"> Divorced </option>
                
					<option value="7-widowed"> Widowed </option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->	
                               <div class="clearfix">
					            <label for="normalSelect">6. Are you male or female?</label>
					            <div class="input">
					              <select class="medium" name="mediumSelect" id="mediumSelect">
					                <option value="">- Select -</option>
									<option value="2-male"> Male </option>
									<option value="3-female"> Female </option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->	
                               <div class="clearfix">
					            <label for="normalSelect">7. What is your race or ethnicity? (<a href="#" data-toggle="popover" data-placement="top" data-content="Optional questions do not need to be completed in order to continue." title="Optional Questions">optional</a>)</label>
					            <div class="input">
					              <select class="medium" name="mediumSelect" id="mediumSelect">
					                <option value="">- Select -</option>
				
					<option value="1381-american_indian_native_alaskans"> American Indian or Alaska Native </option>
                
					<option value="1382-asian"> Asian or Asian-American </option>
                
					<option value="1380-african_american"> Black or African-American </option>
                
					<option value="1384-hispanic"> Hispanic, Latino, or Spanish Origin </option>
                
					<option value="1383-pacific_islander"> Native Hawaiian or Other Pacific Islander </option>
                
					<option value="1379-white"> White </option>
                
					<option value="1385-other_race"> Other </option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->		
                              <a  class="btn btn-large  btn-primary ">Clear Responses</a>
							  <Input type="Submit" name="Save"  class="btn btn-large  "  >    
					        </fieldset>
					      </form>
	          </div>
	        </section>
	        <section id="income">
							<div class="body-header-wrapper ">	<h2><i class="icon-money "></i> Income </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
					        <fieldset>
					          <legend>Section summary information goes here. </legend>
					          <div class="clearfix">
					            <label for="xlInput">On a scale of 1 to 5 (1 being the least hard and 5 being the hardest), how hard is it for you to provide for your <a href="#" data-toggle="popover" data-placement="top" data-content="Basic needs are items that you need each day like food, housing, transportation, and medical care." title="Basic Needs">basic needs</a> each month?</label>
					            <div class="input">
					              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="normalSelect">Select</label>
					            <div class="input">
					              <select name="normalSelect" id="normalSelect">
					                <option>1</option>
					                <option>2</option>
					                <option>3</option>
					                <option>4</option>
					                <option>5</option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="normalSelect">Select</label>
					            <div class="input">
					              <select class="medium" name="mediumSelect" id="mediumSelect">
					                <option>1</option>
					                <option>2</option>
					                <option>3</option>
					                <option>4</option>
					                <option>5</option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->
					          <div class="clearfix">
					            <label for="multiSelect">Multiple select</label>
					            <div class="input">
					              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
					                <option>1</option>
					                <option>2</option>
					                <option>3</option>
					                <option>4</option>
					                <option>5</option>
					              </select>
					            </div>
					          </div><!-- /clearfix -->					    
					        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
					      </form>
	          </div>            
	        </section>
	        <section id="employment">  	
							<div class="body-header-wrapper">	<h2><i class="icon-briefcase "></i>  Employment </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>
	          </div>   
	        </section>
            <section id="debt">  	
							<div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i>  Debt and Expenses </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>
	          </div>         
	        </section>
            <section id="housing">  	
							<div class="body-header-wrapper">	<h2><i class="icon-building "></i>  Housing</h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>

	          </div>
	        </section>
	      <section id="mobility">  	
							<div class="body-header-wrapper">	<h2><i class="icon-ambulance "></i>  Mobility </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>
	          </div> 
	        </section>
            <section id="food">  	
							<div class="body-header-wrapper">	<h2><i class="icon-food "></i>  Food </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>
	          </div>
	        </section>
            	 <section id="health">  	
							<div class="body-header-wrapper">	<h2><i class="icon-medkit "></i> Health </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div class="">
							  			
							      </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <form class="well cmxform" id="commentForm" method="get" action="">
						        <fieldset>
						          <legend>Some form fields</legend>
						          <div class="clearfix">
						            <label for="xlInput">Input</label>
						            <div class="input">
						              <input class="xlarge" id="xlInput" name="xlInput" size="30" type="text" />
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select name="normalSelect" id="normalSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="normalSelect">Select</label>
						            <div class="input">
						              <select class="medium" name="mediumSelect" id="mediumSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>
						          <div class="clearfix">
						            <label for="multiSelect">Multiple select</label>
						            <div class="input">
						              <select class="medium" size="5" multiple="multiple" name="multiSelect" id="multiSelect">
						                <option>1</option>
						                <option>2</option>
						                <option>3</option>
						                <option>4</option>
						                <option>5</option>
						              </select>
						            </div>
						          </div>					    
						        <a  class="btn  btn-primary ">Clear Responses</a>
							  <a  class="btn  disabled">Save</a>	    
					        </fieldset>
						      </form>
	          </div>
	        </section>
            	       </div> <!--span7-->
	       <div class="span4">
	         <div class="well sidebar-nav">
		    <ol class="nav nav-list">
                  <li><a class="nav-header" href="#instructions"><i class="icon-book "></i> Instructions </a></li>
		    <li><a href="#basicinfo"><i class="icon-pencil "></i> Basics &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></li>
		    <li><a href="#income"><i class="icon-money "></i> Income &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></i></a></li>
		    <li><a href="#employment"><i class="icon-briefcase "></i> Employment </i></a></li>
                  <li><a href="#debt"><i class="icon-bar-chart "></i> Debt and Expenses </i></a></li>
                  <li><a href="#housing"><i class="icon-building "></i> Housing </i></a></li>
                  <li><a href="#mobility"><i class="icon-ambulance "></i> Mobility </i></a></li>
                  <li><a href="#food"><i class="icon-food "></i> Food </a></li>
                  <li><a href="#health"><i class="icon-medkit "></i> Health </a></li>
		    </ol>			  
	        </div>	         
	       </div> 
	       
       </div><!-- /row -->
    </div> <!-- /container -->
  </body>
</html>