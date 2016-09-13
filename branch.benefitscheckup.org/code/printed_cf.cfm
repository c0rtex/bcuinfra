<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">

<cfparam name="error1" default="">
<cfparam name="error2" default="">

<cfparam name="zip" default="">

<cfparam name="zip1" default="">
<cfparam name="zip2" default="">

<cfif error1 IS 1>
	<cfset zip1 = zip>
</cfif>

<cfif error2 IS 1>
	<cfset zip2 = zip>
</cfif>


<cfoutput>

<script language="javascript" src="js/jquery.js"></script>

<script type="text/javascript">


$(document).ready(function() {

var clearerror= $('##clearerror').val();

<cfif error1 IS 1>
	if (clearerror == 0) {
		alert('Please enter a valid zip code ');
	}
		$('##zip1').focus();
</cfif>

<cfif error2 IS 1>
	if (clearerror == 0) {
		alert('Please enter a valid zip code ');
	}
	$('##zip2').focus();
</cfif>



	$('##form1').submit(function() {
		if (!$('##zip1').val() && !$('##zip2').val()) {
			alert('Please enter a zip code ');
			return false;
		} else {
			var zip1 = $('##zip1').val();

			reZip = new RegExp(/(^\d{5}$)|(^\d{5}-\d{4}$)/);

			 if (!reZip.test(zip1)) {
			 alert('Please enter a valid zip code ');
			 return false;
			 }
				$('##clearerror').val('1');
				return true;
		}
	});

	$('##form2').submit(function() {
		if (!$('##zip2').val() && !$('##zip2').val()) {
			alert('Please enter a zip code ');
			return false;
		} else {
			var zip2 = $('##zip2').val();

			reZip2 = new RegExp(/(^\d{5}$)|(^\d{5}-\d{4}$)/);

			 if (!reZip2.test(zip2)) {
			 alert('Please enter a valid zip code ');
			 return false;
			 }
				$('##clearerror').val('1');
				return true;
		}
	});

	$('##zip1').focus(function() {
		 $('##error1').hide();
	});

	$('##zip2').focus(function() {
		 $('##error2').hide();
	});

});
</script>

<table cellpadding="20" cellspacing="0" width="100%" border="0">
<tr>
<td><h1 class="indexh1">Printed Questionnaire</h1>
<cfif partnerQuery.wrapper_printed_text IS NOT "">
<cfsavecontent variable="interactiveLink"><cfoutput><a href="<cf_sessionPassVars href="frmwelcome2.cfm" subset_id="#session.subset_id#">">Interactive Questionnaire</a></cfoutput></cfsavecontent>


<cfset printed_text = replacenocase(partnerQuery.wrapper_printed_text, "Interactive Questionnaire", interactiveLink)>
#printed_text#
<cfelse><p class="text1">
<p class="text1">It is recommended that most users fill out an <cf_sessionPassVars href="frmwelcome2.cfm" subset_id="#session.subset_id#">Interactive Questionnaire.</cf_sessionPassVars> However, BenefitsCheckUp also provides the option to print and fill out a questionnaire by hand.   Using your printer, you can obtain a paper-based copy of the questionnaire quickly and easily. You can then take it with you 'on-the-go' -- whether for yourself or a loved one.</p>

<p class="text1">After you've filled out the questionnaire, come back to this page and enter the answers using the &ldquo;Go!&rdquo; button on the lower right.</p>
</cfif>

<p class="text1"><strong>Please choose from the two options below:</strong></p>

<div class="clear"></div>

<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>
</cfif>



<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="400"><div class="box">
	<div class="box-outer" style="height:160px;">
		<div class="box-inner">

			<h2 style="margin-bottom:8px;"><div class="box-content">Get a Printed Questionnaire</div></h2>
			<div class="box-content2">

			<p class="text1"<cfif partner_id NEQ 89 AND partner_id NEQ 90> style="height:54px;"</cfif>>Enter your zip code and click &ldquo;Go!&rdquo; to get your printed questionnaire.</p>
			<form method="post" action="checkzip.cfm?partner_id=#session.partner_id#&subset_id=#session.subset_id#&error=error1" id="form1">
<input type="hidden" name="clearerror" value="0" id="clearerror" />
			<p class="text10"><input type="text" size="10" name="zip" value="#zip1#" maxlength="5" id="zip1"> <input type="submit" value="Go!" class="submitlinkbutton"  />
			</p>
			</form>
			</div>
		</div>
	</div>
</div></td>


<td width="32">&nbsp;</td>
<td valign="top" width="400"><div class="box">
	<div class="box-outer" style="height:160px;">
		<div class="box-inner">

			<h2 style="margin-bottom:8px;"><div class="box-content">Enter Printed Questionnaire Information</div></h2>
			<div class="box-content2">

			<p class="text1"<cfif partner_id NEQ 89 AND partner_id NEQ 90> style="height:54px;"</cfif>>Enter the zip code from your printed questionnaire and click &ldquo;Go!&rdquo; to get started.</p>
			<form method="post" action="checkzip.cfm?partner_id=#session.partner_id#&subset_id=#session.subset_id#&error=error2" id="form2">
			<p class="text10"><input type="text" size="10" name="zip" value="#zip2#" id="zip2" maxlength="5">  <input type="submit" value="Go!" class="submitlinkbutton"  />
			</p>
			</form>
			</div>
		</div>
	</div>
</div></td>

</tr>
</table>
</cfoutput></td>
</tr>
</table>
</form>