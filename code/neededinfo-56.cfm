<cf_cacheWrapperQuery query="wrapper" partner_id="#session.partner_id#">

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
<cfoutput>
<h3>Information You'll Need for <cfif trim(wrapper.wrapper_custom_title) IS NOT "">#wrapper.wrapper_custom_title#<cfelse><cf_tagBCU></cfif></h3>
</cfoutput>

<form>
<b><input type="button" value="Close" onClick="javascript:self.close();"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="Print this Page" onClick="javascript:print()"></B>
</form>
<p>We've found that having the necessary information at your fingertips makes
completing the questions easier.
</p>
<DL>
<DT>You'll need the following information about yourself or about the person you are helping: 
<DD>
<li><strong>ZIP code</strong></li>
<li><strong>Date of birth</strong></li>
<li><strong>Current income and assets from all sources for self, spouse and others in the household</strong></li>
<li><strong>Estimates of current expenses</strong> (such as mortgage/rent, utilities, out-of-pocket medical bills, expenses for caring for someone at home while the person works or goes to school, etc.)</li>
</dl>
<cf_tagClose>
<p>
</font>
</body>
</html>