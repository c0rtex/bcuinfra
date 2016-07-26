<cfsilent>

<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfset approot = "approot">
<cfset imgroot = "img">
<cfset tablewidth="95%">
<cfset cellpadding="5">
<cfset session.cellpadding="12">
<cfset session.cellspacing="2">
<cfset session.innercellpadding="2">
<cfset session.innercellspacing="2">
<cfset title1 = "Benefits CheckUp">
<cfset images = 24>
<cfset randimage = fix((rand() * images + .5))>

<cfparam name="link" default="">
<cfparam name="showmenu" default="0">
<cfparam name="guts" default="">
<cfparam name="content_title_override" default="">
<cfparam name="contenttitle" default="">

<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfset title="BenefitsCheckUp - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUp From NCOA">
	<cfset AddBanner="No">
</cfif>

<cfif randimage IS 0>
	<cfset randimage = 1>
<cfelseif randimage GT images>
	<cfset randimage = images>
</cfif>

<cfif session.partner_id IS 0>
	<cfset qpartner = 1>
<cfelse>
	<cfset qpartner = session.partner_id>
</cfif>
<cf_cachepartnerquery query="partnerQuery" partner_id="#qpartner#">
</cfsilent>
<cfoutput>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<cfif attributes.refreshurl neq ''>
<meta http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#">
</cfif>

<cfif session.subset_id IS 0>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Pay For Prescription Drugs, Get Energy Assistance, and More.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
<cfelseif session.subset_id IS 39>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You Reduce Prescription Drug Costs.'>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>

<cfelseif session.subset_id IS 38>
	<cfparam name='title' default='BenefitsCheckUp - Find Programs to Help You With Disaster Recovery.'>
	<cfparam name='meta' default='<meta name="description" content="Affected by a hurricane or other disaster? Find programs that offer financial help, health care and prescription drugs, housing and more.">
<meta name="keywords" content="hurricane benefits, hurricane Katrina benefits, benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
<cfelse>
	<cfparam name='meta' default='<meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer''s care and more.">
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

<title>#title#</title>
#meta#

<link rel=stylesheet href="css/bcu.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/menu.css" type="text/css" media="screen" />
<link rel="stylesheet" href="js/theme.css" type="text/css" media="screen" />

<!--[if IE]>
<link rel=stylesheet href="css/bcu.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/menuie.css" type="text/css" media="screen" />
<![endif]-->

<link rel=stylesheet href="css/print.css" type="text/css" media="print">
<cfif attributes.css IS NOT ""><cfloop list="#attributes.css#" index="i"><link rel=stylesheet href="css/#attributes.css#" type="text/css" media="print"></cfloop></cfif>

<script type="text/javascript" language="JavaScript" src="js/jquery.js"></script>
<script type="text/javascript" language="JavaScript" src="js/dimmer.js"> </script>
<script type="text/javascript" language="JavaScript" src="js/dimensions.pack.js"></script>
<script type="text/javascript" language="JavaScript" src="js/akModal.js"></script>
<script type="text/javascript" language="JavaScript" src="js/cookie.js"></script>
<script type="text/javascript" language="JavaScript" src="js/timer.js"></script>
<script type="text/javascript" language="JavaScript" src="js/bcu.js"></script>
<script type="text/javascript" language="JavaScript" src="ValidationFunctions.js"></script>

<cfif attributes.js IS NOT "">
<cfloop list="#attributes.js#" index="i"><script language="JavaScript" src="js/#i#"></script></cfloop>
</cfif>


