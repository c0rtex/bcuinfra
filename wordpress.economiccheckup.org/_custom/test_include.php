<div class="span8">  
	<section id="instructions">  	
        <div class="body-header-wrapper">	<h2><i class="icon-book "></i> Instructions </h2>	
            <div class="body-header" style="z-index: 999; position: static; top: 251.5px;">
                <div class="body-header-inner">
                    <div class="">
                            
                    </div>
                </div>
            </div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
            <h4></h4>
          
        </div>
        <div class="">
            <form class="whitewell">
                <fieldset>
                    <legend>Completing the Questionnaire....</legend>
                    <div class="clearfix">
                        <label for="xlInput">You will receive the most complete results if you answer all questions.  Click the  <a class="btn btn-mini btn-info" href="#"><i class="icon-question-sign icon-large"></i></a> link if you need help answering a question.  Please do not click your "Back" button while you are answering the questions, as your answers may not be saved.</label>
                    </div>
                </fieldset>
            </form>
        </div>
    </section>
    <section id="basicinfo"> 
        <div class="body-header-wrapper">	<h2><i class="icon-pencil "></i> Basic Information </h2>	
          <div class="body-header" style="z-index: 999; position: static; top: 505px;">
            <div class="body-header-inner">
              <div id="">
                
              </div>
            </div>
          </div><div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
          	<form action="styleswitch.cfm?style=esi" method="post" id="commentForm" class="well cmxform" novalidate="novalidate">
				<fieldset>
					<legend>Section summary information goes here. Need language. </legend>
					<div class="clearfix">
                    	<div class="row-fluid">
                        	<div class="span1">1.</div>
                            <div class="span11">
					   			<label for="xlInput">Who are you completing this for?  <a data-content="If you are completing this for someone else, please answer all questions as if you are that person." title="" data-toggle="popover" class="badge badge-info" href="#" data-original-title="Please Note">  <i class="icon-info-sign "> INFO </i> </a></label>
                                <div class="input">
                                    <select onChange="var objrow = document.getElementById('p_esi_other_specify'); if (this.selectedIndex == this.options.length - 1) objrow.style.display = ''; else {this.form.esi_other_specify.value = ''; objrow.style.display = 'none';}" id="normalSelect" name="esi_client">
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
                         	</div>
                       	</div>
                   	</div>
					<div class="clearfix">
						<div class="row-fluid">
                        	<div class="span1">2.</div>
                            <div class="span11">
					   			<label for="normalSelect">What is the main reason you are looking for help?  <a data-content="Even though you may have more than one reason you are looking for help, please choose only the main reason that you need help." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"> HELP </i></a></label>
                                <div class="input">
                                    <select id="normalSelect" name="normalSelect">
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
                                </div>
                        	</div>
                    	</div>
                    	<div class="clearfix">
                        	<div class="row-fluid">
                            	<div class="span1">3.</div>
                                <div class="span11">					      	
                                	<label for="normalSelect">What is your zip code?</label>
                                    <div class="input">
                                        <input type="text" maxlength="5" data-source="'10021','10015','10037','56304','55305','12345','22345','32345','42345','60637','72123','80122','90211'" data-provide="typeahead" autocomplete="off" minlength="5" class="required" name="zipcode">
                                    </div>
                            	</div>
                          	</div>
						</div>
					   	<div class="clearfix">
					       	<label for="multiSelect"><strong>4.</strong>   What is your month and year of birth?</label>
					       	<div class="input">
                               	<select id="month" name="month">
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
					         	<select id="year" name="year">	          			
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
                      	</div>		
                      	<div class="clearfix">
					      	<label for="normalSelect"><strong>5.</strong>   What is your marital status?  <a data-content="Please indicate your current marital status: Single = never married, Married = living as husband and wife, separated, or legally separated (the union must be a legally recognized marriage by the state from which the person is applying for benefits), Married Living Separately = legally married but living in separate households, Living with Partner = sharing a household with partner, Divorced =  having legally dissolved a previous marriage&lt;br&gt;Widowed = man or woman whose spouse has died" title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
					      	<div class="input">
					     		<select id="mediumSelect" name="esi_marital" class="medium">
					             	<option value="">-- Select --</option>
                                    <option value="6-single"> Single </option>
                                    <option value="4-married"> Married </option>
                                    <option value="1361-married_living_sep"> Married Living Separately </option>
                                    <option value="2477-esi_living_with_partner"> Living With Partner </option>
                                    <option value="5-divorced"> Divorced </option>
                                    <option value="7-widowed"> Widowed </option>
								</select>
					      	</div>
					  	</div>	
                        <div class="clearfix">
					    	<label for="normalSelect"><strong>6.</strong>   Are you male or female? (<a title="" data-content="Optional questions do not need to be completed in order to continue." data-placement="top" data-toggle="popover" href="#" data-original-title="Optional Questions">optional</a>)</label>
					      	<div class="input">
					        	<select id="mediumSelect" name="esi_gender" class="medium">
					            	<option value="">-- Select --</option>
									<option value="2-male"> Male </option>
									<option value="3-female"> Female </option>
					           	</select>
					      	</div>
					  	</div>	
                        <div class="clearfix">
					    	<label for="normalSelect"><strong>7.</strong>   What is your race or ethnicity? (<a title="" data-content="Optional questions do not need to be completed in order to continue." data-placement="top" data-toggle="popover" href="#" data-original-title="Optional Questions">optional</a>)  <a data-content="Please select the option that best fits your race or ethnicity.  If your race or ethnicity is not listed, please select 'Other.'" title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
					        <div class="input">
					        	<select id="mediumSelect" name="esi_ethnicity" class="medium">
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
					  	</div>		
                        <a class="btn">Clear Responses</a>
						<button data-loading-text="Saving..." class="btn btn-primary" id="fat-btn">Save</button>     
					</div>
             	</fieldset>
			</form>
	  	</div>
	</section>
	<section id="income">
        <div class="body-header-wrapper ">	<h2><i class="icon-money "></i> Income </h2>	
          	<div class="body-header" style="z-index: 999; position: static; top: 1287px;">
            	<div class="body-header-inner">
              		<div class="">
                    
              		</div>
            	</div>
          	</div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
          	<form action="" method="get" id="commentForm" class="well cmxform">
            	<fieldset>
              		<legend>Section summary information goes here. Need language.</legend>
              		<div class="clearfix">
                		<label for="xlInput"><strong>8.</strong>   On a scale of 1 to 5 (1 being the least hard and 5 being the hardest), how hard is it for you to provide for your <a title="" data-content="Basic needs are items that you need each day like food, housing, transportation, and medical care." data-placement="top" data-toggle="popover" href="#" data-original-title="Basic Needs">basic needs</a> each month?  <a data-content="Choose the best option that describes how well each month you are able to meet your basic needs such as food, housing, transportation, and medical care. 1 is the least hard and 5 is the most hard." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                        <div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input type="radio" value="1">It is not hard for me</label>
                                <label class="radio"><input type="radio" value="2">Sometimes it is hard for me</label> 
                                <label class="radio"><input type="radio" value="3">I get by, but it is hard each month</label> 																	   									<label class="radio"><input type="radio" value="4">I cannot get by on my own, I need help each month</label>
                                <label class="radio"><input type="radio" value="5">I cannot meet my basic needs each month even with help</label>
                    		</div>
                		</div>
              		</div>
              		<div class="clearfix">
                		<label for="normalSelect"><strong>9.</strong>   Please enter your current <a title="" data-content="Your gross income is the amount you get before anything is taken out like taxes." data-placement="top" data-toggle="popover" href="#" data-original-title="Gross Income">gross</a> monthly income in the "Self" column below. If married or living with partner, enter your spouse's/partner's income in the "Spouse/Partner" column. If you have income in both your and your spouse's/partner's name, enter it in the "Joint" column. Enter the income of any other people living in your <a title="" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." data-placement="top" data-toggle="popover" href="#" data-original-title="Household">household</a> in the "Household" column.  

