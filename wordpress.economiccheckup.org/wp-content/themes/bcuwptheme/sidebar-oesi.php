<div id="sidebar" class="span3">
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
  <h3>Our Sponsors </h3>
  <div id="rotating-item-wrapper" class="sponsor-block">
    <img src="/wp-content/uploads/2013/08/rrf.png" alt="The Retirement Research Foundation" title="The Retirement Research Foundation" class="rotating-item" width="180" />
    <img src="/wp-content/uploads/2011/10/boa5.png" alt="Bank of America" title="Bank of America" class="rotating-item" width="180" />
    <img src="/wp-content/uploads/2017/05/Taub-revolving-logo.png" alt="Taub" title="Taub" class="rotating-item" width="180" />
  </div> 
  <div class="sponsor-block">
   <a href="http://ncoajobsource.org/" target="_blank"><img src="/cf/bootstrap/css/images/sponsor-2.jpg" alt="JobSource" title="JobSource"></a>
  </div>
  <div class="AdvancedText"><h3 class="widgettitle">Ways to Share</h3>
<span style="padding-right: 3px;" class="st_email_custom" st_processed="yes"><img title="Email" alt="Email" src="/wp-content/uploads/2011/11/email3.gif" style="padding-top:3px;"></span>
<span class="st_facebook_custom" st_processed="yes"><img title="Post to Facebook" alt="Post to Facebook" src="/wp-content/uploads/2011/11/facebook.gif"></span>
<span class="st_twitter_custom" st_title="EconomicCheckUp via @NCOAging" st_processed="yes"><img title="Post to Twitter" alt="Post to Twitter" src="/wp-content/uploads/2011/11/twitter.gif"></span>
<a href="javascript:window.print()"><img title="Print" alt="Print" src="/wp-content/themes/bcuwptheme/images/icons/print.gif"></a>

<script type="text/javascript">var switchTo5x=true;</script><script src="https://ws.sharethis.com/button/buttons.js" type="text/javascript"></script><script type="text/javascript">stLight.options({publisher:'c2e2833d-a68d-4e9e-be78-f1b1f7481b27'});</script>

<script type="text/javascript">    $('.st_twitter_custom').attr('st_title', document.title + ' via @NCOAging' );</script></div>
<?php endif; ?>  
</div>
<div class="clear"></div> 