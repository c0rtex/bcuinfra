<cfset img = fix(rand() * 4)>
<cfif img IS 0 OR img IS 1>
	<cfset img = 1>
	<cfset alt = "Man and Woman with Child">
<cfelseif img IS 3 OR img IS 4>
	<cfset img = 3>
	<cfset alt = "Man with Child Hitting Ball">	
<cfelse>
	<cfset img = 2>
	<cfset alt = "Man with Child">	
</cfif>

<cfoutput>
<div style="padding:16px;">
<cf_displayImage code="img_partners_aarpkb_aarp#img#_jpg"  border="0" class="plimage" align="right">
<p class="introText"><cf_displayText group="site" code="site_aarp_qualifyforbenefits_best_place_to_start_2"></cfoutput> <a href="javascript:help2('<cfoutput>neededinfo-49.cfm</cfoutput>')" class="newslink2"><strong><cf_displayText group="site" code="site_aarp_qualifyforbenefits_click_here"></strong></a> <cf_displayText group="site" code="site_aarp_qualifyforbenefits_best_place_to_start_3"> <a href="javascript:help2('<cfoutput>whatithelps.cfm?id=49</cfoutput>')" class="newslink2"><strong><cf_displayText group="site" code="site_aarp_qualifyforbenefits_click_here"></strong></a> <cf_displayText group="site" code="site_aarp_qualifyforbenefits_best_place_to_start_4">
</p>

<p class="text10" style="margin-bottom:0px;"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=#SESSION.partner_id#" subset_id="49" class="linkbutton">Go!</cf_sessionPassVars></p>

<div class="clear" style="margin-bottom:20px;"></div>

<!---<p class="text1"><cf_displayText group="site" code="site_aarp_qualifyforbenefits_contact"></p>--->
</div>