<a data-content="Income is payment you get. For example, this could be money you earn from your job or interest that is paid on your savings account. If you get other income two to four times a year, instead of each month, you need to estimate what the payment would be each month." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                		<div class="input">
                        	<!--- start income grid --->
                  			<div class="row-fluid">
                            	<div class="span4">&nbsp;</div>
                                <div class="span2" id="incomegrid"><strong>Self</strong></div>
                 				<div class="span2" id="incomegrid"><strong>Spouse/<BR />Partner</strong></div>
                    			<div class="span2" id="incomegrid"><strong>Joint</strong></div>
                 				<div class="span2" id="incomegrid"><a title="" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." data-placement="top" data-toggle="popover" href="#" data-original-title="Household"><strong>Household</strong></a></div>
							</div>
                            <div class="row-fluid">
                            	<div class="span4">Pension/Retirement Benefits</div>
								<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_pri_retire" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
				 				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_pri_retire" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                			<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_pri_retire_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_pri_retire_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
							</div>
                            <div class="row-fluid">
                            	<div class="span4">Dividends/Interest</div>
								<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_dividends" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_dividends" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_dividends_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_dividends_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                			</div>
							<div class="row-fluid">
                            	<div class="span4">Supplemental Security Income</div>
                            	<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_ssi" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_ssi" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>	
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_ssi_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_ssi_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
							<div class="row-fluid">
                            	<div class="span4">Social Security Disability</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_ss_disable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_ss_disable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_ss_disable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_ss_disable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                        	</div>
                			<div class="row-fluid">
                            	<div class="span4">Social Security Retirement/Survivor Benefits</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_ss_retire" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               	<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_ss_retire" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                              	<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_ss_retire_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                              	<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_ss_retire_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                            </div>
                            <div class="row-fluid">
                                <div class="span4">Railroad Retirements Benefits</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_rr_ben" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_rr_ben" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_rr_ben_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_rr_ben_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                            </div>
                            <div class="row-fluid">
                                <div class="span4">Veteran's Benefits</div>
				 				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_vet_ben" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_vet_ben" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_vet_ben_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_vet_ben_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                         	</div>
                            <div class="row-fluid">
                                <div class="span4">Unemployment Insurance</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_unemployment" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_unemployment" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_unemployment_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_unemployment_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
                            <div class="row-fluid">
                                <div class="span4">Worker's Compensation</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_unemploy" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_unemploy" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_unemploy_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_unemploy_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                      		</div>
                            <div class="row-fluid">
                                <div class="span4"><a title="" data-content="Temporary Assistance to Needy Families" data-placement="top" data-toggle="popover" href="#" data-original-title="TANF">TANF</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_tanf" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_tanf" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_tanf_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_tanf_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                         	</div>
                            <div class="row-fluid">
                                <div class="span4"><a title="" data-content="Include programs such as: Public Assistance, General Assistance, or any other state income assistance program." data-placement="top" data-toggle="popover" href="#" data-original-title="Cash Assistance">Cash Assistance</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_cash_assist" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_cash_assist" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_cash_assist_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_cash_assist_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
							<div class="row-fluid">
                                <div class="span4"><a title="" data-content="Include all other income not included above such as: private disability insurance benefits, union benefits, rental or boarder income, alimony, black lung benefits, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Other Non-Work Income">Other Non-Work Income</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_other_nw" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_other_nw" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_other_nw_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_other_nw_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                      		</div>
                            <div class="row-fluid">
                                <div class="span4">Work Income</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_income_earned" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_income_earned" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_income_earned_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_income_earned_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                			</div>
							<!--- end income grid --->
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="normalSelect"><strong>10.</strong>   Please enter the value of your <a title="" data-content="Assets are items that you own that have value. These items may be turned into cash, such as when you sell your home, car or other property." data-placement="top" data-toggle="popover" href="#" data-original-title="Assets">assets</a> in the "Self" column below. If married or living with partner, enter your spouse's/partner's assets  in the "Spouse/Partner" column. These are assets that your spouse/partner owns separately from your assets. If your assets are owned in both you and your spouse's/partner's name, enter them in the "Joint" column.  Enter assets of any other people living in your <a title="" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." data-placement="top" data-toggle="popover" href="#" data-original-title="Household">household</a> in the "Household" column.<br>
<br>
<b>Please Note:</b> If you do not know the exact amount of your assets, please estimate the amount. Don't worry if you don't know all the answers. Just fill in the information you have now and then click on submit. <a data-content="Assets include items such as cash, stocks, bonds, and IRAs. It also includes property such as cars and homes that can be turned into cash." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                		<div class="input">
                        	<!--- start asset grid --->
                  			<div class="row-fluid">
                            	<div class="span4">&nbsp;</div>
                                <div class="span2" id="incomegrid"><strong>Self</strong></div>
                 				<div class="span2" id="incomegrid"><strong>Spouse/<BR />Partner</strong></div>
                    			<div class="span2" id="incomegrid"><strong>Joint</strong></div>
                 				<div class="span2" id="incomegrid"><a title="" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." data-placement="top" data-toggle="popover" href="#" data-original-title="Household"><strong>Household</strong></a></div>
							</div>
                            <div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Include all cash, bank accounts, checking accounts, savings accounts, credit union accounts, certificates of deposit, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Cash/Cash Equivalent">Cash/Cash Equivalent</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_cash" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_cash" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_cash_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_cash_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                        	</div>
                			<div class="row-fluid">
                            	<div class="span4"><a title="" data-content="If this is your only vehicle, enter the Blue Book value of your vehicle in this row.  If you have more than one vehicle, enter the Blue Book value of your most valuable vehicle in this row.  If you don&rsquo;t know the Blue Book value of your car, you can go to www.kbb.com to find out.  You should also feel free to estimate, if necessary." data-placement="top" data-toggle="popover" href="#" data-original-title="Automobile">Automobile</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_auto1" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_auto1" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_auto1_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_auto1_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                           	</div>
                            <div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Indicate value of second car in family, if any." data-placement="top" data-toggle="popover" href="#" data-original-title="Automobile: Vehicle 2">Automobile: Vehicle 2</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_auto2" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_auto2" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_auto2_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                               <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_auto2_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                       		</div>
                			<div class="row-fluid">
                            	<div class="span4">Value of Home</div>
								<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_home" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_home" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_home_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_home_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
                            <div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Include IRA, 401K, Keogh, and any other retirement accounts." data-placement="top" data-toggle="popover" href="#" data-original-title="Retirement Accounts">Retirement Accounts</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_retirement" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_retirement" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_retirement_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_retirement_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
          					<div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Include any investment accounts such as stocks, bonds, savings bonds, annuities, mutual funds, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Investment Accounts">Investment Accounts</a></div>
				 				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_stocks" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_stocks" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_stocks_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_stocks_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                       		</div>
							<div class="row-fluid">
                            	<div class="span4">Life Insurance: Cash Value</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_life_cash" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_life_cash" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_life_cash_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                				<div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_life_cash_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                           	</div>
                            <div class="row-fluid">
                            	<div class="span4">Life Insurance: Face Value</div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_life_face" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_life_face" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_life_face_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_life_face_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                           	</div>
                			<div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Some life insurance policies include an allotment for burial expenses. A revocable burial account means you can draw that money out of your policy during your lifetime from the burial expenses allotments.  The insurance company that issued the life insurance policy can provide the amount set aside for burial expenses." data-placement="top" data-toggle="popover" href="#" data-original-title="Revocable Burial Account">Burial Accounts: Revocable</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_revocable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_revocable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_revocable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_revocable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                         	</div>
                      		<div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Some life insurance policies include an allotment for burial expenses. An irrevocable burial account means you cannot draw that money out of your policy during your lifetime from the burial expenses allotments." data-placement="top" data-toggle="popover" href="#" data-original-title="Irrevocable Burial Account">Burial Accounts: Irrevocable</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_irrevocable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_irrevocable" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_irrevocable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_irrevocable_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                          	</div>
                            <div class="row-fluid">
                            	<div class="span4"><a title="" data-content="Include any other assets not listed above such as: other real estate or properties, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Other Assets">Other Assets</a></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_asset_other_a" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="sp_asset_other_a" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="s_sp_asset_other_a_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                                <div class="span2" id="incomegrid"><input class="grid_input" type="text" name="hh_asset_other_a_simple" value="" size="9" maxlength="8" onBlur="chkDollar(this,value);"></div>
                           	</div>
          					<!--- end ASSET grid --->
                		</div>
              		</div>
                    <div class="clearfix">
					  	<label for="normalSelect"><strong>11.</strong>   Including yourself and your spouse (if married), how many people live in your household AND depend on your income for support?  <a data-content="When answering this question, it is very important to include all members of your household (including your spouse) who depend on your income.<br><br>The income guidelines for certain programs and services may be based on the number of people in your household who depend on your income." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                       	<div class="span1">
                        	<div class="input">
                          		<input type="text" name="esi_incomesupport" maxlength="2" class="grid_input" data-source="" data-provide="typeahead" autocomplete="off" class="required">
                          	</div>
                        </div>
                        <div class="span11">
                        
                        </div>
					</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>12.</strong>   Do you have any  <a title="" data-content="A dependent is a person who relies on you for financial support. If you are able to claim a dependent on a tax return, you may get tax-related benefits. However, to claim a dependent, they must meet certain guidelines by the IRS." data-placement="top" data-toggle="popover" href="#" data-original-title="Dependent">dependents</a>  that you claim on your federal income tax return?  <a data-content="To claim a dependent on your federal tax return, you must meet certain guidelines set by the IRS. These guidelines determine who qualifies as a dependent such as a child or other relative.  If you can claim dependents, it can lower the amount of tax you pay." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="radio_yes_esi_dependants" type="radio" name="esi_dependants" value="y">Yes</label>
                                <label class="radio"><input id="radio_no_esi_dependants" type="radio" name="esi_dependants" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>13.</strong>   If you answered 'yes' that you claim <a title="" data-content="A dependent is a person who relies on you for financial support. If you are able to claim a dependent on a tax return, you may get tax-related benefits. However, to claim a dependent, they must meet certain guidelines by the IRS." data-placement="top" data-toggle="popover" href="#" data-original-title="Dependent">dependents</a> on your federal income tax return, who are they? (check all that apply)</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="checkbox"><input type="checkbox" name="esi_dependspouse" id="esi_dependspouse" value="y">Spouse</label>
                                <label class="checkbox"><input type="checkbox" name="esi_dependpartner" id="esi_dependpartner" value="y"><a title="" data-content="A partner is a girlfriend or boyfriend that lives in your home (also known as a domestic partner)." data-placement="top" data-toggle="popover" href="#" data-original-title="Partner">Partner</a></label>
                                <label class="checkbox"><input type="checkbox" name="esi_dependadultchild" id="esi_dependadultchild" value="y"><a title="" data-content="An adult child is a person between the ages of 19-24 who is a full-time student for at least 5 months out of the year.  If your adult child has a disability, there is no age guideline." data-placement="top" data-toggle="popover" href="#" data-original-title="Adult Child">Adult Child</a></label>
                                <label class="checkbox"><input type="checkbox" name="esi_dependgrandchild" id="esi_dependgrandchild" value="y">Child/Grandchild (18 years of age and under)</label>
                              	<label class="checkbox"><input type="checkbox" name="esi_dependotherrelative" id="esi_dependotherrelative" value="y">Other Relative</label>
								<label class="checkbox"><input type="checkbox" name="esi_dependfriend" id="esi_dependfriend" value="y">Friend</label>
                        	</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>14.</strong>   Do you and your spouse (if married) get any of the following public benefits? (choose all that apply)</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="checkbox"><input type="checkbox" name="receive_msp" id="receive_msp" value="y"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="Medicare Savings Programs">Medicare Savings Programs</a> (QMB, SLMB, or QI-1)</label>
                                <label class="checkbox"><input type="checkbox" name="receive_lis" id="receive_lis" value="y"><a title="" data-content="If you have Medicare and have limited income and resources, you can get Extra Help through the Medicare Prescription Drug Coverage.  Extra Help will cover between 85 percent and 100 percent of your prescription drug costs." data-placement="top" data-toggle="popover" href="#" data-original-title="Extra Help">Extra Help/LIS through Medicare Prescription Drug Coverage</a></label>
                                <label class="checkbox"><input type="checkbox" name="fdstmp_receive" id="fdstmp_receive" value="y"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="SNAP">Supplemental Nutrition Assistance Program (SNAP)</a></label>
                                <label class="checkbox"><input type="checkbox" name="liheap_receive" id="liheap_receive" value="y"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="LIHEAP">Low Income Home Energy Assistance Program</a> (<A HREF="javascript:help2('frmOtherHelp.cfm?keyword=LIHEAP&type=NavTip')" id="liheap_link">LIHEAP</a>)</label>
                              	<label class="checkbox"><input type="checkbox" name="med_receive" id="med_receive" value="y"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="Medicaid">Medicaid</a></label>
								<label class="checkbox"><input type="checkbox" name="receive_propertytax" id="receive_propertytax" value="y">
