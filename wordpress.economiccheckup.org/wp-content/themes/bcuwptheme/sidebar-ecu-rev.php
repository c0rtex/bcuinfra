<div id="sidebar">

<?php if ( function_exists('dynamic_sidebar') && dynamic_sidebar('sidebar2') ) : else : ?>

  <h3>Stay Connected </h3>
  <p>Get news and updates from us </p>
  <form id="signupEmail" method="POST" action="http://waystohelp.ncoa.org/site/Survey" class="signup">
  <input type="hidden" value="t" name="cons_info_component" id="cons_info_component">
  <input type="text" onClick="this.value=''" value="Enter Your Email" name="cons_email" class="left" id="cons_email" style="width:125px;"> 
  <span style="display: none;">&nbsp;<input type="text" name="denySubmit" alt="This field is used to prevent form submission by scripts." id="denySubmit"> Please leave this field empty</span>
  <input type="image" value="Submit" src="/cf/bootstrap/css/images/signup.png" name="ACTION_SUBMIT_SURVEY_RESPONSE" alt="SIGN UP" title="SIGN UP" class="left formimage" id="ACTION_SUBMIT_SURVEY_RESPONSE">  
  <input id="SURVEY_ID" name="SURVEY_ID" type="hidden" value="4140">
  <!-- note: use this button style if you want to change the text -->
  <!--<input type="submit" name="submit" value="Sign up" class="button orange">-->
  </form>

<?php endif; ?>
</div>

