<CFIF IsDefined('Attributes.Page')>
	<CFSWITCH Expression=#Attributes.Page#>
		
		<CFCASE value="about_ncoa">
			<CFSET Title="About NCOA">
			<CFSET Image="about_ncoa.jpg">
		</CFCASE>
		
		<CFCASE value="about_ye">
			<CFSET Title="About Youre Entitled">
			<CFSET Image="about_ye.jpg">
		</CFCASE>
		
		<CFCASE value="about_va">
			<CFSET Title="About VitalAging">
			<CFSET Image="about_va.jpg">
		</CFCASE>
		
		<CFCASE value="nat_spons">
			<CFSET Title="Nationa Sponsers">
			<CFSET Image="nat_spons.jpg">
		</CFCASE>
		
		<CFCASE value="govt_part">
			<CFSET Title="Government Partners">
			<CFSET Image="govt_spons.jpg">
		</CFCASE>
	</CFSWITCH>
<CFELSE>
			<CFSET Title="You're Entitled Public Initiative">
			<CFSET Image="index_splash.jpg">
</CFIF>

<CFOUTPUT>
<html>
<head>
	<title>#Title#</title>
</head>

<body background="images/background.jpg" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
<table cellspacing="0" cellpadding="0" border="0" width="755">
<tr>
    <td colspan="2"><img src="images/banner.jpg" width="775" height="70" border="0"></td>
</tr>
<tr>
    <td colspan="2"><img src="images/#Image#" 
	</CFOUTPUT>
	 usemap="#menu" width="775" height="34" border="0"></td>
</tr>
<tr>
    <td width="218" valign="top"><img src="images/alignment.jpg" width="218" height="195" border="0"><br><img src="images/sponsers.jpg" width="218" height="110" border="0"></td>
    <td width="557" rowspan="2"><BR>

	