<a title="" data-content="You can get property tax relief assistance from programs such as: 
- Circuit Breaker or Property Tax Exemption
- Property Tax Deferral or Abatement
- Property Tax Credit, Rebate, and Refund
- Property Tax Freeze
- Installment and Tax Workoff
" data-placement="top" data-toggle="popover" href="#" data-original-title="Property Tax Relief">Property Tax Relief</a>
</label>
                        	</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>15.</strong>   If you answered yes to getting public benefits, please enter the <b>monthly</b> amount(s) for the program you get help from. <i>If you do not have exact numbers or if the amount you get is different each month, please give an estimate.  If you cannot estimate the amount, please enter 0.</i></label>
                       <div class="row-fluid">
                        	<div class="span6 input">
					<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" maxwidth="5" id="receive_msp_amount" id="appendedPrependedInput" name="receive_msp_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="Medicare Savings Programs">Medicare Savings Programs</a> (QMB, SLMB, or QI-1)</label>
                            </div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="receive_lis_amount" name="receive_lis_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="If you have Medicare and have limited income and resources, you can get Extra Help through the Medicare Prescription Drug Coverage.  Extra Help will cover between 85 percent and 100 percent of your prescription drug costs." data-placement="top" data-toggle="popover" href="#" data-original-title="Extra Help">Extra Help/LIS through Medicare Prescription Drug Coverage</a></label>
                          	</div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="receive_snap_amount" name="receive_snap_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="SNAP">Supplemental Nutrition Assistance Program (SNAP)</a></label>
                          	</div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="receive_liheap_amount" name="receive_liheap_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="LIHEAP">Low Income Home Energy Assistance Program</a> (<A HREF="javascript:help2('frmOtherHelp.cfm?keyword=LIHEAP&type=NavTip')" id="liheap_link">LIHEAP</a>)</label>
                          	</div>
                   	   </div>
                 		<div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="receive_medicaid_amount" name="receive_medicaid_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
							</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Placeholder text. Need language recommendation." data-placement="top" data-toggle="popover" href="#" data-original-title="Medicaid">Medicaid</a></label>
							</div>
                   		</div>
                 		<div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="receive_property_tax_amount" name="receive_property_tax_amount" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
							</div>
                            <div class="span6">
                            <label for="normalSelect"><a title="" data-content="You can get property tax relief assistance from programs such as:
