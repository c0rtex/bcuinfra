
	<?php  echo '<div class="span5"><div class="well" id="your-report"><h2> Recommended Ways to Get Help</h2>
	<h3>State Health Insurance Assistance Program (SHIP)</h3>
	<p><a href="#ship" >Find</a> the government-sponsored program in your locality for help comparing
Medicare options.</p>
	<!--Lynna Cekova: removed the legend code so that a gray line does not show -->
	';

$phoneLinkSide = 0;
$compareLinkSide = 0;

if ($subsetID == 72){
$compareLinkSide = 69;

$phoneLinkSide = 83;
}
else if ($subsetID == 74){

$phoneLinkSide = 66;
$compareLinkSide = 71;
}

else if ($subsetID == 75){

$phoneLinkSide = 51;
$compareLinkSide = 62;
}

	if ($learnMore > 0 )  {
	echo '
<legend></legend>
	<h3>Aon Retiree Health Exchange&#0153;</h3><p>Get expert guidance about your Medicare coverage.</p>
	<ul>
       <li><p><a id="aonFloodlightLink" href="/cf/redirect.cfm?id='.$compareLinkSide.'&tgt=1&partner_id=14&visible=false&'.$reportkey.$appendurl.'"  onClick="'." ga('send', 'event', 'mqc', 'MQC Results Page (Compare AON Link)', 'resultscomparerr'); ga('mmm.send', 'event', 'mqc', 'MQC Results Page (Compare AON Link)', 'resultscomparerr'); ".' javascript:aonFloodlightCompareLink();">Compare</a> supplemental insurance plans online.</p></li>
       <li>'; ?>
	<a class="" 
	
onClick="ga('send', 'event', 'mqc', 'MQC Results Page (Request AON Link)', 'resultsreqrr'); ga('mmm.send', 'event', 'mqc', 'MQC Results Page (Request AON Link)', 'resultsreqrr');"
	<?php echo' href="/cf/redirect.cfm?id='.$phoneLinkSide.'&tgt=1&partner_id=14&visible=false&'.$reportkey.$appendurl.'" onClick="javascript:aonFloodlightRequestLink();" >Request</a> a telephone appointment with a licensed insurance agent to help
you make enrollment decisions.	 
	</li></ul>						
	'; } 
echo '<legend></legend>
	<h3>Medicare.gov</h3>
	<p><a href="#medicare" >Explore</a> your Medicare options yourself using the federal government&apos;s website.</p>
	';?>	
<?php echo '</div>

            <div class="printButton"><form><a data-toggle="modal" class="btn btn-large btn-recs" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Print Your Report</a></form></div>

</div>'; ?>
