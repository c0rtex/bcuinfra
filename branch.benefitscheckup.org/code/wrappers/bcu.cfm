<cfsilent>
<cfparam name="link" default="">
<cfparam name="showmenu" default="0">


<cfparam name="session.subset_id" default="">
<cfparam name="session.org_id" default="">

<cfparam name="org_id" default="#session.subset_id#">
<cfparam name="subset_id" default="#session.subset_id#">

<cfparam name="randomimage" default="">
<cfparam name="content_title_override" default="">
<cfif link IS NOT "" OR org_id GT 0>
	<cfset rightcol = "">
	<cfset show_left_col = "n">
<cfelse>
</cfif>
<cfparam name="show_left_col" default="">
<cfparam name="show_title" default="">

<cfset title1 = "Benefits CheckUp">
<cfset images = 7>
<cfset randimage = fix((rand() * images + .5))>
<cfif randimage IS 0>
	<cfset randimage = 1>
<cfelseif randimage GT images>
	<cfset randimage = images>
<cfelse>
</cfif>
<cfparam name="contenttitle" default="">


<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>

<cfparam name="subset_id" default="">

<cfif subset_id IS 0>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Pay For Prescription Drugs, Get Energy Assistance, and More.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer’s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>

<cfelseif subset_id IS 39>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Reduce Prescription Drug Costs.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer’s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>

<cfelseif subset_id IS 38>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You With Disaster Recovery.'>
	<cfparam name='meta' default='<meta name="description" content="Affected by a hurricane or other disaster? Find programs that offer financial help, health care and prescription drugs, housing and more.">
 
<meta name="keywords" content="hurricane benefits, hurricane Katrina benefits, benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
<cfelse>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer’s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
</cfif>

<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfparam name="title" default="BenefitsCheckUp - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfparam name="title" default="BenefitsCheckUp From NCOA">
	<cfset AddBanner="No">
</cfif>

<cfif session.partner_id GT 0 OR partner_id GT 0>
	<cfset content_title = partnerQuery.partner_titlebar>
<cfelse>
	<cfparam name="content_title" default="#partnerQuery.partner_titlebar#">
</cfif>



</cfsilent><head>
<cfoutput>
<title>#title#</title>
#meta#
<link rel=stylesheet href="css/bcu.css" type="text/css">
<link rel=stylesheet href="css/menu.css" type="text/css">

<script language="JavaScript" src="ValidationFunctions.js"></script>

<!--- <script type="text/javascript" src="overlibmws/overlibmws.js"></script>
<script type="text/javascript" src="overlibmws/overlibmws_scroll.js"></script>
<script type="text/javascript" src="overlibmws/overlibmws_print.js"></script>
<script type="text/javascript" src="overlibmws/overlibmws_print.js"></script>
<script type="text/javascript" src="overlibmws/overlibmws_draggable.js"></script>
<script type="text/javascript" src="overlibmws/ajaxcontentmws.js"></script> --->

<cfif randomimage IS "y">

<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Robert Bui (astrogate@hotmail.com) -->
<!-- Web Site:  http://astrogate.virtualave.net -->

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Begin
var interval = 2.5; // delay between rotating images (in seconds)
var random_display = 1; // 0 = no, 1 = yes
interval *= 1000;

var image_index = 0;
image_list = new Array();
image_list[image_index++] = new imageItem("/img/partners/aarp.gif");
image_list[image_index++] = new imageItem("/img/partners/astra.gif");
image_list[image_index++] = new imageItem("/img/partners/atlantic.gif");
image_list[image_index++] = new imageItem("/img/partners/pfizer.gif");
image_list[image_index++] = new imageItem("/img/partners/synergy.gif");
var number_of_image = image_list.length;
function imageItem(image_location) {
this.image_item = new Image();
this.image_item.src = image_location;
}
function get_ImageItemLocation(imageObj) {
return(imageObj.image_item.src)
}
function generate(x, y) {
var range = y - x + 1;
return Math.floor(Math.random() * range) + x;
}
function getNextImage() {
if (random_display) {
image_index = generate(0, number_of_image-1);
}
else {
image_index = (image_index+1) % number_of_image;
}
var new_image = get_ImageItemLocation(image_list[image_index]);
return(new_image);
}
function rotateImage(place) {
var new_image = getNextImage();
document[place].src = new_image;
var recur_call = "rotateImage('"+place+"')";
setTimeout(recur_call, interval);
}
//  End -->
</script>


<cfelse>
</cfif>
</head>

