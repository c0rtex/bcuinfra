<html>
<head>
<title>Who Is Likely to Receive the Most Help</title>
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
<body bgcolor="#FFFFFF" link="#00594B" alink="#00594B" vlink="purple" onload="window.focus();">
<font face="arial" size="3">
<h3>Who Is Likely to Receive the Most Help</h3>

<form>
<b><input type="button" value="Close" onClick="javascript:self.close();"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="Print this Page" onClick="javascript:print()"></B>
</form>

<b>
<cfif session.subset_id eq 1>
BenefitsCheckUpRx&trade; includes information on more than <cf_countProgramsRounded subset="rx"> different public and private programs.  It will provide the most help to Medicare beneficiaries who: 

<ul>

<li>do not have Medicaid or other Rx coverage.</li>

<li>want help paying for their prescription drugs.</li>

<li>have incomes of less than 200% of Federal Poverty Level (about $19,000 if single, $25,000 if married).</li>

</ul>
<p>
Those with higher incomes who live in Alaska, Connecticut, Hawaii, Illinois, Nevada, New Jersey, New York, North Carolina, Pennsylvania, or Vermont may also find this service helpful.
</p>

<p>
Although the service will be of greatest help to the people described above,  people without Medicare or with higher incomes are also welcome to use the service and many have found some needed assistance. 
</p>
<cfelseif session.subset_id eq 12>

The BenefitsCheckUpRx&trade; Medicare Card Finder provides information to help people choose and enroll in a Medicare-approved drug discount card. It will provide the most help to people with Medicare who:

<ul>

<li>do not have full Medicaid or other Rx coverage; 
<li>want help paying for their prescription drugs; 
<li>and have monthly incomes less than or equal to:
<ul>
<li>$1,077 (single person) or $1,444 (married person) for people living in one of the 48 contiguous states, or
<li>$1,345 (single person) or $1,804 (married person) for people living in Alaska, or
<li>$1,239 (single person) or $1,661 (married person) for people living in Hawaii.</ul></ul>

<p>
Please note: Those with higher incomes should complete a full BenefitsCheckUpRx screening to find help paying for prescription drugs through other resources such as State Prescription Drug Assistance Programs and Patient Assistance Programs offered by pharmaceutical companies.
</p>
</cfif>

</b><br>
<cf_tagClose>
</font>
</body>
</html>