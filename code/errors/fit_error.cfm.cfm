<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">

<head>
<title>Financial Interview Tool - NCOA's Online Screening Service</title>
<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer's care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services."> 

<link rel=stylesheet href="css/fit.css" type="text/css" media="screen" />

<link rel=stylesheet href="css/plmenu.css" type="text/css" media="screen" />

<link rel=stylesheet href="css/screening.css" type="text/css" />

<!--[if IE]>
<link rel=stylesheet href="css/plmenuie.css" type="text/css" media="screen" />
<![endif]-->


<link rel=stylesheet href="css/print_pl.css" type="text/css" media="print">

<script language="JavaScript" src="ValidationFunctions.js"></script>
<script language="JavaScript" src="js/bcu.js"></script>
<script language="JavaScript" src="js/jquery.js"></script>
<script language="JavaScript" src="include/zipcheck.js"></script>
<script language="JavaScript" src="include/ziplist.js"></script>




<script language="JavaScript">
function rmNoneCheck(curObj,id){
	var myCheck = 0;
	if(jQuery("#"+curObj.id).is(":checked")){
		//console.log("cur check");
		myCheck = 1;
	}else if(!jQuery("#"+curObj.id).is(":checked")){
		//console.log("cur not check");
		var tempID = id.substring(5);
		jQuery(".nota_check_"+tempID+" input:checkbox").each(function(){
			var tempThisId = jQuery(this).attr("id");
			if(this.id != tempID && jQuery("#"+this.id).is(":checked")){
				//console.log("this id checked: " + this.id);
				myCheck = 1;
			}
			
		});
		
	}
	if(myCheck === 1){
		jQuery("#" + id +" input:checkbox").attr("checked","");
	}else if(myCheck === 0){
		jQuery("#" + id +" input:checkbox").attr("checked","checked");
	}
};
function rmAllCheck(curObj){
	//console.log("curObj:"+curObj.id);
	jQuery(".nota_check_"+curObj.id+" input:checkbox").each(function(){
		if(this.id !== curObj.id){
			//console.log(this);
			var tempId = jQuery(this).attr("id");
			jQuery(this).attr("checked","");
			//console.log(jQuery("#xtra_" + tempId));
			jQuery("#xtr_" + tempId).css("display","none");
			jQuery("#xtr_" + tempId + " input:text").val("");
			jQuery("#fit_invisible_q14").val("n");
		}else{
			jQuery(this).attr("checked","checked");
			jQuery("#fit_invisible_q14").val("n");
		}
	});
};




	function highlight_off(item) {
	var tag = item + "h";
	if (document.getElementById(tag)) {
		var oetag = document.getElementById(tag);
		oetag.id = item;
		}
	}

	function highlight(item) {
	if (document.getElementById(item)) {
		var oetag = document.getElementById(item);
		oetag.id = item + "h";
		}
	}

	function fixpopups() {
		var tag = "privacy";
		if (document.getElementById(tag)) {
			var oetag = document.getElementById(tag);
			oetag.href = "javascript:help2('/privacy.cfm')";
		}
		
		var tag2 = "terms";
		if (document.getElementById(tag2)) {
			var oetag2 = document.getElementById(tag2);
			oetag2.href = "javascript:help2('/terms.cfm')";
		}
	}
	
	



</script>



</head>

<body onLoad="fixpopups();">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000"></div> 

