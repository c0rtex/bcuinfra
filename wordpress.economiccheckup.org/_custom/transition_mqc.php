<?PHP


// Set $state
$state = 'california';
if(isset($_GET['state']) and ($_GET['state'] != '')){$state = $_GET['state'];}
echo "
     <div class='span8'>  
	<section id='summary'>  	
        <div class='body-header-wrapper'>	<h2><i class='icon-book '></i> Next Steps </h2>	
            <div class='body-header' style='z-index: 999; position: static; top: 251.5px;'>
                <div class='body-header-inner'>
                    <div class=''>
                            
                    </div>
                </div>
            </div>
            <div style='display: none; width: 620px; height: 0px; float: none;'></div>
        </div>
        <div class=''>
            <h4></h4>
        </div>
        <div class=''>
            <form class='whitewell'>
                <fieldset>
                    
<div>
                        <label ><p>The National Council on Aging (NCOA), through its subsidiary, NCOA Services, is partnering with Aon Hewitt Navigators (AHN), the leading Medicare marketplace, to make it easier for you to find and enroll in the coverage that best suits your needs. 
</p>
<p>NCOA recommends AHN because it meets Standards of Excellence established by NCOA to ensure high quality and objective customer service. NCOA Services monitors AHN to ensure that these standards are being met.   
</p>
<p>
Your experienced AHN Benefit Advisor will:
<ul>
<li>Help you shop and compare a wide range of Medicare coverage options, including plans that allow you to keep your preferred doctors and hospitals</li>
<li>Provide expert guidance to find the right coverage to fit your budget</li>
<li>Help you enroll in the plan of your choice</li>
<li>Work with you following enrollment to resolve any outstanding issues or questions you may have about your healthcare coverage</li>
</ul>
</p>
The licensed Aon Hewitt Benefit Advisors have in-depth knowledge of a wide range of health insurance companies and products. All services are provided at no cost to the consumer.
</p>
<p>
Benefits Advisors are available by phone at 1-800-975-9655, Monday through Friday from 8:00 a.m. to 8:00 p.m. Central Time. Extended hours are available during Medicare's Open Enrollment Period (Oct. 15-Dec.7) from 7:00 a.m. to 10:00 p.m. CT. 
</p>
<p>
If you prefer to schedule an appointment with a Benefits Advisor, use the contact form below. An Advisor will return your call within one business day.</p>
<p>
<strong>AHN represents most of the major insurance companies serving Medicare beneficiaries.</strong> Some states may offer other high quality plans that are not represented by AHN. Click <a data-toggle='modal' role='button' href='/carriers/".$state."'> here </a> for a list of the insurance companies represented by AHN, and to learn whether other high quality plans may be available in your state.    
</p>                    
";                  
 
echo '				                   
                </fieldset>
            </form>
        </div>
    </section>

<section id="contact"> 
        <div class="body-header-wrapper">	<h2><i class="icon-user-md "></i> Contact a Benefits Advisor</h2>	
         <div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="clearfix">
                        
                  	</div>
            	</div>
          	</div><div></div>
     		<div></div>
     	</div>
       	<div class="">
         	<div action="" method="get" id="commentForm" class="well whitewell cmxform">
          		<div>
					<label for="xlInput"><p>Click <a data-toggle="modal" role="button" href="/screening-contact/"> here </a> to get started now.</p></label>
                </div>
            </div>
		</div>
	</section>

</div> <!--span8-->
<div class="span3">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#summary"><i class="icon-file"></i> Summary </a></li>
	      	<li class=""><a href="#contact"><i class="icon-user-md"></i> Contact A Benefits Advisor </a></li>
       		
        </ol>	
	
    </div>	  
</div>
';
?>