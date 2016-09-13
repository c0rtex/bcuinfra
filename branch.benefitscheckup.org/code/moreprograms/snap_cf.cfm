<cfoutput>

<div class="icon"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></div>

<div class="apply2"><div class="h1">Supplemental Nutrition Assistance Program (SNAP) Application Forms Service:</div>
<p class="text1"><em>Typically takes 10-15 minutes.</em> <a href="javascript:help2('neededinfo-19.cfm')">Click here</a> to see if you need to gather any information before you begin.

<cfif val(partnerQuery.wrapper_whatithelps) GT 0>
<a href="javascript:help2('<cfoutput>whatithelps.cfm?id=19</cfoutput>')">Click here</a> to see what benefit programs are included in this questionnaire.
</cfif>
</p>

<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="68%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2><div class="box-contentb">Interactive Map</div></h2>
			<div class="box-content2">
			<p class="text1">The Supplemental Nutrition Assistance Program (SNAP) (the new name for the federal Food Stamp Program) helps low-income individuals and families buy the food they need for good health. Although SNAP is the national name, your state may use a different name. </p>
			<p class="text10" style="margin-bottom:0px;"><cf_sessionPassVars href="snap.cfm?partner_id=#SESSION.partner_id#" subset_id="19" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>

</tr>
</table>
</div>
<p style="clear:both; height:8px; margin: 0px;"></p>

</cfoutput>