<div class="print">


	<div class="mainCol">

	
	<div class="container1" id="container">
	
	
		<div class="topheader">

		
			
			
			<div class="bculogo" style="margin-top:0px;">
				
							<a href="http://www.ncoa.org" target="_blank"><img src="img/partners/fit/ncoa-logo.gif" alt="National Council on Aging" title="National Council on Aging"></a>
						
			</div>

			

			<div class="logo" style="margin-top: 10; margin-right: 0;">
				<img src="img/partners/fit/logo2.gif" border="0" alt="Administration on Aging and HUD" title="Administration on Aging and HUD">
			</div>
			
	
		</div>
		
		

		<div class="clear"></div>

		
		


	
		<div class="topmenu">
			<div class="noprint"> 
	<ul id="globalnav">
		<li id="on"> <a href="http://bcuqa.benefitscheckup.org/index.cfm?gohome=true&partner_id=76" onClick="this.href='http://bcuqa.benefitscheckup.org/dispatch.cfm?cfid=22456&cftoken=75943053&source_id=1&prev_id=0&org_id=0&partner_id=76&subset_id=0&language_id=EN&access_id=0&client_id=NULL&user_id=NULL&test_id=0&gohome=true&bcu_url=http%3A%2F%2Fbcuqa%2Ebenefitscheckup%2Eorg%2Findex%2Ecfm%3Fgohome%3Dtrue%26partner%5Fid%3D76';">Home</a> </li>
		<li> <a href="http://bcuqa.benefitscheckup.org/fitapp/index.cfm" onClick="this.href='http://bcuqa.benefitscheckup.org/dispatch.cfm?cfid=22456&cftoken=75943053&source_id=1&prev_id=0&org_id=0&partner_id=76&subset_id=0&language_id=EN&access_id=0&client_id=NULL&user_id=NULL&test_id=0&bcu_url=http%3A%2F%2Fbcuqa%2Ebenefitscheckup%2Eorg%2Ffitapp%2Findex%2Ecfm';">Financial Interview Tool (FIT) </a></li>
        <li> <a href="http://bcuqa.benefitscheckup.org/moreprograms.cfm?partner_id=76" onClick="this.href='http://bcuqa.benefitscheckup.org/dispatch.cfm?cfid=22456&cftoken=75943053&source_id=1&prev_id=0&org_id=0&partner_id=76&subset_id=0&language_id=EN&access_id=0&client_id=NULL&user_id=NULL&test_id=0&bcu_url=http%3A%2F%2Fbcuqa%2Ebenefitscheckup%2Eorg%2Fmoreprograms%2Ecfm%3Fpartner%5Fid%3D76';"> BenefitsCheckUp </a></li>

		<li> <a href="http://bcuqa.benefitscheckup.org/fit_resources.cfm?subset_id=61&partner_id=76" onClick="this.href='http://bcuqa.benefitscheckup.org/dispatch.cfm?cfid=22456&cftoken=75943053&source_id=1&prev_id=0&org_id=0&partner_id=76&subset_id=61&language_id=EN&access_id=0&client_id=NULL&user_id=NULL&test_id=0&bcu_url=http%3A%2F%2Fbcuqa%2Ebenefitscheckup%2Eorg%2Ffit%5Fresources%2Ecfm%3Fsubset%5Fid%3D61%26partner%5Fid%3D76';"> Other Resources </a></li>		
	</ul>
	
	</div>
		</div>
		
		
		
		<div class="clear"></div>		
	

	<table cellpadding="0" cellspacing="0" border="0" class="table1">
		<tr>
		
		
		<td valign="top" class="contentcol2"><a href="http://bcuqa.benefitscheckup.org/dispatch.cfm?cfid=22456&cftoken=75943053&source_id=1&prev_id=0&org_id=0&partner_id=76&subset_id=0&language_id=EN&access_id=1&client_id=NULL&user_id=NULL&test_id=0&bcu_url=http%3A%2F%2Fbcuqa%2Ebenefitscheckup%2Eorg%2Findex%2Ecfm%3Fpartner%5Fid%3D76" title="For browsers utilizing a screen reader, please click here"></a><a href="#skipnav" title="Skip navigational links"></a>

		<table cellpadding="0" cellspacing="0" align="center" border="0">
		<tr>
			<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
		</tr>
		<tr>
			<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b></b></font></td>
		</tr>
		
		</table>
		
		


<style type="text/css">
 .titleFix{
 	height:45px;
 }
</style>
<!--[if IE]>
<style type="text/css">
 .titleFix{
 	height:65px;
 }
</style>
<![endif]-->




<br><br><br><br>
<font face="Arial" size=3>





We are unable to complete your questionnaire at this time.<br> 

Please send an email to <a
href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</a> and
provide any information about what action was taken before you received this
message. <br><br>
        <b>Note: You may have exceeded the maximum time limit (45 minutes) to
complete the questionnaire. <br> To start over, please go to <a
href="http://www.benefitscheckup.org/fit">www.benefitscheckup.org/fit</a></b>
        <br><br>We apologize for the inconvenience.<br>





<br><br>
Thank you,
<br><br>
BenefitsCheckUp Team
</font>





<script language="JavaScript">
<!--
function openComment() {
    url = "http://beta.benefitscheckup.org/cso/contact/form.jsp?src=bcudev";
    window.open(url, "comment", "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=640,height=420");
}
// -->
</script>
</td>
</table> 
	<div class="footer"><div class="container2"><div class="footer1">&copy; 2010 <a href="http://www.ncoa.org" class="footerlink" target="ncoa">National Council on Aging.</a> All rights reserved.</div>

	<div class="footer2">
	
	
	 <a id="link_to_us" href="javascript:linkToUs('/link_to_us.cfm')" class="footerlink">Link to Us</a> / <a id="privacy" class="footerlink" href="privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="termsofuse.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:comments@benefitscheckup.org">Feedback</a> / <a href="http://oeqa.benefitscheckup.org/oe?partner_id=76"  class="footerlink">Partner Login<img src="http://bcuqa.benefitscheckup.org/img/partners/arrow.gif" alt="Arrow" title="Arrow" style="margin:-4px 2px;" /></a>

		
	</div></div>
	</div>

</div>





</BODY>
<cfmail
	from="report@benefitscheckup.org"
	to="kiryl@benefitscheckup.org"
	subject="FIT app error on #cgi.HTTP_HOST#">
	You see this message because you are part of the mail list.
	User Agent: #cgi.HTTP_USER_AGENT#  
	Remote Address: #cgi.REMOTE_ADDR#  
	Script Name: #cgi.SCRIPT_NAME#  
	Path Translated: #cgi.PATH_TRANSLATED#
	HTTP Referer: #cgi.HTTP_REFERER#
	CFID and CFTOKEN: #cgi.HTTP_COOKIE#
	<cfif isDefined("error.message")>Error Message: #error.message#	</cfif>
	<cfif isDefined("error.rootCause")>Root Cause: #error.rootCause#	</cfif>
	<cfif isDefined("error.type")>Error Type: #error.type#	</cfif>
	<cfif isDefined("error.diagnostics")>Error Diagnostics: #error.diagnostics#	</cfif>
	<cfif isDefined("error.browser")>Error Browser: #error.browser#	</cfif>
	<cfif isDefined("error.dateTime")>Error DateTime: #error.dateTime#	</cfif>
	<cfif isDefined("error.invalidFields")>Error Invalid Fields: #error.invalidFields#	</cfif>
</cfmail>

</HTML>