<ul>
<li>Circuit Breaker or Property Tax Exemption</li>
<li>Property Tax Deferral or Abatement</li>
<li>Property Tax Credit, Rebate, and Refund</li>
<li>Property Tax Freeze</li>
<li>Installment and Tax Workoff</li></ul>" data-placement="top" data-toggle="popover" href="#" data-original-title="Property Tax Relief">Property Tax Relief</a>
</label>
							</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>16.</strong>   Do you want information on senior tax deductions or assistance in getting free tax filing assistance?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="" type="radio" name="" value="y">Yes</label>
                                <label class="radio"><input id="" type="radio" name="" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <a class="btn">Clear Responses</a>
                	<a class="btn btn-primary">Save</a>   	    
            	</fieldset>
          	</form>
		</div>            
	</section>
    <section id="employment">  	
        <div class="body-header-wrapper">	<h2><i class="icon-briefcase "></i>  Employment and Training </h2>	
          	<div class="body-header" style="z-index: 999; position: static; top: 1811.5px;">
            	<div class="body-header-inner">
              		<div class="">
                    
              		</div>
            	</div>
          	</div><div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="">
          	<form action="" method="get" id="commentForm" class="well cmxform">
            	<fieldset>
              		<legend>Section summary information goes here. Need language.</legend>
              		<div class="clearfix">
                    	<label for="normalSelect"><strong>17.</strong>   What is your current work status?  <a data-content="Please choose the best option for your current work status:<br>
