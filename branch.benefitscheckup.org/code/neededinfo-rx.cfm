<html>
<head>
<title>Information to Have Before You Begin</title>
<script language="JavaScript">
<!--
function closeThisWindow() {
	if (!opener.closed)
		opener.focus();
	else
		window.open("index.cfm");
	self.close();
}
// -->
</script>
</head>
<body bgcolor="#FFFFFF" link="#00594B" alink="#00594B" vlink="purple" onLoad="window.focus();">
<font face="arial" size="3">
<h3>Information You'll Need for <cf_tagBCU subset_id="1"></h3>

<form>
<b><input type="button" value="Close" onClick="javascript:self.close();"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="Print this Page" onClick="javascript:print()"></B>
</form>

We've found that having the necessary information at your fingertips makes completing the questions easier. <BR>

<DL>
<DT>You'll need the following information about yourself or about the person you are helping:
<DD><li>Date of birth for self and spouse</li> 
<DD><li>ZIP code</li> 
<DD><li>Veteran status for self and spouse</li>
<DD><LI>A list of the prescription medications you are taking (we recommend that you have available the prescription bottles or information about your medications from your health professional)</LI>
<DD><li>Current income from all sources for self, spouse and others in the household</li> 
<DD><li>A general estimate of your assets (excluding your home, car and personal jewelry). Note: If the total value of these assets is less than $10,000, it is more important to have a good estimate.</li> 

</dl>

<cfif Not IsDefined('session.partner_id') or session.partner_id neq 7>
Once you get this information, return to <a href="javascript:closeThisWindow()">www.benefitscheckup.org</a> to fill out the questionnaire.
<BR><BR>
</cfif>

<cf_tagClose><p>
</font>
</body>
</html>