<?PHP
//echo $_SESSION['date_birth'].'<br>';
//echo $_SESSION['zipcode'];
echo "
     <div class='span8'>  
	<section id='summary'>  	
        <div class='body-header-wrapper'>	<h2><i class='icon-book '></i> Needed Info </h2>	
            <div class='body-header' style='z-index: 999; position: static; top: 251.5px;'>
                <div class='body-header-inner'>
                    <div class=''>
                            
                    </div>
                </div>
            </div>
            <div style='display: none; width: 620px; height: 0px; float: none;'></div>
        </div>
        <div class='whitewell'>
                    <legend><i class='icon-list-alt '></i> What Happens Next</legend>   
                        <label ><p>Use this form if you would like a representative of Aon Retiree Health Exchange&#0153; to call you to discuss your coverage options. This service is available at no charge to you, and your information will not be given to any outside parties. An Advisor will return your call within one business day.<p></label>                    
        </div>
    </section>
	<section id='contact'>  	
        <div class='body-header-wrapper'>	<h2><i class='icon-user-md '></i> Contact a Benefits Advisor </h2>	
            <div class='body-header' style='z-index: 999; position: static; top: 251.5px;'>
                
            </div>
            <div style='display: none; width: 620px; height: 0px; float: none;'></div>
        </div>
       
";
//get contact form and display
require_once "screening_user_bodyv2.php";
echo "
    </section>
";  

echo '
</div> <!--span8-->
<div class="span3">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#summary"><i class="icon-file"></i> Summary </a></li>
	      	<li class=""><a href="#contact"><i class="icon-user-md"></i> Contact A Benefits Advisor </a></li>
		<li class=""><a href="#consent"><i class="icon-ok"></i>Terms & Conditions</a><br><TEXTAREA NAME="disclaimer" ROWS=11 COLS=100>By submitting my contact details in this form, I agree to allow a representative of Aon Retiree Health Exchange&#0153; to call me back to discuss my Medicare coverage options. I have read and understand the Privacy Policy and know that my information will not be sold to any outside parties, nor will I be required to purchase any coverage unless I choose to do so. 
</TEXTAREA></li>
        </ol>	
	
    </div>	  
</div>
';
?>
