<cfparam name="link" default="">
<cfparam name="rightcol" default="">
<cfparam name="attributes.tag" default="">
<cfset approot = "approot">
<cfset imgroot = "img">
<cfoutput></td>
</table><cfoutput>

<cfif wrapper.wrapper_show_footer IS 1>

<cfif wrapper.wrapper_footer_custom IS NOT "">
<cfset footer = replacenocase(wrapper.wrapper_footer_custom, "[Year]", Year(Now()), 'all')>
<cfset footer = replacenocase(footer, "##application.serverPathOE##", application.serverPathOE)>
<cfset footer = replacenocase(footer, "##session.partner_id##", session.partner_id)>
<cfset footer = replacenocase(footer, "[Feedback]", request.comments_address)>
<cfset footer = replacenocase(footer, "[none]", "&nbsp;")>
<cfif session.subset_id IS 59>
	<cfset footer = replacenocase(footer, ' | <a href="https://#application.serverPathOE#?partner_id=22">Organization Login</a>', '')>
</cfif>
#footer#

<cfelse>
	<div class="footer">
	<div class="container2">
	<div class="footer1">&copy; #year(now())# <a href="http://www.ncoa.org" class="footerlink" target="ncoa">National Council on Aging.</a> All rights reserved.</div>
	<div class="footer2">
	
	<cfif link IS NOT "" GT 1 OR session.org_id GT 1 OR  (session.partner_id IS 19 AND attributes.showmenu IS 0)>
	
	<!---<a id="link_to_us" href="javascript:linkToUs('/link_to_us.cfm')" class="footerlink">Link to Us</a> / ---><a href="javascript:help2('/privacy_cf.cfm')" id="privacy" class="footerlink">Privacy Policy</a> / <a href="javascript:help2('/termsofuse.cfm')" class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a>
	<cfelse>
	
		<cfif attributes.showmenu IS 1>
	 <!---<a id="link_to_us" href="javascript:linkToUs('/link_to_us.cfm')" class="footerlink">Link to Us</a> / ---><a id="privacy" class="footerlink" href="/privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="/terms.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:#request.comments_address#">Feedback</a>
		<cfelse>
			<cfif SESSION.partner_id NEQ 79><!---<a id="link_to_us" href="javascript:linkToUs('/link_to_us.cfm')" class="footerlink">Link to Us</a> / ---></cfif><a id="privacy" href="javascript:help2('/privacy_cf.cfm')"  class="footerlink">Privacy Policy</a> / <a href="javascript:help2('/terms.cfm')"  class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a>
		</cfif>
	</cfif>
	</div></div>
	<!---<div id="disclaimer">
		<cf_displayText code="site_walmart_disclaimer" group="site">
	</div>--->
	</div>
