<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>EconomicCheckUp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

		<script src="/cf/bootswatch/bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="/cf/bootswatch/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/jquery.validate.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/bootstrap.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/js/scrolltofixed.js"></script>
    	<script src="/cf/bootswatch/bootstrap/js/application.js"></script>
		
		<cfinclude template="stylesheet_switch.cfm">
		
		<link rel="stylesheet" href="/cf/bootswatch/css/font-awesome.css">
		<link href="/cf/bootswatch/bootstrap/css/style.css" rel="stylesheet">
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
				<img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" />
				</a><br>
		  	</div>
   			<div class="span6"><br /><h4 class="statistics">Since 2010, we have helped seniors living near or in poverty find benefits, jobs, support, and more.</h4><br /></div>
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
					            <label for="xlInput">You will receive the most complete results if you answer all questions.  Click the  <a href="#" class="btn btn-mini btn-info"><i class="icon-question-sign icon-large"></i></a> link if you need help answering a question.  Please do not click your &quot;Back&quot; button while you are answering the questions, as your answers may not be saved.</label>
					          </div><!--- /clearfix --->
	        				</fieldset>
                            </form>
                      </div>
         
            </section>
            
	        <section id="basicinfo"> 
							<div class="body-header-wrapper">	<h2><i class="icon-pencil "></i> Basic Information </h2>	
							  <div class="body-header" >
							    <div class="body-header-inner">
							      <div  id="">
						  			
						      	  </div>
							    </div>
							  </div>
							</div>
						    <div class="">
						      <cfoutput><form class="well cmxform" id="commentForm" method="post" action="styleswitch.cfm?style=#url.style#"></cfoutput>
					        <fieldset>
					          <legend>Section summary information goes here. Need language. </legend>
					          <div class="clearfix">
					            <label for="xlInput">1.  Who are you completing this for?  <a href="#" class="badge badge-info" data-toggle="popover" title="Please Note" data-content="If you are completing this for someone else, please answer all questions as if you are that person.">  <i class="icon-info-sign "></i> </a></label>
					            <div class="input">
					              	<select name="esi_client" id="normalSelect" onChange="var objrow = document.getElementById('p_esi_other_specify'); if (this.selectedIndex == this.options.length - 1) objrow.style.display = ''; else {this.form.esi_other_specify.value = ''; objrow.style.display = 'none';}">
                                        <option value="">-- Select --</option>
                                    
                                        <option value="1353-self"> Self </option>
                                    
                                        <option value="2345-spouse"> Spouse </option>
                                    
                                        <option value="3494-domestic"> Domestic Partner </option>
                                    
                                        <option value="1354-mother"> Mother </option>
                                    
                                        <option value="1355-father"> Father </option>
                                    
                                        <option value="1358-client"> Client </option>
                                    
                                        <option value="1359-test"> Test Case </option>
                                    
                                        <option value="1360-other"> Other </option>
                                    
                                    </select>
                                    
                              	</div>
					          </div><!--- /clearfix --->
					          <div class="clearfix">
					            <label for="normalSelect">2.  What is the main reason you are looking for help?  <a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Even though you may have more than one reason you are looking for help, please choose only the main reason that you need help."><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					              <select name="normalSelect" id="normalSelect">
                                 	<option value="">-- Select --</option>
				
                                    <option value="2585-esi_financial"> I have money concerns </option>
                                
                                    <option value="2586-esi_employment"> I want help finding a job </option>
                                
                                    <option value="2587-esi_legal"> I want help with legal problems </option>
                                
                                    <option value="2588-esi_public_benefits"> I want to find programs to help with everyday costs </option>
                                
                                    <option value="2589-esi_housing"> I want help with housing </option>

                                
                                    <option value="2590-esi_aging_services"> I want information about aging services and providers </option>
                                
                                    <option value="2591-esi_health"> I want information about health care services </option>
                                
                                    <option value="2592-esi_other_reason_help"> Other </option>
                                
                                </select>
					          </div><!--- /clearfix --->
					          <div class="clearfix">
					            <label for="normalSelect">3.  What is your zip code?</label>
					            <div class="input">
					              <input name="zipcode" type="text" class="required" minlength="5" autocomplete="off" data-provide="typeahead"  data-source="'10021','10015','10037','56304','55305','12345','22345','32345','42345','60637','72123','80122','90211'" maxlength="5">
                                </div>
					          </div><!--- /clearfix --->
					          <div class="clearfix">
					            <label for="multiSelect">4.  What is your month and year of birth?</label>
					            <div class="input">
                               	  <select name="month" id="month">
                                	<option value="">-- month --</option>
									<option value="1"> Jan </option>
                                    <option value="2"> Feb </option>
                                    <option value="3"> Mar </option>
                                    <option value="4"> Apr </option>
                                    <option value="5"> May </option>
                                    <option value="6"> Jun </option>
                                    <option value="7"> Jul </option>
                                    <option value="8"> Aug </option>
                                    <option value="9"> Sep </option>
                                    <option value="10"> Oct </option>
                                    <option value="11"> Nov </option>
                                    <option value="12"> Dec </option>
                              	  </select>
					           	  <select name="year" id="year">	          			
                               		<option value="">-- year --</option>
									<option value="1900"> 1900 </option>
                                    <option value="1901"> 1901 </option>
                                    <option value="1902"> 1902 </option>
                                    <option value="1903"> 1903 </option>
                                    <option value="1904"> 1904 </option>
                                    <option value="1905"> 1905 </option>
                                    <option value="1906"> 1906 </option>
                                    <option value="1907"> 1907 </option>
                                    <option value="1908"> 1908 </option>
                                    <option value="1909"> 1909 </option>
                                    <option value="1910"> 1910 </option>
                                    <option value="1911"> 1911 </option>
                                    <option value="1912"> 1912 </option>
                                    <option value="1913"> 1913 </option>
                                    <option value="1914"> 1914 </option>
                                    <option value="1915"> 1915 </option>
                                    <option value="1916"> 1916 </option>
                                    <option value="1917"> 1917 </option>
                                    <option value="1918"> 1918 </option>
                                    <option value="1919"> 1919 </option>
                                    <option value="1920"> 1920 </option>
                                    <option value="1921"> 1921 </option>
                                    <option value="1922"> 1922 </option>
                                    <option value="1923"> 1923 </option>
                                    <option value="1924"> 1924 </option>
                                    <option value="1925"> 1925 </option>
                                    <option value="1926"> 1926 </option>
                                    <option value="1927"> 1927 </option>
                                    <option value="1928"> 1928 </option>
                                    <option value="1929"> 1929 </option>
                                    <option value="1930"> 1930 </option>
                                    <option value="1931"> 1931 </option>
                                    <option value="1932"> 1932 </option>
                                    <option value="1933"> 1933 </option>
                                    <option value="1934"> 1934 </option>
                                    <option value="1935"> 1935 </option>
                                    <option value="1936"> 1936 </option>
                                    <option value="1937"> 1937 </option>
                                    <option value="1938"> 1938 </option>
                                    <option value="1939"> 1939 </option>
                                    <option value="1940"> 1940 </option>
                                    <option value="1941"> 1941 </option>
                                    <option value="1942"> 1942 </option>
                                    <option value="1943"> 1943 </option>
                                    <option value="1944"> 1944 </option>
                                    <option value="1945"> 1945 </option>
                                    <option value="1946"> 1946 </option>
                                    <option value="1947"> 1947 </option>
                                    <option value="1948"> 1948 </option>
                                    <option value="1949"> 1949 </option>
                                    <option value="1950"> 1950 </option>
                                    <option value="1951"> 1951 </option>
                                    <option value="1952"> 1952 </option>
                                    <option value="1953"> 1953 </option>
                                    <option value="1954"> 1954 </option>
                                    <option value="1955"> 1955 </option>
                                    <option value="1956"> 1956 </option>
                                    <option value="1957"> 1957 </option>
                                    <option value="1958"> 1958 </option>
                                    <option value="1959"> 1959 </option>
                                    <option value="1960"> 1960 </option>
                                    <option value="1961"> 1961 </option>
                                    <option value="1962"> 1962 </option>
                                    <option value="1963"> 1963 </option>
                                    <option value="1964"> 1964 </option>
                                    <option value="1965"> 1965 </option>
                                    <option value="1966"> 1966 </option>
                                    <option value="1967"> 1967 </option>
                                    <option value="1968"> 1968 </option>
                                    <option value="1969"> 1969 </option>
                                    <option value="1970"> 1970 </option>
                                    <option value="1971"> 1971 </option>
                                    <option value="1972"> 1972 </option>
                                    <option value="1973"> 1973 </option>
                                    <option value="1974"> 1974 </option>
                                    <option value="1975"> 1975 </option>
                                    <option value="1976"> 1976 </option>
                                    <option value="1977"> 1977 </option>
                                    <option value="1978"> 1978 </option>
                                    <option value="1979"> 1979 </option>
                                    <option value="1980"> 1980 </option>
                                    <option value="1981"> 1981 </option>
                                    <option value="1982"> 1982 </option>
                                    <option value="1983"> 1983 </option>
                                    <option value="1984"> 1984 </option>
                                    <option value="1985"> 1985 </option>
                                    <option value="1986"> 1986 </option>
                                    <option value="1987"> 1987 </option>
                                    <option value="1988"> 1988 </option>
                                    <option value="1989"> 1989 </option>
                                    <option value="1990"> 1990 </option>
                                    <option value="1991"> 1991 </option>
                                    <option value="1992"> 1992 </option>
                                    <option value="1993"> 1993 </option>
                                    <option value="1994"> 1994 </option>
                                    <option value="1995"> 1995 </option>
                                    <option value="1996"> 1996 </option>
                                    <option value="1997"> 1997 </option>
                                    <option value="1998"> 1998 </option>
                                    <option value="1999"> 1999 </option>
                                    <option value="2000"> 2000 </option>
                                    <option value="2001"> 2001 </option>
                                    <option value="2002"> 2002 </option>
                                    <option value="2003"> 2003 </option>
                                    <option value="2004"> 2004 </option>
                                    <option value="2005"> 2005 </option>
                                    <option value="2006"> 2006 </option>
                                    <option value="2007"> 2007 </option>
                                    <option value="2008"> 2008 </option>
                                    <option value="2009"> 2009 </option>
                                    <option value="2010"> 2010 </option>
                                    <option value="2011"> 2011 </option>
                                    <option value="2012"> 2012 </option>
                                    <option value="2013"> 2013 </option>
					              </select>
					            </div>
					          </div><!--- /clearfix --->		
                              <div class="clearfix">
					            <label for="normalSelect">5.  What is your marital status?  <a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Please indicate your current marital status: Single = never married, Married = living as husband and wife, separated, or legally separated (the union must be a legally recognized marriage by the state from which the person is applying for benefits), Married Living Separately = legally married but living in separate households, Living with Partner = sharing a household with partner, Divorced =  having legally dissolved a previous marriage<br>Widowed = man or woman whose spouse has died"><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					              <select class="medium" name="esi_marital" id="mediumSelect">
					                <option value="">-- Select --</option>
                                    <option value="6-single"> Single </option>
                                    <option value="4-married"> Married </option>
                                    <option value="1361-married_living_sep"> Married Living Separately </option>
                                    <option value="2477-esi_living_with_partner"> Living With Partner </option>
                                    <option value="5-divorced"> Divorced </option>
                                    <option value="7-widowed"> Widowed </option>
								  </select>
					            </div>
					          </div><!--- /clearfix --->	
                               <div class="clearfix">
					            <label for="normalSelect">6.  Are you male or female? (<a href="#" data-toggle="popover" data-placement="top" data-content="Optional questions do not need to be completed in order to continue." title="Optional Questions">optional</a>)</label>
					            <div class="input">
					              <select class="medium" name="esi_gender" id="mediumSelect">
					                <option value="">-- Select --</option>
									<option value="2-male"> Male </option>
									<option value="3-female"> Female </option>
					              </select>
					            </div>
					          </div><!--- /clearfix --->	
                               <div class="clearfix">
					            <label for="normalSelect">7.  What is your race or ethnicity? (<a href="#" data-toggle="popover" data-placement="top" data-content="Optional questions do not need to be completed in order to continue." title="Optional Questions">optional</a>)  <a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Please select the option that best fits your race or ethnicity.  If your race or ethnicity is not listed, please select 'Other.'"><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					              <select class="medium" name="esi_ethnicity" id="mediumSelect">
					                <option value="">-- Select --</option>
									<option value="1381-american_indian_native_alaskans"> American Indian or Alaska Native </option>
                					<option value="1382-asian"> Asian or Asian-American </option>
                                    <option value="1380-african_american"> Black or African-American </option>
                                    <option value="1384-hispanic"> Hispanic, Latino, or Spanish Origin </option>
                                    <option value="1383-pacific_islander"> Native Hawaiian or Other Pacific Islander </option>
                                    <option value="1379-white"> White </option>
                                    <option value="1385-other_race"> Other </option>
					              </select>
					            </div>
					          </div><!--- /clearfix --->		
                              <a class="btn btn-large">Clear Responses</a><!--- Show only if data was input in this section beyond each section question's default --->
							  <button id="fat-btn"  class="btn btn-large btn-primary" data-loading-text="Saving...">Save</button> <!--- Always Show --->    
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
					          <legend>Section summary information goes here. Need language.</legend>
					          <div class="clearfix">
					            <label for="xlInput">8.  On a scale of 1 to 5 (1 being the least hard and 5 being the hardest), how hard is it for you to provide for your <a href="#" data-toggle="popover" data-placement="top" data-content="Basic needs are items that you need each day like food, housing, transportation, and medical care." title="Basic Needs">basic needs</a> each month?  <a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Choose the best option that describes how well each month you are able to meet your basic needs such as food, housing, transportation, and medical care. 1 is the least hard and 5 is the most hard."><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					                  <div class="btn-group" data-toggle="buttons-radio">
                                        <label class="radio"><input type="radio" value="1"/>It is not hard for me</label>
                                        <label class="radio"><input type="radio" value="2"/>Sometimes it is hard for me</label> 
                                        <label class="radio"><input type="radio" value="3"/>I get by, but it is hard each month</label> 																	   										<label class="radio"><input type="radio" value="4"/>I cannot get by on my own, I need help each month</label>
                                        <label class="radio"><input type="radio" value="5"/>I cannot meet my basic needs each month even with help</label>
                                   	  </div>
					            </div>
					          </div><!--- /clearfix --->
                              <div class="clearfix">
					            <label for="normalSelect">9.  Please enter your current <a href="#" data-toggle="popover" data-placement="top" data-content="Your gross income is the amount you get before anything is taken out like taxes." title="Gross Income">gross</a> monthly income in the "Self" column below. If married or living with partner, enter your spouse's/partner's income in the "Spouse/Partner" column. If you have income in both your and your spouse's/partner's name, enter it in the "Joint" column. Enter the income of any other people living in your <a href="#" data-toggle="popover" data-placement="top" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." title="Household">household</a> in the "Household" column.  

