<cf_sessionLoadVars>
<cfparam name="url.partner_id" default="76">
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>
<style>
	##fit_container
	{
		margin-left: 25px;
		margin-right: 25px;
	}
</style>
<div id="fit_container">
	<h1 class="indexh1"><cf_displayText code="site_fit_toolkit_main_title" group="site"></h1>
		<p class="text1"><cf_displayText code="site_fit_toolkit_main_description" group="site"></p>
	
	<div class="box" style="width:340px; float:left; margin-right:35px;">
		<div class="box-outer">
			<div class="box-inner">
				<h2 class="boxheader">
	            	<div class="box-content titleFix">
	                	<cf_sessionPassVars href="moreprograms.cfm" prev_id="0" class="indexh2b">
							<cf_displayImage code="img_partners_findbenefitsicon_gif"  border="0" class="icon">
							<cf_displayText code="site_fit_toolkit_benefits_title" group="site">
	                    </cf_sessionPassVars>
	                </div>
	            </h2>
				<div class="box-content2">
					<p style="clear:left;" class="text2"><cf_displayText code="site_fit_toolkit_benefits_description" group="site"></p>
					<p class="text3">
						<cf_sessionPassVars href="moreprograms.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
	                </p>
				</div>
			</div>
		</div>
	</div>
	
	<div class="box" style="width:325px; float:left;">
	<div class="box-outer">
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="taxRelief.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="indexh2b">
						<img width="28" src="images/home.png" border="0" class="icon_new" alt="House" title="House">
						<cf_displayText code="site_fit_toolkit_locator_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p style="clear:left;" class="text2"><cf_displayText code="site_fit_toolkit_locator_description" group="site"></p>
				<p class="text3">
					<cf_sessionPassVars href="taxRelief.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div>
<div class="divider"></div>

<div class="box" style="width:340px; float:left; margin-right:35px; margin-top:15px;">
<div class="box-outer">
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="extrahelp.cfm" prev_id="0" class="indexh2b">
						<cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon">
						<cf_displayText code="site_fit_toolkit_lis_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p style="clear:both;" class="text2"><cf_displayText code="site_fit_toolkit_lis_description" group="site"></p>
				<p class="text3" style="margin-top:0px">
					<cf_sessionPassVars href="extrahelp.cfm?partner_id=76" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div>
</div>

<div class="box" style="width:325px; float:left; margin-top:15px;">
	<div class="box-outer">
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="apply.cfm" prev_id="0" class="indexh2b">
						<cf_displayImage code="img_partners_applyicon_gif"  border="0" class="icon">
						<cf_displayText code="site_fit_toolkit_afc_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2" style="clear:both;">
				<p style="clear:both;" class="text2"><cf_displayText code="site_fit_toolkit_afc_description" group="site"></p>
				<p class="text3">
					<cf_sessionPassVars href="apply.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div>
	
		
</div>
	
</cfoutput>
</cf_buildHTML>