</cfif>
</cfif>
</cfoutput>
</div>
<cfif trim(attributes.tag) IS NOT "">
<cfoutput>
#attributes.tag#
</cfoutput>
</cfif>
</cfoutput>
<!---
</div>
<div class="FooterContainer HomePage" style="margin-left:-100px;"> 
<!-- Start: Module G4080: Global Footer --> 
<img src="http://i2.walmartimages.com/i/if/spacer.gif" width="1" height="1" border="0" alt="The Walmart.com site includes Flash technology. To avoid interruption of software designed to aid visually-impaired people, please turn off your Flash player."> 
<div id="g4080inner" class="GlobalFooter"> 
<div id="gFooterLeft" class="mainSpriteICN"> 
<div class="gFooterColumn"> 
<div class="ArialBold12">Financial Services</div> 
<ul class="NoBullet"> 
<li><a href="http://www.walmart.com/cp/walmart-money-center/5433">Walmart MoneyCenter</a></li> 
</ul> 
<a href="http://www.walmart.com/credit"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="130" height="51" border="0" alt="Walmart Credit Cards" title="Walmart Credit Cards"></a> 
<ul class="NoBullet"> 
<li><a href="http://www.walmart.com/cp/Credit-Cards/632402">Walmart Credit Cards</a></li> 
<li><a href="http://www.walmart.com/instantcredit">Apply Now</a></li> 
<li class="lastItem"><a href="https://www2.onlinecreditcenter6.com/consumergen2/login.do?accountType=generic&clientId=walmart&langId=en&subActionId=1000">Manage Account &amp; Pay Bill</a></li> 
</ul> 
</div> 
</div> 
<div class="gFooterColumn"> 
<div class="ArialBold12">Walmart.com</div> 
<ul class="NoBullet"> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=542412">About Walmart.com</a></li> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=538449">Terms of Use</a></li> 
<li><a href="http://affiliates.walmart.com/aff_home.jsp">Affiliate Program</a></li> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=538456">International Customers</a></li> 
<li><a href="http://www.walmart.com/cservice/contextual_help_popup.gsp?modId=971879" onclick="return popupWindow('/cservice/contextual_help_popup.gsp?modId=971879', '', 550, 500)">About Our Ads</a></li> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=121828">See All Departments</a></li> 
</ul> 
</div> 
<div class="gFooterColumn"> 
<div class="ArialBold12">Stores &amp; Corporate</div> 
<ul class="NoBullet"> 
<li><a href="http://www.walmart.com/cservice/ca_storefinder.gsp">Store Finder</a></li> 
<li><a href="http://walmartstores.com/">Corporate Website</a></li> 
<li><a href="http://walmartstores.com/diversity/">Diversity</a></li> 
<li><a href="http://investors.walmartstores.com/">Investor Relations</a></li> 
<li><a href="http://walmartstores.com/PrivacySecurity/?sourceid=walmart.com-footer">Privacy &amp; Security</a></li> 
<li><a href="http://www.walmart.com/wf.gsp/a_d_registration_flow/landing" onclick="s_objectID=&quot;/wf.gsp/a_d_registration_flow/landing_1&quot;;return this.s_oc?this.s_oc(e):true">Associate Discount</a></li> 
<li><a href="http://walmartstores.com/9243.aspx#California">California Privacy Rights</a></li> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=1044526">Careers at Walmart</a></li> 
</ul> 
</div> 
<div class="gFooterColumn"> 
<div class="ArialBold12">Help</div> 
<ul class="NoBullet"> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=5436">Help Center</a></li> 
<li><a href="http://www.walmart.com/cservice/li_trackorder.gsp?NavMode=2">Track Your Order</a></li> 
<li><a href="http://www.walmart.com/catalog/catalog.gsp?cat=538459">Returns Policy</a></li> 
<li><a href="http://www.walmart.com/returns/returns_type.gsp">Return an Item</a></li> 
<li><a href="http://walmartstores.com/Recalls/">Product Recalls</a></li> 
<li><a href="http://www.walmart.com/cservice/cu_comments_online.gsp?cu_heading=8">Contact Us</a></li> 
<!-- Start InlineOpinion Link --> 
<li><a href="http://www.walmart.comjavascript:void(0);" onClick="javascript:oOobj2.OnClick();">Feedback<img style="display:inline; padding-left:5px;" src="http://i2.walmartimages.com/i/opinionlab/sm_000_oo.gif"/></a></li> 
<!-- End InlineOpinion Link --> 
</ul> 
</div> 
<p class="clear"><!-- --></p> 
<div class="Copyright BodyX">&copy; 2011 Wal-Mart Stores, Inc.</div> 
</div> 
<!-- End: Module G4080: Global Footer --> 
<div id = "PanelContainerProductServices"></div> 
<div style='display:none' id='webanalytics'> 
<!-- begin webanalytics --> 
<!-- SiteCatalyst code version: H.20.3
Copyright 1996-2009 Adobe, Inc. All Rights Reserved
More info available at http://www.omniture.com
--> 
<script language="JavaScript" type="text/javascript"><!--
var s_account="walmartcom";//-->
</script> 
<script language="JavaScript" type="text/javascript" src="http://i2.walmartimages.com/webanalytics/omniture/s_code.js"> 
</script> 
<script language="JavaScript" type="text/javascript"> 
<!--
s_omni.pageName="Homepage";
s_omni.server="";
s_omni.channel="";
var omni = {
"adid" : s_omni.getQueryParam('adid'),
"fbref" : s_omni.getQueryParam('fb_ref'),
"sourceid" : s_omni.getQueryParam('sourceid'),
"povid" : s_omni.getQueryParam('povid'),
"findingMethod" : s_omni.getQueryParam('findingMethod'),
getCampaignId : function() {
if(this.adid) { return this.adid; }
else if (this.fbref) { return this.fbref.split('_')[1]; }
else if (this.sourceid){ return this.sourceid; }
else { return ''; }
}
};
s_omni.campaign=omni.getCampaignId();
s_omni.prop1="Homepage";
s_omni.prop2="Homepage ";
s_omni.prop3="Homepage";
s_omni.prop4="Homepage";
s_omni.prop5="Homepage";
s_omni.prop8="Homepage";
s_omni.prop38="Homepage";
BrowserPreference.refresh();
var preferredStoreId = BrowserPreference.PREFSTORE;
s_omni.prop39="Store Selected";
if(preferredStoreId === undefined){
s_omni.prop39="Store Not Selected";
}
s_omni.prop42="Homepage";
s_omni.eVar40 = s_omni.prop39;
//-->
</script> 
<script language="JavaScript" type="text/javascript"><!--
if (typeof buildSmartSearchVars === 'function') buildSmartSearchVars();
var s_code=s_omni.t();if(s_code) document.write(s_code);if (typeof resetSmartSearchVars === 'function' && !WALMART.bot.PageDisplayHelper.QLBOTHelper.isQuickViewPage) resetSmartSearchVars();//-->
</script> 
<!-- End SiteCatalyst code version: H.20.3 --> 
<!-- end webanalytics --> 
</div> 
<script type="text/javascript" src="http://cts.channelintelligence.com/841291_landing.js"></script> 
<!-- jsBottom.js for yga --> 

