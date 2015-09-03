<cfoutput>

<script language="Javascript1.2">
	var message = "Print this Page";

	function printpage() {
		window.print();  
		return false;
	}

</script>

<table cellpadding="0" cellspacing="0" border="0" class="snapTable">
<tr>
<td colspan="2" style="padding-bottom:8px;"><table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td class="text1"><span style="float:left; padding-bottom:4px;"><cf_sessionPassVars href="snap.cfm" prev_id="0" class="snapLink"><img src="img/back_button.gif" /></cf_sessionPassVars></span></td>
<td align="right" class="text1"> <span style="float:right; padding-bottom:4px;"><a href="##" onClick="printpage();" class="snapLink"><img src="img/print_this_page.gif" /></a></span></td>
</tr>
</table>
</td>
</tr>

<tr>
<td class="text1" valign="top" rowspan="2" class="snapLeftCol">

<h1 class="snapH1" style="margin-top:0px;">#snap_title#</h1>

#snap_state.description#</td>

<td class="text1" valign="top" style="white-space:300px;">

<div style="padding:6px 12px 8px; background-color: ##d7d7d7; width: 284px; margin-bottom:16px; margin-top:4px;">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td colspan="2" class="text1" style="height: 30px;"><h2 class="snapH2">Web Resources</h2></td>
</tr>
	
	<cfif trim(tbl_snap.snap_online_app) IS NOT "">
		<tr>
		<td class="text1" valign="top" width="24"><a href="#tbl_snap.snap_online_app#" target="#tbl_snap.snap_state#_info" class="snapLink"><cf_displayImage code="img_apply_gif" hspace="0" vspace="0"></a></td>
		<td class="text1" valign="top"><a href="#tbl_snap.snap_online_app#" target="#tbl_snap.snap_state#_info" class="snapLink">Online Application</a></td>
		</tr>
	</cfif>
	
	<cfif trim(snap_state.url) IS NOT "">
		<tr>
		<td class="text1" valign="top" width="24"><a href="#snap_state.url#" target="#snap_state.url#" class="snapLink"><cf_displayImage code="img_link_go_gif" hspace="0" vspace="0"></a></td>
		<td class="text1" valign="top"><a href="#snap_state.url#" target="#snap_state.url#" class="snapLink">State Website</a></td>
		</tr>
	</cfif>


	<cfif session.partner_id IS 22 OR session.partner_id IS 56>
		<cfset moreprograms_url = "/moreprograms.cfm">
		<cfset prtner_id = 22>
		<cfset sub_id = 49>
	<cfelse>
		<cfset moreprograms_url = "/before_you_start.cfm">
		<cfset sub_id = 0>
		<cfset prtner_id = session.partner_id>		
	</cfif>

<tr>
<td class="text1" valign="top" width="24"><cf_sessionPassVars href="#moreprograms_url#" partner_id="#prtner_id#" subset_id="#sub_id#" prev_id="0" class="snapLink"><cf_displayImage code="img_find_gif" hspace="0" vspace="0"></cf_sessionPassVars></td>
<td class="text1" valign="top"><cf_sessionPassVars href="#moreprograms_url#" partner_id="#prtner_id#" subset_id="#sub_id#" prev_id="0" class="snapLink">Find Out If You're Eligible</cf_sessionPassVars></td>
</tr>

</table>

</div>

<div class="snapRightCol">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
	<td colspan="2" class="text1" style="height: 30px;"><h2 class="snapH2">Application Forms</h2></td>
</tr>
	
<cfif forms.recordcount IS 0>
	<tr>
		<td colspan="2" class="text1">No Application Form Available</td>
	</tr>
<cfelse>
	<cfset setBreak = 0>
	<cfset doBreak = 0>
	
	<cfloop query="forms">
		<cfif findnocase('Food Only', tag_name) GT 0>
			<cfset foodStampLegend = 1>
		</cfif>
	
		<cfif findnocase('Multi-Program', tag_name) GT 0>
			<cfset multiProgramLegend = 1>
		</cfif>		
		
		<cfif formtype_id IS 4>
			<cfset fillableLegend = 1>
		</cfif>		
	
		<cfif findnocase('English', tag_name) IS 0 AND findnocase('Spanish', tag_name) IS 0 AND doBreak IS 0>
			<cfset doBreak = 1>
			<tr>
			<td colspan="2" class="text1"><hr size="1" noshade="noshade" /></td>
			</tr>
		</cfif>
		
		
		<tr>
		<cfset name = replacenocase(tag_name, 'Application', '')>
		<td class="text1" valign="top" width="24"><a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#string#" class="snapLink" target="#tag_name#"><cfif right(trim(string),4) IS ".pdf"><cf_displayImage code="img_pdf_gif" hspace="0" vspace="0"><cfelseif right(trim(string),4) IS ".doc"><cf_displayImage code="img_word_doc_gif" hspace="0" vspace="0"><cfelse><cf_displayImage code="img_apply_gif" hspace="0" vspace="0" class="snap_icon"></cfif></a></td>
		<td class="snapLegend" valign="top"><a href="form_redirect.cfm?id=#form_id#&tgtPartner=#session.partner_id#&tgt=/forms/#string#" class="snapLink" target="#tag_name#">#name#</a> <cfif formtype_id IS 4><cf_displayImage code="img_pencil_gif" hspace="0" vspace="0"></cfif></td>
		
		<cfif findnocase('English', tag_name) IS 0 OR findnocase('Spanish', tag_name) IS 0 AND setBreak IS 0>
			<cfset setBreak = 1>
		</cfif>
	</tr>
	</cfloop>
</cfif>
</table>
</div>
<cfparam name="multiProgramLegend" default="0">
<cfparam name="foodStampLegend" default="0">
<cfparam name="fillableLegend" default="0">

<cfif forms.recordcount IS NOT 0>
<div style="padding:0px 12px; background-color: ##d7d7d7; width: 284px;">
<strong>Call your State Hotline to find out where to send the application.</strong>
</div>
</cfif>

<div style="padding:12px; background-color: ##d7d7d7; width: 284px;">

<cfif multiProgramLegend IS 1 OR foodStampLegend IS 1>
	<h2 class="snapH2" style="margin-bottom:4px;">Definition(s)</h2>
	<cfif multiProgramLegend IS 1><p style="margin-top:0px;" class="snapLegend2"><strong>Multi-Program Forms:</strong><br />
<em>This is to apply for more than one program at the same time.</em>
</p>
</cfif>
	<cfif foodStampLegend IS 1><p style="margin-top:0px;" class="snapLegend2"><strong>Food Only Forms:</strong><br />
<em>This is to apply for the SNAP/Food Stamp program only.</em>
</p></cfif>

	<cfif fillableLegend IS 1><p style="margin-top:0px;" class="snapLegend2"><cf_displayImage code="img_pencil_gif" hspace="0" vspace="0"> <em>This is for fillable forms.</em>
</p></cfif>

</cfif>
</div></td>
</tr>


<tr>
<td class="text1" valign="bottom">



</td>
</tr>

</table></td>
</tr>

</table>
</cfoutput>
