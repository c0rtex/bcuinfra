<!--- if coming in fresh (not from a link inside the AFC), reset drugs to none --->
<cfif not IsDefined('menu_tab')>
	<cfset session.selectedAFCDrugs = ''>
</cfif>
<cf_sessionloadvars> 
<cfset session.partner_id = 11>
<cf_tagheader guts="ec" show_title="yes" content_title_override="Application Forms Center" show_left_col="n">
<style type='text/css'>
	@import url( ../ec/themes/EC/style.css );
</style>
<script type="text/javascript" src="GUIFiles/sugar.js"></script>
<table cellspacing='0' cellpadding='0' width="100%" border='0'>
	<tbody>	
		<tr>
			<td style="padding-right:2px;vertical-align:top;" width="80%">
				<slot>
				<table class='listview' cellspacing='0' cellpadding='0' width="100%" border='0'>
					<tbody>
						<tr>
							<td align="right" valign="top">
								<table cellspacing='0' cellpadding='0' width="100%" border='0'>
									<tbody>
										<tr>
											<td class='listviewpaginationtds1' align='center'><h2>How to Use the Application Forms Center</h2></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr height='20'>
							<td class='hometext' valign='top' bgcolor='white' colspan='3'>
								<p class="text1">The Application Forms Center makes it easy to access Application Forms and Fact Sheets for Rx assistance programs.</p>
								<p class="text1">There are four easy ways to search for an application form:</p>
								<ul class="olex">
									<li class="liec">Search by Drug (you may select the brand name or generic name);</li>
									<li class="liec">Search by Form Category;</li>
									<li class="liec">Search by State; and</li>
									<li class="liec">Search by Form Date.</li>
								</ul>
								<p class="text1">
                                	After selecting one of the search options above, you will be able to narrow your search criteria.  
                                    A list of programs and forms will then be displayed that match your search criteria. You can click 
                                    on the program name to open a printable Fact Sheet or click on the application name to open the printable 
                                    form. Some of the forms are marked fillable, indicating that you can complete the form electronically.
								</p>
								<p class="text1">
                                	BenefitsCheckUp strives to maintain the most current database of programs and application forms possible. 
                                    Please feel free to contact BenefitsCheckUp Customer Support at 
                                    <a href="mailto:support@benefitscheckup.org" style="font-size:12px;">support@benefitscheckup.org</a> with 
                                    questions or program additions.
                                </p>
								<p class="text1">Thank you for using this service.<br></p>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>
<cf_tagfooter>