<script type="text/javascript"> 
OAS_url = "http://oascentral.walmartwom.com/RealMedia/ads/"; // Ad Server URL:
OAS_sitepage = "wmt/homepage"; // Virtual URL, format (case sensitive) : 'www.site.com/
OAS_listpos = "Right1,Bottom1";
OAS_query = ''; //Search Terms, format (case sensitive)
OAS_target = '_blank'; // Window parameter for clicks : (_top or _blank)
// get encrypted customer id
var customerId = getCookie('com.wm.customer');
if (customerId!=null){
var idx= customerId.indexOf('~~');
if (customerId) {
OAS_query= 'XE&oas_clientCode='+customerId.substring(5,idx)+'&XE';
}
}
//get visitor id
var visitorId = getCookie('com.wm.visitor');
if (visitorId!=null && visitorId!=""){
OAS_query= 'visitorId='+visitorId+ "&"+OAS_query;
}
if((BrowserPreference.NPTB!=-1)&&(BrowserPreference.NPTB!=undefined)){
OAS_query = "NextProductToBuy="+escape(BrowserPreference.NPTB)+ "&"+OAS_query;
}
//-->
</script> 
<script type="text/javascript"> 
// Generate random number for cache busting
OAS_rn = new String(Math.random());
OAS_rns = OAS_rn.substring(2, 11);
// Function to find the object in the DOM model
function getObj(name) {
if (document.getElementById) this.obj = document.getElementById(name);
else if (document.all) this.obj = document.all[name];
else if (document.layers) this.obj = document.layers[name];
if (this.obj) this.style = this.obj.style;
}
// Add a body load function, not overridding existing ones
function addLoad(func) {
if (window.addEventListener) window.addEventListener('load', func, false);
else if (document.addEventListener) document.addEventListener('load', func, false);
else if (window.attachEvent) window.attachEvent('onload', func);
else if (typeof window.onload != 'function') window.onload = func;
else {
var oldonload = window.onload;
window.onload = function() {
oldonload();
func();
};
}
}
// onLoad function that move objects in the DOM and make them visible
function OAS_AMJX_init() {
var apos = OAS_listpos.split(',');
var olddocwrite = document.write;
for (var i = 0; i < apos.length; i++) {
var object_togo = new getObj('OAS_' + apos[i]);
var object_tomove = new getObj('Hidden_OAS_' + apos[i]);
html = "";
if (typeof (object_togo.obj) != 'undefined' && typeof (object_tomove.obj) !=
'undefined') {
object_togo.obj.appendChild(object_tomove.obj);
object_tomove.style.display = 'inline';
}
}
}
// write the MJX call
document.write('<scr' + 'ipt type="text/javascript" src="' + OAS_url + 'adstream_mjx.ads/'
+ OAS_sitepage + '/1' + OAS_rns + '@' + OAS_listpos + '?' + OAS_query + '"><\/script>');
// Check for DOM Support
if (document.getElementById && document.createTextNode) addLoad(OAS_AMJX_init);
// Function to deliver if OAS is unreachable
function OAS_NORMAL(pos) {
document.write('<a href="http://www.walmart.com' + OAS_url + 'click_nx.ads/' + OAS_sitepage + '/1' +
OAS_rns + '@' + OAS_listpos + '!' + pos + '?' + OAS_query + '" target=' + OAS_target +
'>');
document.write('<img src="' + OAS_url + 'adstream_nx.ads/' + OAS_sitepage + '/1'
+ OAS_rns + '@' + OAS_listpos + '!' + pos + '?' + OAS_query + '" border="0" /></a>');
}
// Function to Select Ad Function
function OAS_AD(pos) {
typeof OAS_RICH != 'undefined' ? OAS_RICH(pos) : OAS_NORMAL(pos);
//OAS_version >= 11 ? OAS_RICH(pos) : OAS_NORMAL(pos);
}
</script> 

<div id="Hidden_OAS_Right1" style="display: none;"> 
<script language="javascript" type="text/javascript"> 
<!--
OAS_AD('Right1');
//-->
</script> 
</div> 
<div id="Hidden_OAS_Bottom1" style="display: none;"> 
<script language="javascript" type="text/javascript"> 
<!--
OAS_AD('Bottom1');
//-->
</script> 
</div> 
 
