<cf_sessionloadvars> 
<cfset session.partner_id = 11 >
<cf_tagheader guts="ec" show_title="yes" content_title_override="Application Forms Center" show_left_col="n">
<style type='text/css'>
	@import url( ../ec/themes/EC/style.css );
</style>
<script type="text/javascript" src="GUIFiles/sugar.js"></script>
<table cellspacing='0' cellpadding='0' width="100%" border='0'>
	<tbody>	
		<tr>
			<td style="padding:0 8px 0 4px;" valign='top'  width="20%">
            	<cfinclude template="dspFormMenu.cfm">
            </td>
			<td style="padding-right:2px; vertical-align:top;" width="80%">
				<slot>
 					<table class='listview' cellspacing='0' cellpadding='0' width="100%" border='0'>
        				<tbody>
        					<tr>
          						<td align="right" valign="top">
                                	<table cellspacing='0' cellpadding='0' width="100%" border='0'>
              							<tbody>
              								<tr>
                								<td class='listviewpaginationtds1' align='center'>
													<cfif not isdefined('url.hometext')>
														<h2>How to Search by Category</h2>
                                                    </cfif>
                                                </td>
                                            </tr>
                                        </tbody>
                                  	</table>
                                </td>
                            </tr>
							<tr height='20'>
			 					<td class='hometext' valign='top' bgcolor='white' colspan='3'>
             						<p class="text1">The Search by Category option allows you to search applications by the type of program, listed below:</p>
									<ul class="olex">
										<li class="liec"><strong>Patient Assistance Program</strong> refers to company-sponsored patient assistance programs. </li>
                                        <li class="liec">
                                            <strong>Medicare Savings Program</strong> refers to programs that help pay for the out-of-pocket expenses 
                                            associated with Medicare Part B premiums. This includes three programs:
                                            <!--- COMMENTING OUT FOR BUG 4533<ul>
                                                <li><strong>Qualified Medicare Beneficiary (QMB)</strong> covers the Medicare premiums, deductibles, and co-pays. </li>
                                                <li><strong>Specified Low-Income Medicare Beneficiary (SLMB)</strong> covers only the Medicare Part B premium.</li>
                                                <li><strong>Qualifying Individual (QI)</strong> covers only the Medicare Part B premium.</li>
                                            </ul>--->
                                        </li>
                                        <li class="liec">
                                            <strong>Medicaid</strong> refers to the state programs that pay for a broad range of medical services for people with low income and assets.
                                        </li>
                                        <li class="liec">
                                            <strong>State Rx</strong> refers to state-sponsored prescription assistance programs and/or discount programs. Not all states offer a program.
                                        </li>
                                        <li class="liec"><strong>Other Discount</strong> refers to other prescription discount programs. </li>
                                    </ul>
								</td>
							</tr>
						</tbody>
            		</table>
                </slot>
			</td>
    	</tr>
	</tbody>
</table>
<cf_tagfooter>