<cfif attributes.randomimage IS "y">
<cfsilent>
	<cfset imgS = "|">
	<cfset xv = 0>
	<cfset ImgArray = ArrayNew(1)>
	<cfloop list="aarp,astra,atlantic,kaiser,pfizer,harmony,cvs,coventry,healthspring,windsor,wellpoint,unicare,humana,ils" index="i">
		<cfsavecontent variable="img">
		<cf_displayimage code="img_partners_#i#_gif" width="80" height="47" hspace="0" vspace="0">
		</cfsavecontent>
		<cfset a1 = findnocase('alt="', img)>
		<cfset a2 = findnocase('"', img, a1 + 5)>
		<cfset a3 = mid(img, a1 + 5, a2 - a1 - 5)>
		
		<cfset x = ArrayAppend(ImgArray, "/img/partners/#i#.gif~#a3#")>
		<cfset xv = xv + 1>
	</cfloop>
	
	<cfloop from="1" to="#xv#" index="ListElement">
	
		<cfset imgR0 = (rand() * Arraylen(ImgArray)) + 1/2>
		<cfset imgR = int(imgR0)>
		
		<cfif imgR IS 0>
			<cfset imgR = 1>
		<cfelseif imgR GT Arraylen(ImgArray)>
			<cfset imgR = Arraylen(ImgArray)>
		</cfif>
		
		<cfif ListElement IS 1>
			<cfset firstimage = ImgArray[imgR]>
		</cfif>
		
		<cfset imgS = "#imgS##ImgArray[imgR]#|">
		
		<cfset deleteat = ArrayDeleteAt(ImgArray,imgR)>
	
	</cfloop>
	
	<cfset jstring = "">
	
	<cfloop list="#imgS#" index="ListElement" delimiters="|">
	
	<cfif jstring IS "">
		<cfset jstring = 'image_list[image_index++] = new imageItem("#listElement#");'>
	<cfelse>
	<cfset jstring = '#jstring#
	image_list[image_index++] = new imageItem("#listElement#");'>
	</cfif>
	
	</cfloop>
</cfsilent>
	<script language="javascript">
	var interval = 2.5; // delay between rotating images (in seconds)
	var random_display = 0; // 0 = no, 1 = yes
	interval *= 1000;
	
	var image_index = 0;
	image_list = new Array();
	
	#jstring#
	
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
		} else {
			image_index = (image_index+1) % number_of_image;
		}
	
		var new_image = get_ImageItemLocation(image_list[image_index]);
		return(new_image);
	}
	
	function rotateImage(place) {
		var new_image = getNextImage();
		
		var img = '.' + place;
		delim = new_image.search('~');
		src = new_image.slice(0,delim);
		alt = new_image.slice(delim + 1, new_image.length);
		alt2 = unescape(alt);
		$(img).attr('src', src);
		$(img).attr('alt', alt2);
		$(img).attr('title', alt2);
		var recur_call = "rotateImage('"+place+"')";
		setTimeout(recur_call, interval);
	}
	</script>
</cfif>

</head>

<body <cfif attributes.randomimage IS "y">onLoad="fixpopups();rotateImage('anim');#attributes.onload#"<cfelse>onLoad="fixpopups();#attributes.onload#"</cfif>>
<div class="print">
<div class="bcu">
	<h1>Benefits Checkup</h1>
	<h3>A Service of the National Council on Aging</h3>
</div>

<div class="container1">


<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)>
	<div class="topheader2">
<cfelse>
	<cfif attributes.showmenu IS 1>
		<div class="topheader">
	<cfelse>
		<div class="topheader2">
	</cfif>
</cfif>

<div class="bculogo">

<cfif session.org_id GT 1>
	<cfif showmenu IS 1>
		<cf_sessionpassvars href="index.cfm"><cf_displayimage code="img_bculogo_gif"></cf_sessionpassvars>
	<cfelse>
		<cf_displayimage code="img_bculogo_gif">
	</cfif>
<cfelse>
	<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)>
		<cf_displayimage code="img_bculogo_gif">
	<cfelse>
		<cfif attributes.showmenu IS 1>
			<cf_sessionpassvars href="index.cfm"><cf_displayimage code="img_bculogo_gif"></cf_sessionpassvars>
		<cfelse>
			<cf_displayimage code="img_bculogo_gif">
		</cfif>
	</cfif>
</cfif>

</div>

