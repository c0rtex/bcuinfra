<cfset localSrc="BCU_NonApp">
<cfset mailTable="tbl_CSOAlphaTestersPhase2">
<!--- this file processes the email sent to the Alpha Testers of the CSO version of BenefitsCheckUp 

This is the email saying that the testing is over. --->

<CFQUERY NAME="testers" DATASOURCE="#localSrc#">
	select Usr_Fname, Usr_Lname, Usr_Email, Login_ID, Usr_Password, Usr_NCOA_ID
	from #mailTable#
	where Login_ID='AlphaT062'
</CFQUERY>

<html>
<head>
	<title>Send E-Mail to Alpha Testers - 21 March 2002</TITLE>
</head>
<body>

<CFOUTPUT QUERY="testers">
UserFirstName = #Usr_Fname# --
UserLastName = #Usr_Lname# --
Email = #Usr_Email# --
LoginID = #Login_ID# --
Password = #Usr_Password# --
NCOAID = #Usr_NCOA_ID#<BR>
</CFOUTPUT>
<br>

<!--- Loop through query results, sending email to each tester --->
<cfmail query="testers" to="#Usr_Email#" from="cso@benefitscheckup.org" subject="Alpha Testing Completed" server="smtp.vitalaging.com">

Thank you!

The Alpha Testing of the organizational version of BenefitsCheckUp was very successful.  We learned a lot.  The collected suggestions will propel us to the next level.

We received so many helpful suggestions that in order to effectively and efficiently prepared for the next release, we will shut down the Alpha Test site so that we can focus on implementing the recommendations.  Given that some of the modifications affect  the database, we regret that any entered data will be lost.

I'll be back in touch with you when the next release is available (expected at NCOA's conference April 4, 2002).  Thanks again for your cooperation, patience, suggestions, understanding and support!  Together we are making a powerful new service to help older adults across the country.  It's amazing and fun! Take care - the development team

p.s. I'm analyzing the completed surveys now and will be contacting the gift certificate winners (there will be four of them) in the next couple of days via email.</cfmail>

<CFOUTPUT QUERY="testers">#Usr_Email#<br></CFOUTPUT>
<br>

It's done!
</body>
</html>
