<cfsilent>

<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">
<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) or Find("before_you_start.cfm", BasePath)>
	<cfset title = "#partnerQuery.wrapper_title# - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title = partnerQuery.wrapper_title>
	<cfset AddBanner="No">
</cfif>
<!-- set table values -->
<cfset tablewidth="95%">
<cfset cellpadding="5">

<cfset session.cellpadding="12">
<cfset session.cellspacing="2">
<cfset session.innercellpadding="2">
<cfset session.innercellspacing="2">
<cfparam name="link" default="">
<cfparam name="showmenu" default="1">
<cfparam name="guts" default="">
<cfparam name="content_title_override" default="">
<cfparam name="session.org_id" default="">


<cfset approot = "approot">
<cfset imgroot = "img">

<cfif session.partner_id IS 0>
	<cfset qpartner = 1>
<cfelse>
	<cfset qpartner = session.partner_id>
</cfif>

<cfparam name="contenttitle" default="">

</cfsilent><HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
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
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset AddBanner="No">
</cfif>

<cfif session.partner_id GT 0 OR partner_id GT 0>
	<cfset content_title = partnerQuery.partner_titlebar>
<cfelse>
	<cfparam name="content_title" default="#partnerQuery.partner_titlebar#">
</cfif>

<cfoutput>
<cfparam name="attributes.popupwarning" default="0">
<head>
<title>#title#</title>
#meta#

<cfif wrapper.wrapper_additional_css IS NOT "">
#wrapper.wrapper_additional_css#
</cfif>

<link rel=stylesheet href="/css/#wrapper.wrapper_css#" type="text/css" media="screen" />
<cfif wrapper.wrapper_menu_css IS NOT "">
<link rel=stylesheet href="/css/#wrapper.wrapper_menu_css#" type="text/css" media="screen" />
<cfelse>
<link rel=stylesheet href="/css/plmenu.css" type="text/css" media="screen" />
</cfif>
<link rel=stylesheet href="/css/screening.css" type="text/css" />

<!--[if IE]>
<cfif wrapper.wrapper_menu_ie_css IS NOT ""><link rel=stylesheet href="/css/#wrapper.wrapper_menu_ie_css#" type="text/css" media="screen" />
<cfelse><link rel=stylesheet href="/css/plmenuie.css" type="text/css" media="screen" />
</cfif><![endif]-->


<link rel=stylesheet href="/css/print_pl.css" type="text/css" media="print">

<script language="JavaScript" src="ValidationFunctions.js"></script>
<script language="JavaScript" src="/js/bcu.js"></script>
<script language="JavaScript" src="/js/jquery.js"></script>
<script language="JavaScript" src="/include/zipcheck.js"></script>
<script language="JavaScript" src="/include/ziplist.js"></script>


<cfset custom_js = replacenocase(partnerQuery.wrapper_custom_js, "[serverpath]", "#application.transferType#://#application.serverPath#", "all")>

<script language="JavaScript">
function rmNoneCheck(curObj,id){
	var myCheck = 0;
	if(jQuery("##"+curObj.id).is(":checked")){
		//console.log("cur check");
		myCheck = 1;
	}else if(!jQuery("##"+curObj.id).is(":checked")){
		//console.log("cur not check");
		var tempID = id.substring(5);
		jQuery(".nota_check_"+tempID+" input:checkbox").each(function(){
			var tempThisId = jQuery(this).attr("id");
			if(this.id != tempID && jQuery("##"+this.id).is(":checked")){
				//console.log("this id checked: " + this.id);
				myCheck = 1;
			}
			
		});
		
	}
	if(myCheck === 1){
		jQuery("##" + id +" input:checkbox").attr("checked","");
	}else if(myCheck === 0){
		jQuery("##" + id +" input:checkbox").attr("checked","checked");
	}
};
function rmAllCheck(curObj){
	//console.log("curObj:"+curObj.id);
	jQuery(".nota_check_"+curObj.id+" input:checkbox").each(function(){
		if(this.id !== curObj.id){
			//console.log(this);
			var tempId = jQuery(this).attr("id");
			jQuery(this).attr("checked","");
			//console.log(jQuery("##xtra_" + tempId));
			jQuery("##xtr_" + tempId).css("display","none");
			jQuery("##xtr_" + tempId + " input:text").val("");
			jQuery("##fit_invisible_q14").val("n");
		}else{
			jQuery(this).attr("checked","checked");
			jQuery("##fit_invisible_q14").val("n");
		}
	});
};

