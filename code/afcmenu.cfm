<cfparam name="menu_tab" default="index">
<cfparam name="org_id" default="">
<cfparam name="user_id" default="">
<cfoutput>
<div id="menu0">
<ul id="globalnav">
<li <cfif menu_tab IS "index">id = "menu_homeh"<cfelse> id = "menu_home"</cfif>><a href="http://<cfoutput>#APPLICATION.serverpathcanonical#/</cfoutput>ec/index.cfm?menu_tab=index&partner_id=11&org_id=#org_id#&user_id=#user_id#">How to Use</a></li>

<li <cfif menu_tab IS "drug">id = "menu_findh"<cfelse> id = "menu_find"</cfif>><a href="http://<cfoutput>#APPLICATION.serverpathcanonical#/</cfoutput>ec/drugs.cfm?menu_tab=drug&partner_id=11&org_id=#org_id#&user_id=#user_id#&drugs=brand">Search by Drug</a></li>

<li <cfif menu_tab IS "category"> id = "menu_abouth"<cfelse> id = "menu_about"</cfif>><a href="http://<cfoutput>#APPLICATION.serverpathcanonical#/</cfoutput>ec/category.cfm?menu_tab=category&partner_id=11&org_id=#org_id#&user_id=#user_id#&cat=PAP">Search by Category</a></li>

<li <cfif menu_tab IS "state"> id = "menu_newsh"<cfelse> id = "menu_news"</cfif>><a href="http://<cfoutput>#APPLICATION.serverpathcanonical#/</cfoutput>ec/state.cfm?menu_tab=state&partner_id=11&org_id=#org_id#&user_id=#user_id#&cat=ST">Search by State</a></li>

<li <cfif menu_tab IS "date"> id = "menu_partnersh"<cfelse> id = "menu_partners"</cfif>><a href="http://<cfoutput>#APPLICATION.serverpathcanonical#/</cfoutput>ec/date.cfm?menu_tab=date&partner_id=11&org_id=#org_id#&user_id=#user_id#&cat=pub">Search by Date</a></li>

</ul>
</div></cfoutput>