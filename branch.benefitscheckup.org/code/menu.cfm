<cfsilent>
<cfparam name="menu_tab" default="">
</cfsilent>
<cfoutput>
<div id="menu0">
<ul id="globalnav">
<li <cfif attributes.guts IS "index_cf.cfm">id = "menu_homeh"<cfelse> id = "menu_home"</cfif>><cf_sessionPassVars href="index.cfm" extralist="gohome=true" target="_top" prev_id="0">Home</cf_sessionPassVars></li>

<li <cfif attributes.guts IS "find_benefits_cf.cfm" OR attributes.guts IS "moreprograms_cf.cfm" OR attributes.guts IS "apply_cf.cfm" OR attributes.guts IS "ec" >id = "menu_findh"<cfelse> id = "menu_find"</cfif>><cf_sessionPassVars href="moreprograms.cfm" prev_id="0">Find Benefits</cf_sessionPassVars></li>

<li <cfif attributes.guts IS "about_cf.cfm"> id = "menu_abouth"<cfelse> id = "menu_about"</cfif>><cf_sessionPassVars href="about.cfm" prev_id="0">About Us</cf_sessionPassVars></li>

<li <cfif cgi.PATH_TRANSLATED CONTAINS "bcunews"> id = "menu_newsh"<cfelse> id = "menu_news"</cfif>><cf_sessionPassVars href="bcunews/index.cfm" target="_top" prev_id="0">News</cf_sessionPassVars></li>

<li <cfif attributes.guts IS "partners_cf.cfm" OR attributes.guts IS "partner_cf.cfm"> id = "menu_partnersh"<cfelse> id = "menu_partners"</cfif>><cf_sessionPassVars href="sponsors.cfm" target="_top" prev_id="0">Sponsors</cf_sessionPassVars></li>

<li <cfif attributes.guts IS "donate_cf.cfm"> id = "menu_donateh"<cfelse> id = "menu_donate"</cfif>><cf_sessionPassVars href="donate.cfm" target="_top" prev_id="0">Donate</cf_sessionPassVars></li>

<li <cfif attributes.guts IS "refer_cf.cfm"> id = "menu_referh"<cfelse> id = "menu_refer"</cfif>><cf_sessionPassVars href="refer.cfm" target="_top" onmouseover="highlight('menu_refer')" prev_id="0">Refer a Friend</cf_sessionPassVars></li>

<li id = "menu_oe" style="background-color:fff;"><a href="http://#application.serverPathOE#" target="oe" onmouseover="highlight('menu_oe')" onmouseout="highlight_off('menu_oe')">Organization Users</a></li>
</ul>
</div></cfoutput>