<cfif link IS NOT "" OR session.org_id IS NOT 0 OR (session.partner_id IS 19 AND attributes.showmenu IS 0)><cfelse>

	<cfif attributes.showmenu IS 1>
		<div class="asof1">
		<span class="asofh2">As of <span class="h2strong">#dateformat(now(), 'ddddd, mmmmm d, yyyy')#</span> we have helped<br /><span class="h2strong"><cf_cachetoteboard></span> people find over <span class="h2strong"><cf_cachetoteboard field="dollars" writerounded="true"></span> worth<br />of the annual benefits they deserve.</span>
		</div>

	<cfelse>

	</cfif>


</cfif>
</div>

<div class="clear"></div>

	<cfif link IS NOT "" OR session.org_id GT 0 OR (session.subset_id IS 41) OR session.partner_id IS 19>
	<cfelse>
		<cfif attributes.showmenu IS 1>
			<cfinclude template="/#approot#/menu.cfm">
		<cfelse>
		</cfif>
		<div class="clear"></div>
	</cfif>
<div class="noprint">
<cfif attributes.show_title IS "yes" AND attributes.content_title_override IS "">
	<cfswitch expression="#session.subset_id#">
		<cfcase value="0"><div class="contenttitle"><h1 class="title">Comprehensive</h1></div></cfcase>	
		<cfcase value="19"><div class="contenttitle"><h1 class="title">Patient Assistance Programs</h1></div></cfcase>
		<cfcase value="27"><div class="contenttitle"><h1 class="title">Medicare Rx Extra Help</h1></div></cfcase>
		<cfcase value="35"><div class="contenttitle"><h1 class="title">Food Stamps, Housing and Energy Assistance</h1></div></cfcase>
		<cfcase value="38"><div class="contenttitle"><h1 class="title">Disaster Recovery</h1></div></cfcase>
		<cfcase value="39"><div class="contenttitle"><h1 class="title">Prescription Drug Assistance</h1></div></cfcase>
		<cfcase value="41"><div class="contenttitle"><h1 class="title">Medicare Rx Extra Help Application</h1></div></cfcase>
		<cfdefaultcase><div class="contenttitle0"></div></cfdefaultcase>
	</cfswitch>
<cfelseif attributes.content_title_override IS NOT "">
		<div class="contenttitle"><h1 class="title">#attributes.content_title_override#</h1></div>
<cfelse>
<div class="contenttitle0"></div>
</cfif>
</div>
<table cellpadding="0" cellspacing="0" width="770">
<tr>
<cfif attributes.show_left_col IS 'y'>
	<td valign="top" class="clients" width="150"><cf_displayimage code="img_left#randimage#_jpg">
	<h3 class="clientsh3">What People Are Saying...</h3>
<blockquote><cf_displayquote action="random"></blockquote>

<p style="text-align:center; margin-top:0px;"><a href="article.cfm?article_id=14
"><cf_displayimage code="images_healthawards_gif"></a></p>

</td>
<cfelse>
</cfif>
<cfif attributes.show_left_col IS 'y'>
	<cfif attributes.rightcol IS "">
		<cfparam name="colstyle" default="contentcol">
	<cfelse>
		<cfparam name="colstyle" default="contentcol1">
	</cfif>
<cfelse>
	<cfif attributes.rightcol IS "">
		<cfparam name="colstyle" default="contentcol2">
	<cfelse>
		<cfparam name="colstyle" default="contentcol3">
	</cfif>

</cfif>
<td valign="top" class="#colstyle#"><cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>
<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b>#parent_name#</b></font></td>
			</tr>
			<cfif trim(center_logo) eq ''>
			<tr>
				<td align="center" valign="top" colspan="3">#right_logo#</td>
			</tr>
			<tr>
				<td align="center" valign="bottom" colspan="3">#page_slogan#</td>
			</tr>
			<cfelseif trim(left_logo) neq ''>
			<tr>
				<td rowspan="2" align="right">#left_logo#</td>
				<td rowspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			<tr>
				<td align="left" valign="bottom">#page_slogan#</td>
			</tr>
			<cfelse>
			<cfif session.org_id IS 0>
			<cfelse>
			<tr>
				<td rowspan="2" align="right">#center_logo#</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			<tr>
				<td align="left" valign="bottom">#page_slogan#</td>
			</tr>
			</cfif>
			</cfif>
			</table>
</cfoutput>