<a href="#" class="btn btn-mini btn-info" data-toggle="popover" title="Help" data-content="Income is payment you get. For example, this could be money you earn from your job or interest that is paid on your savings account. If you get other income two to four times a year, instead of each month, you need to estimate what the payment would be each month."><i class="icon-question-sign icon-large"></i></a></label>
					            <div class="input">
					              
					            </div>
					          </div><!--- /clearfix --->
					          <a class="btn btn-large">Clear Responses</a><!--- Show only if data was input in this section beyond each section question's default --->
							  <a  class="btn btn-large btn-primary">Save</a> <!--- Always Show --->  	    
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
           	      <div class="well sidebar-nav" >
                    <legend><i class="icon-list-alt "></i> Completion Status</legend>
                    <ol class="nav nav-list">
                        
                        <li><a href="#basicinfo"><i class="icon-pencil "></i> Basics &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></li>
                        <li><a href="#income"><i class="icon-money "></i> Income &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></i></a></li>
                        <li><a href="#employment"><i class="icon-briefcase "></i> Employment </i></a></li>
                      	<li><a href="#debt"><i class="icon-bar-chart "></i> Debt and Expenses </i></a></li>
                      	<li><a href="#housing"><i class="icon-building "></i> Housing </i></a></li>
                      	<li><a href="#mobility"><i class="icon-ambulance "></i> Mobility </i></a></li>
                      	<li><a href="#food"><i class="icon-food "></i> Food </a></li>
                      	<li><a href="#health"><i class="icon-medkit "></i> Health </a></li>
				
		     </ol>
			   <legend><i class="icon-file-alt "></i> Resources</legend>
		     <ul class="nav-list">
                        <li><a href="#printablequestions" role="button" data-toggle="modal"><i class="icon-print "></i>Printable Version</a></li>
			   <li><a href="#detailedinstructions" role="button" data-toggle="modal"><i class="icon-book "></i> Instructions </a></li>
                   </ul>			  
	           </div>	         
	       </div> 
<!-- Modal printable questions -->
<div id="printablequestions" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3 id="myModalLabel">Printable Questionnaire</h3>
  </div>
  <div class="modal-body">
    <p>Include Printable PDF here.</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary">Save changes</button>
  </div>
</div>
<!-- Modal Instruction details -->
<div id="detailedinstructions" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3 id="myModalLabel">Filling Out. The Questionnaire.</h3>
  </div>
  <div class="modal-body">
    <p>Instructions. body text.</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary">Save changes</button>
  </div>
</div>
       </div><!-- /row -->
    </div> <!-- /container -->
  </body>
</html>