<!-- OPINIONLAB ENGINE JS; NECESSARY FOR ALL IMPLEMENTATIONS --> 
<script src="http://i2.walmartimages.com/js/opinionlab/oo_engine_c.js" type="text/javascript"></script> 
<!-- FEEDBACK PLUG-IN ; INLINE FEEDBACK LINK SURVEY --> 
<script src="http://i2.walmartimages.com/js/opinionlab/oo_conf_en-US_inline.js" type="text/javascript"></script> 
<script type="text/javascript"> 
try {
WALMART.richmedia.load();
}
catch (e) {}
</script> 
<!-- Rich Relevance Tagging Start --> 
<!-- CASE00304830 add a disableRRCall in case the Rich Relevance tagging is no need to be called  --> 
<!-- Rich Relevance Tagging End --> 
</div> 
</div> 
<!--[if lt IE 7]>
<iframe id="overlay" src="http://content-cdn.walmart.com/domain.html" name="overlay" frameborder="0" scrolling="no"></iframe>
<![endif]--> 
<!--[if gt IE 6]>
<iframe id="overlay" src="http://content-cdn.walmart.com/domain.html" name="overlay" frameborder="0" scrolling="no" allowTransparency="yes"></iframe>
<![endif]--> 
<![if ! IE]> 
<iframe id="overlay" src="about:blank" name="overlay" frameborder="0" scrolling="no" allowTransparency="yes"></iframe> 
<![endif]> 
<div class="BodyXS" style="color:#FFFFFF;width:565px;clear:both"> 
<div>ew182</div> 
<div>/index.gsp</div> 
<div>/index.gsp</div> 
category id: 14503 path:
<div>Category Id: 14503</div> 
</div> 
<style type="text/css"> 
.yui-panel{
font-family:Verdana,sans-serif;
}
.LocalStore .CloseWindowBtn_30{
margin:10px 0 0;
padding-bottom:5px
}
</style> 
<div id="box" class="OverlayBody" style=" width:532px;"> 
<!-- Start Module X3126: Overlay Confirm --> 
<table> 
<tr> 
<td class="LocalStore" style="width:532px;"> 
<div class="CornerTopLeft"></div> 
<div class="CornerTopRight"></div> 
</td> 
<td class="dropShadowRight" rowspan="2"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="6" height="6" alt=""></td> 
</tr> 
<tr> 
<td class="LocalStore"> 
<div class="RoundedBox"> 
<div class="TitleArea"> 
<div class="OverlayTitle"><h3 id="Handle" class="Popup5XL">Your Local Store</h3></div> 
<div class="OverlayClose"><a id="TRANSITION_CLOSE" href="javascript:;" class="CloseLink BodyXSBold">close<img src="http://i2.walmartimages.com/i/if/spacer.gif" alt="" class="mainSpriteBTN CloseBtn"></a></div> 
<p class="clear"><!-- --></p> 
</div> 
<div class="OverlayMargin"> 
<div class="CornerTop"><img src="http://i2.walmartimages.com/i/corners/margin-toplf.gif" width="2" height="2" alt=""></div> 
<div class="OverlayContent VibsConfsWrap"> 
<div id="CONFIRMATION_WITH_PUT_DESC" style="display:none;"> 
<div class="BodyMBold">Your Selected Store Has Been Saved</div> 
<p class="BodyM">When you browse Walmart.com, you&#39;ll see products available online and in the <span id="LOCAL_STORE_CITY1" class="BodyXLBold">[city name]</span> store. This store is also saved for the Store Finder feature and your Local Ad.</p> 
<!-- IF the customer has NOT yet selected a store (no store in the cookie) THEN display this module. add by iwang--> 
<div id="NO_STORE_SELECTED" style="display:none;"> 
<div id="CnPModule"> 
<div class="CornerTopLeft"></div> 
<div class="CornerTopRight"></div> 
<div class="RoundedBox"> 
<table> 
<tr> 
<td valign="top"><img class="mainSpriteICN pickupTodayLogo" height="16" width="121" alt="Pick Up Today" src="http://i2.walmartimages.com/i/if/spacer.gif"/></td> 
<td width="15"></td> 
<td> 
<div class="BodyMBoldOrg">New Feature &ndash; Pay Online and Pick Up Today</div> 
<div style="font-size:11px;" >Place your order on Walmart.com and we'll have your order ready at your selected store for you to pick up later.</div> 
</td> 
</tr> 
</table> 
</div> 
<div class="CornerBtmLeft"></div> 
<div class="CornerBtmRight"></div> 
</div> 
</div> 
<!-- END IF the customer has NOT yet selected a store--> 
<!--IF the customer is changing their store (store is in the cookie) THEN display the following message: add by iwang--> 
<div id="STORE_SELECTED" style="display:block;"> 
<p style="margin-top:20px;" class="BodyXS"><span class="ImportantXSBold">Please note:</span> If you have Pick Up Today items in your cart, the pickup store has been changed to this new location. Please review your cart &ndash; the availability of your Pick Up Today items may have changed.</p> 
</div> 
<!--END  IF the customer is changing their store--> 
<a id="TRANSITION_BUTTON" href="javascript:;"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="49" height="19" border="0" alt="Close" class="mainSpriteBTN CloseWindowBtn_30"></a> 
</div> 
<div id="CONFIRMATION_NORMAL" style="display:none;" > 
<div class="Body2XL">Your Selected Store Has Been Saved</div> 
<p class="BodyXL">When you browse Walmart.com, you'll see products available online and in the <span id="LOCAL_STORE_CITY" class="BodyXLBold">[city name]</span> store. This store is also saved for the Store Finder feature and the Local Ad.</p> 
<p class="BodyS">You can change this store anytime using the View Products in Your Store feature or by using Store Finder or the Find in Store feature throughout the site.</p> 
<a id="TRANSITION_BUTTON1" href="javascript:;"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="49" height="19" border="0" alt="Close" class="mainSpriteBTN CloseWindowBtn_30"></a> 
</div> 
</div> 
<div class="CornerBottom"><img src="http://i2.walmartimages.com/i/corners/margin-botlf.gif" width="2" height="2" alt=""></div> 
</div> 
<div class="BottomPad">&nbsp;</div> 
</div> 
<div class="CornerBtmLeft"></div> 
<div class="CornerBtmRight"></div> 
</td> 
</tr> 
<tr> 
<td class="dropShadowBottom"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="1" height="6" alt=""></td> 
<td class="dropShadowCorner"><img src="http://i2.walmartimages.com/i/if/spacer.gif" width="6" height="6" alt=""></td> 
</tr> 
</table> 
<div id="ErrorOffset" class="Error"><span class="ErrorM">&nbsp;</span></div> 
<!-- End Module X3126: Overlay Confirm --> 
</div> 
<script type="text/javascript" language="JavaScript"> 
if(typeof YAHOO.wm == 'undefined') {
YAHOO.namespace("wm.container");
}
// Initialize the temporary Panel to display while waiting for external content to load
YAHOO.wm.container.box = null
function initConfirmBox() {
YAHOO.wm.container.box = new YAHOO.widget.Panel("box",
{
fixedcenter:true,
close:false,
draggable:false,
modal:true,
visible:false
}
);
//YAHOO.example.container.wait.setHeader("Loading, please wait...");
//YAHOO.wm.container.box.setBody(document.getElementById("box"));
YAHOO.wm.container.box.render("wm");
YAHOO.util.Event.addListener("TRANSITION_BUTTON1", "click", hide);
YAHOO.util.Event.addListener("TRANSITION_BUTTON", "click", hide);
YAHOO.util.Event.addListener("TRANSITION_CLOSE", "click", hide);
}
//show();
var localStoreItemId = '';
var localStore = '';
function show(itemId, store) {
document.body.style.position='static';
document.getElementById("LOCAL_STORE_CITY").innerHTML = store.address.city;
if(document.getElementById("LOCAL_STORE_CITY1"))
document.getElementById("LOCAL_STORE_CITY1").innerHTML = store.address.city;
YAHOO.wm.container.box.show();
if(typeof itemId != 'undefined') {
localStoreItemId=itemId;
localStore = store;
} else {
localStoreItemId='';
localStore='';
}
}
function hide() {
document.body.style.position='relative';
YAHOO.wm.container.box.hide();
// do not call doAction if isCallingFromHeaderStoreModule is true
if ((typeof isCallingFromHeaderStoreModule != 'undefined') && isCallingFromHeaderStoreModule){
isCallingFromHeaderStoreModule = false;
}else{
doAction(localStoreItemId, localStore);
}
//when the parent is from cart page, go to cart page
if(parent.window.location.href.indexOf("cart") != -1){
parent.window.location.href = "/cart.gsp?isClearCache=true";
}
}
function loadConfirmationType(isStorePUTEligible){
var PUT_SWITCH_ON = true;
if( PUT_SWITCH_ON && isStorePUTEligible) {
if(document.getElementById('CONFIRMATION_WITH_PUT_DESC'))
document.getElementById('CONFIRMATION_WITH_PUT_DESC').style.display="block";
if(document.getElementById('CONFIRMATION_NORMAL'))
document.getElementById('CONFIRMATION_NORMAL').style.display="none";
} else {
//set default display status
if(document.getElementById('CONFIRMATION_WITH_PUT_DESC'))
document.getElementById('CONFIRMATION_WITH_PUT_DESC').style.display="none";
if(document.getElementById('CONFIRMATION_NORMAL'))
document.getElementById('CONFIRMATION_NORMAL').style.display="block";
}
}
function loadPUTDescription(isStoreSelected) {
if(isStoreSelected) {
//user has selected store before, display the related view
if(document.getElementById('NO_STORE_SELECTED'))
document.getElementById('NO_STORE_SELECTED').style.display = 'none';
if(document.getElementById('STORE_SELECTED'))
document.getElementById('STORE_SELECTED').style.display = 'block';
} else {
//user didn't select store before, display the related view
if(document.getElementById('NO_STORE_SELECTED'))
document.getElementById('NO_STORE_SELECTED').style.display = 'block';
if(document.getElementById('STORE_SELECTED'))
document.getElementById('STORE_SELECTED').style.display = 'none';
}
}
function doAction(localStoreItemId, localStore) {}
//YAHOO.util.Event.addListener(window, "load", init);
YAHOO.util.Event.onDOMReady(initConfirmBox);
</script> 
<div id="ROLLOVER" class="ToolTip"> 
<img id="TRIANGLE_IMG_TOP" style="display:none" src="http://i2.walmartimages.com/i/if/miniOverlay_triangle_top.gif" width="8" height="9" alt="" class="TriangleTop"> 
<div class="CornerTopLeft"></div> 
<div class="CornerTopRight"></div> 
<div id="CONTENT_BOX" class="RoundedBox"> 
<img id="ROLLOVER_CLOSE" class="mainSpriteBTN close_x_box" style="display:none" align="right" src="http://i2.walmartimages.com/i/if/spacer.gif" alt=""> 
<div id="CONTENT" class="TipContent"> 
<div id="ROLLOVER_CITY" style="display:none"></div> 
<div id="ROLLOVER_ADDR1" style="display:none"></div> 
<div id="ROLLOVER_ADDR2" style="display:none"></div> 
<div id="ROLLOVER_OTHER_TEXT" style="display:none"></div> 
<div id="ROLLOVER_PICKUP_HOUR" style="display:none"></div> 
</div> 
</div> 
<div class="CornerBtmLeft"></div> 
<div class="CornerBtmRight"></div> 
<img id="TRIANGLE_IMG_BOTTOM1" style="display:none" src="http://i2.walmartimages.com/i/if/miniOverlay_triangle.gif" width="8" height="9" alt="" class="Triangle"> 
</div> 
<script type="text/javascript" language="JavaScript"> 
if(typeof YAHOO.wm == 'undefined') {
YAHOO.namespace("wm.container");
}
var whatIsThisText = 'Select your local Walmart to see information about products in that store while you browse Walmart.com.'
var DEFAULT_WIDTH="190px";
YAHOO.wm.container.rollover = new YAHOO.widget.Overlay("ROLLOVER", {
visible:false,
width:DEFAULT_WIDTH,
zIndex:101000 /*Set high in order to always display above mask zIndex of 99999 in slap_overlay.jsp*/
/*,
effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.5}*/ } );
YAHOO.wm.container.rollover.render("wm");
YAHOO.util.Event.addListener(document, "click", hideRollover);
YAHOO.util.Event.addListener("ROLLOVER", "mouseover", setEnteredRollover);
if(document.getElementById("put_storeRollover") != null) {
YAHOO.util.Event.addListener("put_storeRollover", "mouseover", showPreferredStoreRollover, 1);
}
if(document.getElementById("storeRollover_1") != null) {
YAHOO.util.Event.addListener("storeRollover_1", "mouseover", showPreferredStoreRollover, 1);
}
if(document.getElementById("storeRollover_2") != null) {
YAHOO.util.Event.addListener("storeRollover_2", "mouseover", showPreferredStoreRollover, 2);
}
if(document.getElementById("storeRollover_3") != null) {
YAHOO.util.Event.addListener("storeRollover_3", "mouseover", showPreferredStoreRollover, 3);
}
if(document.getElementById("storePickupHours") != null){
YAHOO.util.Event.addListener("storePickupHours", "mouseover", showPreferredStoreRollover, 3);
}
//var enteredRollover=false;
function setEnteredRollover(e){
//enteredRollover = true;
clearTimeout(hideTimer);
if(document.getElementById("ROLLOVER_CLOSE").style.display == 'none') {
setHideTimer(MIN_DISPLAY_TIME);
}
//YAHOO.util.Event.addListener(document, "mouseover", checkHide);
}
/*
function checkHide(e){
var el = getSourceElementId(e);
if(enteredRollover && (el!='' && el!='ROLLOVER' && el!='CONTENT_BOX' && el!='ROLLOVER_CLOSE' && el!='CONTENT' && el!='ROLLOVER_CITY' && el!='ROLLOVER_ADDR1' && el!='ROLLOVER_ADDR2' && el!='ROLLOVER_OTHER_TEXT')) {
hideRollover();
enteredRollover=false;
YAHOO.util.Event.removeListener(document, "mouseover", checkHide);
}
}
*/
function getSourceElementId(e){
e = (e) ? e : ((window.event) ? window.event : "")
var el=null;
try{
el = e.srcElement.id;
}catch(ex){
el = e.target.id;
}
return el;
}
var MIN_DISPLAY_TIME = 3500;
function showRollover(e, text, width){
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
if(width != undefined) {
YAHOO.wm.container.rollover.cfg.setProperty("width", width+"px");
}
else{
YAHOO.wm.container.rollover.cfg.setProperty("width", DEFAULT_WIDTH);
}
resetRollover();
document.getElementById("ROLLOVER_OTHER_TEXT").style.display = '';
document.getElementById("TRIANGLE_IMG_TOP").style.display = '';
document.getElementById("ROLLOVER_CLOSE").style.display = '';
document.getElementById("ROLLOVER_OTHER_TEXT").innerHTML = text;
e = (e) ? e : ((window.event) ? window.event : "")
YAHOO.wm.container.rollover.cfg.setProperty("xy", [getX(e),getY(e, 0)]);
YAHOO.wm.container.rollover.show();
}
function showOverlayRollover(x,y){
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
resetRollover();
document.getElementById("ROLLOVER_OTHER_TEXT").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_OTHER_TEXT").innerHTML = whatIsThisText;
YAHOO.wm.container.rollover.cfg.setProperty("xy", [x,y]);
YAHOO.wm.container.rollover.show();
}
function showPickupHourRollover(x,y,businessHours){
if(businessHours != undefined && businessHours.length >= 3){
var businessHourM2FText = generateBusinessHourText(businessHours[2]);
var businessHourSATText = generateBusinessHourText(businessHours[0]);
var businessHourSUNText = generateBusinessHourText(businessHours[1]);
pickupHourInfo = '<div class="BodyM">Monday &ndash; Friday</div><div class="BodyMBold">'
+businessHourM2FText
+'</div><div style="font-size:5px;">&nbsp;</div><div class="BodyM">Saturday</div>'
+'<div class="BodyMBold">'+businessHourSATText +'</div>'
+'</div><div style="font-size:5px;">&nbsp;</div><div class="BodyM">Sunday</div>'
+'<div class="BodyMBold">'+businessHourSUNText +'</div>';
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
resetRollover();
document.getElementById("ROLLOVER_PICKUP_HOUR").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_PICKUP_HOUR").innerHTML = pickupHourInfo;
YAHOO.wm.container.rollover.cfg.setProperty("xy", [x,y]);
YAHOO.wm.container.rollover.show();
document.getElementById("ROLLOVER").style.top = (parseInt(document.getElementById("ROLLOVER").style.top.replace("px","")) - 114) +"px";
}else{
pickupHourInfo = '<div class="BodyM">Please call for store hours.</div>';
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
resetRollover();
document.getElementById("ROLLOVER_PICKUP_HOUR").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_PICKUP_HOUR").innerHTML = pickupHourInfo;
YAHOO.wm.container.rollover.cfg.setProperty("xy", [x,y]);
YAHOO.wm.container.rollover.show();
document.getElementById("ROLLOVER").style.top = (parseInt(document.getElementById("ROLLOVER").style.top.replace("px","")) - 38) +"px";
}
}
function generateBusinessHourText(businessHour){
if(businessHour){
openTime = businessHour.openTime;
closeTime = businessHour.closeTime;
if((openTime =='-1:-1 am' || openTime =='00:00 am') && closeTime == '00:00 am'){
return 'Closed';
}else if(openTime =='00:00 am' && (closeTime == '11:59 pm' || closeTime == '-1:-1 am')){
return 'Open 24 hours';
}else{
return openTime +' &ndash; '+ closeTime;
}
}
}
/*
* This method added for VIBS project which used to show online price tooltip.
*/
function showOnlinePriceOverlayRollover(e){
var onliePriceTipContent = 'In-store prices vary from online prices - please visit your store for exact pricing. Online prices are not honored in our stores.'
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
resetRollover();
document.getElementById("ROLLOVER_OTHER_TEXT").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_OTHER_TEXT").innerHTML = onliePriceTipContent;
e = (e) ? e : ((event) ? event : "")
YAHOO.wm.container.rollover.cfg.setProperty("xy", [getX(e), getY(e) - 25]);
YAHOO.wm.container.rollover.show();
}
var isRolloverShown = false;
var rolloverIndex=0;
function showPreferredStoreRollover(e, ind){
var slapStoresData = WALMART.bot.stores;
var spulStoresData = WALMART.spul.stores;
var storesData = (typeof slapStoresData !== 'undefined' && slapStoresData && slapStoresData != '' && slapStoresData.stores != '') ? slapStoresData : spulStoresData;
if (storesData != null && storesData.stores != null && storesData.stores !='' && (!isRolloverShown || rolloverIndex != ind)){
rolloverIndex=ind;
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
e = (e) ? e : ((window.event) ? window.event : "")
var el = YAHOO.util.Event.getTarget(e);
var storeIndex = ind-1;
resetRollover();
document.getElementById("ROLLOVER_CITY").style.display = '';
document.getElementById("ROLLOVER_ADDR1").style.display = '';
document.getElementById("ROLLOVER_ADDR2").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_CITY").innerHTML = storesData.stores[storeIndex].address.city;
document.getElementById("ROLLOVER_ADDR1").innerHTML = storesData.stores[storeIndex].address.fullStreet;
document.getElementById("ROLLOVER_ADDR2").innerHTML = storesData.stores[storeIndex].address.city +", "+ storesData.stores[storeIndex].address.stateCode +" "+storesData.stores[storeIndex].address.zipCode;
//alert(document.getElementById("ROLLOVER_CITY").innerHTML);
YAHOO.wm.container.rollover.cfg.setProperty("xy", [findPosX(el), findPosY(el)-66]);
YAHOO.wm.container.rollover.show();
}
}
function showSelectedStoreRollover(e,city,fullstreet,zip,state){
//  if (store!=null ){
//rolloverIndex=ind;
isRolloverShown = true;
setHideTimer(MIN_DISPLAY_TIME);
e = (e) ? e : ((window.event) ? window.event : "")
resetRollover();
document.getElementById("ROLLOVER_CITY").style.display = '';
document.getElementById("ROLLOVER_ADDR1").style.display = '';
document.getElementById("ROLLOVER_ADDR2").style.display = '';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = '';
document.getElementById("ROLLOVER_CITY").innerHTML = city//store.address.city;
document.getElementById("ROLLOVER_ADDR1").innerHTML = fullstreet//store.address.fullStreet;
document.getElementById("ROLLOVER_ADDR2").innerHTML = city +", " +  state + " " + zip;
YAHOO.wm.container.rollover.cfg.setProperty("xy", [getX(e),getY(e)]);
YAHOO.wm.container.rollover.show();
//}
}
function showSOIRollover(e, desc){
showRollover(e, desc);
}
function hideRollover(e){
YAHOO.wm.container.rollover.hide();
isRolloverShown = false;
clearTimeout(hideTimer);
}
function resetRollover(){
document.getElementById("ROLLOVER_CITY").style.display = 'none';
document.getElementById("ROLLOVER_ADDR1").style.display = 'none';
document.getElementById("ROLLOVER_ADDR2").style.display = 'none';
document.getElementById("ROLLOVER_OTHER_TEXT").style.display = 'none';
document.getElementById("TRIANGLE_IMG_TOP").style.display = 'none';
document.getElementById("TRIANGLE_IMG_BOTTOM1").style.display = 'none';
document.getElementById("ROLLOVER_CLOSE").style.display = 'none';
document.getElementById("ROLLOVER_PICKUP_HOUR").style.display = 'none';
}
var hideTimer;
function setHideTimer(elapseVal){
clearTimeout(hideTimer);
hideTimer = setTimeout("hideRollover()", elapseVal);
}
var isOpera = (navigator.userAgent.indexOf('Opera') != -1);
var isIE = (!isOpera && navigator.userAgent.indexOf('MSIE') != -1)
function getX(e){
var posx;
if (e.pageX){
posx = e.pageX;
}
else if (e.clientX){
posx = e.clientX;
if (isIE){
posx += top.document.documentElement.scrollLeft + top.document.body.scrollLeft;
}
}
return posx;
}
function getY(e, offset){
var defaultOffset=66;
var posy;
if (e.pageY){
posy = e.pageY;
}
else if (e.clientY){
posy = e.clientY;
if (isIE){
posy += top.document.documentElement.scrollTop + top.document.body.scrollTop;
}
}
if ( offset==undefined){
posy -= defaultOffset;
}
else{
posy-=offset
}
return posy;
}
</script> 
<script type="text/javascript" language="JavaScript"> 
YAHOO.util.Event.addListener(this, "beforeunload", function(){
BrowserPreference.updateSessionCookie('FROMCATREF', '14503');
});
function doAction(itemId,store) { //overriding this method from localstore_confirmed.jsp
// this is accessed from 2 distinct storefinders VIBS and SLAP
if ((typeof(vibsStoreFinder) != "undefined") && (vibsStoreFinder != undefined) && vibsStoreFinder) {
vibsStoreFinder=false;
top.curStore = store;
setPrefStore();
}
//directly using top.location.href doesn't work in IE6, use setTimeout funtion to enable going to desired tab
setTimeout(function(){top.location = top.location.href;}, 0);
return false;
}
</script> 
</body> 
--->