- Retired = once worked, but no longer working or no longer wish to work;<br>
- Employed = currently working;<br>
- Unemployed = not employed right now and seeking work;<br>
- Underemployed = your job is not meeting your needs. This may be because you have a part-time job when you need or want a full-time job. Or because you have more education, experience, and skills than your job requires." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                    	<div class="input">
                        	<select id="select_esi_employmentsituation_list" name="esi_employmentsituation_list">
                                <option value="">- Select -</option>
                            
                                <option value="2482-esi_employmentsituation_retired"> Retired </option>
                            
                                <option value="2483-esi_employmentsituation_employed"> Employed </option>
                            
                                <option value="2484-esi_employmentsituation_seeking"> Unemployed </option>
                            
                                <option value="2485-esi_employmentsituation_underemp"> Underemployed </option>
                            
                                <option value="2486-esi_employmentsituation_none"> None of the above </option>
                            
                            </select>
                      	</div>
                  	</div>
                  	<div class="clearfix">
                		<label for="xlInput"><strong>18.</strong>   If you are looking for a job, what kind of help do you need? (check all that apply)</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                            	<label class="checkbox"><input type="checkbox" name="esi_seekingemployment_usehelp" id="esi_seekingemployment_usehelp" value="y">I need help with the job search.</label>
                		<label class="checkbox"><input type="checkbox" name="esi_seekingemployment_refresher" id="esi_seekingemployment_refresher" value="y">I need help with my job skills and would like to take an online class.</label>
                        <label class="checkbox"><input type="checkbox" name="esi_seekingemployment_skillsassessment" id="esi_seekingemployment_skillsassessment" value="y">I need help matching my skills with jobs that I can apply for.</label>
                            </div>
                   		</div>
                 	</div>					    
                	<a class="btn  btn-primary ">Clear Responses</a>
              		<a class="btn  disabled">Save</a>	    
            	</fieldset>
          	</form>
      	</div>   
    </section>
    <section id="debt">  	
      	<div class="body-header-wrapper">	<h2><i class="icon-bar-chart "></i>  Debt and Money Management </h2>	
        	<div class="body-header" style="z-index: 999; position: static; top: 2393px;">
             	<div class="body-header-inner">
                	<div class="">
                            
                    </div>
               	</div>
          	</div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
     	</div>
        <div class="">
          	<form action="" method="get" id="commentForm" class="well cmxform">
            	<fieldset>
              		<legend>Section summary information goes here. Need language.</legend>
              		<div class="clearfix">
                		<label for="xlInput"><strong>19.</strong>   Please enter your current <b>monthly</b> <a title="" data-content="A household is a single person or a group of people who live together and typically buy food and prepare meals together to eat at home.  In addition, household members do not have to be related to each other.  Married couples who live together and adult children (under a certain age) who live with a parent, are considered part of the same household, even if they do not prepare meals together.  Other people who live together (such as an elderly parent, 60 years of age or older, or a person with a disability) and who do not buy and prepare food together, are not a household.  They will be considered to be separate households." data-placement="top" data-toggle="popover" href="#" data-original-title="Household">household</a> expenses below.  If you do not have exact numbers or if the amount you get is different each month, please give an estimate.</label>
                       <div class="row-fluid">
                        	<div class="span6 input">
					<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_outofpocket" name="esi_outofpocket" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Money that you spend on heating fuel, gas, electricity, water, telephone, and rent or mortgage payments." data-placement="top" data-toggle="popover" href="#" data-original-title="Housing Expenses">Housing</a></label>
                            </div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_food" name="esi_food" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Money that you spend on groceries, eating out, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Food Expenses">Food</a></label>
                          	</div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_healthmonthly" name="esi_healthmonthly" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Money that you spend on medical costs that are not paid for by health insurance. For example, what you pay for prescription drugs, doctor&rsquo;s costs, co-payments, transportation to doctor's visits, home health care costs, health insurance costs, and medical equipment." data-placement="top" data-toggle="popover" href="#" data-original-title="Health Expenses">Health</a></label>
                          	</div>
                        </div>
                        <div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_transportation" name="esi_transportation" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
                           	</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Money that you spend on gas, buses, subways, taxis, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Transportation Expenses">Transportation</a></label>
                          	</div>
                   	   </div>
                 		<div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_other_expenses" name="esi_other_expenses" value="" maxlength="5" size="6" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
							</div>
                            <div class="span6">
                            	<label for="normalSelect"><a title="" data-content="Include any other monthly expenses you have. Examples would be senior center membership costs, money you give to charities, newspaper/magazine costs, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Other Monthly Expenses">Other Monthly Expenses</a></label>
							</div>
                   		</div>
                 		<div class="row-fluid">
                        	<div class="span6 input">
                            	<div class="input-prepend input-append"><label for="normalSelect"><span class="add-on">$</span><input type="text" id="esi_debtestimate" name="esi_debtestimate" value="" maxlength="7" size="8" onBlur="chkDollar(this,value);"><span class="add-on">.00</span></label></div>
							</div>
                            <div class="span6">
                            <label for="normalSelect"><a title="" data-content="Money you spend paying off credit cards, car loans, personal loans, etc." data-placement="top" data-toggle="popover" href="#" data-original-title="Debt Payments">Debt Payments</a></label>
							</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>20.</strong>   If you are having trouble paying your monthly expenses, which of the items below describes your situation? (check all that apply) </label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                            	<label class="checkbox"><input type="checkbox" name="esi_debtscenarios_creditlimit" id="esi_debtscenarios_creditlimit" value="y">I am near or at the limit of my <a title="" data-content="A line of credit is money that the bank loans you. It is an account that you can use when you need money. You only pay interest on the amount of money you take out of the account. There may be other costs you will need to pay for this kind of account." data-placement="top" data-toggle="popover" href="#" data-original-title="Line of Credit">lines of credit</a></label>
                				<label class="checkbox"><input type="checkbox" name="esi_debtscenarios_minimum" id="esi_debtscenarios_minimum" value="y">I can only make the minimum (smallest amount allowed) payments on my credit cards.</label>
                        		<label class="checkbox"><input type="checkbox" name="esi_debtscenarios_creditors" id="esi_debtscenarios_creditors" value="y">I am getting calls from creditors about overdue bills.</label>
                        		<label class="checkbox"><input type="checkbox" name="esi_debtscenarios_bankruptcy" id="esi_debtscenarios_bankruptcy" value="y">I am thinking about filing for bankruptcy.</label>
                            </div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>21.</strong>   Would you like help with any of the following: creating and managing a budget, lowering the amount you spend each month and/or finding ways to reduce debt? </label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="radio_no_esi_helpbalancing" type="radio" name="esi_helpbalancing" value="n">Yes</label>
                                <label class="radio"><input id="radio_yes_esi_helpbalancing" type="radio" name="esi_helpbalancing" value="y">No</label> 
                            </div>
                		</div>
              		</div>	
                    <div class="clearfix">
                		<label for="xlInput"><strong>22.</strong>   Are you interested in learning about savings options?</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Mutual Funds</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Traditional Savings</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Annuities</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Bonds</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">IRAs</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">401K</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">403B</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">General Savings Tools</label>
                          	</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>23.</strong>   Do you want help finding information on an affordable bank, electronic banking , check casher, or credit union?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="" type="radio" name="" value="y">Yes</label>
                                <label class="radio"><input id="" type="radio" name="" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>24.</strong>   If you are looking for help in planning your retirement, what kind of assistance do you need?  (check all that apply)</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Getting a financial planner</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Information on life insurance options</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Help securing my pension</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Writing a will</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Getting a power of attorney</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">I'm interested in general planning resources</label>
                          	</div>
                   		</div>
                 	</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>25.</strong>   Do you want information on fraud and protecting your personal financial information?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="" type="radio" name="" value="y">Yes</label>
                                <label class="radio"><input id="" type="radio" name="" value="n">No</label> 
                            </div>
                		</div>
              		</div>
              		<a class="btn  btn-primary ">Clear Responses</a>
                	<a class="btn  disabled">Save</a>	    
            	</fieldset>
        	</form>
     	</div>         
	</section>
   	<section id="housing">  	
		<div class="body-header-wrapper">	<h2><i class="icon-building "></i>  Housing </h2>	
			<div class="body-header" style="z-index: 999; position: static; top: 2974.5px;">
				<div class="body-header-inner">
					<div class="">
							  			
					</div>
				</div>
			</div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
      	</div>
		<div class="">
			<form action="" method="get" id="commentForm" class="well cmxform">
				<fieldset>
					<legend>Section summary information goes here. Need language.</legend>
                    <div class="clearfix">
                    	<label for="normalSelect"><strong>26.</strong>    In what type of housing do you live?  <a data-content="Please choose your current type of housing:<br>
