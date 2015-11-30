<cfset neededURL = "neededinfo.cfm">

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

<cfif wrapper.wrapper_special_link IS NOT "">
	<cfset special_link = evaluate(wrapper.wrapper_special_link)>
	<cfset special_text = replacenocase(wrapper.wrapper_special_text, "[link]", "#application.transferType#://#special_link#", "all")>
<cfelse>
	<cfset special_link = application.serverPathES>
</cfif>
<cfoutput>


<table cellpadding="0" cellspacing="0" width="100%" border="0" class="boxtable">
<tr>
<td style="padding:0px 16px 16px 16px;">

<cf_displayImage code="img_partners_aarpkb_aarp#img#_jpg"  border="0" class="plimage" align="right">
<h1 class="indexh1"><cf_displayText group="site" code="site_aarp_homepage_get_started"></h1>
<p class="introText"><cf_displayText group="site" code="site_aarp_homepage_intro"></p>
<!--- reverting to site text per bug 4857
<p class="introText">#wrapper.wrapper_get_started_now#</p> --->

<div class="clear"></div>

<cfsavecontent variable="find_programs">
<cf_displayText group="site" code="site_aarp_homepage_find_programs">
</cfsavecontent>

<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><cf_displayImage code="img_partners_findbenefitsicon_gif"  border="0" class="icon2"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=49" subset_id="49" partner_id="22" class="indexh2b"><cf_displayText group="site" code="site_aarp_homepage_bql"></cf_sessionPassVars>
			</div>
			<div class="box-content2">
				
					<p class="text3"><cf_displayText group="site" code="site_aarp_homepage_bql_description">
					</p>

						<p class="text3" style="text-align:center"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=49" subset_id="49" partner_id="22" class="linkbutton">Go!</cf_sessionPassVars></p>
					

				
		
				<div class="clear"></div>
			</div>
		</div>
	</div>	
</div>

<div class="divider"></div>




<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="33%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			
			<h2 class="boxheader"><div class="box-content"><cf_sessionPassVars href="snap.cfm?partner_id=22" class="indexh2c">
			<cf_displayImage code="img_partners_food_gif"  border="0" class="icon"><cf_displayText group="site" code="site_aarp_homepage_snap_title" target="snap"></cf_sessionPassVars></div></h2>
			<div class="box-content2">
			<p class="text2" style="clear:left; height:90px;"><cf_displayText group="site" code="site_aarp_homepage_snap_description"></p>
			<p class="text3" style="margin-top:5px;">
			<cf_sessionPassVars href="snap.cfm?partner_id=22" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>
<td width="32">&nbsp;</td>

<td valign="top" width="32%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
			<div class="box-content">
			<cf_sessionPassVars href="pdb.cfm?partner_id=22" prev_id="0" class="indexh2c"><cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon"><cf_displayText group="site" code="site_aarp_homepage_rx_title"></cf_sessionPassVars>
			</div></h2>
			<div class="box-content2">
			<p class="text2" style="clear:left; height:92px;"><cf_displayText group="site" code="site_aarp_homepage_rx_description"></p>
			<p class="text3">
				<cf_sessionPassVars href="pdb.cfm?partner_id=22" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
			</p>


			</div>
		</div>
	</div>	
</div></td>

<td width="32">&nbsp;</td>

<td valign="top" width="33%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 class="boxheader"><div class="box-content"><div style="width:175px;float:left;"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=68" subset_id="68" partner_id="22" prev_id="0" class="indexh2c"><img src="images/employment.png" border="0" class="icon" alt="Office Building" title="Office Building"><cf_displayText group="site" code="site_aarp_homepage_factsheet_title"></cf_sessionPassVars></div><div></div></div></h2>
            <div class="box-content2">
			<p class="text2" style="clear:left; height:93px;"><cf_displayText group="site" code="site_aarp_homepage_factsheet_description"></p>
<p class="text3"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=68" subset_id="68" partner_id="22" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div>
</td>
</tr>
</table></td>
</tr>
<tr>
<td style="padding:0px 16px 16px 16px;">
<table cellpadding="0" cellspacing="0" width="100%">
<tr>

<td valign="top" width="49.5%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
<h2 class="boxheader"><div class="box-content"><div style="float:left;"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=76" subset_id="76" partner_id="22" prev_id="0" class="indexh2c"><img src="images/home_2.png" height="32" border="0" class="icon" alt="House" title="House">Help with your Home</cf_sessionPassVars></div><div></div></div></h2>
			<div class="box-content2">
			<p class="text2" style="clear:left; height:45px;">Find housing programs that can help you get property tax relief
and exemptions, make home repairs, pay for utilities, and other assistance.</p>
			<p class="text3">
				<cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=76" subset_id="76" partner_id="22" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
			</p>


			</div>
		</div>
	</div>	
</div></td>


<td valign="top" width="1%"></td>
<td valign="top" width="49.5%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 class="boxheader"><div class="box-content"><div style="float:left;"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=77" subset_id="77" partner_id="22" prev_id="0" class="indexh2c"><img src="images/book_open2.png" height="32" border="0" class="icon" alt="Book" title="Book">Resources for Adult Education</cf_sessionPassVars></div><div></div></div></h2>
            <div class="box-content2">
			<p class="text2" style="clear:left; height:45px;">Find education programs that can help you save money on adult
education and get other learning opportunities.</p>
<p class="text3"><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=22&subset_id=77" subset_id="77" partner_id="22" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div>
</td>
</tr>
</table>

</td>

</tr>
</table>

<!---<p class="text3" style="margin:5px 15px 10px;"><cf_displayText group="site" code="site_aarp_homepage_contact_info"></p>--->

</cfoutput>