<cfif val(partnerQuery.wrapper_iframe) GT 0>
	document.domain="caring.com";
	$(document).ready(function(){
	resize();
});

function resize() {

	height = $("##container").innerHeight() + 40;
	var theFrame = $("##bcuFrame", parent.document.body);	
	var theTop = $(top.document);	
	frameheight = height + "px";
	if (height > 680) {
	$(theFrame).height(frameheight);
		$(theFrame).css("height", frameheight);
	} else {
		$(theFrame).height(680);
	}
	parent.location.hash = '##';
	
	

}

</cfif>


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
	
	#custom_js#


</script>



</head>

<body onLoad="fixpopups();#attributes.onload#">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000"></div> 

<div class="print">


	<div class="mainCol">

	<cfif wrapper.wrapper_left_col_ad IS NOT "" and cgi.script_name neq '/fullprint.cfm' >
	<div class="adCol"><div class="noprint">
	- Advertisement -
	<script type='text/javascript'>
                  //<![CDATA[
                    if (typeof ord=='undefined') {ord=Math.random()*10000000000000000;};
                    document.write('<script language="JavaScript" src="https://ad.doubleclick.net/adj/caring.ncoa;tile=1;sz=160x600;ord=' + ord + '?" type="text/javascript"><\/script>');
                  //]]>
                </script>

                <noscript>
                  <a href="http://ad.doubleclick.net/jump/caring.ncoa;tile=2;sz=160x600;ord=' + ord + '?" target='_blank'>
                    <img alt='' height='90' src="https://ad.doubleclick.net/ad/caring.ncoa;tile=1;sz=160x600;ord=' + ord + '?" width='728' />
                  </a>
                </noscript>

	</div></div>
	<div class="container2" id="container">
	<cfelse>
	<div class="container1" id="container">
	</cfif>
	
	<cfif trim(wrapper.wrapper_top_menu) IS NOT "">
	<div class="noprint">
	<div class="container2" id="container">#wrapper.wrapper_top_menu#</div>
	<div style="clear:left; height:0px; line-height: 0px;"></div>
	</div>
	</cfif>
	
		<div class="topheader">
		
			<cfif wrapper.wrapper_bcu_logo IS NOT "">
            	<cfif 
					attributes.guts IS "moreprograms_pl_cf.cfm" 
					OR attributes.guts IS "moreprograms_pl_cf.cfm" 
					OR attributes.guts IS "frmwelcome2.cfm" 
					OR attributes.guts IS "frmquestions.cfm" 
					OR attributes.guts IS "frmquestionssec.cfm" 
					OR attributes.guts IS "frmquestionssecdep.cfm" 	
					OR attributes.guts IS "frmskipgrid.cfm" 
					OR attributes.guts IS "frmquestionsthird.cfm" 
					OR attributes.guts IS "frmRecommend.cfm" 	
					OR attributes.guts IS "frmincomegrid.cfm" 	
					OR attributes.guts IS "frmassetgrid.cfm" 		
					OR attributes.guts IS "frmDrugList.cfm" 			
					OR attributes.guts IS "frmeligibility.cfm" 
					OR attributes.guts IS "frmDetails.cfm" 
					OR attributes.guts IS "redirect.cfm" 	
					OR attributes.guts IS "genericdruginfo.cfm" 	
					OR attributes.guts IS "printed_cf.cfm" 
					OR attributes.guts IS "full.cfm" OR attributes.guts is "fullprint.cfm" OR attributes.guts is "frmreportview.cfm" OR cgi.script_name is "/frmreportview.cfm">
					<cfset logo = "img/partners/bculogo.gif">
                    <cfset alt = "BenefitsCheckUp">
                    <cfset link = "index.cfm">
                <cfelse>
                	<cfset logo = wrapper.wrapper_bcu_logo>
                    <cfset alt = wrapper.wrapper_bcu_logo_alt_text>
                    <cfset link = wrapper.wrapper_logo_link>
                </cfif>
			<cfelse>
				<cfset logo = "img/partners/bculogo.gif">
				<cfif trim(wrapper.wrapper_bcu_logo_alt_text) IS NOT "">
					<cfset alt = wrapper.wrapper_bcu_logo_alt_text>
				<cfelse>
					<cfset alt = "BenefitsCheckUp">
				</cfif>
				
				<cfif trim(wrapper.wrapper_logo_link) IS NOT "">
					<cfset link = wrapper.wrapper_logo_link>
				<cfelse>
					<cfset link = "index.cfm">
				</cfif>				
			
			</cfif>
	
			<cfif wrapper.wrapper_show_header IS 1>
			
			<div class="bculogo" style="margin-top:0px;">
				<cfif attributes.showmenu IS 1 AND val(session.org_id) IS 0>
					<cfif attributes.popupwarning IS 0>
						<cfif link IS "index.cfm">
							<cf_sessionPassVars href="/#link#"><img src="#logo#" alt="#alt#" title="#alt#"></cf_sessionPassVars>
						<cfelse>
							<a href="#link#" target="_blank"><img src="#logo#" alt="#alt#" title="#alt#"></a>
						</cfif>
					<cfelse>
						<cf_displayText group="site" code="site_results_click_warning" var="clickText">
						<cfif link IS "index.cfm">
							<cf_sessionPassVars href="/#link#" prev_id="0" extralist="gohome=true" target="_top" confirm="#clickText#"><cf_displayimage code="img_bculogo_gif"></cf_sessionPassVars>
						<cfelse>
							<cf_sessionPassVars href="#link#" target="_top" confirm="#clickText#"><img src="#logo#" alt="#alt#" title="#alt#"></cf_sessionPassVars>
						</cfif>
					</cfif>
				<cfelse>
					<img src="#logo#" alt="#alt#" title="#alt#">
				</cfif>
			</div>

			<cfif wrapper.wrapper_logo IS NOT "">

			<div class="logo" style="margin-top: #val(partnerQuery.wrapper_logo_margin_top)#; margin-right: #val(partnerQuery.wrapper_logo_margin_right)#;">
				<cfif trim(partnerQuery.wrapper_link) IS NOT ""><a href="#partnerQuery.wrapper_link#" target="#partnerQuery.wrapper_id#"><img src="#partnerQuery.wrapper_logo#" border="0" alt="#partnerQuery.wrapper_logo_alt_text#" title="#partnerQuery.wrapper_logo_alt_text#"></a><cfelse><img src="#partnerQuery.wrapper_logo#" border="0" alt="#partnerQuery.wrapper_logo_alt_text#" title="#partnerQuery.wrapper_logo_alt_text#"></cfif>
			</div>
			</cfif>
	
		</div>
		
		</cfif>

		<div class="clear"></div>
		
		


	<cfif attributes.showmenu IS 1 AND wrapper.wrapper_menu IS 1 AND val(session.org_id) IS 0>
		<div class="<cfif wrapper.wrapper_left_col_ad IS NOT "">topmenu2<cfelse>topmenu</cfif>">
			<div class="noprint"><cfinclude template="/#approot#/plmenu_fit.cfm"></div>
		</div>
		
		<cfif wrapper.wrapper_left_col_ad IS NOT "" and cgi.script_name neq '/fullprint.cfm' >
			<div class="noprint">
			<div id="menuAd">
			Made Possible By:&nbsp;
			<script type='text/javascript'>
			  //<![CDATA[
				if (typeof ord=='undefined') {ord=Math.random()*10000000000000000;};
				document.write('<script language="JavaScript" src="https://ad.doubleclick.net/adj/caring.ncoa;tile=1;sz=120x60;ord=' + ord + '?" type="text/javascript"><\/script>');
			  //]]>
			</script>
		
			<noscript>
			  <a href="http://ad.doubleclick.net/jump/caring.ncoa;tile=2;sz=120x60;ord=' + ord + '?" target='_blank'>
				<img alt='' height='90' src="https://ad.doubleclick.net/ad/caring.ncoa;tile=1;sz=120x60;ord=' + ord + '?" width='728' />
			  </a>
			</noscript>
				</div></div>
		</cfif>
		
		<div class="clear"></div>		
	<cfelse>
		<div class="gnFix">
			<div id="globalnav"></div>		
		</div>
        <!--- THIS IS A TEST FOR BUG 4725 --->
        <div class="clear"></div>	
	</cfif>

	<table cellpadding="0" cellspacing="0" border="0" class="<cfif wrapper.wrapper_left_col_ad IS NOT "">table2<cfelse>table1</cfif>">
		<tr>
		<cfparam name="colstyle" default="contentcol2">
		
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