- Own Home = you live in a house, apartment, cooperative, or condo that you own;<br>
- Rental = you live in a house, apartment, or condo that you rent;<br>
- Live with Others = you live in a community based residential setting such as an Assisted Living Facility;<br>
- Low-Income Housing = you live in public housing offered to you because you have a low income; or  <br>
- Homeless or Live in Shelter = you do not have a home that you own or rent and may use a shelter.  You may live in a shelter, with friends, or on the streets." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                    	<div class="select">
                        	<select id="select_esi_housingtype" name="esi_housingtype">
                                <option value="">- Select -</option>
                            
                                <option value="2487-esi_housingtype_own"> Own Home </option>
                            
                                <option value="2488-esi_housingtype_rent"> Rental </option>
                            
                                <option value="2489-esi_housingtype_liveothers"> Live with Others </option>
                            
                                <option value="2490-esi_housingtype_subsidized"> Low-Income Housing </option>
                            
                                <option value="2491-esi_housingtype_homeless"> Homeless or Live in a Shelter </option>
                            
                            </select>
                      	</div>
                  	</div>		
                    <div class="clearfix">
                		<label for="xlInput"><strong>27.</strong>   Are you interested in information and tools on moving?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="" type="radio" name="" value="y">Yes</label>
                                <label class="radio"><input id="" type="radio" name="" value="n">No</label> 
                            </div>
                		</div>
              		</div>			  
                    <a class="btn  btn-primary ">Clear Responses</a>
                    <a class="btn  disabled">Save</a>	    
                </fieldset>
            </form>
        </div>
    </section>
	<section id="health">  	
		<div class="body-header-wrapper">	<h2><i class="icon-medkit "></i>  Health </h2>	
			<div class="body-header" style="z-index: 999; position: static; top: 2974.5px;">
				<div class="body-header-inner">
					<div class="">
							  			
					</div>
				</div>
			</div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
      	</div>
		<div class="">
			<form action="" method="get" id="commentForm" class="well cmxform">
				<fieldset>
					<legend>Section summary information goes here. Need language.</legend>
    				<div class="clearfix">
                		<label for="xlInput"><strong>28.</strong>   Do you have a <a title="" data-content="A physical or mental condition that makes it difficult or impossible to support or care for yourself or your family. The disability may be permanent or temporary but should be expected to last at least 30 days." data-placement="top" data-toggle="popover" href="#" data-original-title="Disability">disability</a> that has been diagnosed by your doctor that makes it very hard or impossible for you to care for yourself or your family each day?  <a data-content="Please select yes if you have a condition that has been diagnosed by your healthcare provider that makes it hard for you to work and/or complete your activities of daily living (e.g. eating, bathing, cleaning, and dressing)." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="radio_yes_esi_healthdisability" type="radio" name="esi_healthdisability" value="y">Yes</label>
                                <label class="radio"><input id="radio_no_esi_healthdisability" type="radio" name="esi_healthdisability" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>29.</strong>   Do you currently have any of the following <a title="" data-content="Chronic conditions are illnesses or disabilities that last a year or more and may limit your everyday activities. Having a chronic condition means you need to work with a doctor and other healthcare providers to take care of and manage your illness." data-placement="top" data-toggle="popover" href="#" data-original-title="Chronic Conditions">chronic conditions</a>: arthritis, asthma, emphysema, bronchitis, cancer, depression, anxiety, diabetes, heart disease, high blood pressure, stroke, osteoporosis, or HIV/AIDS?</label>
                        <div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input type="radio" name="esi_chroniccondition" value="2604-chroniccondition_no">No Chronic Conditions</label>
                                <label class="radio"><input type="radio" name="esi_chroniccondition" value="2603-chroniccondition_1">One Chronic Condition</label> 
                                <label class="radio"><input type="radio" name="esi_chroniccondition" value="2605-chroniccondition_2_more">Two or More Chronic Conditions</label>
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>30.</strong>   On a scale of 1 to 5 (1 being excellent health and 5 being poor health), how would you rate your health?</label>
                        <div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input type="radio" name="esi_ratehealth" value="2511-esi_ratehealth_excellent">1 - Excellent</label>
                                <label class="radio"><input type="radio" name="esi_ratehealth" value="2512-esi_ratehealth_verygood">2 - Very Good</label> 
                                <label class="radio"><input type="radio" name="esi_ratehealth" value="2492-esi_ratehealth_good">3 - Good</label>
                                <label class="radio"><input type="radio" name="esi_ratehealth" value="2493-esi_ratehealth_fair">4 - Fair</label> 
                                <label class="radio"><input type="radio" name="esi_ratehealth" value="2494-esi_ratehealth_poor">5 - Poor</label>
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>31.</strong>   On a scale of 1 to 4 (1 being not at all and 4 being almost all the time), over the last month, how often have you felt down, depressed or hopeless?  <a data-content="Choose the best option that describes if you feel depressed on a daily basis, with 1 that you never feel depressed and 4 that you feel depressed every day." title="" data-toggle="popover" class="btn btn-mini btn-info" href="#" data-original-title="Help"><i class="icon-question-sign icon-large"></i></a></label>
                        <div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input type="radio" name="esi_depression" value="2597-esi_depression_notatall">1 -  I have not felt down, depressed or hopeless.</label>
                                <label class="radio"><input type="radio" name="esi_depression" value="2598-esi_depression_several">2 - I have felt down, depressed or hopeless on a few days over the past month.</label> 
                                <label class="radio"><input type="radio" name="esi_depression" value="2599-esi_depression_half">3 - I have felt down, depressed or hopeless on more than half the days over the past month.</label>
                                <label class="radio"><input type="radio" name="esi_depression" value="2600-esi_depression_every">4 - I have felt down, depressed, or hopeless almost every day over the past month.</label>
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>32.</strong>   Do you have Medicare?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input id="radio_yes_esi_enrolledmedicare" type="radio" name="esi_enrolledmedicare" value="y">Yes</label>
                                <label class="radio"><input id="radio_no_esi_enrolledmedicare" type="radio" name="esi_enrolledmedicare" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>33.</strong>   If you have Medicare, do you have one of the following plans: </label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio"><input type="radio" name="esi_medicaresupplement" value="2601-esi_medicareadvantage">Medicare Advantage Plan</label>
                                <label class="radio"><input type="radio" name="esi_medicaresupplement" value="2602-esi_medigap">Medigap (Medicare Supplement Insurance)</label> 
                                <label class="radio"><input type="radio" name="esi_medicaresupplement" value="2476-none_of_the_above">None of the above</label>
                            </div>
                		</div>
              		</div>
                    <div class="clearfix">
                		<label for="xlInput"><strong>34.</strong>   Are you interested in meeting with a counselor to discuss your health insurance options and look at ways to cut down on your medical costs?</label>
						<div class="radio">
                            <div data-toggle="buttons-radio" class="btn-group">
                                <label class="radio inline"><input id="radio_yes_esi_counselor" type="radio" name="esi_counselor" value="y">Yes</label>
                                <label class="radio inline"><input id="radio_no_esi_counselor" type="radio" name="esi_counselor" value="n">No</label> 
                            </div>
                		</div>
              		</div>
                    <a class="btn  btn-primary ">Clear Responses</a>
                    <a class="btn  disabled">Save</a>
               	</fieldset>
          	</form>
		</div>
  	</section>
    <section id="morehelp">  	
    	<div class="body-header-wrapper">	<h2><i class="icon-question-sign "></i>  More Help </h2>	
        	<div class="body-header" style="z-index: 999; position: static; top: 2393px;">
             	<div class="body-header-inner">
                	<div class="">
                            
                    </div>
               	</div>
          	</div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
     	</div>
        <div class="">
          	<form action="" method="get" id="commentForm" class="well cmxform">
            	<fieldset>
              		<legend>Section summary information goes here. Need language.</legend>
                    <div class="clearfix">
                		<label for="xlInput"><strong>35.</strong>   Please choose any of the following that you may like more information about. (check all that apply)</label>
                        <div class="checkbox">
                            <div data-toggle="buttons-radio" class="btn-group">
                            	<label class="checkbox"><input type="checkbox" name="esi_interest_budgeting" id="esi_interest_budgeting" value="y"><a title="" data-content="This service can help you create a budget, set up financial goals and help you control your spending." data-placement="top" data-toggle="popover" href="#" data-original-title="Budget Assistance">Online Assistance with Money Management and Budgeting</a></label>
                				<label class="checkbox"><input type="checkbox" name="esi_interest_pension" id="esi_interest_pension" value="y"><a title="" data-content="This service helps you understand and get a pension. It also explains the death benefits your spouse may get from your pension." data-placement="top" data-toggle="popover" href="#" data-original-title="Pension Assistance">Help with your pension</a></label>
                        		<label class="checkbox"><input type="checkbox" name="esi_interest_aps" id="esi_interest_aps" value="y">Adult Abuse and Neglect (<a title="" data-content="Adult Protective Services helps prevent and checks out reports of abuse and neglect of older and disabled adults." data-placement="top" data-toggle="popover" href="#" data-original-title="Adult Protective Services">Adult Protective Services</a>)</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Managing Paperwork</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Companion Assistance</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Learning Technology</label>
                                <label class="checkbox"><input type="checkbox" name="" id="" value="y">Bill Paying Programs</label>
                        	</div>
                   		</div>
                 	</div>
                    <a class="btn  btn-primary ">Clear Responses</a>
                    <a class="btn  disabled">Save</a>
               	</fieldset>
           	</form>
      	</div>
  	</section>

	<section id="">  	
    	<div class="body-header-wrapper">	
        	<div class="body-header" >
             	<div class="body-header-inner">
                	<div class="">
                            
                    </div>
               	</div>
          	</div>
            <div ></div>
     	</div>
        <div class="">
          <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br>
      	</div>
  	</section>
</div> 
<!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Completion Status</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#basicinfo"><i class="icon-pencil "></i> Basics &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></li>
            <li class=""><a href="#income"><i class="icon-money "></i> Income &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></a></li>
            <li class=""><a href="#employment"><i class="icon-briefcase "></i> Employment </a></li>
            <li class=""><a href="#debt"><i class="icon-bar-chart "></i> Debt </a></li>
            <li class=""><a href="#housing"><i class="icon-building "></i> Housing </a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i> Health </a></li>
	     <li class=""><a href="#morehelp"><i class="icon-question-sign "></i> More Help </a></li>
        </ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="#detailedinstructions"><i class="icon-book "></i> Instructions </a></li>
	      <li><a data-toggle="modal" role="button" href="#printable"><i class="icon-print "></i> Printable Questionnaire </a></li>
           <li><a data-toggle="modal" role="button" href="#referafriend"><i class="icon-link "></i> Refer A Friend </a></li>

  </ol>	
    </div>	  
</div>



