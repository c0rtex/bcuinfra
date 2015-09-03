<cfoutput>
<cfif val(partnerQuery.wrapper_rx)>

<div class="icon"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></div>
<div class="apply2"><div class="h1">Medicare Rx Extra Help:</div>
<p class="text1"><em>Typically takes 10-15 minutes.</em> <a href="javascript:help2('neededinfo-27.cfm')">Click here</a> to see if you need to gather any information before you begin.

<cfif val(partnerQuery.wrapper_whatithelps) GT 0>
<a href="javascript:help2('<cfoutput>whatithelps.cfm?id=27</cfoutput>')">Click here</a> to see what benefit programs are included in this questionnaire.
</cfif>
</p>
<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="68%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 style="margin-bottom:8px;"><div class="box-content">Interactive Questionnaire (recommended)</div></h2>
			<div class="box-content2">
			<p class="text1">This is the quickest and easiest way to get started. You will only answer questions based on your unique needs, saving you time.</p>
			<p class="text10" style="margin-bottom:0px;"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=#SESSION.partner_id#" subset_id="27" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>
<td width="24">&nbsp;</td>
<td valign="top" width="30%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 style="margin-bottom:8px;"><div class="box-content">Printed Questionnaire</div></h2>
			<div class="box-content2">
			<p class="text1">Get a questionnaire to fill out by hand.</p>
<p class="text10" style="margin-bottom:0px;"><cf_sessionPassVars href="printed.cfm?partner_id=#SESSION.partner_id#" subset_id="27" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>
</tr>
</table>
</div>
<p style="clear:both; height:8px; margin: 0px;"></p>
</cfif>
</cfoutput>