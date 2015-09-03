<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script type="text/javascript" language="JavaScript"  src="js/jquery.js"></script>
<script type="text/javascript" src="js/cookie.js"></script>

<script type="text/javascript">
$(document).ready(function() {

	$("##openSurvey").click(function() {		
			$("##message1").hide();
			$("##message2").show();
			 window.open('#caseurl#', 'popup', 'width=740,height=640,scrollbars=1,status=1'); 
			 $.cookie('BCUSURVEY', 999, { expires: 1000, domain: '.benefitscheckup.org', secure: false, path: '/' });
			 $.cookie('BCUSURVEY10', 999, { expires: 1000, domain: '.benefitscheckup.org', secure: false, path: '/' });
			 parent.$.akModalRemove();
			 $('body').unbind("mouseleave");
			 return false;
		});	  
		
	$("##dialogClose2").click(function() {		
			$.cookie('BCUSURVEY', 999, { expires: 1000, domain: '.benefitscheckup.org', secure: false, path: '/' });
			$.cookie('BCUSURVEY10', 999, { expires: 1000, domain: '.benefitscheckup.org', secure: false, path: '/' });
			parent.$.akModalRemove();
		});	  		
		
});

</script>


<style type="text/css">
html, body {
	background-color:transparent;
	margin:0px; padding:0px;
}

.messagePanel {
	background:##fdfdbc;
	text-align:center;
	width: 340px;
	height:235px;
	background-image:url(/img/survey/surveyBack.gif);
	background-repeat:no-repeat;
	background-position:top;
	padding-top: 20px;
}

.messagePanel5 {
	background:##fdfdbc;
	text-align:center;
	width: 340px;
	height:235px;
	background-image:url(/img/survey/surveyBack.gif);
	background-repeat:no-repeat;
	background-position:top;
	padding-top: 20px;
}

.messagePanel10 {
	background:##fdfdbc;
	text-align:center;
	width: 340px;
	height:235px;
	background-image:url(/img/survey/surveyBack.gif);
	background-repeat:no-repeat;
	background-position:top;
	padding-top: 16px;
}

.m5 {
font-family:Verdana, Arial, Helvetica, serif;
font-size:12px;
color: ##012a5c;
font-weight:bold;
padding: 0px 0px 8px 0px;
margin: 0px;
padding-bottom:8px;
}

.m10 {
font-family:Verdana, Arial, Helvetica, serif;
font-size:12px;
color: ##012a5c;
font-weight:bold;
padding: 0px 0px 4px 0px;
margin: 0px;
padding-bottom:4px;
}


.m2 {
font-family:Verdana, Arial, Helvetica, serif;
font-size:12px;
color: ##012a5c;

padding: 12px 0px;
margin: 0px;
}

.m2 a:link, .m2 a:visited {
	text-decoration:none;
	font-weight:bold;
	color: ##012a5c;
}

.m2 a:hover, .m2 a:active {
	text-decoration:underline;
}



</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>BCU Survey</title>
</head>

<body>
<div id="message1" class="messagePanel#surveyCase#">
	<div class="m#surveyCase#">
	<img src="img/survey/survey#surveyCase#please.gif" alt="Please tell us about your visit to" title="Please tell us about your visit to" />
	</div>
	
	<div class="m#surveyCase#">
	<img src="img/survey/survey#surveyCase#BCU.gif" alt="BenefitsCheckUp.org" title="BenefitsCheckUp.org" />
	</div>		
	
	<div class="m#surveyCase#">
	<img src="img/survey/survey#surveyCase#.gif" alt="Click below to take a brief survey and earn a $#surveyCase# gift card." title="Click below to take a brief survey and earn a $#surveyCase# gift card." />
	</div>
	
	<div class="m#surveyCase#">
	<img id="openSurvey" src="img/survey/surveyYes.gif" alt="Take survey now" title="Take survey now" width="131" height="32" /> &nbsp <img id="dialogClose2" src="img/survey/surveyNo.gif" alt="Not now, thanks" title="Not now, thanks" width="130" height="32" />
	</div>
</div>

<div id="message2" style="display:none;" class="messagePanel">
	<div class="m2">
	<img src="img/survey/surveyWait.gif" alt="Please Wait..." title="Please Wait..." />
	</div>
	<div class="m2">
	The survey will popup in a new window.
	</div>
	<div class="m2">
	<a href="#caseurl#" target="survey">If survey window does not open, click here.</a>
	</div>
	<div class="m2">
	<img id="dialogClose3" src="img/survey/SurveyClose.gif" alt="Close window" title="Close window" onclick="javascript:parent.$.akModalRemove();" />
	</div>
</div>
</body>
</html>
</cfoutput>