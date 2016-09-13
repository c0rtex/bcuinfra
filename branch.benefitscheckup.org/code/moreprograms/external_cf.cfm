<cfoutput>
<cfif val(partnerQuery.wrapper_external)><div class="icon"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></div>
<div class="apply2"><div class="h1">#partnerQuery.wrapper_external_title#:</div>
<cfif trim(partnerQuery.wrapper_external_time) IS NOT ""><p class="text1"><em>Typically takes #partnerQuery.wrapper_external_time# minutes.</em></p></cfif>

<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td valign="top" width="100%">
        	<div class="box">
				<div class="box-outer">
					<div class="box-inner">
						<!--- <h2 style="margin-bottom:8px;"> --->
                        <div class="box-content">&nbsp;
							<cfif trim(partnerQuery.wrapper_external_title_graphic) IS NOT ""><img src="img/partners/#partnerQuery.wrapper_external_title_graphic#" /></cfif>
                        </div>
                        <!--- </h2> --->
						<div class="box-content2">
							<p class="text1">#partnerQuery.wrapper_external_text#</p>
							<p class="text10" style="margin-bottom:0px;">
								<cf_sessionPassVars href="redirect.cfm?partner_id=#session.partner_id#&id=#partnerQuery.wrapper_external_link#&tgt=1" target="#partnerQuery.wrapper_external_link#" subset_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                            </p>
						</div>
					</div>
				</div>	
			</div>
		</td>
	</tr>
</table>

</div>

<p style="clear:both; height:8px; margin: 0px;"></p>
</cfif>
</cfoutput>