<body <cfif randomimage IS "y">onLoad="rotateImage('rImage')"<cfelse></cfif>>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000"></div> 
<div class="BCU"><h1>Benefits Checkup</h1>
<h3>A Service of the National Council on Aging</h3></div>

<div class="container1">

<div class="topheader"><div class="bculogo">
<cfif org_id GT 1>
		<cfif showmenu IS 1>
			<a href="index.cfm?org_id=#org_id#"><img src="img/bculogo.gif"></a>
	<cfelse>
	<img src="img/bculogo.gif">
	</cfif>
<cfelse>

<cfif link IS NOT "" OR session.org_id IS NOT 0><img src="img/bculogo.gif"><cfelse><a href="index.cfm?org_id=#org_id#"><img src="img/bculogo.gif"></a></cfif></cfif></div><div class="asof1"><span class="asofh2">As of <span class="h2strong">#dateformat(now(), 'ddddd, mmmmm d, yyyy')#</span> we have helped <span class="h2strong"><cf_cachetoteboard></span> people find the benefits they deserve.</span></div>
</div>
<div class="clear"></div>
<cfif org_id GT 1>
	<cfif showmenu IS 1>
			<cfinclude template="/#approot#/menu.cfm">
		<cfelse>
		</cfif>

<cfelse>
	<cfif link IS NOT "" OR org_id GT 1 OR (subset_id IS 41 AND org_id IS NOT 0)>
		<cfif showmenu IS 1>
			<cfinclude template="/#approot#/menu.cfm">
		<cfelse>
		</cfif>
	<cfelse>
		<cfinclude template="/#approot#/menu.cfm">
		<div class="clear"></div>
	</cfif>
</cfif>
<cfif show_title IS "yes" AND content_title_override IS "">
	<cfif partner_id IS 12 AND subset_id IS 39>
			<div class="contenttitle"><h1 class="title">Rx</h1></div>
	<cfelseif subset_id IS 35>
		<div class="contenttitle"><h1 class="title">Food Stamps, Housing and Energy Assistance</h1></div>
	<cfelseif subset_id IS 19>
		<div class="contenttitle"><h1 class="title">Patient Assistance Programs</h1></div>
	<cfelseif subset_id IS 41>
				<div class="contenttitle"><h1 class="title">Medicare Rx Extra Help Application</h1></div>
	<cfelse>
			<div class="contenttitle"><h1 class="title">#content_title#</h1></div>
	</cfif>
<cfelseif content_title_override IS NOT "">
		<div class="contenttitle"><h1 class="title">#content_title_override#</h1></div>
<cfelse>
<div class="contenttitle0"></div>
</cfif>
<table cellpadding="0" cellspacing="0" width="770">
<tr>
<cfif show_left_col IS 'y'>
	<td valign="top" class="clients" width="150"><img src="#imgroot#/left#randimage#.jpg">
	<h3 class="clientsh3">What People Are Saying...</h3>
<blockquote>&ldquo;The website is awesome and extremely helpful. As a social worker, I refer families to your website on a <em>daily</em> basis!&rdquo;</blockquote></td>
<cfelse>
</cfif>
<cfparam name="rightcol" default="">
<cfif show_left_col IS 'y'>
	<cfif rightcol IS "">
		<cfparam name="colstyle" default="contentcol">
	<cfelse>
		<cfparam name="colstyle" default="contentcol1">
	</cfif>
<cfelse>
	<cfif rightcol IS "">
		<cfparam name="colstyle" default="contentcol2">
	<cfelse>
		<cfparam name="colstyle" default="contentcol3">
	</cfif>

</cfif>
<td valign="top" class="#colstyle#"></cfoutput><cfinclude template="/#approot#/#guts#"></td>



<cfif rightcol IS "">
<cfelse>
	<td valign="top" class="rightcol"><cfinclude template="#rightcol#"></td>
</cfif>

</tr>
</table><cfoutput>
<div class="footer"><div class="container2"><div class="footer1">&copy; #year(now())# National Council on Aging. All rights reserved.</div>
<div class="footer2"><cfif link IS NOT "" OR org_id GT 1 OR session.org_id GT 1><cfelse><a class="footerlink" href="index.cfm">Home</a> / </cfif><a class="footerlink" href="site_map.cfm">Site Map</a> / <a class="footerlink" href="privacy.cfm">Privacy Policy</a> / <a class="footerlink" href="terms.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:comments@BenefitsCheckUp.org">Feedback</a></div></div>
</div>
</cfoutput>
</body>
</html>